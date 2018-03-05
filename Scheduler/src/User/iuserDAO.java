package User;

public interface iuserDAO {
	
	public boolean join(userDTO dto);
	public userDTO login(userDTO dto);
	public boolean checkId(String id);	// 가입시 아이디 중복 여부
	public String findId(String name, String birth);	// 아이디 찾기
	public String findPw(String id, String email);	// 비밀번호 찾기
	public boolean modifyUserInfo(String id, String pw);	// 회원정보 수정
	public boolean exitUser(String id);	// 회원 탈퇴
	
	
	
	
}
