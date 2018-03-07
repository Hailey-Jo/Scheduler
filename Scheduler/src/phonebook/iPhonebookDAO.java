package phonebook;

import java.util.List;

public interface iPhonebookDAO {

	public List<PhonebookDTO> getAllPhoneList(String id);
	public boolean addPhonebook(PhonebookDTO dto);
}
