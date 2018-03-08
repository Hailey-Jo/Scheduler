<%@page import="org.omg.Messaging.SYNC_WITH_TRANSPORT"%>
<%@page import="phonebook.PhonebookDAO"%>
<%@page import="phonebook.PhonebookDTO"%>
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
<%
	String id = "AAA";
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	
	PhonebookDAO dao = PhonebookDAO.getInstance();
	
	boolean check = true;
	boolean daocheck = true;
	
	// 1986-05-17
	if(birth.length() != 10 || Integer.parseInt(birth.substring(5, 7))>12 || Integer.parseInt(birth.substring(5, 7))<1
		|| Integer.parseInt(birth.substring(8, 10))>31 || Integer.parseInt(birth.substring(8, 10))<1){
		System.out.println("birth issue");
		check = false;
	}
	// 010-9992-6424
	if( phone.length()!=13){
		System.out.println("phone issue");
		check = false;
	}
	
	
	if(!check){%>
		<script type="text/javascript">
			alert("모든항목을 정확하게 입력하세요.");
			location.href="../phonebook/addphonebook.jsp";
		</script>
	<%
	}else{
		PhonebookDTO dto = new PhonebookDTO(0,id,name,birth,phone,email);
		daocheck = dao.addPhonebook(dto);
		
		if(daocheck){
			%>
				<script type="text/javascript">
					location.href="../phonebook/phonebookMain.jsp";
				</script>
			<%
			}
			else{
			%>
				<script type="text/javascript">
					alert("실패했다");
					location.href="../phonebook/phonebookMain.jsp";
				</script>
			<%
			}
			
	}%>
	
	

</body>
</html>