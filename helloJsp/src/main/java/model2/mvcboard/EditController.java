package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
import common.JSFunction;

/**
 * Servlet implementation class EditController
 */
@WebServlet("/mvcboard/edit.do")
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 게시물 조회
		MVCBoardDao dao = new MVCBoardDao();
		MVCBoardDto dto = dao.selectOne(request.getParameter("idx"));
		
		
		// request영역에 저장
		request.setAttribute("dto", dto);
		
		// jsp파일로 포워딩
		request.getRequestDispatcher("../14MVCBoard/Edit.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String saveDirectory = "C:/upload";
		// 파일 업로드 : 업로드 경로, 최대 사이즈를 지정
		MultipartRequest mr = FileUtil.uploadFile(request, saveDirectory, 1024*1000);
		
		if(mr == null) {
			// 파일 업로드 실패
			JSFunction.alertBack(response, "파일 저장중 오류가 발생 하였습니다.");
			return;
		}
		
		// 파일 업로드 외 저장
		// form값을 DTO에 저장
		MVCBoardDto dto = new MVCBoardDto();
		
		dto.setName(mr.getParameter("name"));
        dto.setTitle(mr.getParameter("title"));
        dto.setContent(mr.getParameter("content"));
        dto.setIdx(mr.getParameter("idx"));
		 
        // 원본 파일명과 저장된 파일이름 설정
        
        // 2. 새로운 파일명 생성
	    // 	동일한 파일명이 업로드 되는 경우, 기존파일이 소실될 위험이 있으므로 파일명을 변경합니다
	    String fileName = mr.getFilesystemName("ofile");
	    System.out.println("fileName : " + fileName);
	    if(fileName != null) {
	    	// 첨부파일의 확장자
	    	String ext = fileName.substring(fileName.lastIndexOf("."));
	    	
	    	// H : 0~23, S : millisecond
	    	// 현재시간을 파일이름으로 지정
	    	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	    	String oFileName = fileName.substring(0, fileName.lastIndexOf("."));
	    	
	    	String newFileName = oFileName +"_"+ now + ext;
	    	System.out.println("원본파일명 : " + fileName);
	    	System.out.println("신규파일명 : " + newFileName);
	    	
	    	// 3. 파일명 변경
	    	File oldFile = new File(saveDirectory + File.separator + fileName);
	    	File newFile = new File(saveDirectory + File.separator + newFileName);
	    	oldFile.renameTo(newFile);
	    	
	    	dto.setOfile(fileName);	// 원본 파일명
	    	dto.setSfile(newFileName);	// 저장된 파일명
	    	
	    }
		
		MVCBoardDao dao = new MVCBoardDao();
		int res = dao.update(dto);
		
		System.out.println("res = " + res);
		
		if(res>0) {
			//resp.sendRedirect("../mvcboard/list.do");
			JSFunction.alertLocation(response, "../mvcboard/list.do", "작성되었습니다.");
		} else {
			JSFunction.alertBack(response, "작성중 오류가 발생하였습니다 관리자에게 문의해주세요");
		}		
			

	}	
	
}
