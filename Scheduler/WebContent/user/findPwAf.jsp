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
String id = request.getParameter("id");
String email = request.getParameter("email");

System.out.println("af name:" + id);
System.out.println("af birth:" + email);


iuserDAO dao = userDAO.getInstance();
String finded_pw = dao.findPw(id, email);


System.out.println("찾아진 비밀번호:" + finded_pw);
if(finded_pw==null){
	finded_pw = "정보를 다시 확인해 주세요";
}
%>

결과 : <%=finded_pw %>

</body>
</html>