<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>영역을 통해 전달된 객체 읽기</h2>
	<%
		// 표현언어(EL)을 이용하면 형변환이 필요 없이 파라메터를 읽어올 수 있습니다.
		// 별도의 null처리를 하지 않아도 오류가 발생하지 않습니다
		// (현재페이지 리로드시 오류발생 안함)
		// 객체를 사용하기 위해서 임포트만 해주면 됩니다.
	%>
	<ul>
		<li>Person객체
			<p>아이디 : ${personObj.id }, 이름 :${personObj.name }</p>
		</li>
		<li>String 객체
			<p>${stringObj }</p>
		</li>
		<li>Integer 객체
			<p>${integerObj }</p>
		</li>
	</ul>
	
	<h2>매개변수로 전달된 값 읽기</h2>
	<ul>
		<li>${param.firstNum }</li>
		<li>${param.secondNum }</li>
		<!-- 중괄호 안에서만 연산 가능 -->
		<li>${param.firstNum + param.secondNum }</li>
		<li>${param.firstNum } + ${param.secondNum }</li>
		<li>${param['firstNum'] }</li>
		<li>${param['secondNum'] }</li>
	</ul>
</body>
</html>