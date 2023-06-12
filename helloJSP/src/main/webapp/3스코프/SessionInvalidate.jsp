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
		// 세션읜 기본 유효시간은 30분
		
		// 세션무효화
		session.invalidate();
	%>
	세션이 무효화 되었습니다.
	<a href="SessionLocation.jsp">SessionLocation.jsp 바로가기</a>
</body>
</html>