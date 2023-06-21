<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	//유효성 검사
	function validateForm(form){
		if(form.name.value == ''){
			alert("작성자를 입력하세요");
			form.name.focus();
			return false;
		}
		
		if(form.title.value == ''){
			alert("제목을 입력하세요");
			form.title.focus();
			return false;
		}
		
		if(form.attachedFile.value ==''){
			alert("첨부파일은 필수 입력 입니다");
			return false;
		}
		if(document.querySelectorAll("[name=category]:checked").length == 0){
			alert("카테고리를 선택해주세요")
			return false;
		}
	}
</script>
</head>
<body>
	<h3>파일 업로드</h3>
	<!-- 파일을 업로드하기위해 속성을 변경 
		method : post
		enctype : multipart/form-data
	-->
	<!-- 
	유효성검사, validation체크
	사용자입력체크 로직추가 -->
	<form action="UploadProcess.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm(this);">
		<p>
			작성자 : <input type="text" name="name" value="하니">
		</p>
		
		<p>
			제목 : <input type="text" name="title" value="제목">
		</p>
		<p>
			카테고리 : 
				<input type="checkbox" name="category" value="사진" checked>사진
				<input type="checkbox" name="category" value="과제">과제
				<input type="checkbox" name="category" value="워드">워드
				<input type="checkbox" name="category" value="음원">음원
		</p>
		<p>	
			첨부파일 : <input type="file" name="attachedFile">
		</p>
			<input type="submit" value="전송하기">
	</form>
	
	<!-- enctype : form값을 서버로 전송할때의 인코딩 방식을 지정
		- application/x-www-form-urlencoded(기본값)
			모든 문서를 서버로 전송하기 전에 인코딩
			
		- multipart/form-data
			<form>태그를 통해 파일을 서버로 전송할때 사용
			모든 문자를 인코딩하지 않음
	 -->
	 
	 <h3>다운로드</h3>
	 <a href="${pageContext.request.contextPath }/upload/사원정보.xlsx" download="파일명">다운로드</a>
</body>
</html>