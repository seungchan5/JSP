<%@page import="dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>Session</title></head>
<body>
	<jsp:include page="Link.jsp" />
    <h2>로그인 페이지</h2>
    <span style="color: red; font-size: 1.2em;"> 
    </span>
    <%=
    	request.getAttribute("LoginErrMsg") == null?"":request.getAttribute("LoginErrMsg")
    %>
    
    <!-- 
    	1. 로그인 성공시 로그인폼을 화면에 보여주지 않음
    	2. ~님 환영합니다. 제목태그를 이용해서 출력
    	3. header영역(link.jsp)의 로그인링크를 로그아웃으로 수정
     -->
        
        <%
        	// 로그인 되었는지 확인
        	if(session.getAttribute("UserId")== null){
        %> 
    <form action="LoginProcess.jsp" method="post" name="loginFrm"
        onsubmit="return validateForm(this);">
        아이디 : <input type="text" name="user_id" required="required"/><br />
        패스워드 : <input type="password" name="user_pw" required="required"/><br />
        <input type="submit" value="로그인하기" />
    </form>
    <%} else {
    	
    		String name = "";
    		if(session.getAttribute("member") != null){
    			Member member = (Member)session.getAttribute("member");
    			name = member.getName();
    		}
    %>
    	<h2><%=name %>님 환영합니다</h2>
    <%} %>
    
</body>
</html>