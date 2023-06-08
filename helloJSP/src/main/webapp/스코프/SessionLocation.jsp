<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
	<h1>session 영역의 속성 읽기</h1>
	<%
	
		/*
			브라우저를 닫았다가 새로 열면
			쿠키에 저장된 세션ID값이 변경되므로 세션이 유지되지 않는다.
		*/
		if(session.getAttribute("person") != null){
			Person p = (Person)session.getAttribute("person");
			out.print(p.getName()+",");
			out.print(p.getAge()+"<br>");
		}else{
			out.print("session에 저장된 person객체가 없음");
		}
		if(session.getAttribute("list") != null){
			ArrayList<String> list = (ArrayList<String>)session.getAttribute("list");
			
			for(String str : list){
				out.print(str + "<br>");
			}
		}
	%>
</body>
</html>