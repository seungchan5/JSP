package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.common.DBConnectionPool;
import com.library.vo.Book;
import com.library.vo.Criteria;


public class BookDao {
	/**
	 * 도서목록 조회
	 * @param cri 
	 * @return
	 */
	public List<Book> getList(Criteria cri){
		List<Book> list = new ArrayList<Book>();
		
		//String sql = "select * from book order by no";
		String sql = 
				"select * from (select tb.*, rownum rn from("
				+"select no, title"
				+ "    , nvl((select 대여여부 "
				+ "			 from 대여 "
				+ "			where 도서번호 = no "
				+ "			  and 대여여부='Y'),'N') rentyn "
				+ "    , author "
				+ "from book ";
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			
			sql += "where " + cri.getSearchField() + " like '%" + cri.getSearchWord() + "%'";
			
		}
				sql += "order by no"
						+")tb )"
						+"where rn between "+cri.getStartNo()+" and "+cri.getEndNo();
				
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				
				
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				int no = rs.getInt(1);
				String title = rs.getString(2);
				String rentYN = rs.getString(3);
				String author = rs.getString(4);
				
				Book book = new Book(no, title, rentYN, author);
				list.add(book);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * 도서 등록
	 * @param book
	 * @return
	 */
	public int insert(Book book) {
		int res = 0;
		
		String sql = String.format
	("insert into book values (SEQ_BOOK_NO.NEXTVAL, '%s', '%s', '%s')"
				, book.getTitle(), book.getRentyn(), book.getAuthor());

		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 삭제
	 * @return
	 */
	public int delete(String noStr) {
		int res = 0;
		
		String sql = String.format
						("delete from book where no in (%s)", noStr);
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 업데이트
	 * @return
	 */
	public int update(int no, String rentYN) {
		int res = 0;
		
		String sql = String.format
		("update book set rentYN = '%s' where no = %d", rentYN ,no);
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	public String getRentYN(int bookNo) {
		String rentYN = "";
		String sql = 
				String.format(
					"SELECT RENTYN FROM BOOK WHERE NO = %s", bookNo);
		
		
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt= conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			// 조회된 행이 있는지 확인
			if(rs.next()) {
				// DB에서 조회된 값을 변수에 저장
				rentYN = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rentYN;
	}

	public int getTotalCnt(Criteria cri) {
		int totalCnt = 0;
		String sql ="select count(*) from book";
				
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += " where "+ cri.getSearchField() +" like '%"+cri.getSearchWord()+"%'";
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























