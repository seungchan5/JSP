package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.one")
public class FrontController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String uri =  req.getRequestURI();
		
		// 요청경로
		String commandStr = uri.substring(uri.lastIndexOf("/"));
		//res.getWriter().print(commandStr);
		
		if(commandStr.equals("/regist.one")) {
			registFunc(req);
		} else if(commandStr.equals("/login.one")) {
			loginFunc(req);
		} else if(commandStr.equals("/freeboard.one")) {
			freeboardFunc(req);
		}
		
		req.setAttribute("uri", uri);
		req.setAttribute("commandStr", commandStr);
		
		req.getRequestDispatcher("/13서블릿/FrontController.jsp").forward(req, res);
	}
	
	
	// 요청별 처리 메소드
	private void freeboardFunc(HttpServletRequest req) {
		// TODO Auto-generated method stub
		req.setAttribute("reslutValue", "<h4>자유게시판</h4>");
	}

	private void loginFunc(HttpServletRequest req) {
		// TODO Auto-generated method stub
		req.setAttribute("reslutValue", "<h4>로그인</h4>");
	}

	private void registFunc(HttpServletRequest req) {
		req.setAttribute("reslutValue", "<h4>회원가입</h4>");
		
	}

	public FrontController() {
		// TODO Auto-generated constructor stub
	}

}
