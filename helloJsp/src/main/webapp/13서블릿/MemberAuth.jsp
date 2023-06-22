<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>MVC패턴으로 회원 인증하기</h2>
	
	<p>${authMessage }</p>
	<a href="./MemberAuth.mvc?id=test1&pw=1234">
		test로그인
	</a>
</body>
</html>