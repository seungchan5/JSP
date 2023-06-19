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
<%@include file="Link.jsp" %>
<h2>수정하기</h2>

<%
	String num = request.getParameter("num");
	BoardDao dao = new BoardDao();
	// 1건의 게시물을 조회
	Board board = dao.selectOne(num);
%>
<form action="EditProcess.jsp" method="post">
<input type = "text" value="<%=num%>" name="num">

	<table border="1" width="90%">
		<tr>
			<td>제목</td>
			<td><input type="text" value="<%=board.getTitle() %>" name="title" style="width:90%"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="content" style="width:90%; height:100px;"><%=board.getContent() %></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">수정하기</button>
				<button type="reset">초기화</button>
				<button type="button" onclick="location.href='Board.jsp'">목록 보기</button>
				
			</td>
		</tr>
	</table>
</form>
</body>
</html>