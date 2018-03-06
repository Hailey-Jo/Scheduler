package Schedule;

public class ScheduleDTO {

	private int seq;
	private String id;
	private String title;
	private String startDate;
	private String endDate;
	private String category;
	private String content;
	private int important;
	private int del;
	
	public ScheduleDTO(){
	}

	public ScheduleDTO(int seq, String id, String title, String startDate, String endDate, String category,
			String content, int important, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.category = category;
		this.content = content;
		this.important = important;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getImportant() {
		return important;
	}

	public void setImportant(int important) {
		this.important = important;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "ScheduleDTO [seq=" + seq + ", id=" + id + ", title=" + title + ", startDate=" + startDate + ", endDate="
				+ endDate + ", category=" + category + ", content=" + content + ", important=" + important + ", del="
				+ del + "]";
	}
	
}
