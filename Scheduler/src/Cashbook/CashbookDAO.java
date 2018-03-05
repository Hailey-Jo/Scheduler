package Cashbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import Schedule.ScheduleDAO;
import db.DBClose;
import db.DBConnection;

public class CashbookDAO implements iCashbookDAO{

	private static CashbookDAO CashbookDAO = new CashbookDAO();
	
	private CashbookDAO() {
		DBConnection.initConnect();
	}
	
	
	public static CashbookDAO getInstance() {
		return CashbookDAO;
	}

	/*---------------------------------------------------------
	 // TODO *CashBook 입력하기 (수입/지출)
	 ---------------------------------------------------------*/
	@Override
	public boolean addCashbook(List<CashbookDTO> cashDto) {
		
		
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
		
		
		System.out.println("addCashbook sql : "+sql);
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
			e.printStackTrace();
			System.out.println("3/6 fail addCashbook");
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("4/6 success addCashbook");
		}
		
		return count>0 ? true:false;
	}

	


	/*---------------------------------------------------------
	 // TODO 최근 리스트 불러오기
	 ---------------------------------------------------------*/
	@Override
	public List<CashbookDTO> getCashDate(String id) {
		
		/*SELECT MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL
		FROM MONEYBOOK
		WHERE ID='creepin';*/
		
		String sql = " SELECT MONEYBOOK_SEQ, ID, "
				+ " TITLE, MONEYDATE, "
				+ " IOMONEY, CATEGORY, "
				+ " PRICE, "
				+ " CONTENT, DEL "
				
				+ " FROM MONEYBOOK "
				+ " WHERE ID=? AND DEL=0 "
				+ " ORDER BY MONEYDATE DESC ";
		
		System.out.println("addCashbook sql : "+sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CashbookDTO> cList = new ArrayList<CashbookDTO>();
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 success getCashDate");
	
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,id);
			System.out.println("2/6 success getCashDate");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 success getCashDate");
			
			while(rs.next()) {
				int i=1;
				CashbookDTO cDto = new CashbookDTO(rs.getInt(i++),
													rs.getString(i++), 
													rs.getString(i++),  
													rs.getString(i++),  
													rs.getInt(i++), 
													rs.getInt(i++), 
													rs.getInt(i++), 
													rs.getString(i++),  
													rs.getInt(i++));
				cList.add(cDto);
			}
			System.out.println("4/6 success getCashDate");
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("fail getCashDate");
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 success getCashDate");
		}
		
		return cList;
	}

	

	/*---------------------------------------------------------
	 // TODO 수입 / 지출 합계 구하기 (이달의 가계)
	 ---------------------------------------------------------*/
	
	@Override
	public int getInOutcome(String id, int ioMoney, String todayDate) {
		
		//System.out.println("getInoutcome id : " + id);
		
		Calendar cal = Calendar.getInstance();
		 
		//현재 년도, 월
		int year = cal.get ( cal.YEAR );
		int month = cal.get ( cal.MONTH ) + 1 ;
		String monthAf;
		if(month<10) {
			monthAf="0"+month;
		}else {
			monthAf=month+"";
		}
		
		todayDate = year+"" + monthAf;
		System.out.println("todayDate : " + todayDate);

		
		/*SELECT SUM(PRICE)
		FROM MONEYBOOK 
		WHERE ID='creepin' AND IOMONEY=0 AND TO_CHAR(MONEYDATE, 'YYYYMM') = '201802';*/
		
		String sql = " SELECT SUM(PRICE) "
				+ " FROM MONEYBOOK "
				+ " WHERE ID=? "
				+ " AND IOMONEY=?  "
				+ " AND TO_CHAR(MONEYDATE, 'YYYYMM') = ? "
				+ " AND DEL=0 ";
		
		System.out.println("getInOutcome sql : "+sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int result = 0;
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 success getInOutcome");
	
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,id);
			psmt.setInt(2, ioMoney);
			psmt.setString(3,todayDate);
			System.out.println("2/6 success getInOutcome");
			
			rs = psmt.executeQuery();
			   if(rs.next()){
			// null 값이 아닌경우 이 부분에 while(rs.next()){} 또는 do{ }while(rs.next()){} 구문을 쓸수 있다.
				   result = rs.getInt(1);
			   }else{
			// ResultSet값이 null인 경우 처리하고 싶은 코드를 작성하면 된다.
				   result=0;
			 }

			System.out.println("3/6 success getInOutcome");
			
			
		}catch (Exception e) {
			System.out.println("fail getInOutcome");
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("4/6 success getInOutcome");
		}
		
		return result;
	}


	/*---------------------------------------------------------
	 // TODO 삭제하기
	 ---------------------------------------------------------*/
	@Override
	public boolean deleteCashbook(int seq) {
		
		/*
		UPDATE MONEYBOOK
		SET DEL=1
		WHERE MONEYBOOK_SEQ=?;*/
		
		String sql = " UPDATE MONEYBOOK "
					+ " SET DEL=1 "
					+ " WHERE MONEYBOOK_SEQ=? ";
		
		System.out.println("deleteCashbook sql : "+sql);
		int count =0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConnection.makeConnection();
			System.out.println("1/6 success deleteCashbook");
		
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,seq);
			count = psmt.executeUpdate();
			System.out.println("2/6 success deleteCashbook");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 success deleteCashbook");
			
			
		}catch (SQLException e) {
			e.printStackTrace();
			System.out.println("4/6 fail deleteCashbook");
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 success deleteCashbook");
		}
		
		
		return count>0 ? true:false;
	}


	/*---------------------------------------------------------
	 // TODO 수정하기
	 ---------------------------------------------------------*/
	@Override
	public boolean modifycashbook(CashbookDTO cashDto) {
		
		
		return false;
	}
	
	
	
	
}
