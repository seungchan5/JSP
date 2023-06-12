<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>페이지 이동 후 page영역의 속성값 읽기</h1>
	<%
		Object page_str = pageContext.getAttribute("page");
		Object page_int = pageContext.getAttribute("page_int");
		Object page_Person = pageContext.getAttribute("pagePerson");
	%>
	
	<ul>
		<li>int : 
			<%= (page_int == null)? "값 없음": page_int %>
		</li>
		<li>string : 
			<%= (page_str == null)? "값 없음": page_str %>
		</li>
		<li>person : 
			<%= (page_Person == null)? "값 없음": page_Person %>
		</li>
	</ul>
</body>
</html>