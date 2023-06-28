package com.library.vo;

public class Book {
	private String no;		// 도서 일련번호
	private String title;	// 도서명
	private String author;	// 작가

	private String sfile;	// 저장된파일명
	private String ofile;	// 원본파일명
	
	private String id;		// 대여자 ID
	private String rentyn;	// 도서 대여여부
	private String rentno;	// 대여번호
	private String startDate;	// 대여시작일
	private String endDate;		// 반납가능일
	private String returnDate; 	// 반납일
	
	public Book() {
		
	}

	// 도서를 추가할 경우 도서명과 작가명만 알고 있으면 생성 가능
	public Book(String title, String author) {
		this.title = title;
		this.author = author;
		// 신규도서이므로 N
		this.rentyn = "N";
	}
	
	public Book(String no, String title, String rentyn, String author) {
		super();
		this.no = no;
		this.title = title;
		this.rentyn = rentyn;
		this.author = author;
	}
	
	@Override
	public String toString() {
		String rentYNStr = "";
		
		// 도서가 rentYN=Y(대여중)인 경우 대여중으로 표시
		if("Y".equals(getRentyn())) {
			rentYNStr="대여중";
		}
		return getNo()
				+ " " + getTitle()
				+ " " + getAuthor()
				+ " " + rentYNStr;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRentyn() {
		return rentyn;
	}
	public void setRentyn(String rentyn) {
		this.rentyn = rentyn;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSfile() {
		return sfile;
	}
	
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	
	public String getOfile() {
		return ofile;
	}
	
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}

	public String getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}

	public String getRentno() {
		return rentno;
	}

	public void setRentno(String rentno) {
		this.rentno = rentno;
	}
}
