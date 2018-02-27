package Cashbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import db.DBClose;
import db.DBConnection;

public class CashbookDAO implements iCashbookDAO{

	

	/*---------------------------------------------------------
	 *CashBook 입력하기 (수입/지출)
	 ---------------------------------------------------------*/
	@Override
	public boolean addCashbook(List<CashbookDTO> cashDto) {
		// TODO Auto-generated method stub
		
		/*INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL)
		VALUES (MONEYBOOK_SEQ.NEXTVAL, 'creepin', '식비', '20180227', '1', '0', 18000, '점심 식사', 0);*/

		String sql = " INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, "
				+ " TITLE, MONEYDATE, "
				+ " IOMONEY, CATEGORY, "
				+ " PRICE, "
				+ " CONTENT, DEL)"
				
				+ " VALUES (MONEYBOOK_SEQ.NEXTVAL, ?, "
				+ " ?, ?, "
				+ " ?, ?, "
				+ " ?, "
				+ " ?, 0) ";
		
		int count =0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			System.out.println("1/6 success addCashbook");
		
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 success addCashbook");
			
			for (int i = 0; i < cashDto.size(); i++) {
				psmt.setString(1, cashDto.get(i).getId()); //ID
				psmt.setString(2, cashDto.get(i).getTitle()); //TITLE
				psmt.setString(3, cashDto.get(i).getMoneyDate()); //MONEYDATE
				psmt.setInt(4, cashDto.get(i).getIoMoney()); //IOMONEY
				psmt.setInt(5, cashDto.get(i).getCategory()); //CATEGORY
				psmt.setInt(6, cashDto.get(i).getPrice()); //PRICE
				psmt.setString(7, cashDto.get(i).getContent()); //CONTENT
				
				count = psmt.executeUpdate();
			}
			System.out.println("3/6 success addCashbook");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("3/6 fail addCashbook");
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("4/6 success addCashbook");
		}
		
		return count>0 ? true:false;
	}


	
}
