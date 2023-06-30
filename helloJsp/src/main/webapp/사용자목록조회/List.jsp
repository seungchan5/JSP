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
<%@ include file="header.jsp" %>
	<h2>사용자 목록</h2>
	총건수 : ${totalCnt }
	<form method="get" name="searchForm" action="../mem/list.do"> 
	<input type="text" name="pageNo">
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="id">아이디</option> 
                <option value="name" ${param.searchField eq "name" ? "selected" : ""}>이름</option>
            </select>
            <input type="text" name="searchWord" value="${param.searchWord }"/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <table border='1'>
    	<tr>
			<th width="5%"></th>
			<th width="20%">아이디</th>
			<th width="10%">이름</th>
			<th width="20%">관리자여부</th>
		</tr>
	<c:if test="${empty list}">
			<tr>
				<td colspan="4" class="center">등록된 게시물 없음</td>
			</tr>
		</c:if>
    <c:forEach items="${list }" var="list" step="1">
    	<tr>
    		<td><input type="checkbox" value="${list.no }"></td>
    		<td>${list.id }</td>
    		<td>${list.name }</td>
    		<td>${list.adminyn }</td>
    	</tr>
    </c:forEach>
  	
  	<tr>
  	<td colspan='4'>
				<%@include file="PageNavi.jsp" %>
			</td>
		</tr>
  	</table>
  	
    
    
</body>
</html>