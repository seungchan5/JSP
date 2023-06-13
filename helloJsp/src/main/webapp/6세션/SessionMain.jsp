<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		Session
		클라이언트의 상태 정보를 저장합니다
		로그인 기능을 구현 하는데 사용됩니다.
		
			http통신은 요청과 응답으로 구성되어 있습니다.
			클라이언트에서 서버로 페이지를 요청을하면 서버는 페이지를 응답해주고
			통신은 종료 된다.
			
			서버는 어떻게 로그인 상태를 유지하는가
			
			클라이언트에서 웹브라우저로 서버에 최초로 접근시
				-> 웹서버는 웹브라우저에게 세션아이디를 발급
				-> 세션아이디는 쿠키로 생성되어 응답객체의 쿠키에 담겨 클라이언트로 전송
				 	개발자도구의 쿠키를 확인해보면 JSESESSIONID라는 값이 입력되어 있습니다
				 	여기 저장된 값이 세션아이디 입니다.
			(웹브라우저를 새로 열고 서버에 접근시 쿠키에 저장된 세션ID값이 변경된것을 확인할 수 있다.)
			
		세션의 유지시간
			유지시간을 설정하지 않으면 기본 30분(1800초)이며,
			유지시간이 만료되기전 새로운 요청이 들어오면 유지시간이 연장됩니다
			
			클라이언트가 유지시간내 요청이 없는 경우 해당 세션은 서버에서 제거됩니다.
			
			클라이언트에서 JSESESSION 쿠키를 제거할 경우 서버는 새로운 세션아이디를 발급합니다
	 -->
	 

	 
	 <%
	 	// 설정파일을 이용할 경우 주석 처리
	 	//session.setMaxInactiveInterval(10);
	 
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
	 	
	 	long creationTime = session.getCreationTime(); // 최초 요청(세션 생성) 시각
	 	String creationTimeStr = sdf.format(new Date(creationTime));
	 	
		long lastTime = session.getLastAccessedTime(); // 마지막 요청시각
		String lastTimeStr = sdf.format(new Date(lastTime));
	 %>
	 
	 <h2>Session 설정확인</h2>
	 <ul>
	 	<li>최초 요청 시각 : <%=creationTimeStr %></li>
	 	<li>마지막 요청 시각 : <%=lastTimeStr %></li>
	 	<li>세션 아이디 : <%=session.getId() %></li>
	 	<li>세션 유지시간 : <%=session.getMaxInactiveInterval() %></li>
	 </ul>
</body>
</html>