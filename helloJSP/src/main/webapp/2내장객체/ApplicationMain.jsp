<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - application</title>
</head>
<body>
	<!-- 
		application 내장객체
			웹 어플리케이션당 하나만 생성되며 모든 jsp페이지에서 접근할 수 있는 객체
			ServletContext타입으로 웹 어플리케이션 전반에 이용하는 정보를 저장하거나
			서버의 정보, 서버의 물리적 경로등을 얻어오는데 사용 합니다.
		
		web.xml (배포서술자)
			웹 어플리케이션에 대한 여러가지 설정을 저장하는 파일
			
		서버의 물리적 경로 : 이클립스에서 지정한 임의의 경로가 출력
	 -->
	 <%
	 	// xml에 설정한 파라메터 읽어오기
	 	String init = application.getInitParameter("INIT_PARAM");
	 	// 서버에 물리적 경로 읽어오기
	 	String path = application.getRealPath("/내장객체");
	 %>
	 <h1>application</h1>
	 초기화 매개변수 : <%=init %> <br>
	 내장객체의 물리적 주소 : <%=path %>
	 
	 <h2>선언부에서 application 내장객체 사용하기</h2>
	 <%!
	 	// 메서드 선언, 필드 선언
	 	public String useImplicitObject(){
		 return this.getServletContext().getRealPath("/내장객체");
	 	}
	 
	 	public String useImplicitObject(ServletContext app){
	 		return app.getRealPath("/내장객체");
	 	}
	 %>
	 
	 <ul>
	 	<li>this사용 : <%=useImplicitObject()  %></li>
	 	<li>내장객체를 인수로 전달 : <%=useImplicitObject(application) %></li>
	 </ul>
</body>
</html>