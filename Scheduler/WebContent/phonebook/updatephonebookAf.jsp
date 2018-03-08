<%@page import="java.io.File"%>
<%@page import="User.userDTO"%>
<%@page import="phonebook.PhonebookDTO"%>
<%@page import="phonebook.iPhonebookDAO"%>
<%@page import="phonebook.PhonebookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String eventstring = "";
String id = "";
String pic = "";
String imgPath = "";
String serverPath = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getRequestURI()));
String packagePath = request.getContextPath();

if(session.getAttribute("login") != null){

	//user
	userDTO user = new userDTO();
	user = (userDTO)session.getAttribute("login");
	
	id = user.getId();
	pic = user.getPic();
	
	if(pic==null){
		imgPath = serverPath+packagePath+File.separator+"icon"+File.separator+"user-g.png";
	}else{
		imgPath = File.separator+"img"+File.separator+id+File.separator+pic;
	}
	
}else{
%>
<script type="text/javascript">
	alert("로그인 후 이용해 주세요.");
	location.href="index.jsp";
</script>
<%	
}
%>
<%
	String sseq = request.getParameter("seq");
	int seq = Integer.parseInt(sseq.trim());		
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	
	System.out.println("seq: " + seq);
	System.out.println("name: " + name);
	System.out.println("birth: " + birth);
	System.out.println("phone: " + phone);
	System.out.println("email: " + email);
	
	
	PhonebookDTO dto = new PhonebookDTO(seq,id,name,birth,phone,email);
	
	iPhonebookDAO dao = PhonebookDAO.getInstance();
	
	boolean check = dao.updatephonebook(dto);
	
	if(check){
%>
<script type="text/javascript">
	location.href="../phonebook/phonebookMain.jsp";
</script>
<%
}
	else{ 
%>
	<script type="text/javascript">
	alert("실패....");
	location.href="../phonebook/phonebookMain.jsp";
	</script>	
<%
}
%>

</body>
</html>