<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action ="loginAction.jsp" method = "post">
		<%
			String name = request.getParameter("name");
			if(name != null && !name.equals("")){
				out.print("<h1>"+ name + "님 환영합니다</h1>");
			}else{
		%>
            <div class='loginbox'>
            	<div id='login'>
            	 <input type="text" name="userid" id="userid" placeholder='ID를 입력해주세요.'>
                               <input type="password" name="userpw" id="userpw" placeholder='PW를 입력해주세요.'>
                           </div>
                           <div id='button'>
                           <input type="submit" value="로그인">
                           </div>
                       </div>
                       <div id='info'>
                           <a href="">회원가입</a>
                           <a href="">ID찾기</a>
                           <a href="">PW찾기</a>
                       </div>
                    </form>
                    <%} %>
</body>
</html>