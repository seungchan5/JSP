<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function go(page){
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
		
	}
</script>
</head>
<body>
	<!-- 
		PageDto객체를 가지고 페이지 블럭을 생성
		- 페이지블럭의 시작번호
		- 페이지블럭의 끝번호
		- 게시물의 끝 페이지 번호
		- 이전 버튼을 출력할지 여부
		- 다음 버튼을 출력할지 여부
	 -->
	 <!--  영역에 저장 -->
	 <c:set var="pageDto" value="${map.pageDto }"></c:set>
	 
	 <!-- 이전 버튼 -->
	 <c:if test="${pageDto.prev }">
	 	<!--  <a href='List.jsp?pageNo=${pageDto.startNo-1}'>이전</a>-->
	 	<input type='button' value='이전' onclick='go(${pageDto.startNo-1})'>
	 </c:if>
	 
	 <c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
	 	<!--  <a href='List.jsp?pageNo=${i }'>${i }</a>-->
	 	<input type='button' value='${i }' onclick='go(${i})'>
	 </c:forEach>
	 
	 <!-- 다음 버튼 -->
	 <c:if test="${pageDto.next }">
	 	<!--  <a href='List.jsp?pageNo="${pageDto.endNo+1 }'>다음</a> -->
	 	<input type='button' value='다음' onclick='go(${pageDto.endNo+1})'>
	 </c:if>

	 <%
	 /*
	 	// 총 게시물수, 검색조건(페이지번호, 페이지당 게시물 수, 검색어, 검색조건)
	 	int pageNo=request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
	 
	 	// totalCnt, pageNo를 세팅해줘야함
	 	int totalCnt=305;
	 	Criteria criteria = new Criteria(11);
	 	
	 	PageDto pageDto = new PageDto(totalCnt, criteria);
	 	*/
	 %>
</body>
</html>