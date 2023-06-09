package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.library.common.ConnectionUtil;

/**
 * DB에 연결 데이터 입출력 처리
 * @author user
 *
 */
public class RentDao {
	public static void main(String[] args) {
		RentDao dao = new RentDao();
		// 반납테스트
		System.out.println(dao.update(3));
		
		// 입력테스트
//		System.out.println(dao.insert("user", 3));
		// 대여여부 테스트
//		System.out.println(dao.getRentYN(3));
	}
	/**
	 * 도서가 대출 상태를 확인
	 * 
	 * @param no
	 * @return 대출중 : Y
	 * 		   대출가능 : N
	 */
	public String getRentYN(int no) {
		String rentYN="N";
		
//		StringBuffer sb = new StringBuffer();
//		sb.append("select 대여여부 ");
//		sb.append("from 대여 ");
//		sb.append("where 도서번호 = 3 and 대여여부 = 'Y'");
		
		
		String sql = "select 대여여부 "
					+ "from 대여 "
					+ "where 도서번호 = ? "
					+ "and 대여여부 = 'Y'";
		
		
		try (Connection conn = ConnectionUtil.getConnection();
				PreparedStatement pstmt= conn.prepareStatement(sql);){
			
			// 파라메터 세팅 : ?표에 순서대로 입력
			pstmt.setInt(1, no);
			// 쿼리실행
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rentYN = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return rentYN;
	}
	
	public int insert(String id, int no) {
		int res = 0;
		
		String sql = 
				"insert into 대여 "
				+ "values (seq_대여.nextval, ?,?,'Y'"
				+ "			,sysdate,null,sysdate+7,null)";
		try (Connection conn = ConnectionUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			pstmt.setInt(2, no);
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	public int update(int no) {
		int res = 0;
		String sql = 
				"update 대여 "
				+ "set 반납일 = sysdate, 대여여부='N' "
				+ "where 도서번호=?";
		try (Connection conn = ConnectionUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, no);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
}















