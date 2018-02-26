package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;

public class userDAO implements iuserDAO {

	@Override
	public boolean join(userDTO user) {
		String sql = "";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("F join");
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return false;
	}

}
