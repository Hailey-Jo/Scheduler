package Schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;

public class ScheduleDAO implements iScheduleDAO {
	
	private static ScheduleDAO ScheduleDAO = new ScheduleDAO();
	
	private ScheduleDAO() {
		DBConnection.initConnect();
	}
	
	public static ScheduleDAO getInstance() {
		return ScheduleDAO;
	}

	@Override
	public List<ScheduleDTO> getAllSchedulList() {
		String sql = " SELECT SHECDELE_SEQ, ID, TITLE, STARTDATE, "
				+ " ENDDATE, CATEGORY, CONTENT, IMPORTANT, DEL "
				+ " FROM SCHEDULE ";
		
		System.out.println("1/6 getAllSchedulList");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("2/6 getAllSchedulList");
			
			while(rs.next()) {
				ScheduleDTO sDTO = new ScheduleDTO();
				
				sDTO.setSeq(rs.getInt("SHECDELE_SEQ"));
				sDTO.setId(rs.getString("id"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setStartDate(rs.getString("startDate"));
				sDTO.setEndDate(rs.getString("enddate"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setImportant(rs.getInt("important"));
				sDTO.setDel(rs.getInt("del"));
				
				list.add(sDTO);
			}
			System.out.println("3/6 getAllSchedulList");
		} catch (SQLException e) {
			System.out.println("F getAllSchedulList");
			e.printStackTrace();
		} finally {
			System.out.println("4/6 getAllSchedulList");
			DBClose.close(psmt, conn, rs);
		}
		return list;

	}

	@Override
	public boolean addSchedule(ScheduleDTO dto) {
		String sql = "INSERT INTO SCHEDULE VALUES(SHECDELE_SEQ.NEXTVAL, ?,?,?,?,?,?,?,0)";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count=0;
		
		System.out.println("addSchedul 1/6 Success");
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("addSchedul 2/6 Success");			
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getStartDate());
			psmt.setString(4, dto.getEndDate());
			psmt.setString(5, dto.getCategory());
			psmt.setString(6, dto.getContent());
			psmt.setInt(7, dto.getImportant());
			
			System.out.println("addSchedul 3/6 Success");
			
			count = psmt.executeUpdate();
			
			System.out.println("addSchedul 4/6 Success");
		} catch (SQLException e) {
			System.out.println("addSchedul Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("addSchedul 5/6 Success");
		return count>0? true:false;
	}

}
