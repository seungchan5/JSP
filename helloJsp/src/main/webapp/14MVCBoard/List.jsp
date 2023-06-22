<%@page import="model2.mvcboard.MVCBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="model2.mvcboard.MVCBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MVCBoardDao dao = new MVCBoardDao();
	List<MVCBoardDto> list = dao.getlist();
	
%>
	
	<c:forEach items="${list }" var="row" varStatus="loop">
		${row.idx }<br>
		${row.name }<br>
		${row.title }<br>
		===============================
	</c:forEach>

	<h2>MVC 모델2 게시판</h2>
	
	<form action="">
		<table border="1" width="90%">
			 <tr>
        		<td align="center">
            		<select name="searchField"> 
                		<option value="title">제목</option> 
                		<option value="content">내용</option>
            		</select>
            		<input type="text" name="searchWord"/>
            		<input type="submit" value="검색하기" />
        		</td>
    		</tr>  
		</table>
	</form>
	<table border="1" width="90%">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
			<th>첨부</th>
		</tr>
<%
	if(list.isEmpty()){
		
%>
		<tr>
			<td colspan="6" align="center">등록된 게시물 없음</td>
		</tr>
<%
	} else {
		for(MVCBoardDto board : list){
%>
	<tr align="center">
		<td><%=board.getIdx() %></td>
		<td><%=board.getTitle() %></td>
		<td><%=board.getName() %></td>
		<td><%=board.getVisitcount() %></td>
		<td><%=board.getPostdate() %></td>
		<td></td>
	</tr>
<%
	}
}
%>	
	</table>
	
	
	
</body>
</html>