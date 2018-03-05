package Cashbook;

import java.util.List;

public interface iCashbookDAO {

	//입력 하기
	public boolean addCashbook(List<CashbookDTO> cashDto);
	
	//최근 내역 불러오기
	public List<CashbookDTO> getCashDate(String id);
	
	//이달의 총 수입 / 지출
	public int getInOutcome(String id, int ioMoney, String todayDate);
	
	//정보 삭제하기
	public boolean deleteCashbook(int seq);
	
	//정보 수정하기
	public boolean modifycashbook(CashbookDTO cashDto);
	
}
