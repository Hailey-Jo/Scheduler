package Cashbook;

public class CashbookDTO {

	private int seq;
	private String id;
	private String title;
	private String cashDate;
	private int ioCash;
	private int category;
	private String content;
	private int del;
	
	
	public CashbookDTO() {
	}

	public CashbookDTO(int seq, String id, String title, String cashDate, int ioCash, int category, String content,
			int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.cashDate = cashDate;
		this.ioCash = ioCash;
		this.category = category;
		this.content = content;
		this.del = del;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCashDate() {
		return cashDate;
	}

	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}

	public int getIoCash() {
		return ioCash;
	}

	public void setIoCash(int ioCash) {
		this.ioCash = ioCash;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "CashbookDTO [seq=" + seq + ", id=" + id + ", title=" + title + ", cashDate=" + cashDate + ", ioCash="
				+ ioCash + ", category=" + category + ", content=" + content + ", del=" + del + "]";
	}
	
}
