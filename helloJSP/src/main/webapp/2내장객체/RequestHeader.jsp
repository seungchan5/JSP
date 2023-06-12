<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - request </title>
</head>
<body>

	<h2>3. 요청 헤더 정보 출력하기</h2>
	
	<%
		// Enumberation : 객체들을 집합체 형태로 관리하게 해주는 인터페이스
		// Iterator
		// 컬렉션에서 사용됨
		// list, set, map
		Enumeration headers = request.getHeaderNames();
		
		// Next()
		while(headers.hasMoreElements()){
			String headerName = (String)headers.nextElement();
			String headerValue = request.getHeader(headerName);
			
			out.print("헤더명 : " + headerName 
						+ "헤더값 : " + headerValue +"<br>");
		}
	
		
	%>
	<p>이 파일을 직접 실행하면 referer 정보는 출력되지 않습니다.</p>
	
</body>
</html>







