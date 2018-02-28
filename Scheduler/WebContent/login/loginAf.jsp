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
String id = request.getParameter("input_id");
String pw = request.getParameter("input_pw");

iuserDAO dao = userDAO.getInstance();
userDTO user = dao.login(new userDTO(0, id, pw, null, null, null, null, 0));

if(user != null && !user.getId().equals("")){
	session.setAttribute("login", user);
	session.setMaxInactiveInterval(30*60);
%>
	<script type="text/javascript">
	alert("어서오세요<%=user.getId()%>님");
	location.href = "../NewFile.jsp";
	<%
	session.setAttribute("login", user);
	%>
	
	</script>


<%	}else{	%>
	<script type="text/javascript">
	alert("아이디와 패스워드를 확인해주세요");
	location.href = "login.jsp";
	</script>
<%	}	%>


</body>
</html>