package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import Schedule.ScheduleDTO;
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
	public userDTO login(String id, String pw) {
		String sql = " SELECT USER_SEQ, ID, NAME, BIRTH, EMAIL, PIC, DEL "
				+ " FROM USERDTO "
				+ " WHERE ID='" + id + "' AND PASSWORD='" + pw + "'";
		
		System.out.println("1/6 login");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		userDTO user = new userDTO();
		
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("2/6 login");
			
			while(rs.next()) {
				user.setSeq(rs.getInt(1));
				user.setId(rs.getString(2));
				user.setName(rs.getString(3));
				user.setBirth(rs.getString(4));
				user.setEmail(rs.getString(5));
				user.setPic(rs.getString(6));
				user.setDel(rs.getInt(7));
			}
			
			System.out.println("3/6 login");
		} catch (SQLException e) {
			System.out.println("login fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("4/6 login");
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


	@Override
	public boolean pwd_send_email(String id, String email, String pwd) {

		// email 송신자 정보
		String host = "smtp.naver.com";
		final String user = "superpcm";
		final String password = "zxc123";
		
		String to = email;
		System.out.println(email);
		
		// Get the session object
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(user, password);
			}
		});
		
		// Compose the message
		boolean isS = false;
		
		try {

		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(user));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		
		// Subject
		message.setSubject("[제목] 비밀번호 메일 보내기");
		
		// Text
		message.setText(" "+id+"님의 비밀번호는 "+pwd+" 입니다 \n\n 감사합니다");
		
		// send the message
		Transport.send(message);
		System.out.println("message sent successfully...");
		isS = true;
		
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return isS;
		
	}

	@Override
	public boolean pwd_change(String id, String new_pwd) {
		
		String sql =  " UPDATE USERDTO "
					+ " SET PASSWORD = '"+new_pwd+"' "
					+ " WHERE ID = '"+id+"'";
		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("1/4 pwd_change Success");
				
		boolean pwd_c = false;
		
		try {

		conn = DBConnection.makeConnection();
		psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		System.out.println("2/4 pwd_change Success");

		
		pwd_c = true;
		System.out.println("3/4 pwd_change Success");

		
		} catch (SQLException e) {
			System.out.println("pwd_change fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/4 pwd_change Success");

		}
				
		return pwd_c;
	}
}
