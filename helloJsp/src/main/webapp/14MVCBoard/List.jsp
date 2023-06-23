<%@page import="dto.Criteria"%>
<%@page import="model2.mvcboard.MVCBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="model2.mvcboard.MVCBoardDao"%>
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

	<h2>MVC 모델2 게시판</h2>
	
	
	<h4>총 게시물 수 : ${totalCnt }</h4>
	<!-- 검색 폼 -->
	<form method="get" name="searchForm">
		<table border="1" width="90%">
		<input type="hidden" name="pageNo">
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
	
	<!-- 목록 테이블 -->
	<table border="1" width="90%">
		<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>첨부</th>
		</tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td colspan="6">등록된 게시물이 없습니다</td>
				</tr>
			</c:when>
			
			<c:otherwise>
				<!-- 게시물 출력 -->
				<c:forEach items="${list }" var="row" varStatus="loop">
					<tr>
						<td>${row.idx }</td>
						<td><a href="../mvcboard/view.do?idx=${row.idx }">${row.title }</a></td>
						<td>${row.name }</td>
						<td>${row.visitcount }</td>
						<td>${row.postdate }</td>
						<td>첨부파일</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<!-- 
		글쓰기 버튼 달기
		글쓰기 버튼 클릭시 클쓰기 페이지로 이동 -> 작성완료 버튼 클릭하면 글 등록 
	-->
	<form>
		<table border="1" width="90%">
			<tr>
				<td align="right">
					<input type='button' value="글쓰기" onclick="location.href='../14MVCBoard/Write.jsp';">
				</td>
			</tr>
		</table>
	</form>
	<table border="1" width="90%">
		<tr>
			<td align="center"><%@include file="../9페이지/PageNavi.jsp" %></td>
		</tr>
	</table>
	
	
</body>
</html>