package fileupload;

public class FileDto {

	private String idx;
	private String name;
	private String title;
	private String cate;
	private String ofile;
	private String sfile;
	private String postdate;
	
	public FileDto() {
		// TODO Auto-generated constructor stub
	}

	public FileDto(String idx, String name, String title, String cate, String ofile, String sfile, String postdate) {
		super();
		this.idx = idx;
		this.name = name;
		this.title = title;
		this.cate = cate;
		this.ofile = ofile;
		this.sfile = sfile;
		this.postdate = postdate;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public String getOfile() {
		return ofile;
	}

	public void setOfile(String ofile) {
		this.ofile = ofile;
	}

	public String getSfile() {
		return sfile;
	}

	public void setSfile(String sfile) {
		this.sfile = sfile;
	}

	public String getPostdate() {
		return postdate;
	}

	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}

}
