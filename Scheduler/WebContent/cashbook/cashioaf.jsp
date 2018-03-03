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

	String id = request.getParameter("login_username");  
	System.out.println("id : "+id);

	System.out.println("cashioaf.jsp 도착================================= ");

	String[] arr = request.getParameterValues("cashioaf");
	System.out.println("cashioaf 들어온 배열 크기 : " + arr.length);
	
	for(int i=0; i<arr.length; i++){
		System.out.println(arr[i]);
	}

	
	iCashbookDAO cashDao = CashbookDAO.getInstance();
	
	List<CashbookDTO> cList = new ArrayList<CashbookDTO>();
	CashbookDTO cDto =null;
	
	/* private int seq; 
	private String id;
	private String title; //ex)식비, 교통비 분류
	private String moneyDate; //기입 날짜
	private int ioMoney; //수입 0 , 지출1
	private int category; //이미지
	private int price; //금액
	private String content; //상세 내역
	private int del; //삭제 여부 */
	
	/* 
	0 - 0,1,2
	1 - 3,4,5
	2 - 6,7,8 
	
	arr.push($("#inCategory"+i).val());
	arr.push($("#inPrice"+i).val());
	arr.push($("#inContent"+i).val());
	
	
};

*/
	for(int i=0; i<arr.length; i=i+5){
		System.out.println("========================== 아이콘 번호 : " +Integer.parseInt(arr[i+2]));
		System.out.println("========================== 날짜 : " +Integer.parseInt(arr[i+1]));
		cList.add(new CashbookDTO(0,"creepin",arr[i],arr[i+1],0,Integer.parseInt(arr[i+2]),Integer.parseInt(arr[i+3]),arr[i+4],0));
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