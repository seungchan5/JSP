<%@page import="java.util.ArrayList"%>
<%@page import="dto.PageDto"%>
<%@page import="dto.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="dao.NewBoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<%
	
	// 검색조건
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	
	if(searchWord == null){
		searchWord = "";
	}
	
	
	// 페이지번호
	int pageNo = request.getParameter("pageNo")==null? 1:Integer.parseInt(request.getParameter("pageNo"));
	
	Criteria criteria = new Criteria(searchField,searchWord, pageNo);
	
	NewBoardDao dao = new NewBoardDao();
	//List<Board> list = dao.getListpage(criteria);
	
	List<Board> list = new ArrayList<Board>(dao.getListpage(criteria));
	
	int totalCnt = dao.getTotalCnt(criteria);
	
	out.print("총건수 : " + totalCnt);
%>
<body>
<!-- 
	/:절대경로
	../ : 상위폴더
 -->
<%@include file="/6세션/Link.jsp" %>
    <h2>목록 보기(List)</h2>
    <!-- 검색폼 --> 
    <form method="get" name="searchForm"> 
    <input type='text' name='pageNo' value='<%=criteria.getPageNo()%>'> 
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord"/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
        
	        <!-- 목록의 내용 -->
	        <!-- EL에서 사용하기 위해 변수를 페이지영역에 저장 -->
	<c:set var="list" value="<%=list %>"/>
	 
	 <!-- 리스트가 비어있는지 확인 -->
	<c:if test="${empty list }" var="res">
		<tr>
			<td colspan="5" align="center">등록된 게시물이 없습니다</td>
		</tr>
	</c:if>
	
	<!-- 리스트가 비어있지 않다면 리스트를 출력 -->
	<c:if test="${not res }">
	<!-- 반복문을 통해 리스트에 담긴 board객체를 출력 
		items : 향상된 for문
	-->
	<c:forEach items="${list }" var="board">
	<tr align="center">
	            <td>${board.num }</td>  <!--게시물 번호-->
	            <td align="left">  <!--제목(+ 하이퍼링크)-->
	               <a href="View.jsp?num=${board.num }&pageNo=<%=criteria.getPageNo()%>">${board.title }</a> 
	            </td>
	            <td align="center">${board.id }</td>          <!--작성자 아이디-->
	            <td align="center">${board.visitcount }</td>  <!--조회수-->
	            <td align="center">${board.postdate }</td>    <!--작성일-->
	        </tr>	
	</c:forEach>
	</c:if>


    </table>
    
    <!--목록 하단의 [글쓰기] 버튼-->
    <c:if test="${ not empty sessionScope.UserId }">
     <table border="1" width="90%">
        <tr align="right">
            <td><button type="button" onclick="location.href='/Write.jsp'">글쓰기</button></td>
        </tr>
    </table>
    </c:if>
    
    <!-- 
    	페이지블럭 생성시작
    	- 총 건수
    	- 쿼리수정
    	- form의 이름을 searchForm으로 지정
    	- pageNo 필드 생성
     -->
<%
	PageDto pageDto = new PageDto(totalCnt, criteria);	
%>
<table border='1' width="90%">
	<tr>
		<td align="center">
			<%@include file="/9페이지/PageNavi.jsp" %>
		</td>
</tr>
</table>
</body>
</html>
