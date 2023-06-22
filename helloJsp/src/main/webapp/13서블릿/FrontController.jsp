<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>하나의 매핑으로 여러 요청 처리하기</h3>
	${resultValue }
	
	<ul>
		<li>URI : ${uri }</li>
		<li>요청명 : ${commandStr }</li>
	</ul>
	
	<ul>
		<li><a href="../13서블릿/regist.one">회원가입</a></li>
		<li><a href="../13서블릿/login.one">로그인</a></li>
		<li><a href="../13서블릿/freeboard.one">자유게시판</a></li>
	</ul>
</body>
</html>