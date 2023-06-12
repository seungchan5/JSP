<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.ConnectionUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>외부 설정파일로부터 DB접속정보를 읽어 오기</title>
</head>
<body>
	<%
		Connection conn = ConnectionUtil.getConnection(application);
	
		PreparedStatement psmt = conn.prepareStatement("select sysdate from dual");
		
		ResultSet rs = psmt.executeQuery();
		
		rs.next();
		out.print(rs.getString(1));
	%>
</body>
</html>