package com.library.service;

import java.util.List;

import com.library.dao.BookDao;
import com.library.vo.Book;

public class BookService {
	BookDao dao = new BookDao();
	
	/**
	 * 책 리스트를 조회 합니다.
	 * @return
	 */
	public List<Book> getList(){
		List<Book> list = dao.getList();
		for(Book book : list) {
			System.out.println(book);
		}
		return list;
	}

	/**
	 * 도서 정보 입력
	 */
	public void insert(String title, String author) {
		Book book = new Book(title, author);
		int res = dao.insert(book);
		if(res > 0) {
			System.out.println(res + "건 입력 되었습니다.");
		} else {
			System.err.println("입력중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
	}

	public void delete(int no) {
		int res = dao.delete(no);
		if(res>0) {
			System.out.println(res+"건 삭제되었습니다.");
		} else {
			System.err.println("삭제중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
	}

	public void rentBook(int bookNo) {
		// 대여가능한 도서인지 확인
		String rentYN = dao.getRentYN(bookNo);
		if("Y".equals(rentYN)) {
			System.err.println("이미 대여중인 도서 입니다.");
		} else if ("".equals(rentYN)) {
			System.out.println("없는 도서 번호 입니다.");
		}
		
		// 대여처리
		int res = dao.update(bookNo, "Y");
		
		if(res>0) {
			System.out.println(res + "건 대여 되었습니다.");
		}else {
			System.out.println("대여중 오류가 발생 하였습니다.");
			System.out.println("관리자에게 문의 해주세요");
		}
	}

	public void returnBook(int bookNo) {
		// 반납가능한 도서인지 확인
		String rentYN = dao.getRentYN(bookNo);
		if("N".equals(rentYN)) {
			System.err.println("반납 가능한 상태가 아닙니다.");
		} else if ("".equals(rentYN)) {
			System.out.println("없는 도서 번호 입니다.");
		}
		
		// 반납처리
		int res = dao.update(bookNo, "N");
		
		if(res>0) {
			System.out.println(res + "건 반납 되었습니다.");
		}else {
			System.out.println("반납 처리 중 오류가 발생 하였습니다.");
			System.out.println("관리자에게 문의 해주세요");
		}
	}
	
}













