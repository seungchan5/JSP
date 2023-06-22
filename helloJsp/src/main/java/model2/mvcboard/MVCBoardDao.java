package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.ConnectionUtil;

public class MVCBoardDao {

	public MVCBoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	public List<MVCBoardDto> getlist(){
		List<MVCBoardDto> list = new ArrayList<MVCBoardDto>();
		
		String sql = "select * from mvcboard order by idx desc";
		
		try (Connection conn = ConnectionUtil.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				MVCBoardDto board = new MVCBoardDto();
				board.setIdx(rs.getString("idx"));
				board.setName(rs.getString("name"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setPostdate(rs.getString("postdate"));
				board.setOfile(rs.getString("ofile"));
				board.setSfile(rs.getString("sfile"));
				board.setDowncount(rs.getInt("downcount"));
				board.setPass(rs.getString("pass"));
				board.setVisitcount(rs.getInt("visitcount"));
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
}
