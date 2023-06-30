<%@page import="com.library.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/common/header.jsp" %>

<%
	// 세션에 저장된 멤버 객체로 부터 아이디를 출력 합니다.
	if(session.getAttribute("member")!=null){
		Member m = (Member)session.getAttribute("member");
%>
	
	<%=m.getId() %>님 환영합니다.
	<button onclick="location.href='logout.jsp'">로그아웃</button>
	<h2>관리자 메뉴</h2>
	<ul>
		<li>도서등록</li>
		<li>도서삭제 - 도서 상세보기 삭제버튼을 이용하세요</li>
		<li>관리자등록</li>
		<li>관리자삭제</li>
		
	</ul>
	
<%
	}
%>
</body>
</html>