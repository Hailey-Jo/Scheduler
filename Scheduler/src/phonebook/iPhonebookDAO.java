package phonebook;

import java.util.List;

public interface iPhonebookDAO {

	public List<PhonebookDTO> getAllPhoneList(String id);
	public boolean addPhonebook(PhonebookDTO dto);
	public boolean updatephonebook(PhonebookDTO dto);
	public List<PhonebookDTO> searchphonebook(String searchtitle, String id);
	public boolean deletephonebook(int seq);
}
