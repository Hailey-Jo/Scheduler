package Cashbook;

import java.util.List;

public interface iCashbookDAO {

	//입력 하기
	public boolean addCashbook(List<CashbookDTO> cashDto);
	
	//최근 내역 불러오기
	public List<CashbookDTO> getCashDate(String id);
}
