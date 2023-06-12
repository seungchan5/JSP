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
   <%
      String id = request.getParameter("userid");
      String pw = request.getParameter("userpw");
      String saveCheck = request.getParameter("saveCheck");
      
      out.print("saveCheck : " +saveCheck);
      // 체크박스가 체크되었을경우, 아이디를 쿠키에 저장
      if(saveCheck != null && saveCheck.equals("Y")){
    	  out.print("쿠키 생성");
    	  CookieManager.makeCookie(response, "userId", id, 60*60*24*7);
      }
      
      if("abc".equalsIgnoreCase(id) && "123".equals(pw)){
         // 로그인 성공
		 // 세션영역에 id 저장         
         session.setAttribute("id", id);
         
         response.sendRedirect("gogreen.jsp");
         //response.sendRedirect("gogreen.jsp?name="+id);
      } else {
         // 로그인 실패
         response.sendRedirect("gogreen.jsp?loginErr=Y");
      }
   %>
</body>
</html>