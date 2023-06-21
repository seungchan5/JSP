<%@page import="fileupload.FileDao"%>
<%@page import="fileupload.FileDto"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		// 저장할 디렉토리의 실제 경로
		String saveDirectory = "C:/upload";
		
		// 파일의 최대 크기(1MB)
		int maxPostSize= 1024 * 1000;
		
		// 인코딩 방식
		String encoding = "utf-8";
		
		try{
			// 1. MultipartRequest 객체 생성
			//		생성자의 매개변수로 저장경로, 파일의 최대크기, 인코딩방식을 지정
			//		객체가 정상적으로 생성되면 파일은 업로드
			MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
			// 파일목록으로 이동
			
			// 폼 요소의 값을 저장
			String name = mr.getParameter("name");
			String title = mr.getParameter("title");
			// 체크박스인 경우, 배열로 반환받아서 문자열로 연결해서 저장
			String[] categoryArr = mr.getParameter("category");
			
			String ofileName = mr.getFilesystemName("attachedfile");
			
			System.out.println("name : "+name);
			System.out.println("title : "+title);
			System.out.println("category : "+ category);
			System.out.println("ofileName : "+ ofileName);
			
			//DTO 생성
			FileDto dto = new FileDto("", name, title, category, ofileName, "sfileName", "");
			
			//DAO를 통해 데이터 베이스에 등록
			FileDao dao = new FileDao();
			int res = dao.insertFile(dto);
			
			if(res>0) {
				out.print("등록 되었습니다");
				// 리스트 페이지로 이동
			} else{
				out.print("DB등록에 실패 하였습니다");
				// 이전페이지로 이동
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			out.print(e);
			request.setAttribute("errorMsg", "파일업로드 오류");
			
			// 이전페이지로 이동
		}
	%>
</body>
</html>