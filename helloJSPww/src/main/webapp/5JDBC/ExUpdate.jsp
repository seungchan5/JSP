<%@page import="dao.MemberDao"%>
<%@page import="dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원 추가 테스트</h2>
	
	<%
		Member member = new Member("id","pw","이름","");
		MemberDao dao = new MemberDao();
		int res = dao.insert(member);
		
		if(res>0){
			out.print(res+"건 입력 되었습니다");
		} else{
			out.print("입력 되지 않았습니다");
		}
	%>
</body>
</html>