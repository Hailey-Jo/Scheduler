package User;

public interface iuserDAO {
	
	public boolean join(userDTO dto);
	public userDTO login(String id, String pw);
	public boolean checkId(String id);	// 가입시 아이디 중복 여부
	public String findId(String name, String birth);	// 아이디 찾기
	public String findPw(String id, String email);	// 비밀번호 찾기	
	public boolean pwd_change(String id, String new_pwd);	// 회원정보 수정
	public boolean pwd_send_email(String id, String email, String npwd);
	
	
	
	
}
