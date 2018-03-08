<%@page import="User.userDTO"%>
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
userDTO user_dto = (userDTO)session.getAttribute("login");

String id = user_dto.getId();
String new_pwd = request.getParameter("new_pwd");
System.out.println("new_pwd: "+new_pwd);
iuserDAO dao = userDAO.getInstance();
boolean isS = dao.pwd_change(id, new_pwd);

if(isS){
%>
<script type="text/javascript">
alert("비밀번호가 변경되었습니다");
location.href = "../Main.jsp"
</script>
<%	}else{	%>
<script type="text/javascript">
alert("비밀번호 변경에 실패했습니다");
location.href = "password_change.jsp";
</script>
<%	}	%>

</body>
</html>