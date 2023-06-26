package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.ConnectionUtil;
import common.DBConnectionPool;
import dto.Board;
import dto.Criteria;

public class MVCBoardDao {

	public MVCBoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	public List<MVCBoardDto> getlist(Criteria criteria){
		List<MVCBoardDto> list = new ArrayList<MVCBoardDto>();
		
		String sql = "select * from mvcboard ";
		
		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")){
			sql+="where " + criteria.getSearchField() + " like '%"+criteria.getSearchWord()+"%'";
		}
		
		sql += " order by idx desc";
		try (Connection conn = DBConnectionPool.getConnection();
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
	
	// 목록조회 + 페이징
	public List<MVCBoardDto> getlistpage(Criteria criteria){
		List<MVCBoardDto> list = new ArrayList<MVCBoardDto>();
		
		String sql = "select * from("
						+"select tb.*, rownum rn from("
					
						+"select * from mvcboard ";
		
		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")){
			sql+="where " + criteria.getSearchField() + " like '%"+ criteria.getSearchWord() +"%'";
		}
		
		sql += " order by idx desc"
				+") tb)"
				+"where rn between ? and ?";
		
		//System.out.println("검색 sql : " + sql);
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			// 페이징 처리 - 시작번호와 끝번호를 입력
			psmt.setInt(1, criteria.getStartNo());
			psmt.setInt(2, criteria.getEndNo());
			
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

	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0;
		String sql ="select count(*) from mvcboard";
				
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += " where "+ criteria.getSearchField() +" like '%"+criteria.getSearchWord()+"%'";
		}		
		
		sql += " order by idx desc";
		
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			rs.next();
			totalCnt = rs.getInt(1); // 첫번째 컬럼의 값을 반환
			
			rs.close();
		} catch (SQLException e) {
			System.err.println("총 게시물의 수를 조회 하던중 예외가 발생");
			e.printStackTrace();
		}
		
		
		return totalCnt;
	}
	
	public int insert(MVCBoardDto dto) {
		int res = 0;
		
		String sql = "insert into mvcboard (idx, name, title, content, pass, ofile, sfile)"
			    + "values (seq_mvcboard_num.nextval, ?, ?, ?, ?, ?, ?)";
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getPass());
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getSfile());
			
			// insert, update, delete 실행 후 몇건이 처리 되었는지 반환
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("게시물 입력중 예외 발생");
			e.printStackTrace();
		}
		
		return res;
	}

	public MVCBoardDto selectOne(String idx) {
		MVCBoardDto dto = new MVCBoardDto();
		String sql = "select * from mvcboard where idx=?";
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, idx);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(rs.getInt("downcount"));
				dto.setPass(rs.getString("pass"));
				dto.setVisitcount(rs.getInt("visitcount"));
			}
			
		} catch (SQLException e) {
			System.out.println("게시물 상세보기 조회중 오류가 발생하였습니다");
			e.printStackTrace();
		}
		
		
		
		return dto;
	}
	
	// 게시글의 비밀번호가 일치하는지 확인
	public boolean confirmPassword(String pass, String idx) {
		boolean res = false;
		
		String sql = "select * from mvcboard where idx= ? and pass= ?";
		
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, idx);
			psmt.setString(2, pass);
			
			ResultSet rs = psmt.executeQuery();
			
			res = rs.next();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	public int delete(String idx) {
		int res = 0;

		String sql = "delete from mvcboard where idx = ?";
		
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, idx);
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return res;
	}
	
	public int updateVisitCount(String idx) {
		int res = 0;
		String sql="update mvcboard set visitcount = visitcount+1 where idx = ?";
		
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, idx);
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	public int update(MVCBoardDto dto) {
		int res = 0;
		
		String sql = "update mvcboard set name = ? , title = ?, content = ?, ofile = ?, sfile=? where idx = ?";
		
		System.out.println(sql);
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return res;
	}
}
