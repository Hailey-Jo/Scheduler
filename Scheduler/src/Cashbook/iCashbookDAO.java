package Cashbook;

import java.util.List;

public interface iCashbookDAO {

	//입력 하기
	public boolean addCashbook(List<CashbookDTO> cashDto);
	
	
}
