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
String name = request.getParameter("name");
String birth = request.getParameter("birth");

System.out.println("af name:" + name);
System.out.println("af birth:" + birth);


iuserDAO dao = userDAO.getInstance();
String finded_id = dao.findId(name, birth);



System.out.println("찾아진 아이디:" + finded_id);
if(finded_id==null){
	System.out.println("if문 탔니??");
	finded_id = "찾으시는 아이디가 없습니다.";
}
%>

결과 : <%=finded_id %>


</body>
</html>