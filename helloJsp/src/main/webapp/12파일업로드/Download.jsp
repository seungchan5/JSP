<%@page import="java.io.FileNotFoundException"%>
<%@page import="common.JSFunction"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
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
	// 업로드파일이 저장된 경로
	String saveDirectory = "C:/upload";
	// 원본 파일이름
	String originalFilename = request.getParameter("oName");
	// 저장된 파일이름
	String saveFileName = request.getParameter("sName");
	
	out.print("ofileName : " + originalFilename+"<br>");
	out.print("sfileName : " + saveFileName+"<br>");
	
	try{
		File file = new File(saveDirectory, saveFileName);
		out.print("file : "+file);
		
		// 파일 입력스트림 생성
		InputStream inStream = new FileInputStream(file);
		
		// 한글 파일명 깨짐 방지
		String client = request.getHeader("User-Agent");
		// ie 체크
		if(client.indexOf("WOW64")==-1){
			originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
		} else {
			originalFilename = new String(originalFilename.getBytes("KSC5601"), "ISO-8859-1");	
		}
		
		// 파일 다운로드용 응답 헤더 설정
		response.reset();
		
		// 파일 다운로드 창을 띄우기 위한 콘텐츠 타입을 지정
		// octet-stream은 8비트 단위의 바이너리 데이터를 의미
		response.setContentType("application/octet-stream");
		
		// 원본파일이름으로 다운로드 받울 수 있게 설정하는 부분
		response.setHeader("Content-Disposition", "attachment; filename=\""+originalFilename + "\"");
		response.setHeader("Content-Length", ""+file.length());
		
		// 출력스트림 초기화
		out.clear();
		// response 내장 객체로부터 새로운 출력 스트림을 생성
		OutputStream outStream = response.getOutputStream();
		
		// 출력 스트림에 파일 내용 출력
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while( (readBuffer = inStream.read(b)) > 0){
			outStream.write(b, 0, readBuffer);
		}
		
		// 입/출력 스트림 닫음;
		inStream.close();
		outStream.close();
	} catch (FileNotFoundException e){
		JSFunction.alertBack("파일을 찾울 수 없습니다", out);
			
	} catch (Exception e){
		JSFunction.alertBack("파일 다운로드 중 오류가 발생하였습니다", out);
	}
%>
</body>
</html>