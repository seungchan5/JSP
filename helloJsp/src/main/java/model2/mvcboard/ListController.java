package model2.mvcboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리스트 조회
		MVCBoardDao dao = new MVCBoardDao();
		List<MVCBoardDto> list = dao.getlist();
		// request영역에 저장
		req.setAttribute("list", list);
		// 화면 페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
	
	public ListController() {
		// TODO Auto-generated constructor stub
	}

}
