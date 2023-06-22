<%@page import="java.net.URLEncoder"%>
<%@page import="fileupload.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="fileupload.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>DB에 등록된 파일 목록 보기</h2>
<a href="FileUpload.jsp">파일 등록하기</a><br>

<!-- 자바빈을 표현언어에서 사용하기 위해 변수로 선언 -->
<!-- jstl을 사용한 방법 -->
<%--<%
	FileDao dao = new FileDao();
	List<FileDto> list = dao.getFileList();
	out.print("총건수 : " + list.size());
%>
 --%> 




<c:set var="fileList" value="${requestScope.list }"/>

<table border="1">
	<tr>
		<th>No</th>
		<th>작성자</th>
		<th>제목</th>
		<th>카테고리</th>
		<th>원본 파일명</th>
		<th>저장된 파일명</th>
		<th>작성일</th>
		<th></th>
	</tr>

<c:forEach items="${fileList }" var="fileDto">
	<tr>
		<td>${fileDto.idx }</td>
		<td>${fileDto.name }</td>
		<td>${fileDto.title }</td>
		<td>${fileDto.cate }</td>
		<td>${fileDto.ofile }</td>
		<td>${fileDto.sfile }</td>
		<td>${fileDto.postdate }</td>
		<td><a href="Download.jsp?oName=${fileDto.ofile }&sName=${fileDto.sfile }">다운로드</a></td>
	</tr>
</c:forEach>

</table>
</body>
</html>