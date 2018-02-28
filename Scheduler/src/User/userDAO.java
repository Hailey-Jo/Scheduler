package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;

public class userDAO implements iuserDAO {

	private static userDAO userDao = new userDAO();
	
	public userDAO() {
		DBConnection.initConnect();
	}
	
	public static userDAO getInstance() {
		return userDao;
	}
	
	@Override
	public boolean join(userDTO dto) {

		String sql = " INSERT INTO USERDTO "
				+ " (USER_SEQ, ID, PASSWORD, NAME, BIRTH, EMAIL, PIC, DEL) "
				+ " VALUES(USER_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, 0) ";
		
		
		// seq 하는 방법 확인후 다시
		
		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("1/6 join Success");
		
		int count = 0;

		try {

			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 join Success");	
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPassword());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getBirth());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getPic());
			System.out.println("3/6 join Success");
			
			count = psmt.executeUpdate();
			System.out.println("4/6 join Success");
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("회원가입 실패");
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("5/6 join Success");
			System.out.println("6/6 join Success");
		}
		
		return count>0?true:false;
	}

	@Override
	public userDTO login(userDTO dto) {
		
		userDTO user = null;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT USER_SEQ, ID, NAME, BIRTH, EMAIL, PIC, DEL "
				+ " FROM USERDTO "
				+ " WHERE ID=? AND PASSWORD=? ";
		
		
		System.out.println(dto.toString());
		
		try {

			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/6 login Success");

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPassword());
			System.out.println("2/6 login Success");

			
			rs = psmt.executeQuery();
			System.out.println("3/6 login Success");
			
			// rs 데이터 체크한 것
			boolean found;
			
			found = rs.next();
			if(found) {
				System.out.println("record found");
			}else {
				System.out.println("record not found");
			}
			
			
				int seq = rs.getInt(1);
				String id = rs.getString(2);
				String name = rs.getString(3);
				String birth = rs.getString(4);
				String email = rs.getString(5);
				String pic = rs.getString(6);
				int del = rs.getInt(7);
				System.out.println("4/6 login Success");

				
				user = new userDTO(seq, id, null, name, birth, email, pic, del);
				System.out.println("5/6 login Success");


		} catch (SQLException e) {
			System.out.println("로그인 실패");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("6/6 login Success");

		}
		
		return user;

	}

	@Override
	public boolean checkId(String id) {

		String sql = " SELECT ID "
				+ " FROM  USERDTO "
				+ " WHERE ID = '"+id+"'";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		System.out.println("1/3 checkId Success");
		
		boolean findId = false;
		
		try {

			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("2/3 checkId Success");
			
			
			while(rs.next()) {
				findId = true;
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("3/3 checkId Success");
		}
		
		return findId;
		
	}

	@Override
	public String findId(String name, String birth) {

		String sql = " SELECT ID "
				+ " FROM USERDTO "
				+ " WHERE NAME ='"+name+"' AND BIRTH = '"+birth+"'";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String id = null;
		
		
		try {

			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				id = rs.getString("ID");
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			System.out.println("찾기 성공~:"+ id);
			DBClose.close(null, conn, rs);
			
		}
		
		return id;
		
	}

	@Override
	public String findPw(String id, String email) {

		String sql = " SELECT PASSWORD "
				+ " FROM USERDTO "
				+ " WHERE ID = '"+id+"' AND EMAIL = '"+email+"'";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		System.out.println("1/3 findPw Success");
		
		String pw = null;
		
		try {

			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println("2/3 findPw Success");
			
			while(rs.next()) {
				pw = rs.getString("PASSWORD");
			}
			System.out.println("3/3 findPw Success");
			
		} catch (SQLException e) {
			System.out.println("findPw fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("findPw Success");
		}
		 
		return pw;
		
	}
}
