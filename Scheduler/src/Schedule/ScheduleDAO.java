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
	public List<ScheduleDTO> getAllSchedulList(String id) {
		String sql = " SELECT SHECDELE_SEQ, ID, TITLE, STARTDATE, "
				+ " ENDDATE, CATEGORY, CONTENT, IMPORTANT, DEL "
				+ " FROM SCHEDULE WHERE ID = '"+id+"'";
		
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
	public List<ScheduleDTO> getImportentSchedulList(String id) {
		String sql = " SELECT SHECDELE_SEQ, ID, TITLE, STARTDATE, "
				+ " ENDDATE, CONTENT, DEL "
				+ " FROM SCHEDULE WHERE ID = '"+id+"' AND IMPORTANT= 1";
		
		System.out.println("1/6 getImportentSchedulList");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("2/6 getImportentSchedulList");
			
			while(rs.next()) {
				ScheduleDTO sDTO = new ScheduleDTO();
				
				sDTO.setSeq(rs.getInt("SHECDELE_SEQ"));
				sDTO.setId(rs.getString("id"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setStartDate(rs.getString("startDate"));
				sDTO.setEndDate(rs.getString("enddate"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setDel(rs.getInt("del"));
				
				list.add(sDTO);
			}
			System.out.println("3/6 getImportentSchedulList");
		} catch (SQLException e) {
			System.out.println("F getImportentSchedulList");
			e.printStackTrace();
		} finally {
			System.out.println("4/6 getImportentSchedulList");
			DBClose.close(psmt, conn, rs);
		}
		return list;

	}
	@Override
	public boolean addSchedule(ScheduleDTO dto) {
		String sql = "INSERT INTO SCHEDULE VALUES(SHECDELE_SEQ.NEXTVAL, ?,?,to_date(?,'YYYY-MM-DD HH24:MI'),to_date(?,'YYYY-MM-DD HH24:MI'),?,?,?,0)";
		
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

	@Override
	public ScheduleDTO findschduel(int seq) {
		String sql = " SELECT SHECDELE_SEQ, ID, TITLE, STARTDATE, "
				+ " ENDDATE, CATEGORY, CONTENT, IMPORTANT, DEL "
				+ " FROM SCHEDULE WHERE SHECDELE_SEQ = " + seq;
		
		System.out.println("1/6 findschduel");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ScheduleDTO dto = new ScheduleDTO();
		
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			System.out.println("2/6 findschduel");
			
			while(rs.next()) {
				dto.setSeq(seq);
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setStartDate(rs.getString(4));
				dto.setEndDate(rs.getString(5));
				dto.setCategory(rs.getString(6));
				dto.setContent(rs.getString(7));
				dto.setImportant(rs.getInt(8));
				dto.setDel(rs.getInt(9));
			}
			
			System.out.println("3/6 findschduel");
		} catch (SQLException e) {
			System.out.println("findschduel fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("4/6 findschduel");
		return dto;
	}

	@Override
	public boolean updateSchedule(ScheduleDTO dto) {
		String sql = "UPDATE SCHEDULE SET TITLE=?, IMPORTANT=?, STARTDATE=to_date(?,'YYYY-MM-DD HH24:MI'), "
				+ "ENDDATE=to_date(?,'YYYY-MM-DD HH24:MI'), CONTENT=?, CATEGORY=? WHERE SHECDELE_SEQ="+dto.getSeq();
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		System.out.println("1/6 updateSchedule");
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			System.out.println("2/6 updateSchedule");
			
			psmt.setString(1, dto.getTitle());
			psmt.setInt(2, dto.getImportant());
			psmt.setString(3, dto.getStartDate());
			psmt.setString(4, dto.getEndDate());
			psmt.setString(5, dto.getContent());
			psmt.setString(6, dto.getCategory());
			
			count = psmt.executeUpdate();
			
			System.out.println("3/6 updateSchedule");
		} catch (SQLException e) {
			System.out.println("updateSchedule fail TT");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("4/6 updateSchedule");
		return count>0? true:false;
	}

	@Override
	public boolean deleteSchedule(int seq) {
		String sql = "DELETE FROM SCHEDULE WHERE SHECDELE_SEQ = " +seq;
		
		Connection conn= null;
		PreparedStatement psmt = null;
		int count = 0;
		
		System.out.println("1/6 deleteSchedule");
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 deleteSchedule");
			count = psmt.executeUpdate();
			System.out.println("3/6 deleteSchedule");
		} catch (SQLException e) {
			System.out.println("deleteSchedule fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("4/6 deleteSchedule");
		return count>0? true:false;
	}

	@Override
	public List<ScheduleDTO> searchSchedule(String searchtitle, String id) {
		
		String stitle = "%"+searchtitle+"%";

		String sql = " SELECT SHECDELE_SEQ, ID, TITLE, STARTDATE, "
				+ " ENDDATE, CATEGORY, CONTENT, IMPORTANT, DEL "
				+ " FROM SCHEDULE WHERE ID = ? AND TITLE LIKE ?";
		
		List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, stitle);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ScheduleDTO dto = new ScheduleDTO();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setStartDate(rs.getString(4));
				dto.setEndDate(rs.getString(5));
				dto.setCategory(rs.getString(6));
				dto.setContent(rs.getString(7));
				dto.setImportant(rs.getInt(8));
				dto.setDel(rs.getInt(9));
				
				list.add(dto);
			}
			/*String sql = " SELECT SHECDELE_SEQ, ID, TITLE, STARTDATE, "
					+ " ENDDATE, CATEGORY, CONTENT, IMPORTANT, DEL "
					+ " FROM SCHEDULE WHERE TITLE = ?";*/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

}
