<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
<%@page import="User.userDTO"%>

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
String id = request.getParameter("input-id");
String pw = request.getParameter("input-pw");
String repw = request.getParameter("input-repw");
String name = request.getParameter("input-name");
String birth = request.getParameter("input-birth");
String email = request.getParameter("input-email");
String agree = request.getParameter("CheckForm");
// 약관 확인?

		
		
System.out.println("id:" + id);
System.out.println("name:" + name);
System.out.println("birth:" + birth);
System.out.println("email:" + email);
System.out.println("agree:" + agree);


try{
	
	
boolean isS = false;
boolean ok = false;


if(agree==null){
	ok = false;	
}else{
	ok = true;
}
	
if(ok){
	iuserDAO dao = userDAO.getInstance();
	isS = dao.join(new userDTO(0, id, pw, name, birth, email, null, 0));
	
	if(isS){
		%>
			<script type="text/javascript">
			alert("환영합니다 <%=id%>님");
			location.href = "login.jsp"
			</script>

		<%	}else{	%>
			<script type="text/javascript">
			alert("가입에 실패했습니다");
			location.href = "signup.jsp"
			</script>
		<%	}	%>
		
<%
}else{
	%>
	<script type="text/javascript">
	alert("약관에 동의 후 가입할 수 있습니다");
	location.href = "signup.jsp";
	</script>

	<%}
}catch (NullPointerException e){
	e.printStackTrace();
}
%>

<!-- // seq pic 수정할 것 -->

</body>
</html>