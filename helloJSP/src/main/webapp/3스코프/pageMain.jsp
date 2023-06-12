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
<!-- 
	내장객체의 영역
		웹에서는 페이지들이 모여 하나의 요청을 처리하며
		요청들이 모여 하나의 세션을,
		세션이 모여 하나의 어플리케이션을 이룹니다.
		
	page 영역 : 동일한 페이지에서만 공유
	request 영역 : 하나의 요청에 의해 호출된 페이지 및 포워드 페이지
	session 영역 : 클라이언트가 처음 웹 브라우저로 접속한 후 웹브라우저를 닫을때까지
	application 영역 : 웹어플리케이션(웹서버)가 종료될때까지
	[사용방법]
	setAttribute(String name, Object value)
		각 영역에 속성을 저장
		Object타입을 받고 있으므로 모든 타입이 저장 가능
		
	getAttribute(name)
		영역에 저장된 속성값을 받아줌
		Object형태로 자동 형변환되어 저장되므로 원래 타입으로 형 변환 후 사용 가능
 -->
 
 <%
 	// 페이지 영역에 저장
 	pageContext.setAttribute("page", "페이지영역(스코프)");
 	pageContext.setAttribute("page_int", 10000);
 	pageContext.setAttribute("pagePerson",  new Person("하니",20));
 %>
 
 <h2>page 영역의 속성 값 읽기</h2>
 
 <%
 	// object 타입으로 변환 되므로 형 변환이 필요
 	String page_str = pageContext.getAttribute("page").toString();
 	int page_int = (Integer)(pageContext.getAttribute("page_int"));
 	Person page_person = (Person)(pageContext.getAttribute("pagePerson"));
 %>
 
 <ul>
 	<li>int : <%=page_int %></li>
 	<li>string : <%=page_str %></li>
 	<li>Person : <%=page_person.getName() %>, <%=page_person.getAge() %></li>
 </ul>
 
 	<h2>include된 파일에서 page영역 읽어오기</h2>
 	<p>include지시어로 감싼 JSP파일은 포함관계를 가지므로 같은 페이지</p>
 	<p>페이지 영역이 공유된다.</p>
 		<%@ include file = "PageInclude.jsp" %>
 		
 	<h2>페이지 이동 후 page영역 읽어오기</h2>
 	<!-- 링크를 이용해서 페이지를 다시 요청하게 되면 페이지 영역이 초기화 된다 -->
 	<a href = "PageLocation.jsp">PageLocation.jsp 바로가기</a>
 	
 	
 	
 	
 	
</body>
</html>