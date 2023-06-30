package common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	
	/**
	 * 파일 다운로드
	 * @param request
	 * @param response
	 * @param saveDirectroy
	 */
	// 매개변수에 넣어주어 getParameter 값이 수시로 변경되어도 공통으로 사용할수있게 해줍니다.
//	public static void download(HttpServletRequest request, HttpServletResponse response, String saveDirectroy) {
	public static void download(HttpServletRequest request, HttpServletResponse response, String saveDirectroy
			, String originalFileName, String saveFileName) {
		
		// 읽어 들여서 출력하는겁니다 input String 으로 읽어들이고 output으로 출력합니다.
		// 업로드파일이 저장된 경로
		// String saveDirectroy = "C:/upload";
		
		// 원본 파일이름
//		String originalFileName = request.getParameter("oName");
//		String originalFileName = request.getParameter("ofile");
		// 저장된 파일이름
//		String saveFileName = request.getParameter("sName");
//		String saveFileName = request.getParameter("sfile");
		
		System.out.println("oFileName : " + originalFileName + "<br>");
		System.out.println("sFileName : " + saveFileName + "<br>");
		// out.print("oFileName : " + originalFileName + "<br>");
		// out.print("sFileName : " + saveFileName + "<br>");
		
		
		
		try{
		
		File file = new File(saveDirectroy, saveFileName);
		System.out.println("file : " + file);
		// out.print("file : " + file);
		
		// 파일 입력 스트림 생성
		InputStream inStream = new FileInputStream(file);
		
		// 한글 파일명 깨짐 방지
		String client = request.getHeader("User-Agent");
		// ie체크
		if (client.indexOf("WOW64") == -1 ){
			originalFileName =
					new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
		}
		else {
			originalFileName =
					new String(originalFileName.getBytes("KSC5601"), "ISO-8859-1");
		}
		
		
		// 파일 다운로드용 응답 헤더 설정
		response.reset();
		
		// 파일 다운로드 창을 띄우기 위한 콘텐츠 타입을 지정
		// octet-stream은 8비트 단위의 바이너리 데이터를 의미
		response.setContentType("application/octet-stream");
		
		// 원본파일이름으로 다운로드 받을 수 있게 설정하는 부분
		response.setHeader("Content-Disposition",
							"attachment; filename=\"" + originalFileName + "\"");
		response.setHeader("Content-Lenght", "" + file.length());
		
		System.out.println("originalFileName: " + originalFileName);
		
//		// 출력스트림 초기화
//		// 기존 out 객체를 비우고 새로 쓸 준비를 함
//		out.clear();
//		// out 객체를 다시 쓸수있도록 설정해줘야 합니다.
//		out = PageContext.pushBody();
		
		// response 내장 객체로 부터 새로운 출력 스트림을 생성
		OutputStream outStream = response.getOutputStream();
		
		// 출력 스트림에 파일 내용 출력
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while ( (readBuffer = inStream.read(b)) > 0 ) {
			outStream.write(b, 0, readBuffer);
		}
		
			// 입/출력 스트림 닫음;
			inStream.close();
			outStream.close();
		}	
		 catch (FileNotFoundException e) {
//			 JSFunction.alertBack("파일을 찾을 수 없습니다.", out); // Package org.apache.jasper.tagplugins.jstl.core
			 JSFunction.alertBack(response, "파일을 찾을 수 없습니다.");
		}
		 catch (Exception e) {
//			JSFunction.alertBack("파일 다운로드중 오류가 발생 하였습니다.", out); //Package org.apache.jasper.tagplugins.jstl.core
			JSFunction.alertBack(response, "파일 다운로드중 오류가 발생 하였습니다.");
		}
		
	}
	
	/**
	 * 파일 업로드
	 * @return
	 */
	public static MultipartRequest uploadFile(HttpServletRequest req, String saveDirectory, int maxPostSize) {
		
		// 게시글이나 파일들이 연결되어있을때 게시글만 삭제되면 파일은 더미데이터가.. 잔뜩 쌓이게 될껄?
		try {
			// 파일 업로드
			return new MultipartRequest(req, saveDirectory, maxPostSize, "UTF-8");
			
		} catch (IOException e) {
			// 업로드 실패
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 파일 삭제
	 */
	public static void deleteFile(String directory, String filename) {
		File file = new File(directory, File.separator + filename);
		
		// 파일이 존재 하면 제거
		if(file.exists()) {
			file.delete();
		}
		
	}

	/**
	 * 
	 * @param saveDirectory
	 * @param fileName
	 * @return
	 */
	public static String fileNameChange(String saveDirectory
										, String fileName ) {
		
		System.out.println("fileName : "+ fileName);
	    // 첨부파일의 확장자
	    String ext = fileName.substring(fileName.lastIndexOf("."));
	    // H : 0~23, S : millisecond
	    // 현재시간을 파일이름으로 지정
	    String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	    String oFileName = fileName.substring(0, fileName.lastIndexOf("."));
	    
	    String newFileName = oFileName +"_"+ now + ext;
	    System.out.println("원본파일명 : " + fileName);
	    System.out.println("신규파일명 : " + newFileName);
	    
	    // 3. 파일명 변경
	    File oldFile = new File(saveDirectory + File.separator + fileName);
	    File newFile = new File(saveDirectory + File.separator + newFileName);
	    oldFile.renameTo(newFile);
	    
	    return newFileName;
	}
	
	
	public FileUtil() {
		// TODO Auto-generated constructor stub
	}

}

















