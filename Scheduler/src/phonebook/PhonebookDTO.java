package phonebook;

import java.io.Serializable;

/*CREATE TABLE PHONEBOOK(
		PHONEBOOK_SEQ	NUMBER(8),
		ID	VARCHAR2(50),
		NAME VARCHAR2(50) NOT NULL,
		BIRTH VARCHAR2(50) NOT NULL,
		PHONE VARCHAR2(50) NOT NULL,
		EMAIL VARCHAR2(50) NOT NULL
)*/

public class PhonebookDTO implements Serializable {

	int seq;
	String id;
	String name;	
	String birth;
	String phone;
	String email;
	
	public PhonebookDTO() {
		// TODO Auto-generated constructor stub
	}

	public PhonebookDTO(int seq, String id, String name, String birth, String phone, String email) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.birth = birth;
		this.phone = phone;
		this.email = email;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "PhonebookDTO [seq=" + seq + ", id=" + id + ", name=" + name + ", birth=" + birth + ", phone=" + phone
				+ ", email=" + email + "]";
	}
	
	
}
