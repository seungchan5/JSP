package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnectionPool;
import dto.Criteria;
import dto.Mem;

public class Memdao {

	public Memdao() {
		// TODO Auto-generated constructor stub
	}

	public List<Mem> getList(Criteria criteria){
		List<Mem> list = new ArrayList<>();
		
		String sql = ""
				+ "select * from("
				+"select rownum rn, t.* from("
				+ "select no, id, name, adminyn from mem"; 
		
		// 검색어가 입력되었으면 검색 조건을 추가
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += " where "+ criteria.getSearchField() +" like '%" + criteria.getSearchWord()+ "%'";
		}
		
		sql += " order by no desc"
				+ ")t )"
				+ "where rn between " + criteria.getStartNo()
				+ " and "+ criteria.getEndNo();
		
		System.out.println(sql);
		// 검색조건 추가
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);
				ResultSet rs = psmt.executeQuery();) {
			
			// 게시글의 수만큼 반복
			while(rs.next()) {
				
				// 게시물의 한행을 DTO에 저장
				Mem mem = new Mem();
				
				mem.setNo(rs.getString("no"));
				mem.setId(rs.getString("id"));
				mem.setName(rs.getString("name"));
				mem.setAdminyn(rs.getString("adminyn"));
				
				// 결과 목록에 저장
				list.add(mem);
			}
		} catch (SQLException e) {
			System.err.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0;
		String sql ="select count(*) from mem";
				
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += " where "+ criteria.getSearchField() +" like '%"+criteria.getSearchWord()+"%'";
		}		
		
		sql += " order by no desc";
		
		
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
}
