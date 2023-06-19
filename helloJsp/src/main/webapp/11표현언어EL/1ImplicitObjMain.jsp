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
		/*
			표현언어 EL(Expression Language)
			변수와 값을 출력할때 사용하는 스크립트 언어
			
			4가지 영역에 지정된 값을 출력
			사용법이 간결하고 예외와 형변환에 관대합니다
			
			서블릿에서 처리된 결과는 영역을 통해 전달되고
			표현언어로 접근하여 쉽게 출력할 수 있습니다.
			
			- JSP 내장객체의 영역에 담긴 속성을 사용합니다
			- 산술연산, 논리연산, 비교연산이 가능 합니다
			- 자바 클래스에 정의된 메서드를 호출할 수 있습니다.
			
			기본사용법
			$(영역, 속성)
			변수에 접근하기 위해서는 영역을 지정해주어야 합니다.
			
			페이지영역			: pageScope
			요청영역			: requestScope
			세션영역			: sessionScope
			어플리케이션 영역		: applicationScope
			
			${requestScope.saveVar}
	
			요청 파라메터
			request.getParameter("매개변수명")
			${param.매개변수명}
			${param["매개변수명"]}
			${param['매개변수명']}
			
			한글, 특수문자가 입력된 경우 대괄호([])를 이용해야 요류가 발생하지 않습니다.
			ex) ${param["user-agent"]}
				${param["한글"]}
		*/
	%>
	
	<%
		pageContext.setAttribute("scopeValue", "페이지영역");
		request.setAttribute("scopeValue", "리퀘스트영역");
		session.setAttribute("scopeValue", "세션영역");
		application.setAttribute("scopeValue", "어플리케이션영역");
	%>
	
	<h2>각 영역에 저장된 속성 읽기</h2>
	<ul>
		<li>페이지영역:
			${pageScope.scopeValue }</li>
			
		<li>리퀘스트영역:
			${requestScope.scopeValue }</li>
			
		<li>세션영역:
			${sessionScope.scopeValue }</li>
		<li>어플리케이션영역:
			${applicationScope.scopeValue }</li>
	</ul>
	
	<h2>영역 지정 없이 속성 읽기</h2>
	<ul>
		<li>${scopeValue }</li>
	</ul>
	
	<!-- forward는 기존 출력은 무시되고 페이지를 이동한다 -->
	<jsp:forward page="ImplicitForwardResult.jsp"></jsp:forward>
</body>
</html>