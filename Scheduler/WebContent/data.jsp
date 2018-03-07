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

{ "memberList" : [ {"name" : "김하늘", "birth" : "1월", "address" : "충북"}, {"name" : "최형택", "birth" : "2월", "address" : "대전"}, {"name" : "김대환", "birth" : "3월", "address" : "대전"}, {"name" : "김명화", "birth" : "4월", "address" : "전남"}, {"name" : "김민제", "birth" : "5월", "address" : "대전"}, {"name" : "김종민", "birth" : "6월", "address" : "대전"}, {"name" : "김평호", "birth" : "7월", "address" : "대전"}, {"name" : "문준형", "birth" : "8월", "address" : "대전"}, {"name" : "안우영", "birth" : "9월", "address" : "대전"}, {"name" : "오유근", "birth" : "10월", "address" : "대전"}, {"name" : "윤주호", "birth" : "11월", "address" : "부산"}, {"name" : "이수호", "birth" : "12월", "address" : "대전"}, {"name" : "이은식", "birth" : "1월", "address" : "충북"}, {"name" : "임창현", "birth" : "2월", "address" : "충북"}, {"name" : "황영호", "birth" : "3월", "address" : "부산"}, {"name" : "강백수", "birth" : "4월", "address" : "대전"} ], "memberCount" : 16, "courseName" : "자바 시큐어 코딩 개발자 과정" }

<%

iCashbookDAO dao = CashbookDAO.getInstance();


%>

</body>
</html>