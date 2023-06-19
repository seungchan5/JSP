<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>El 폼값 받기</h2>
	<%
		/*
			요청시 받아온 파라메터를 출력
			
			request.getParameter("name속성명")
			${param.name속성명}
	
			request.getParameterValues("name속성명")
			${paramValues.name속성명[배열번호]}
			
			체크박스는 선택된 내용만 넘어옵니다
			null에 대한 오류처리없이 사용할 수 있습니다.
		*/
	%>
	<ul>
		<li>이름: ${param.name }</li>
		<li>성별: ${param.gender }</li>
		<li>학력: ${param.grade }</li>
		<li>관심사항: ${paramValues.inter[0] }
					${paramValues.inter[1] }
					${paramValues.inter[2] }
					${paramValues.inter[3] }</li>
	</ul>
</body>
</html>