package com.library.controller;

import java.util.Scanner;

import com.library.service.BookService;
import com.library.service.MemberService;
import com.library.service.RentService;
import com.library.vo.Member;

/**
 * 도서대여 시스템
 * 
 * ▶ 사용자로부터 입력을 받아서 
 * 		사용자요청에 알맞는 서비스로직을 호출 합니다.
 * 
 * ▶ 로그인
 * 	- 관리자
 * 		메뉴 : 도서등록, 도서삭제, 사용자등록, 사용자삭제	
 *  - 사용자
 *  	메뉴 : 도서대여, 도서반납, 도서대여현황
 * 
 * @author user
 *
 */
public class LibraryController {
	
	Scanner scan = new Scanner(System.in);

	// 서비스 멤버로 등록
	MemberService memberService = new MemberService();
	BookService bookService = new BookService();
	RentService rentService = new RentService();
	
	/**
	 * 도서관리 시스템 시작
	 * 
	 */
	public void library() {
		System.out.println("=================");
		System.out.println("도서관리시스템 v1.0");
		System.out.println("=================");
		
		
		while(true) {
			// 로그인
			Member member = login();
			
			if(member.getAdminyn().equalsIgnoreCase("Y")) {
				// 관리자 메뉴 실행
				adminMenu();
			} else {
				// 사용자 메뉴 실행
				userMenu(member.getId());
			}
		}
		
		
		
	}
	
	/**
	 * 사용자 메뉴
	 */
	private void userMenu(String id) {
		while(true) {
			// 책 목록 출력
			bookService.getList();
			System.out.println("관리자 메뉴 ============================================");
			System.out.println("1. 도서대여 2. 도서반납 0. 로그아웃 4. 종료");
			System.out.println("======================================================");
			System.out.println("메뉴를 입력해주세요.");
			int menu = getInt();
			int bookNo = 0;
			switch (menu) {
			case 1:
				// 도서대여
				System.out.println("대여할 도서번호를 입력해주세요.");
				bookNo = getInt();
				rentService.rentBook(bookNo, id);
				break;
			case 2:
				// 도서반납
				System.out.println("반납할 도서번호를 입력해주세요.");
				bookNo = getInt();
				rentService.returnBook(bookNo);
				break;
			case 0:
				// 로그아웃
				return;
			default:
				System.err.println("메뉴 번호를 확인해주세요!");
				break;
			}
			
		}
	}

	/**
	 * 관리자 메뉴
	 */
	private void adminMenu() {
		
		while(true) {
			// 도서 목록을 출력 
			bookService.getList();
			
			System.out.println("관리자 메뉴 ============================================");
			System.out.println("1. 도서등록 2. 도서삭제 "
									+ "3. 사용자등록 4. 사용자삭제 "
									+ "0. 로그아웃 Q. 종료");
			System.out.println("======================================================");
			System.out.println("메뉴를 선택 해주세요");
			
			int menu = getInt();
			
			switch (menu) {
			case 1:
				// 도서등록 
				// 사용자로 부터 입력 받기 - 도서명, 작가명
				// Controller -> service -> dao -> data처리
				System.out.println("도서명을 입력해주세요");
				String title = getString();
				System.out.println("작가명을 입력해주세요");
				String author = getString();
				
				bookService.insert(title, author);
				break;
			case 2:
				// 도서삭제
				System.out.println("삭제한 도서 번호를 입력해주세요.");
				int no = getInt();
				bookService.delete(no);
				break;
			case 3:
				// 사용자 등록
				String id="";
				
				// 아이디 중복체크
				while(true) {
					System.out.println("사용자 id를 입력해주세요.");
					id = getString();
					boolean idcheck = memberService.idCheck(id);
					if(idcheck) {
						break;
					}
				}
				System.out.println("비밀번호를 입력해주세요.");
				String pw = getString();
				System.out.println("이름을 입력해주세요.");
				String name = getString();
				System.out.println("관리자 계정이면 Y를 입력해주세요.");
				String str = getString();
				String adminYN = str.equalsIgnoreCase("Y")?"Y":"N";
				
				memberService.insert(id, pw, name, adminYN);
				break;
			case 4:
				// 사용자 삭제
				System.out.println("삭제할 id를 입력해주세요.");
				String delId = getString();
				memberService.delete(delId);
				break;
			case 0:
				// 로그아웃
				return;
				
			default:
				// 없는 메뉴 번호 입력
				System.out.println("메뉴를 확인후 다시 입력해주세요");
				break;
			}
			
		}
		
	}

	public Member login() {
		// 로그인
		while(true) {
			System.out.println("<로그인>");
			System.out.println("id를 입력해주세요");
			String id = getString();
			System.out.println("pw를 입력해주세요");
			String pw = getString();
			
			Member member = memberService.login(id, pw);
			
			// 로그인 성공 - member 객체를 반환
			if(member != null) {
				return member;
			} 
		}
		
	}
	
	
	/**
	 * 사용자의 입력을 받아 문자열을 반환 합니다.
	 * 문자가 입력 될때까지 반복
	 * q,Q 되면 종료
	 * @return
	 */
	private String getString(){
		String str = "";
		
		while(true) {
			str = scan.next();
			
			if(str.equalsIgnoreCase("q")) {
				System.out.println("프로그램 종료!!");
				System.exit(0);
			}
			return str;	
		}
		
	}
	
	/**
	 * 사용자의 입력을 받아 숫자를 반환 합니다.
	 * 숫자가 입력 될때까지 반복
	 * q,Q 되면 종료
	 * @return
	 */
	private int getInt(){
		int i=0;
		while(true) {
			
			try {
				i = scan.nextInt();
				return i;
			} catch (Exception e) {
				String str = scan.next();
				// q, Q가 입력된 경우 정상종료
				if(str.equalsIgnoreCase("q")) {
					System.out.println("프로그램을 종료 합니다.");
					System.exit(0);
				}
				System.err.println(str+"은 입력 불가능 합니다.");
				System.err.println("숫자를 입력해주세요");
			}
		}
		
//		return i;
	}
}


















