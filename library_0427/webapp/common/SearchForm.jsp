<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 검색 폼 시작 -->
	<form method="get" name="searchForm">		
		<!-- 페이지 번호 -->
		<input type="text" name="pageNo">
		
		<table border="1" width="90%">
			 <tr>
        		<td align="center">
            		<select name="searchField"> 
                		<option value="title">제목</option> 
                		<option value="content" ${param.searchField eq "content" ? "selected" : ""}>내용</option>
            		</select>
            		<input type="text" name="searchWord" value="${param.searchWord }">
            		<input type="submit" value="검색하기">
        		</td>
    		</tr>  
		</table>
	</form>
</body>
</html>