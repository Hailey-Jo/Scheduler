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
/* "seq" : afterStr[0],
"title" : $("#inCashMyModalModify #inTitle").val(),
"moneyDate" : selectedDateModify,
"category" : inCategoryModi,
"price" : $("#inCashMyModalModify #inPrice").val(),
"content" :$("#inCashMyModalModify #inContent").val(), */

	System.out.println("cashModiAf.jsp 도착================================= ");

	String seq = request.getParameter("seq");
	String title = request.getParameter("title");
	String moneyDate = request.getParameter("moneyDate");
	String category = request.getParameter("category");
	String price = request.getParameter("price");
	String content = request.getParameter("content");
	
	
	System.out.println("cashModiAf.jsp 도착================================= :" +seq);
	

	iCashbookDAO cashDao = CashbookDAO.getInstance();
	CashbookDTO cashDto =null;
	
	/* int seq, String title, String moneyDate, int category, int price, String content */
	
	boolean isS = cashDao.modifycashbook(new CashbookDTO(
									Integer.parseInt(seq), 
									title, 
									moneyDate, 
									Integer.parseInt(category), 
									Integer.parseInt(price), 
									content));
	
	if(isS){
		System.out.println("등록 성공");
	}else{
		System.out.println("등록 실패");
	}
	
%>

</body>
</html>