<%@page import="User.userDTO"%>
<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
String id = request.getParameter("input-id");
String pw = request.getParameter("input-pw");
String repw = request.getParameter("input-repw");
String name = request.getParameter("input-name");
String birth = request.getParameter("input-birth");
String email = request.getParameter("input-email");
String Fichier1 = request.getParameter("Fichier1");
String agree = request.getParameter("agree");
// 약관 확인?

System.out.println("-----SignUpAF-------");
		
System.out.println("id:" + id);
System.out.println("name:" + name);
System.out.println("birth:" + birth.replace("-", "")); //.substring(0, 8)
System.out.println("email:" + email);
System.out.println("Fichier1:" + Fichier1);
System.out.println("agree:" + agree);


try{
	
	
boolean isS = false;
/* boolean ok = false;


if(agree==null){
	ok = false;	
}else{
	ok = true;
} */
	
/* if(ok){ */
	iuserDAO dao = userDAO.getInstance();
	isS = dao.join(new userDTO(0, id, pw, name, birth, email, null, 0));
	
	if(isS){
		%>
			<script type="text/javascript">
			alert("환영합니다 <%=id%>님");
			location.href = "../index.jsp"
			</script>

		<%	}else{	%>
			<script type="text/javascript">
			alert("가입에 실패했습니다. 빈항목을 체크해주세요.");
			location.href = "signup.jsp"
			</script>
		<%	}	%>
		
<%
}catch (NullPointerException e){
	e.printStackTrace();
}
%>

<!-- // seq pic 수정할 것 -->

</body>
</html>