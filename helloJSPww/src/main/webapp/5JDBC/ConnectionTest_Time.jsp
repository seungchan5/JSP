<%@page import="common.DBConnectionPool"%>
<%@page import="common.ConnectionUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>ConnectionUtil을 이용한 커넥션 생성</h2>
	
	<%
		long sTime, eTime;
		sTime = System.currentTimeMillis();
		
		for(int i=0; i<100; i++){
			Connection con1 = ConnectionUtil.getConnection(application);
			System.out.println("con1 : "+con1);
			con1.close();
		}
		
		eTime = System.currentTimeMillis();
		out.print("100개 생성시 걸리는 시간 : " + (eTime-sTime) + "ms");
		
	%>
	
	<h2>커넥션 풀 테스트</h2>
	
	<%
		sTime = System.currentTimeMillis();
		
		for(int i=0; i<100; i++){
			Connection con2 = DBConnectionPool.getConnection();
			System.out.println("con2 : "+con2);
			con2.close();
		}
		
		eTime = System.currentTimeMillis();
		out.print("100개 생성시 걸리는 시간 : " + (eTime-sTime) + "ms");
		
	%>
</body>
</html>