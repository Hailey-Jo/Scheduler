package pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import pds.PageingUtil;
import pds.PagingBean;

public class PdsDao implements iPdsDao {
	
	private static PdsDao pdsdao = new PdsDao();
	
	private PdsDao() {}	
	
	public static PdsDao getInstance() {
		if(pdsdao == null){
			pdsdao = new PdsDao();
		}
		return pdsdao;
	}
	

	@Override
	public boolean write(PdsDto pds) {
		String sql = " INSERT INTO S_PDS( "
				+ " SEQ, ID, TITLE, CONTENT, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGDATE) VALUES (SEQ_S_PDS.NEXTVAL, "
				+ " ?, ?, ?, ?, 0, 0, SYSDATE) ";
		
	int count =0;
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try {
		conn = DBConnection.makeConnection();
		System.out.println("1/6 writePds");
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, pds.getId());
		psmt.setString(2, pds.getTitle());
		psmt.setString(3, pds.getContent());
		psmt.setString(4, pds.getFilename());
		System.out.println("2/6 writePds");
		
		count = psmt.executeUpdate();
		System.out.println("3/6 writePds");
		
	} catch (SQLException e) {
		System.out.println("F writePds");
	}finally {
		DBClose.close(psmt, conn, null);
		System.out.println("4/6 writePds");
	}
		
		return count>0?true:false;
	}

	@Override
	public List<PdsDto> getPdsList(String id) {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM S_PDS WHERE ID = '"+id+"'"
				+ " ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
			
		List<PdsDto> list = new ArrayList<PdsDto>();
			
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getPdsList");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getPdsList");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getPdsList");
			
			while(rs.next()) {
				PdsDto dto = new PdsDto(rs.getInt(1), //seq
										rs.getString(2),//id
										rs.getString(3),//title
										rs.getString(4),//content
										rs.getString(5),//filename
										rs.getInt(6),//readcount
										rs.getInt(7),//downcount
										rs.getString(8));//regdate
				
				list.add(dto);
			}
			System.out.println("4/6 getPdsList");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 getPdsList");
		}
		return list;
	}

	@Override
	public boolean downloadCount(int seq) {
		String sql = " UPDATE S_PDS "
				+ " SET DOWNCOUNT=DOWNCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 downloadCount");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 downloadCount");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 downloadCount");
			
		} catch (SQLException e) {
			System.out.println("F downloadCount");
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}
	
	public boolean pdsReadCount(int seq) {
		String sql = " UPDATE S_PDS "
				+ " SET READCOUNT = READCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public PdsDto getPDS(int seq) {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM S_PDS WHERE SEQ=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
			
		PdsDto pdsDto = new PdsDto();
			
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getPds");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getPds");
			
			psmt.setInt(1, seq);
			System.out.println("3/6 getPds");
			
			rs = psmt.executeQuery();
			System.out.println("4/6 getPds");
			
			while(rs.next()){
				seq = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String content = rs.getString(4);
				String filename = rs.getString(5);
				int readcount  = rs.getInt(6);
				int downcount = rs.getInt(7);
				String regdate = rs.getString(8);
				
				pdsDto.setSeq(seq);
				pdsDto.setId(id);
				pdsDto.setTitle(title);
				pdsDto.setContent(content);
				pdsDto.setFilename(filename);
				pdsDto.setReadcount(readcount);
				pdsDto.setDowncount(downcount);
				pdsDto.setRegdate(regdate);
				System.out.println("5/6 getPds");
			}	
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("F getPds");
		}finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("6/6 getPds");
		}
		
		return pdsDto;
	}

	@Override
	public boolean pdsDel(int seq) {
		String msg = "이 글은 삭제 되었습니다.";
		
		String sql = " UPDATE S_PDS SET TITLE = ? , CONTENT = ? , FILENAME = ? "
				+ " WHERE SEQ=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, msg);
			psmt.setString(2, msg);
			psmt.setString(3, msg);
			psmt.setInt(4, seq);
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}

	@Override
	public List<PdsDto> getPdsPagingList(String id, PagingBean paging, String searchWord) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PdsDto> pdslist = new ArrayList<>();
		
		//검색어
		String sWord = "%" + searchWord.trim() + "%";
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 S getPdsPagingList");
			
			String totalSql = " SELECT COUNT(SEQ) FROM S_PDS WHERE ID= '"+id+"' AND TITLE LIKE '" + sWord + "'";
			psmt = conn.prepareStatement(totalSql);
			rs = psmt.executeQuery();
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1);	// row의 총 갯수
			System.out.println("totalCount==>"+totalCount);
			paging.setTotalCount(totalCount);
			paging = PageingUtil.setPagingInfo(paging);
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM"
					+ " (SELECT * FROM (SELECT * FROM S_PDS  WHERE ID='"+id+"' AND TITLE LIKE '" + sWord + "' ORDER BY SEQ ASC) "
					+ " WHERE ROWNUM <=" + paging.getStartNum() + " ORDER BY SEQ ASC) "
					+ " WHERE ROWNUM <=" + paging.getCountPerPage();
						
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 S getPdsPagingList");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 S getPdsPagingList");
			
			while(rs.next()){
				int i = 1;
				PdsDto dto = new PdsDto(
						rs.getInt(i++),		// seq 
						rs.getString(i++),	// id 
						rs.getString(i++),  //title
						rs.getString(i++), 	// content 
						rs.getString(i++), 	// filename 
						rs.getInt(i++),		// readcount 
						rs.getInt(i++),		// downcount 
						rs.getString(i++)); // regdate 

						pdslist.add(dto);				
			}	
			System.out.println("4/6 S getPdsPagingList");
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 S getPdsPagingList");
		}		
		
		return pdslist;
	}
	

}
