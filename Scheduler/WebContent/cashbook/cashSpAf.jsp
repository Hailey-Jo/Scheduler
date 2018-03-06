<%@page import="java.util.ArrayList"%>
<%@page import="Cashbook.CashbookDTO"%>
<%@page import="Cashbook.CashbookDAO"%>
<%@page import="Cashbook.iCashbookDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
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
	System.out.println("cashSpAf.jsp 도착================================= ");

	String[] arr = request.getParameterValues("cashSpAf");
	System.out.println("cashSpAf 들어온 배열 크기 : " + arr.length);
	
	for(int i=0; i<arr.length; i++){
		System.out.println(arr[i]);
	}
	
	iCashbookDAO cashDao = CashbookDAO.getInstance();
	
	List<CashbookDTO> cList = new ArrayList<CashbookDTO>();
	CashbookDTO cDto =null;
	
	for(int i=0; i<arr.length; i=i+6){
		System.out.println("========================== id : " +arr[i]);
		cList.add(new CashbookDTO(
				0,
				arr[i],
				arr[i+1],
				arr[i+2],
				1,
				Integer.parseInt(arr[i+3]),
				Math.abs(Integer.parseInt(arr[i+4])),
				arr[i+5],
				0));
	}
	boolean isS = cashDao.addCashbook(cList);
	
	if(isS){
		System.out.println("등록 성공");
	}else{
		System.out.println("등록 실패");
	}
	
%>
 
</body>
</html>