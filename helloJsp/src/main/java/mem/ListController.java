package mem;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Memdao;
import dto.Criteria;
import dto.Mem;
import dto.PageDto;


/**
 * Servlet implementation class ListController
 */
@WebServlet("/mem/list.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Memdao dao = new Memdao();
		

		// 검색어, 페이지정보 세팅
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String pageNo = req.getParameter("pageNo");
		
		Criteria criteria = new Criteria(searchField, searchWord, pageNo);
		
		criteria.setSearchField(req.getParameter("searchField"));
		criteria.setSearchWord(req.getParameter("searchWord"));
		
		// 검색어, 페이지 정보를 담은 객체를 매개변수로 넣어 줍니다
		List<Mem> list = dao.getList(criteria);
		
		int totalCnt = dao.getTotalCnt(criteria);
		
		PageDto pageDto = new PageDto(totalCnt, criteria);
		
		// request영역에 저장
		req.setAttribute("list", list);
		System.out.println(list);
		req.setAttribute("totalCnt", totalCnt);
		req.setAttribute("pageDto", pageDto);
		// 화면 페이지 전환
		req.getRequestDispatcher("/사용자목록조회/List.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
