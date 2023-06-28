package com.library.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.service.BookService;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.oreilly.servlet.MultipartRequest;
import com.utils.FileUtil;
import com.utils.JSFunction;

@WebServlet("*.book")
public class BookController extends HttpServlet{

	BookService bs = new BookService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri : " + uri);
		
		if(uri.indexOf("list") > 0) {
			
			// 검색조건 세팅
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			// 리스트 조회 및 요청 객체에 저장
			Map<String, Object> map = bs.getList(cri);
			req.setAttribute("map", map);
			
			// 포워딩
			req.getRequestDispatcher("./list.jsp").forward(req, resp);
		
		} else if(uri.indexOf("delete") > 0) {
			
			int res = bs.delete(req.getParameter("delNo"));
			if(res>0) {
				req.setAttribute("message", res+ "건 삭제 되었습니다");
			} else {				
				req.setAttribute("message", "삭제 실패");
			}
			
			req.getRequestDispatcher("./list.book").forward(req, resp);
		} else if(uri.indexOf("write")>0){
			resp.sendRedirect("./Write.jsp");
			
		} else if(uri.indexOf("view")>0){
			Book book = bs.selectOne(req.getParameter("no"));
			req.setAttribute("dto", book);
			System.out.println(book);
			if(book!=null) {
				req.getRequestDispatcher("./View.jsp").forward(req, resp);
			} else {
				JSFunction.alertBack(resp, "해당 번호에 해당하는 도서가 없습니다");
			}
			
		} else {
			JSFunction.alertBack(resp, "url을 확인해주세요");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri : " + uri);
		
		if(uri.indexOf("write") > 0 ) {
			
			// 도서등록
			String saveDirectory = "C:\\Users\\user\\git\\JSP\\library_0427\\webapp\\Images\\bookimg";
			MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024*1000);
			
			Book book = new Book(mr.getParameter("title"), mr.getParameter("author"));
			
			String ofile = mr.getFilesystemName("bookimg");
			System.out.println(ofile);
			
			if(ofile != null && !"".equals(ofile)) {
				String sfile = FileUtil.fileNameChange(saveDirectory, ofile);
				
				book.setOfile(ofile);
				book.setSfile(sfile);
			}
			
			int res = bs.insert(book);
			
			if(res > 0) {
				JSFunction.alertLocation(resp, "./list.book", "등록되었습니다");
			} else {
				JSFunction.alertBack(resp, "등록 실패");
			}
			
		} else if(uri.indexOf("rent")>0) {
			// 로그인 아이디 확인
			HttpSession session = req.getSession();
			if(session.getAttribute("userId")==null) {
				JSFunction.alertBack(resp, "로그인 후 이용 가능한 메뉴 입니다");
				return;
			}
			
			// 대여하기 - 책 번호, 로그인 아이디
			Book book = new Book();
			book.setNo(req.getParameter("no"));
			book.setId(session.getAttribute("userId").toString());
			
			int res = bs.rentBook(book);
			
			if(res>0) {
				JSFunction.alertLocation(resp, "./view.book?no="+book.getNo(), "대여 되었습니다");
			} else {
				JSFunction.alertBack(resp, "대여중 오류 발생");
			}
		} else if(uri.indexOf("return")>0) {
			
			int res = bs.returnBook(req.getParameter("no"));
			if(res>0) {
				JSFunction.alertLocation(resp, "./view.book?no="+ req.getParameter("no"), "반납 되었습니다");
			} else {
				JSFunction.alertBack(resp, "반납 중 오류 발생");
			}
		}
	}
	
	public BookController() {
		// TODO Auto-generated constructor stub
	}

}
