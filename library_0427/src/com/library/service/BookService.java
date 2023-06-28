package com.library.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.dao.BookDao;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.PageDto;

public class BookService {
	BookDao dao = new BookDao();
	
	/**
	 * 책 리스트를 조회 합니다.
	 * @return
	 */
	public Map<String, Object> getList(Criteria cri){
		Map<String, Object> map = new HashMap<>();
		
		// 리스트 조회
		List<Book> list = dao.getList(cri);
		
		// 총 건수 
		int totalCnt = dao.getTotalCnt(cri);
		
		//페이지DTO
		PageDto pageDto = new PageDto(totalCnt, cri);
		
		map.put("list", list);
		map.put("totalCnt", totalCnt);
		map.put("pageDto", pageDto);
		
		return map;
	}

	/**
	 * 도서 정보 입력
	 */
	public int insert(Book book) {
		
		int res = dao.insert(book);
		return res;
	
	}

	public int delete(String noStr) {
		int res = dao.delete(noStr);
		return res;
	}

	public int rentBook(Book book) {
		int res = dao.rentBook(book);
		return res;
	}

	public int returnBook(String no) {
		int res = dao.returnbook(no);
		return res;
	}
	
	public Book selectOne(String no) {
		return dao.selectOne(no);
	}

	
}













