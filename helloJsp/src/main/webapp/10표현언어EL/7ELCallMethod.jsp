<%@page import="utils.CookieManager"%>
<%@page import="el.MyELClass"%>
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
		MyELClass myClass = new MyELClass();
		pageContext.setAttribute("myClass", myClass);
		pageContext.setAttribute("response", response);
		
	%>
	
	<h3>영역에 저장 후 메서드 호출하기</h3>
	001129-3000000 => ${myClass.getGender("001129-3000000")}<br>
	001129-2000000 => ${myClass.getGender("001129-2000000")}<br>
	
	<h3>정적메소드 호출하기</h3>
	${MyELClass.showGugudan(7) }
	
	<h3>정적메소드 호출하기 - 쿠키생성하기</h3>
	${CookieManager.makeCookie(response, "ELCookie", "EL좋아요", 10) }<br>
	${cookie.ELCookie.value }
	
	<h3>메서드 호출하기</h3>
	${"123-123".replace("-","") }
</body>
</html>