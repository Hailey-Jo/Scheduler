<%@page import="pds.PdsDto"%>
<%@page import="pds.PdsDao"%>
<%@page import="pds.iPdsDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BizPayDay</title>
</head>
<body>

<%!
public String processUploadedFile(FileItem fileItem, String dir, JspWriter out) throws IOException{
	
	String fileName = fileItem.getName();
	long sizeInBytes = fileItem.getSize();
	
	//Upload File true
	if(sizeInBytes > 0){ //   e:\\tmp\\abc.jpg
		int idx = fileName.lastIndexOf("\\");
		if(idx == -1){ // '\' not find
			idx = fileName.lastIndexOf("/");
		}
		fileName = fileName.substring(idx+1); // abc.jpg
	
		try{	
			File uploadedFile = new File(dir, fileName);
			fileItem.write(uploadedFile); //file upload
		}catch(Exception e){
			
		}
	}	
	return fileName;
		
	
}
%>

<%
// tomcat upload
//String fupload = application.getRealPath("/upload");

//user folder upload
String fupload = "c:"+File.separator+"upload"+File.separator;

System.out.println("file Upload : "+fupload);

String yourTempDirectory = fupload;

int yourMaxRequestSize = 100*1024*1024; // 1M byte
int yourMaxMemorySize = 100*1024;


//form field data add
String id = "";
String title = "";
String content = "";

//file data
String filename = "";

boolean isMultipart = ServletFileUpload.isMultipartContent(request);

if(isMultipart){ //Multipart set true?

	//file start
		
	// fileItem object set class
	DiskFileItemFactory factory = new DiskFileItemFactory();

	//memory size set 1M byte > filesize(yourfile)  ==> use
	factory.setSizeThreshold(yourMaxMemorySize);
	factory.setRepository(new File(yourTempDirectory)); //file dir set
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(yourMaxRequestSize); // file upload MaxSize 
	
	//file end
	
	List<FileItem> items = upload.parseRequest(request);
	
	Iterator<FileItem> it = items.iterator();
	
	while(it.hasNext()){
		FileItem item = it.next();
		if(item.isFormField()){ // id, title, content 파일형태가 아닐때   
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");
			}else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
			}else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}
		}else{ //fileload
			if(item.getFieldName().equals("fileload")){
				String saveUrl = fupload+id+File.separator+"tmp"+File.separator;
				System.out.println("PDS_FileUPload saveUrl==>"+saveUrl);
				File file = new File(saveUrl); //upload/id/tmp/
				
				if (!file.exists()) {
					file.mkdirs();
					filename = processUploadedFile(item, saveUrl, out);
				}else{
					filename = processUploadedFile(item, saveUrl, out);
				}
			}
			System.out.println("filename : "+filename);
		}
	}
	
		
}else{
	System.out.println("not multipart!");
}

iPdsDao dao = PdsDao.getInstance();

boolean isS = dao.write(new PdsDto(id, title, content, filename));

if(isS){
	%>
	<script type="text/javascript">
	alert("파일 업로드 성공");
	location.href = "pdslist.jsp";
	</script>
	<%
}else{
%>
	<script type="text/javascript">
	alert("파일 업로드 실패");
	location.href = "pdslist.jsp";
	</script>
<%
}
%>

</body>
</html>