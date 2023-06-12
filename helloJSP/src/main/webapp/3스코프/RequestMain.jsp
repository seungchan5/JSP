<%@page import="dto.Person"%>
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
		request.setAttribute("request_str", "request영역에 문자열을 저장");
		request.setAttribute("request_person", new Person("미미",25));
	%>
	
	<h2>request 영역의 속성값 읽어오기</h2>
	<%
		String str = (String)request.getAttribute("request_str");
		Person person = (Person)request.getAttribute("request_person");
		String request_int = (String)request.getAttribute("request_int");
	%>
	
	<ul>
		<li><%=str %></li>
		<li><%=person.getName() %>, <%=person.getAge() %></li>
		<li><%=request_int %></li>
	</ul>
	
	<h2>request 영역의 속성값 삭제하기</h2>
	<%
		request.removeAttribute("request_str");
		request.removeAttribute("request_int");
	%>
	
	request_str 삭제 : <%= request.getAttribute("request_str") %>
	
	<h2>forward된 페이지에서 request 영역 속 값 읽기</h2>
	<%
		request.getRequestDispatcher("RequestForward.jsp?name=하니&age=18").forward(request, response);
	%>
</body>
</html>