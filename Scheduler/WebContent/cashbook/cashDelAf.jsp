<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Cashbook.CashbookDTO"%>
<%@page import="java.util.List"%>
<%@page import="User.userDTO"%>
<%@page import="Cashbook.CashbookDAO"%>
<%@page import="Cashbook.iCashbookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	userDTO user = new userDTO();
	user = (userDTO)session.getAttribute("login");
	String id = user.getId();

	System.out.println("cashDelAf.jsp 도착================================= ");

	String seqbf = request.getParameter("cashDelAf");
	int seq = Integer.parseInt(seqbf);
	System.out.println("cashDelAf로 들어온 seq 번호 : " + seq);
	
	iCashbookDAO dao = CashbookDAO.getInstance();
	boolean isS = dao.deleteCashbook(seq);
	
	if(isS){
		System.out.println("삭제 성공================================= ");
	}


	List<CashbookDTO> delAfList = dao.getCashDate(id);
	
	JSONObject jsonObj = new JSONObject();
	JSONArray jArray = new JSONArray();
	
	for(int i=0; i<delAfList.size(); i++){
		
		System.out.println(delAfList.get(i).getIoMoney());
		System.out.println(delAfList.get(i).getContent());
		System.out.println(delAfList.get(i).getMoneyDate().substring(0, 10));
		System.out.println(String.format("%,d", delAfList.get(i).getPrice()));
		System.out.println(delAfList.get(i).getTitle());
		
		jsonObj.put("ioMoney", delAfList.get(i).getIoMoney());
		jsonObj.put("content", delAfList.get(i).getContent());
		jsonObj.put("moneyDate", delAfList.get(i).getMoneyDate().substring(0, 10));
		jsonObj.put("price", String.format("%,d", delAfList.get(i).getPrice()));
		jsonObj.put("title", delAfList.get(i).getTitle());
				
		jArray.add(i, jsonObj);
	}
	
	jsonObj.put("delList", jArray);
	System.out.println(jsonObj.toString());

	System.out.println("----------------------------------------------------------");
       System.out.println("JSON String 파싱");
        try{
            JSONArray delList = (JSONArray)jsonObj.get("delList");
            for(int i=0;i<delList.size();i++){
               JSONObject returnSubject = (JSONObject) delList.get(i);
               System.out.println("ioMoney : "+returnSubject.get("ioMoney"));
               System.out.println("content : "+returnSubject.get("content"));
           }
            String ioMoney = (String)jsonObj.get("ioMoney");
           System.out.println("ioMoney : " + ioMoney );
           
           String jsonSt = jsonObj.toJSONString();
       	jsonSt = jArray.toJSONString();
       	//JsonArray String으로 변환
       	System.out.println(jsonSt);
       	out.print(jsonSt);
       	out.flush();
            
        }catch(Exception e){
            e.printStackTrace();
        }
       System.out.println("----------------------------------------------------------");

	


		    
	
%>



</html>