package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

import com.library.service.MemberService;
import com.library.vo.Member;
import com.utils.CookieManager;

/**
 * Servlet implementation class LoginAction
 */
@WebServlet("/login/LoginAction.do")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// name속성의 값을 매개값으로 넘겨주면 value속성의 값을 반환 합니다
				String id = request.getParameter("userid");
				String pw = request.getParameter("userpw");
				 String saveCheck = request.getParameter("saveCheck");
			      
			      //System.out.print("saveCheck : " +saveCheck);
			      // 체크박스가 체크되었을경우, 아이디를 쿠키에 저장
			      if(saveCheck != null && saveCheck.equals("Y")){
			    	  System.out.print("쿠키 생성");
			    	  CookieManager.makeCookie(response, "userId", id, 60*60*24*7);
			      }
				
				// lib 이동
				// Java Resource -> webapp/WEB-INF/lib
				MemberService service = new MemberService();
				Member member = service.login(id, pw);
				
				if(member != null && !member.getId().equals("")){
					HttpSession session = request.getSession();
					
					// 로그인 성공
					session.setAttribute("member", member);
					session.setAttribute("userId", member.getId());
					System.out.print(member.getId() + "님 환영");
					
					
					if("Y".equals(member.getAdminyn())){
						// 관리자인 경우 adminYN = Y
						session.setAttribute("adminYn", "Y");
					}
					
					response.sendRedirect("../book/list.book");
					//request.getRequestDispatcher("../book/list.book").forward(request, response);
				}else{
					// 로그인 실패
					// 로그인 화면으로 이동	
					response.sendRedirect("../login.jsp?error=Y");
				}
	}

}
