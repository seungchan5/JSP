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
				"select * from ( "
				+ "    select t.*,  rownum rn "
				+ "    from ("
				
				+ " 		select no, title"
//				+ "				    , nvl((select 대여여부 "
//				+ "			 from 대여 "
//				+ "			where 도서번호 = no "
//				+ "			  and 대여여부='Y'),'N') rentyn "
				+ "    , author "
				+ "from book ";
		
		//검색어가 입력 되었으면 검색 조건을 추가 합니다.
		if(cri.getSearchWord() != null 
				&& !"".equals(cri.getSearchWord())){		
			
			sql 	+=	"where " + cri.getSearchField() 
							+" like '%" + cri.getSearchWord() + "%' ";
		}		
		
		sql += "order by no desc) t"
			+ ")"
			+ "where rn between " +cri.getStartNo()+ " and "+cri.getEndNo();
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				String no = rs.getString(1);
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
	("insert into book values (SEQ_BOOK_NO.NEXTVAL, '%s', '%s', '%s', '%s', '%s', null)"
				, book.getTitle(), book.getRentyn(), book.getAuthor()
				, book.getOfile(), book.getSfile());

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
		
		String sql = "select count(*) from book ";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "where "+ cri.getSearchField() +" like '%"+ cri.getSearchWord() +"%'";
		}	
		
		sql += "order by no desc";
		
		try (Connection conn = DBConnectionPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			ResultSet rs = psmt.executeQuery();
			rs.next();
			totalCnt = rs.getInt(1); // 첫번째 컬럼의 값을 반환
			System.out.println("totalCnt"+totalCnt);
			rs.close();
		} catch (SQLException e) {
			System.out.println("총 게시물의 수를 조회 하던중 예외가 발생 하였습니다.");
			e.printStackTrace();
		}
		
		return totalCnt;
	}
	
	/**
	 * 상세페이지 조회
	 * @return
	 */
	public Book selectOne(String no) {
		Book book=null;
		
		//String sql = "select * from book order by no";
		String sql = 
				
					" select "
				  + " b.no, b.title, d.대여여부, b.author, d.아이디"
				  + " , to_char(대여일,'yy/mm/dd') 대여일, to_char(반납가능일,'yy/mm/dd') 반납가능일" 
				  + " , 반납일, sfile, ofile, d.대여번호"
				  + " from book b, 대여 d where b.rentno = d.대여번호(+) and b.no="+no;
		
		System.out.println(sql);
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = DBConnectionPool.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				ResultSet rs = stmt.executeQuery(sql)){
			if(rs.next()) {
				String bookNo = rs.getString(1);
				String title = rs.getString(2);
				String rentYN = rs.getString(3);
				String author = rs.getString(4);
				
				book = new Book(bookNo, title, rentYN, author);
				
				
				book.setId(rs.getString(5));
				book.setStartDate(rs.getString(6));
				book.setEndDate(rs.getString(7));
				book.setReturnDate(rs.getString(8));
				book.setSfile(rs.getString(9));
				book.setOfile(rs.getString(10));
				book.setRentno(rs.getString(11));
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return book;
	}

	public int rentBook(Book book) {
		int res = 0;
		// 1. 대여번호 조회 (R000001)
		String sql1 = "select 'R'||lpad(seq_대여.nextval||'',5,0) from dual";
		
		// 2. Book테이블 업데이트 (rentyn = Y, rentno = 대여번호)
		//		조건 : 도서번호, rentno가 null또는 빈 문자열
		String sql2 = "update book set rentno=? where no=? and (rentno is null or rentno='')";
		
		// 3. 대여 테이블 인서트()
		String sql3 = "insert into 대여 values(?, ?, ?,'Y', sysdate, null, sysdate+14, null)";
		
		
		
		try (Connection conn = DBConnectionPool.getConnection();) {
			conn.setAutoCommit(false);
			
			PreparedStatement psmt = conn.prepareStatement(sql1);
			ResultSet rs = psmt.executeQuery();
			if(!rs.next()) {
				return res;
			}
			
			String rentno = rs.getString(1);
			System.out.println("rentno : "+rentno);
			psmt.close();
			
			psmt=conn.prepareStatement(sql2);
			psmt.setString(1, rentno);
			psmt.setString(2, book.getNo());
			res = psmt.executeUpdate();
			System.out.println("sql : "+sql2);
			System.out.println("res : "+res);
			
			if(res>0) {
				psmt.close();
				psmt = conn.prepareStatement(sql3);
				psmt.setString(1, rentno);
				psmt.setString(2, book.getId());
				psmt.setString(3, book.getNo());
				
				res = psmt.executeUpdate();
				System.out.println("sql : "+sql3);
				System.out.println("res : "+res);
				
				if(res>0) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} else {
				conn.rollback();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return res;
	}
}























