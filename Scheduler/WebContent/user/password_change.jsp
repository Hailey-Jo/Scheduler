<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
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
	header {
	    height: 10%;
	    width: auto;
	    padding: 5px;
	    color: white;
	    background-color: #006699;
	}
	
	.top {
	    font-weight: bold;
	    font-size: 2rem;
	    width: 35%;
	    float: left;
	    overflow: hidden;
	    clear: left;
	    align-content: center;
	}
  </style>

</head>

<body>
<!-- 로그인 dto 받아와서 뿌림  -->
<%
userDTO login_user_dto = (userDTO)session.getAttribute("login");

iuserDAO dao = userDAO.getInstance();
String old_pwd = dao.findPw(login_user_dto.getId(), login_user_dto.getEmail());

System.out.println(old_pwd);
%>

<!-- 비밀번호 동일여부 체크 -->
<script type="text/javascript">
	$(function() {
		$("#pwd").blur(function() {
			var userPW = $('#pwd').val();
			$.ajax({
				type : 'post',
				url : './checkRegi2.jsp',
				data : {
					userPW : userPW
				},
				success : function(data) {
						/* $("#checkMessage").attr('display','block'); */
						$("#pwd_check").html(data);
				},
				error : function() {
					alert("실패");
					
				}
			});
		});
	});
</script>

<header>
	<nav id="topMenu" style="height: 35px; vertical-align: middle;">
			<div class="topMenu_siteTitle">
				<ul>
					<li class="top">아이디 비밀번호 찾기</li>
				</ul>
			</div>
	</nav>
</header>

<div class="container">
<br><br><br><br>

  <h2>비밀번호 변경</h2>
  <hr><br><br>
  <form action="password_changeAf.jsp" class="pwd_change_form well well-sm" method="post"> 
    <div class="form-group row"  style="margin-left: 3em; margin-bottom: 1px;">
      <label class="col-sm-2" style="line-height: 35px;">현재 비밀번호&emsp;:</label>
      <div class="col-sm-3">
      	<input type="password" class="form-control" id="pwd" name="pwd">      	
      </div>
      <p id="pwd_check" style="line-height: 35px;"></p>
      
    </div>

    <div class="form-group row" style="margin-left: 3em; margin-bottom: 1px;">
      <label class="col-sm-2" style="line-height: 35px;">변경 비밀번호&emsp;:</label>
      <div class="col-sm-3">
      	<input type="password" class="form-control" id="new_pwd" name="new_pwd">
      </div>
      <p id="new_pwd_check" style="line-height: 35px;"></p>
    </div>
    
    <div class="form-group row"  style="margin-left: 3em; margin-bottom: 1px;">
      <label class="col-sm-2" style="line-height: 35px;">비밀번호 확인&emsp;:</label>
      <div class="col-sm-3">
     	 <input type="password" class="form-control" id="new_pwd2" name="new_pwd2">
     	 <p id="new_pwd_check2" style="line-height: 35px;"></p>     	 
      </div>
    </div>
    
    <br><br>
    <div class="form-group col-md-offset-5">
    	<input type="submit" class="btn btn-primary" value="비밀번호 변경">
		<button type="button" class="btn btn-warning" onclick="location.href='../Main.jsp'">뒤로가기<i class="fa fa-times spaceLeft"></i></button>
    </div>
    
    <script type="text/javascript">
    jQuery( function ($) {		// html 문서를 모두 읽고 실행
    	
	    var	form = $(".pwd_change_form");
	    var	ipwd = $("#pwd");
	    var	inew_pwd = $("#new_pwd");
	    var	inew_pwd2 = $("#new_pwd2");
    	
    
	   	form.submit(function () {
	   		
	   		var old_pwd = "<%=old_pwd%>";
	   		var re_pw = /^[a-z0-9_-]{6,18}$/;
	   		
	   		if(ipwd.val().length == 0){
	   			alert("기존 비밀번호를 입력해주세요");
	   			ipwd.focus();
	   			return false;
	   		}
	   		if(ipwd.val() != old_pwd){
				alert("기존 비밀번호가 다릅니다 다시 입력해 주세요");
				ipwd.focus();
				return false;				
			}
	   		if(inew_pwd.val().length ==0){
				alert("새 비밀번호를 입력하세요");
				ipwd.focus();
				return false;				
			}
	   		if(inew_pwd.val().test(re_pw) == false){
	   			alert("비밀번호는 6자이상 18자 이하로 정해주세요");
	   			inew_pwd.focus();
	   			return false;
	   		}
	   		if(inew_pwd.val() != inew_pwd2.val()){
				alert("새 비밀번호가 다릅니다 다시 입력해 주세요");
				inew_pwd2.focus();
				return false;
			}		
		});
	   	
	   	inew_pwd.keyup( function () {
	   		var i = $("#new_pwd_check");
	   		
			if (inew_pwd.val().length == 0) {
				i.text("");
			}else if(inew_pwd.val().length < 6) {
				i.text("너무 짧아요");
				
			}else if(inew_pwd.val().length > 18) {
				i.text("너무 길어요");
			}else{
				i.text("적당해요");
			}
		});
	   	
	   	inew_pwd2.keyup(function () {
			var j = $("#new_pwd_check2");
			
			if(inew_pwd.val() == inew_pwd2.val()){
				j.text("동일합니다");
			}
			if(inew_pwd.val() != inew_pwd2.val()){
				j.text("새 비밀번호를 다시 확인 해주세요");
			}
		});
    
	});
    </script>
    
  </form>  		
</div>




</body>
</html>