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
		액션태그는 태그의 형태를 지니고 있어 소스의 이질감이 줄어들고
		jsp코드보다 훨씬 짧은 코드로 동일한 기능을 구현할 수 있다
	 -->
	<h2>자바빈을 활용한 매개변수 전달</h2>
	
	<%
		request.setCharacterEncoding("utf-8");
	%>

	<jsp:useBean id="person" class="dto.Person" scope="request"></jsp:useBean>
	
	이름 : <jsp:getProperty property="name" name="person"/>
	나이 : <jsp:getProperty property="age" name="person"/>
	
	<h2>forward된 페이지에서 매개변수 확인</h2>
	<%=request.getParameter("param1") %><br>
	<%=request.getParameter("param2") %><br>
	<%=request.getParameter("param3") %><br>
	
	<!-- jsp:include 액션태그를 이용해 다른페이지를 불러올때
	jsp:param 액션태그를 이용시 파라메터를 전달할 수 있습니다 -->
	<h2>jsp:include페이지에 파라메터 넘기기</h2>
	<jsp:include page="inc/ParamInclude.jsp">
		<jsp:param value="서울 구로구" name="loc1"/>
		<jsp:param value="개봉동" name="loc2"/>
	</jsp:include>
</body>
</html>