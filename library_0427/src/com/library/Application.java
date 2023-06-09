package com.library;

import com.library.controller.LibraryController;

public class Application {
	public static void main(String[] args) {
		LibraryController lib = new LibraryController();
		lib.library();
		
		
		
//		MemberDao dao = new MemberDao();
//		System.out.println(dao.delete("user"));
		
//		아이디체크 테스트
//		System.out.println(dao.idCheck("user01"));
		
//		로그인 테스트
//		System.out.println(dao.login("admin", "1234"));
		
//		사용자 입력 테스트
//		Member member = new Member("user","1234","사용자",null,null,null);
//		dao.insert(member);

//		BookDao dao = new BookDao();
//		update 테스트
//		dao.update(12, "Y");
		
//		delete 테스트
//		dao.delete(13);
		
//		insert 테스트
//		Book book = new Book("불편한편의점2", "나카사키");
//		dao.insert(book);
		
//		getList 테스트
//		List<Book> list = dao.getList();
//		
//		for(Book book1 : list) {
//			System.out.println(book1.toString());
//		}
		
//		리스트를 출력 하면 리스트의 요소들의 toString이 출력 됩니다.
//		[]로 묶어서 출력!!
//		System.out.println(dao.getList().toString());
//		System.out.println("=====================");
//		System.out.println(dao.getList());
		
		
	}
}
