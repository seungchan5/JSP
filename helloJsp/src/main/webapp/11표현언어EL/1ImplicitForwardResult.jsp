<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h2>각 영역에 저장된 속성 읽기</h2>
	<ul>
		<li>페이지영역:
			${pageScope.scopeValue }</li>
			
		<li>리퀘스트영역:
			${requestScope.scopeValue }</li>
			
		<li>세션영역:
			${sessionScope.scopeValue }</li>
		<li>어플리케이션영역:
			${applicationScope.scopeValue }</li>
	</ul>
	
	<h2>영역 지정 없이 속성 읽기</h2>
	<ul>
		<li>${scopeValue }</li>
	</ul>
</body>
</html>