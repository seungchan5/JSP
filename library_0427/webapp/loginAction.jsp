<%@page import="com.utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.library.service.MemberService" %>
<%@ page import="com.library.vo.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// name속성의 값을 매개값으로 넘겨주면 value속성의 값을 반환 합니다
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		 String saveCheck = request.getParameter("saveCheck");
	      
	      out.print("saveCheck : " +saveCheck);
	      // 체크박스가 체크되었을경우, 아이디를 쿠키에 저장
	      if(saveCheck != null && saveCheck.equals("Y")){
	    	  out.print("쿠키 생성");
	    	  CookieManager.makeCookie(response, "userId", id, 60*60*24*7);
	      }
		
		// lib 이동
		// Java Resource -> webapp/WEB-INF/lib
		MemberService service = new MemberService();
		Member member = service.login(id, pw);
		if(member != null && !member.getId().equals("")){
			// 로그인 성공
			session.setAttribute("member", member);
			out.print(member.getId() + "님 환영");
			if("admin".equals(member.getId())){
				// 관리자 페이지 호출
				response.sendRedirect("loginAdmin.jsp?error=Y");
			}else{
				// 사용자 페이지 호출				
				response.sendRedirect("loginMember.jsp?error=Y");
			}
		}else{
			// 로그인 실패
			// 로그인 화면으로 이동	
			response.sendRedirect("login.jsp?error=Y");
		}
		
		
		
	%>
</body>
</html>