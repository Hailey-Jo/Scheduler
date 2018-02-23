package User;

public class userDTO {
	private int seq;
	private String id;
	private String password;
	private String name;
	private String birth;
	private String email;
	private String pic;
	private int del;
	
	public userDTO() {
	}
	
	public userDTO(int seq, String id, String password, String name, String birth, String email, String pic, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.password = password;
		this.name = name;
		this.birth = birth;
		this.email = email;
		this.pic = pic;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "userDTO [seq=" + seq + ", id=" + id + ", password=" + password + ", name=" + name + ", birth=" + birth
				+ ", email=" + email + ", pic=" + pic + ", del=" + del + "]";
	}

}
