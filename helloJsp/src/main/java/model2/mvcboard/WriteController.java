package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Response;

import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
import common.JSFunction;

public class WriteController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.sendRedirect("../14MVCBoard/Write.jsp");
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String saveDirectory = "C:/upload";
		
		// 파일 업로드 : 업로드 경로, 최대 사이즈 지정 
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024 * 1000);
		
		MVCBoardDto dto = new MVCBoardDto();
		
		dto.setIdx(mr.getParameter("idx"));
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setOfile(mr.getParameter("ofile"));
		dto.setSfile(mr.getParameter("sfile"));
		dto.setPass(mr.getParameter("pass"));
		
	}
	
	public WriteController() {
		// TODO Auto-generated constructor stub
	}

}
