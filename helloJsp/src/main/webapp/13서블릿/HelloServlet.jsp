<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	표현식 : <%=request.getAttribute("message") %> <br>
	EL : ${requestScope.message }<br>
	
	<!-- ./ : 현재경로 -->
	<!-- 13서블릿/HelloServlet.do -->
	<a href="./HelloServlet.do">HelloServlet.do 바로가기</a><br>
	<a href="${pageContext.request.contextPath }/13서블릿/AnnotationMapping.do">AnnotationMapping.do 바로가기</a>
</body>
</html>