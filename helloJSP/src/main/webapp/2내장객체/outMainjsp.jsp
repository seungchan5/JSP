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
		out객체
		웹브라우저에 변수 등의 값을 출력할때 사용
		스크립틀릿(< % 자바코드 %>) 내부에서 변수등을 출력하기 위해서 사용
	 -->
	 
	 <%
	 	// 버퍼내용 삭제하기
	 	out.print("즐거운 목요일"); // 버퍼에 저장
	 	out.clearBuffer();		// 버퍼를 비우기
	 	
	 	out.print("<h2>out 내장 객체</h2>");
	 	
	 	// 기본크기 8kb(1kb - 1024byte)
	 	out.print("출력 버퍼의 크기 : " + out.getBufferSize() + "<br>");
	 	out.print("남은 버퍼의 크기 : " + out.getRemaining() + "<br>");
	 	
	 	out. flush();			// 버퍼의 내용을 출력
	 	out.print("남은 버퍼의 크기 : " + out.getRemaining() + "<br>");
	 	
	 	// 다양한 타입을 출력할 수 있음
	 	out.print(1);
	 	out.print(false);
	 %>
</body>
</html>