<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
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

System.out.println(seq);

iScheduleDAO dao = ScheduleDAO.getInstance();
boolean checkdelete = dao.deleteSchedule(seq);

if(checkdelete){
%>
	<script type="text/javascript">
		location.href="scheduleMain.jsp";
	</script>
<%}else{
%>
 	<script type="text/javascript">
 		alert("삭제하지못했습니다. 다시시도하세요");
 		location.href="updateschedule.jsp?seq=<%=seq %>";
 	</script>
<%
}
%>
</body>
</html>