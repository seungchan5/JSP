<%@page import="common.JSFunction"%>
<%@page import="dao.NewBoardDao"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../6세션/isLogin.jsp" %>
<%@include file ="../6세션/Link.jsp" %>
<%
	Board board = new Board();
	
	board.setTitle(request.getParameter("title"));
	board.setContent(request.getParameter("content"));
	board.setId(session.getAttribute("UserId").toString());
	
	NewBoardDao dao = new NewBoardDao();
	int res = dao.insert(board);
	
	if(res > 0){
		// 등록 성공
		JSFunction.alertLocation("게시글이 등록 되었습니다", "List.jsp", out);
		
	} else {
		// 등록 실패
		JSFunction.alertBack("게시글 등록중 오류가 발생하였습니다.", out);
	}
%>
</body>
</html>