<%@page import="User.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdswrite.jsp</title>
</head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<body>

<%
userDTO user = (userDTO)session.getAttribute("login");
%>


<h3>자료올리기</h3>

<form action="pdsupload.jsp" method="post" enctype="multipart/form-data">

<table class="table table-bordered" border="1" bgcolor="lightgray">
<col width="200"><col width="500">

<tr>
	<td>아이디</td>
	<td><%=user.getId() %><input type="hidden" name="id" value="<%=user.getId() %>"></td>
</tr>

<tr>
	<td>제목</td>
	<td><input type="text" name="title" size="50"></td>
</tr>

<tr>
	<td>파일업로드</td>
	<td><input type="file" name="fileload" style="width: 400px"></td>
</tr>

<tr>
	<td>내용</td>
	<td><textarea rows="20" cols="50" name="content"></textarea></td>
</tr>

<tr align="center">
	<td colspan="2"><input type="submit" value="올리기"></td>
</tr>
</table>

</form>

</body>
</html>