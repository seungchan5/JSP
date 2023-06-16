<%@page import="dto.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
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
	// 검색조건
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	String pageNo = request.getParameter("pageNo");
	
	// 검색조건 객체로 생성
	Criteria criteria = new Criteria(searchField, searchWord, pageNo);
	
	// 게시판 DB 작업 - DAO생성
	BoardDao dao = new BoardDao();
	
	// 리스트 조회
	//List<Board> boardList = dao.getList(searchField, searchWord);
	List<Board> boardList = dao.getListPage(criteria);
	
	// 총 건수 조회
	int totalCnt = dao.getTotalCnt(criteria);
	
	
%>

<jsp:include page="Link.jsp"></jsp:include>

	<h2>목록보기(List)</h2>
총건수 : <%=totalCnt %>

<!-- 검색폼 -->

<form name='searchForm'>
<input type='hidden' name='pageNo' value='<%=criteria.getPageNo()%>'>
	<table border="1" width="90%">
		<tr>
			<td align="center">
				<select name="searchField">
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchWord" value="<%=criteria.getSearchWord() %>">
				<input type="submit" value="검색하기">
			</td>
		</tr>
	</table>
</form>
<!-- 검색폼 끝 -->

<table border='1' width="90%">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
	</tr>
<%
	if(boardList.isEmpty()){
		// 게시글이 하나도 없으면	
%>
<tr>
	<td colspan="5" align="center">등록된 게시물 없음</td>
</tr>
<%
	} else{
		for(Board board : boardList){
%>
<tr>
	<td><%=board.getNum() %></td>
	<td><a href="View.jsp?num=<%=board.getNum() %>"><%=board.getTitle() %></a></td>
	<td><%=board.getId()%></td>
	<td><%=board.getVisitcount() %></td>
	<td><%=board.getPostdate() %></td>
</tr>

<%
	}
}
%>
</table>

<%if(session.getAttribute("UserId") != null){ %> 
<table border="1" width="90%">
		<tr>
			<td align="right">
					<input type="submit" value="글쓰기" onclick="location.href='Write.jsp'">
			</td>
		</tr>
	</table>
<%} %>

<!-- 페이지블럭 생성 시작 -->
<%
	PageDto pageDto = new PageDto(totalCnt, criteria);	
%>
<table border='1' width="90%">
	<tr>
		<td align="center">
			<%@include file="PageNavi.jsp" %>
		</td>
</tr>
</table>
</body>
</html>









