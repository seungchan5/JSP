<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style1.css">
<script type="text/javascript">
	
	let message = '${message}';
	if(message != null && "" != message){
		alert(message);
	}
	
	function deleteBook(){
		// 체크박스가 선택된 요소는 value값을 ,로 연결
		delNoList = document.querySelectorAll("[name=delNo]:checked");
		
		let delNo = "";
		delNoList.forEach((e)=>{
			delNo += e.value + ',';
		});
		
		delNo = delNo.substr(0, delNo.length-1);
		console.log("삭제할 번호 : "+delNo);
		// 삭제 요청
		searchForm.action= "../book/delete.book";
		searchForm.delNo.value= delNo;
		searchForm.submit();
	}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<h2>도서목록</h2>
	총 건수 : ${map.totalCnt }
	<!-- 검색 폼 시작 -->
	<%@ include file="../common/SearchForm.jsp" %>
	<!-- 검색 폼 끝 -->
	
	<table border="1">
		<c:if test="${sessionScope.adminYn eq 'Y' }">
		<tr>
			<td colspan="5" class="right">
				<!-- 어드민 계정인 경우 등록, 삭제 버튼을 출력 -->
				<button onclick="location.href='./write.book'">도서등록</button>
				<button onclick="deleteBook()">도서삭제</button>
			</td>
		</tr>
		</c:if>
		<!-- 목록 출력 -->
		<tr>
			<th width="5%"></th>
			<th width="20%">제목</th>
			<th width="10%">저자</th>
			<th width="20%">대여여부/반납일</th>
			<th width="20%">등록일</th>
		</tr>
		<c:if test="${empty map.list}" var="res">
			<tr>
				<td colspan="5" class="center">등록된 게시물 없음</td>
			</tr>
		</c:if>
		<c:if test="${not res }">
			<c:forEach items="${map.list }" var="book" step="1">
				<tr>
					<td class="center">
						<!-- 삭제용 체크박스 -->
						<input type="checkbox" name="delNo" value="${book.no }">
					</td>
					<td>
						<a href="../book/view.book?no=${book.no}">
							${book.title }
						</a>
					</td>
					<td>${book.author }</td>
					<td>${book.rentyn }</td>
					<td></td>
				</tr>
			</c:forEach>
		</c:if>
		<tr>
		<!-- 페이징 -->
			<td colspan='5'>
				<%@include file="../common/PageNavi.jsp" %>
			</td>
		</tr>
	</table>	
	<!-- 상세 -->
	
	<!-- 삭제 -->
	<!-- 등록 -->
</body>
</html>