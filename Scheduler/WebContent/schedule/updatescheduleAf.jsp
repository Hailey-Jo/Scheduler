<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
boolean b=true;
public boolean nullcheck(String element){
	if(element==null || element.length()<1){
		b=false;
	}	
	return b;
}
%>
<%
// userDTO user = (userDTO)session.getAttribute("login");

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());
String title = request.getParameter("title");
String simportant = request.getParameter("important");
String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate");
String category = request.getParameter("colorbtn");
String content = request.getParameter("content");

if(simportant==null){
	simportant = "off";
}
if(category.equals("Select Color")){
	category=null;
}

int important;
if(simportant.equals("on")){
	important=1;
}
else{
	important=0;
}

b = nullcheck(title);
b = nullcheck(startdate);
b = nullcheck(enddate);
/* b = nullcheck(category); */
b = nullcheck(content);

if(!b){
%>
<script type="text/javascript">
	alert("모든 항목을 입력해주시기 바랍니다.");
	location.href="updateschedule.jsp?seq=<%=seq %>";
</script>
<%
}
else{
	ScheduleDTO dto = new ScheduleDTO(seq,"AAA",title,startdate,enddate,category,content,important,0);
	iScheduleDAO dao = ScheduleDAO.getInstance();
	boolean addcheck = dao.updateSchedule(dto);
	
	if(!addcheck){
%>
	<script type="text/javascript">
		alert("실패");
	</script>
<%
}else{
%>
<script type="text/javascript">
	location.href="schedulemain.jsp";
</script>
<%
}
}
%>
</body>
</html>