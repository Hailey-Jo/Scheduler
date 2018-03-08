<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>biz payday</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="../css/loading.css" />	<!-- 로딩이미지 -->
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

  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#menu1">아이디 찾기</a></li>
    <li><a data-toggle="tab" href="#menu2">비밀번호 찾기</a></li>
  </ul>

  <div class="tab-content">
    <div id="menu1" class="tab-pane fade in active">
      <h3 align="left">아이디 찾기</h3>
      <hr><br>
				<div class="form_field well">				
					<div class="form-group">
						<label style="font-size: 20px">이름 :&emsp;&emsp;</label>
						<input class="input_form input-lg" type="text" id="input_name"
							placeholder="이름">
					</div>
					<div class="form-group">
						<label style="font-size: 20px">생년월일 : </label>
						<input class="input_form input-lg" type="text" id="input_birth"
							placeholder="생년월일(예:2018-01-01)">
					</div>
					<div class="form-group">
						<button id="find_id_btn" class="btn btn-primary" data-toggle="modal" data-target="#findId">아이디 찾기</button>
					</div>
				</div>
    </div>
    <div id="menu2" class="tab-pane fade">
      <h3>비밀번호 찾기</h3>
				<hr><br>
				<div class="form_field well">				
					<div class="form-group">
						<label style="font-size: 20px">아이디 :&emsp;</label>
						<input class="input_form input-lg" type="text" id="input_id"
							placeholder="아이디">
					</div>
					<div class="form-group">
						<label style="font-size: 20px">이메일 :&emsp;</label>
						<input class="input_form input-lg" type="email" id="input_email"
							placeholder="Email">
					</div>
					<div class="form-group">
						<button id="find_pw_btn" class="btn btn-primary" data-toggle="modal" data-target="#findPw">비밀번호 찾기</button>
					</div>
				</div>
    </div>
  </div>
</div>

<div align="center">
<button class="btn btn-warning" onclick="location.href='../index.jsp'">뒤로가기</button>
</div>


<!-- 아이디 찾기 modal -->
<div class="modal fade" id="findId" role="dialog">
	<div class="modal-dialog">
	
		<!-- modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button> 
				<h4 class="modal-title">아이디 찾기 결과</h4>
			</div>
			<div class="modal-body">
				<div id="resultId"></div>
				
				<script type="text/javascript">
				$("#find_id_btn").click(function () {
					$.ajax({
						type:"post",
						url:"./findIdAf.jsp",
						data:{
							name:$('#input_name').val(),
							birth:$('#input_birth').val()
						},
						success:function(data){
							$("#resultId").html(data);
		
						},
						error:function(){
							alert("실패");
						}
					});
						
				});
				</script>			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<!-- 비밀번호 찾기 modal -->
<div class="modal fade" id="findPw" role="dialog">
	<div class="modal-dialog">
	
		<!-- modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button> 
				<h4 class="modal-title">비밀번호 찾기 결과</h4>
			</div>
			<div class="modal-body">
				
				<div id="resultPw">발송중입니다...
				  <div>
				  	<span class="a">
      					<span class="b">
      			    	<span class="c">
      			  	</span>
      			  </div>
				</div>
				
				<script type="text/javascript">
				$("#find_pw_btn").click(function () {
					$.ajax({
						type:"post",
						url:"./findPwAf.jsp",
						data:{
							id:$('#input_id').val(),
							email:$('#input_email').val()
						},
						success:function(data){
							$("#resultPw").html(data);
		
						},
						error:function(){
							alert("실패");
						}
					});
						
				});
				
				</script>			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


</body>
</html>
