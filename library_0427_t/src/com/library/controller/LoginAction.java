package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// name속성의 값을 매개값으로 넘겨주면 value속성의 값을 반환 합니다.
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		
		// 아이디 쿠키에 저장
		String saveCheck = request.getParameter("saveCheck");
		if("Y".equals(saveCheck)){
			CookieManager.makeCookie(response, "userId", id, 60*60*24*7);
		}
		
		// lib 이동
		// Java Resources -> webapp/WEB-INF/lib
		MemberService service = new MemberService();
		Member member = service.login(id, pw);
		
		if(member != null && !member.getId().equals("")){
			HttpSession session = request.getSession();
			
			// 로그인 성공
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getId());
			System.out.print(member.getId() + "님 환영합니다.");
			
			
			if("Y".equals(member.getAdminyn())){
				// 관리자인 경우 adminYn = Y
				session.setAttribute("adminYn", "Y");	
			}
			
			response.sendRedirect("../book/list.book");
			//request.getRequestDispatcher("../book/list.book")
			//				.forward(request, response);
		} else {
			// 로그인 실패
			// 로그인 화면으로 이동
			response.sendRedirect("../login.jsp?error=Y");
		}
	}

}
