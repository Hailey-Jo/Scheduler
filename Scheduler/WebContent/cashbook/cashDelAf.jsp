<%@page import="Cashbook.CashbookDAO"%>
<%@page import="Cashbook.iCashbookDAO"%>
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


	System.out.println("cashDelAf.jsp 도착================================= ");

	String seqbf = request.getParameter("cashDelAf");
	int seq = Integer.parseInt(seqbf);
	System.out.println("cashDelAf로 들어온 seq 번호 : " + seq);
	
	iCashbookDAO dao = CashbookDAO.getInstance();
	boolean isS = dao.deleteCashbook(seq);
	
	if(isS){
		System.out.println("삭제 성공================================= ");
	}

%>

</body>
</html>