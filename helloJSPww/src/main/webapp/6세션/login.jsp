<%@page import="utils.CookieManager"%>
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
			// 쿠키에 저장된 아이디 보여주기
			// 쿠키에 저장된 아이디가 있다면 id필드의 value속성에 아이디 값을 넣기	

			String userId = CookieManager.readCookie(request, "userId");
			
			/*
			String userId="";
			Cookie[] cookies = request.getCookies();
			if(cookies != null){
				for(Cookie cookie : cookies){
					if("userId".equals(cookie.getName())){
						userId = cookie.getValue();
						out.print("userId : " + userId);
						
						break;
					}
				}
			}
			*/
			
		
			String name = request.getParameter("name");
			if(name != null && !name.equals("")){
				out.print("<h1>"+ name + "님 환영합니다</h1>");
			}else{
		%>
            <div class='loginbox'>
            	<div id='login'>
            				   <input type="text" name="userid" id="userid" placeholder='ID를 입력해주세요.' required="required" value="<%=userId %>"><br>
                               <input type="password" name="userpw" id="userpw" placeholder='PW를 입력해주세요.' required="required"><br>
                               <input type="checkbox" name="save_check" value="Y">아이디 저장하기<br>
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