<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
<%@page import="User.userDTO"%>
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
userDTO dto = (userDTO)session.getAttribute("login");
String id = dto.getId();
String email = dto.getEmail();

iuserDAO dao = userDAO.getInstance();

String i_user_pw = request.getParameter("userPW");	//  유저가 입력한 비밀번호
String login_user_pw = dao.findPw(id, email);	// 로그인된 유저의 비밀번호

System.out.println("유저가 입력한 비밀번호 : " + i_user_pw);
System.out.println("로그인한 유저 비밀번호 : " + login_user_pw);


String eqpw = "";

if(i_user_pw.equals(login_user_pw)){
	eqpw = "비밀번호 맞음";
}else if(i_user_pw.length() == 0){
	eqpw = "";
}else{
	eqpw = "비밀번호가 다릅니다";
}

%>

<%=eqpw %>
</body>
</html>