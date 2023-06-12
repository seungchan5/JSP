<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>JSP에서 JAVA코드를 작성하는 방법</h2>
	<p>JSP Scripting Element
		<ul>
			<li>선언문	:	변수, 메서드를 선언 (전역변수, 메서드)</li>
			<li>스크립트릿	: 	자바코드를 작성 (지역변수)</li>
			<li>표현식	: 	값을 출력</li>
		</ul>
	</p>
	<!-- 선언부 -->
	
	<p>JSP파일이 서블릿 파일로 변환시 
		_jspService()메서드 외부에 작성되어 
		
		전역변수, 메서드 생성</p>
	<%!
		// 선언부
		// 전역변수를 선언
		String str = "Java Server Page";
		// 메서드를 선언
		public int add(int num1, int num2){
			return num1 + num2;
		}
	%>
	<!-- 스크립틀릿 -->
	<p>자바코드를 작성하는 영역</p>
	<p>JSP파일이 서블릿 파일로 변환시 
		_jspService()메서드 내부에 기술</p>
	<p>메서드 선언 불가!</p>
	<%
		// 지역변수 
		int res = add(10,20);
	%>
	<!-- 표현식 -->
	<p>변수, 상수, 수식등을 출력</p>
	<p>실행결과 하나의 값이 남는문장을 화면에 출력</p>
	<h1><%= str%></h1>
	<h1><%= res%></h1>
	<h1><%= add(10,20)%></h1>
	
	
	<h3>서블릿으로 변환된 JSP파일의 위치</h3>
	<p>
	워크스페이스\.metadata\.plugins\org.eclipse.wst.server.core
					\tmp0\work\Catalina\localhost\ROOT\org\apache\jsp
	</p>
	
	
	
	
	
	
	
	
	
</body>
</html>