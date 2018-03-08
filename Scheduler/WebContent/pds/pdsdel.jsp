<%@page import="pds.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdsdel.jsp</title>
</head>
<body>

<%
String pdsseq = request.getParameter("seq");
int seq = Integer.parseInt(pdsseq);
String pdsid = request.getParameter("pdsid");

PdsDao dao = PdsDao.getInstance();

boolean isS = dao.pdsDel(seq);

if(isS){
%>
	<script type="text/javascript">
	alert("글이 삭제되었습니다.");
	location.href="pdslist.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("글이 삭제되지 않았습니다.");
	location.href="pdslist.jsp";
	</script>
<%
}
%>

</body>
</html>