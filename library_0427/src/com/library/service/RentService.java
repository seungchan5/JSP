package com.library.service;

import com.library.dao.RentDao;

public class RentService {
	RentDao dao = new RentDao();
	
	public String getRentYN(int no){
		String rentYN = dao.getRentYN(no);
		return rentYN;
	}
	
	/**
	 * 도서 대여
	 * 
	 * 대여 테이블에 데이터를 입력 합니다.
	 * @param no : 도서번호
	 * @param id : 아이디
	 */
	public void rentBook(int no, String id) {
		// 대여 가능 여부 체크
		String rentYN = dao.getRentYN(no);
		if("Y".equals(rentYN)) {
			System.err.println("이미 대여 중인 도서 입니다.");
			return;
		}
		
		int res = dao.insert(id, no);
		
		System.out.println(res+"건 대여 되었습니다.");
		
	}
	
	/**
	 * 도서 반납
	 * 
	 * 반납일과 대여여부를 업데이트합니다.
	 * @param no
	 */
	public void returnBook(int no) {
		// 반납 가능 여부 체크
		String rentYN = dao.getRentYN(no);
		if("N".equals(rentYN)) {
			System.err.println("반납 가능한 도서가 아닙니다.");
			return;
		}
		
		int res = dao.update(no);
		
		System.out.println(res+"건 반납 되었습니다.");
	}
}









