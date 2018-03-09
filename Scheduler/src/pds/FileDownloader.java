package pds;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import User.iuserDAO;
import User.userDAO;
import User.userDTO;

public class FileDownloader extends HttpServlet {
	
	private static final int BUFFER_SIZE = 8192; // 8kb
	private ServletConfig mConfig = null;
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		mConfig = config;  //getRealPath를 가져오기 위함
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("FileDownloader doGet");
		
		String filename = new String(req.getParameter("filename").getBytes("8859_1"), "KSC5601");
		System.out.println("filename ==> "+filename);
		
		//download 횟수 증가
		String pdsseq = req.getParameter("seq");
		
		int seq = Integer.parseInt(pdsseq);
		
		iPdsDao dao = PdsDao.getInstance();
		
		userDTO user = new userDTO();
		
		boolean isS = dao.downloadCount(seq);
		
		if(!isS) {
			resp.sendRedirect("pdslist.jsp");
		}
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		String filePath = "";
		
		if(pdsseq != null) {
			//tomcat
			//filePath =  mConfig.getServletContext().getRealPath("/upload");
			
			HttpSession session = req.getSession();
			user = (userDTO) session.getAttribute("login");
			
			//user folder
			String serverPath = req.getRequestURL().substring(0,req.getRequestURL().indexOf(req.getRequestURI()));
			
			filePath = serverPath+File.separator+"img"+File.separator+user.getId()+File.separator+"tmp"+File.separator+filename;
		}
		
		try {
			filePath = filePath + "\\" + filename;
			
			File f = new File(filePath);
			System.out.println("filePath ==>"+filePath);
			
			if(f.exists() && f.canRead()) {
				
				// 다운로드 window 설정(다운로드 창)
				resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
				resp.setHeader("Content-Transfer-Encoding", "binary;");
				resp.setHeader("Content-Length", "" + f.length());
				resp.setHeader("Pragma", "no-cache;"); 
				resp.setHeader("Expires", "-1;");
				
				BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
				byte buffer[] = new byte[BUFFER_SIZE];
				
				int read = 0;
				
				while((read = fileInput.read(buffer)) != -1) {
					out.write(buffer, 0, read);
				}
				
				fileInput.close();
				out.flush();
			}else {
				System.out.println("파일이 존재하지 않습니다.");
			}
		}catch(Exception e){
			
		}finally {
			if(out != null) {
				out.flush();
				out.close();
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("FileDownloader doPost");

	}

/*	public doProcess(HttpServlet req, HttpServletRequest resp) throws ServletException, IOException {
		
	}
	*/
}
