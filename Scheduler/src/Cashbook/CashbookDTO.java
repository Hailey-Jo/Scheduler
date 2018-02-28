package Cashbook;

public class CashbookDTO {

/*	CREATE TABLE MONEYBOOK(
			MONEYBOOK_SEQ	NUMBER(8),
			ID	VARCHAR2(50),
			TITLE	VARCHAR2(50)	NOT NULL,
			MONEYDATE	DATE	NOT NULL,
			IOMONEY	NUMBER(1)	NOT NULL,
			CATEGORY	NUMBER(2),
			PRICE	NUMBER(8) NOT NULL,
			CONTENT	VARCHAR2(2000)	NOT NULL,
			DEL	NUMBER(1)	NOT NULL
		)*/
	
	private int seq; 
	private String id;
	private String title; //ex)식비, 교통비 분류
	private String moneyDate; //기입 날짜
	private int ioMoney; //수입 0 , 지출1
	private int category; //이미지
	private int price; //금액
	private String content; //상세 내역
	private int del; //삭제 여부
	
	public CashbookDTO() {
		super();
	}


	public CashbookDTO(int seq, String id, String title, String moneyDate, int ioMoney, int category, int price,
			String content, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.moneyDate = moneyDate;
		this.ioMoney = ioMoney;
		this.category = category;
		this.price = price;
		this.content = content;
		this.del = del;
	}

	
	


	public CashbookDTO(String title, int category, int price, String content) {
		super();
		this.title = title;
		this.category = category;
		this.price = price;
		this.content = content;
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


	public String getMoneyDate() {
		return moneyDate;
	}


	public void setMoneyDate(String moneyDate) {
		this.moneyDate = moneyDate;
	}


	public int getIoMoney() {
		return ioMoney;
	}


	public void setIoMoney(int ioMoney) {
		this.ioMoney = ioMoney;
	}


	public int getCategory() {
		return category;
	}


	public void setCategory(int category) {
		this.category = category;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
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
		return "CashbookDTO [seq=" + seq + ", id=" + id + ", title=" + title + ", moneyDate=" + moneyDate + ", ioMoney="
				+ ioMoney + ", category=" + category + ", content=" + content + ", del=" + del + "]";
	}
	
	
	
	
	
	
}
