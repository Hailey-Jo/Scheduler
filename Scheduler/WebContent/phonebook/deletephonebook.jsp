<%@page import="phonebook.PhonebookDAO"%>
<%@page import="phonebook.iPhonebookDAO"%>
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
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

iPhonebookDAO dao = PhonebookDAO.getInstance();
boolean check = dao.deletephonebook(seq);

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
	alert("실패했네....와이");
	location.href="../phonebook/phonebookMain.jsp";
</script>
<%
}
%>

</body>
</html>