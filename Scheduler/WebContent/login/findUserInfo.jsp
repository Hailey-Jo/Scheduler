<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 비밀번호 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style type="text/css">
* {
	box-sizing: border-box;
}

body {
	margin: 0;
}

.page_header {
	background-color: #006699;
	padding: 20px;
	text-align: center;
	color: white;
}

.page_row:after {
	content: "";
	display: table;
	clear: both;
}

.column {
	float: left;
	width: 50%;
	padding: 15px;
	borde: 6px solid;
}

.form_field {
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	float
	margin-bottom: 1rem;
}

input {
	width: 100%; /* 원하는 너비 설정 */ 
	height: auto; /* 높이값 초기화 */ 
	line-height : normal; /* line-height 초기화 */ 
	padding: .8em .5em; /* 원하는 여백 설정, 상하단 여백으로 높이를 조절 */ 
	font-family: inherit; /* 폰트 상속 */ 
	border: 1px solid #999; 
	border-radius: 0; /* iSO 둥근모서리 제거 */ 
	outline-style: none; /* 포커스시 발생하는 효과 제거를 원한다면 */ 
	-webkit-appearance: none; /* 브라우저별 기본 스타일링 제거 */ 
	-moz-appearance: none; 
	appearance: none;
}

/* 모달 부분 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

.modal_content {
    position: relative;
    background-color: #fefefe;
    margin: auto;
    padding: 0;
    border: 1px solid #888;
    width: 30%;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s
}

</style>
</head>
<body>

	<div class="page_header">
		<h1>아이디 비밀번호 찾기</h1>
	</div>

	<div class="page_row">

		<div class="column">
			<h1>아이디 찾기</h1>
				<div class="form_field">
					<div class="form_input">
						<input class="input_form" type="text" id="input_name"
							placeholder="이름">
					</div>
					<div class="form_input">
						<input class="input_form" type="text" id="input_birth"
							placeholder="생년월일">
					</div>
					<div class="form_input">
						<button id="find_id_btn">아이디 찾기</button>
					</div>
				</div>
		</div>


		<div class="column">
			<h1>비밀번호 찾기</h1>
				<div class="form_field">
					<div class="form_input">
						<input class="input_form" type="text" id="input_id"
							placeholder="아이디">
					</div>
					<div class="form_input">
						<input class="input_form" type="text" id="input_email"
							placeholder="이메일">
					</div>
					<div class="form_input">
						<button id="find_pw_btn">비밀번호 찾기</button>
					</div>
				</div>
		</div>
	</div>

<!-- modal -->
<div id="findModal" class="modal">
	<div class="modal_content">		
		<h2>아이디 찾기 결과</h2>
		<div id="resultId"></div>
		<button id="close_modal_btn">확인</button>
		
		
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
</div>

<script type="text/javascript">
var modal = document.getElementById("findModal");
var btn = document.getElementById("find_id_btn");
var close_btn = document.getElementById("close_modal_btn");

btn.onclick = function () {
	modal.style.display = "block";
}

close_btn.onclick = function () {
	modal.style.display = "none";
}

window.onclick = function (event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
}

</script>

<div id="findModal2" class="modal">
	<div class="modal_content">		
		<h2>비밀번호 찾기 결과</h2>
		<div id="resultPw"></div>
		<button id="close_modal_btn2">확인</button>
		
		
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
</div>

<script type="text/javascript">
var modal2 = document.getElementById("findModal2");
var btn2 = document.getElementById("find_pw_btn");
var close_btn = document.getElementById("close_modal_btn2");

btn2.onclick = function () {
	modal2.style.display = "block";
}

close_btn.onclick = function () {
	modal2.style.display = "none";
}

window.onclick = function (event) {
	if (event.target == modal) {
		modal2.style.display = "none";
	}
}

</script>
</body>
</html>