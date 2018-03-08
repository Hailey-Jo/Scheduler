<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
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
String userID = request.getParameter("userID");
System.out.println("userID : "+userID);

iuserDAO dao = userDAO.getInstance();
boolean checkID = dao.checkId(userID);

System.out.println("checkID : "+checkID);

String b_id = "";

if(checkID== true) {	
	b_id = "중복된 아이디 입니다";
}else if(userID.length()==0){
	b_id = "";
}else{
	b_id = "사용 가능한 아이디 입니다";
}

%>

<%=b_id %>


</body>
</html>