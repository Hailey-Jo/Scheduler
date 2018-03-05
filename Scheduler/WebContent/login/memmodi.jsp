<%@page import="User.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>biz payday 회원정보 수정</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

  <style type="text/css">
	.header {
		background-color: #006699;
		padding: 20px;
		text-align: center;
		color: white;
	}
  </style>

</head>

<body>
<!-- 로그인 dto 받아와서 뿌림  -->
<%
userDTO dto = (userDTO)session.getAttribute("login");
%>

<div class="header">
<h1>BIZ PAY DAY</h1>
</div>

<div class="container">
<br><br><br><br>

  <h2>비밀번호 변경</h2>
  <hr><br><br>
  <form action="newpwdAf"> 
    <div class="form-group">
      <label class="col-sm-3 control-label">현재 비밀번호:</label>
      <div class="col-sm-10">
      	<input type="password" class="form-control" id="pwd" name="pwd">
      </div>
    </div>

    <div class="form-group">
      <label class="col-sm-3 control-label">변경 비밀번호:</label>
      <div class="col-sm-5">
      	<input type="password" class="form-control" id="new_pwd" name="new_pwd">
      </div>
    </div>
    
    <div class="form-group">
      <label class="col-sm-3 control-label">비밀번호 확인:</label>
      <div class="col-sm-5">
     	 <input type="password" class="form-control" id="new_pwd2" name="new_pwd2">
      </div>
    </div>
    
    <button type="submit" class="btn btn-primary">비밀번호 변경</button>
  </form>
</div>


</body>
</html>