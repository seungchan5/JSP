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
	// response 내장 객체로 부터 에러코드를 확인
	int status = response.getStatus();
	
	// 에러 코드에 맞게 적절한 메세지를 출력
	if(status==404){
		out.print("ERROR CODE : 404");
		out.print("<br>파일 경로를 확인해주세요");
	} else if(status==405) {
		out.print("ERROR CODE : 405");
		out.print("<br>요청방식(method)를 확인해주세요");
	} else if(status==500){
		out.print("ERROR CODE : 500");
		out.print("<br>관리자에게 문의해주세요");
	}
%>
</body>
</html>