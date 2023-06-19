<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 파라메터를 입력받아 Dto객체 생성
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board board = new Board(num, title, content, "","","");
	
	// 게시물 업데이트
	BoardDao dao = new BoardDao();
	int res = dao.update(board);
	
	if(res > 0){
		//성공 : 메세지 출력 후 상세페이지로 이동
		JSFunction.alertLocation("수정이 완료되었습니다", "View.jsp?num="+board.getNum(), out);
	} else {
		// 실패 : 메세지 출력 이후 이전 페이지로 이동
		JSFunction.alertBack("수정 중 오류가 발생하였습니다", out);
	}
%>
</body>
</html>