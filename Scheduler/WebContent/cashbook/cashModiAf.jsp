<%@page import="Cashbook.CashbookDAO"%>
<%@page import="Cashbook.iCashbookDAO"%>
<%@page import="Cashbook.CashbookDTO"%>
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

	String id = request.getParameter("login_username");  
	System.out.println("id : "+id);

	System.out.println("cashIoAf.jsp 도착================================= ");

	String[] arr = request.getParameterValues("cashIoAf");
	System.out.println("cashIoAf 들어온 배열 크기 : " + arr.length);
	
	for(int i=0; i<arr.length; i++){
		System.out.println(arr[i]);
	}
	
	iCashbookDAO cashDao = CashbookDAO.getInstance();
	CashbookDTO cashDto =null;
	

	boolean isS = cashDao.modifycashbook(cashDto);
	
	if(isS){
		System.out.println("등록 성공");
	}else{
		System.out.println("등록 실패");
	}
	
%>

</body>
</html>