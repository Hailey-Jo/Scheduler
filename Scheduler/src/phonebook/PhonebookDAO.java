package phonebook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;

public class PhonebookDAO implements iPhonebookDAO {
	
	private static PhonebookDAO phonebookdao = new PhonebookDAO();
	
	private PhonebookDAO() {
		DBConnection.initConnect();
	}
	
	public static PhonebookDAO getInstance() {
		return phonebookdao;
	}

	@Override
	public List<PhonebookDTO> getAllPhoneList(String id) {

		List<PhonebookDTO> list = new ArrayList<PhonebookDTO>();
		
		
		String sql = "SELECT PHONEBOOK_SEQ, ID, NAME, BIRTH, PHONE, EMAIL FROM PHONEBOOK WHERE ID = '"+id+"'";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		System.out.println("getAllPhoneList 1/6 Success");
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("getAllPhoneList 2/6 Success");
			while(rs.next()) {
				PhonebookDTO dto = new PhonebookDTO();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setBirth(rs.getString(4));
				dto.setPhone(rs.getString(5));
				dto.setEmail(rs.getString(6));
				
				list.add(dto);
			}
			System.out.println("getAllPhoneList 3/6 Success");
		} catch (SQLException e) {
			System.out.println("getAllPhoneList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("getAllPhoneList 4/6 Success");
		
		return list;
	}

	@Override
	public boolean addPhonebook(PhonebookDTO dto) {
		
		String sql = "INSERT INTO PHONEBOOK VALUES(PHONEBOOK_SEQ.NEXTVAL,?,?,?,?,?)";
		int count = 0;
		
		Connection conn= null;
		PreparedStatement psmt = null;
		
		System.out.println("addPhonebook 1/6 success");
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			System.out.println("addPhonebook 2/6 success");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getBirth());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getEmail());
			
			System.out.println("addPhonebook 3/6 success");
			
			count = psmt.executeUpdate();
			
			System.out.println("addPhonebook 4/6 success");
		} catch (SQLException e) {
			System.out.println("addPhonebook fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		System.out.println("addPhonebook 5/6 success");
		return count>0? true:false;
	}

}
