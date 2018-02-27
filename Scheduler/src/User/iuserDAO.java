package User;

public interface iuserDAO {
	
	public boolean join(userDTO dto);
	public userDTO login(userDTO dto);

}
