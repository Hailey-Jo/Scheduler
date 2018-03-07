<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
		
		jsonObj = new JSONObject();
		jsonObj.put("ioMoney", delAfList.get(i).getIoMoney()+"");
		jsonObj.put("content", delAfList.get(i).getContent());
		jsonObj.put("moneyDate", delAfList.get(i).getMoneyDate().substring(0, 10));
		jsonObj.put("price", String.format("%,d", delAfList.get(i).getPrice()));
		jsonObj.put("title", delAfList.get(i).getTitle());
				
		jArray.add(i, jsonObj);
	}
	
    String jsonSt = jsonObj.toJSONString();
   	jsonSt = jArray.toJSONString();
   	//JsonArray String으로 변환
   	System.out.println(jsonSt);
   	out.print(jsonSt);
   	out.flush();
   	

/* 	System.out.println("----------------------------------------------------------");
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

	 */
 
 
 %>
<%--  <%
 public class JsonTest { 
	 public void Bean2Json() {
		 
		MyBean myBean1 = new MyBean();
		myBean1.setId(1);
		myBean1.setName("mudchobo");
		MyBean myBean2 = new MyBean();
		myBean2.setId(2);
		myBean2.setName("shit");
		
		List<MyBean> mybeanList = new ArrayList<MyBean>();
		mybeanList.add(myBean1);
		mybeanList.add(myBean2);
		
		JSONArray jsonArray = JSONArray.fromObject(mybeanList);
		System.out.println("mybeanList - " + jsonArray);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beanlist", jsonArray);
		
		JSONObject jsonObject = JSONObject.fromObject(map);
		System.out.println("json - " + jsonObject);
	 }
 }
		    
 %>	 --%>

