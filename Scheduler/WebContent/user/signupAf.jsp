<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="User.userDTO"%>
<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
//form field data add
String id = "";
String pw = "";
String repw = "";
String name = "";
String birth = "";
String email = "";

String agree = "";

//file data
String filename = "";

//tomcat upload
//String fupload = application.getRealPath("/upload");

//user folder upload
String fupload = "c:"+File.separator+"upload"+File.separator;

System.out.println("file Upload : "+fupload);

String yourTempDirectory = String.valueOf(fupload);

int yourMaxRequestSize = 100*1024*1024; // 1M byte
int yourMaxMemorySize = 100*1024;


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
	System.out.println("items==>"+items.toString());
	
	Iterator<FileItem> it = items.iterator();
	
	while(it.hasNext()){
		FileItem item = it.next();
		if(item.isFormField()){ // id, title, content 파일형태가 아닐때   
			if(item.getFieldName().equals("input-id")){
				id = item.getString("utf-8");
			}else if(item.getFieldName().equals("input-pw")){
				pw = item.getString("utf-8");
			}else if(item.getFieldName().equals("input-repw")){
				repw = item.getString("utf-8");
			}else if(item.getFieldName().equals("input-name")){
				name = item.getString("utf-8");
			}else if(item.getFieldName().equals("input-birth")){
				birth = item.getString("utf-8");
			}else if(item.getFieldName().equals("input-email")){
				email = item.getString("utf-8");
			}else if(item.getFieldName().equals("agree")){
				agree = item.getString("utf-8");
			}
		}else{ //fileload
			if(item.getFieldName().equals("input-pic")){
				String saveUrl = fupload+id;
				File file = new File(saveUrl); //upload/a
				
				if (!file.exists()) {
					file.mkdirs();
					filename = processUploadedFile(item, saveUrl, out);
				}else{
					filename = processUploadedFile(item, saveUrl, out);
				}
			}
		}
	}
	
		
}else{
	System.out.println("not multipart!");
}

//user
iuserDAO dao = userDAO.getInstance();
userDTO user = new userDTO();

user.setId(id);
user.setPassword(pw);
user.setName(name);
user.setBirth(birth);
user.setEmail(email);
user.setPic(filename);

System.out.println("-----SignUpAF-------");
		
System.out.println("id:" + id);
System.out.println("name:" + name);
System.out.println("birth:" + birth.replace("-", "")); //.substring(0, 8)
System.out.println("email:" + email);
System.out.println("pic:" + filename);
System.out.println("agree:" + agree);


try{
	boolean isS = false;
		
	isS = dao.join(user);
	
	if(isS){
		%>
			<script type="text/javascript">
			alert("환영합니다 <%=id%>님");
			location.href = "../index.jsp"
			</script>

		<%	}else{	%>
			<script type="text/javascript">
			alert("가입에 실패했습니다. 빈항목을 체크해주세요.");
			location.href = "signup.jsp"
			</script>
		<%	}	%>
<%
}catch (NullPointerException e){
	e.printStackTrace();
}
%>
</body>
</html>