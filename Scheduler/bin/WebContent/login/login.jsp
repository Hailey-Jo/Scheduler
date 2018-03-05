<!doctype html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<meta charset="UTF-8">
<title>Biz PayDay</title>
<style>
@import url(http://weloveiconfonts.com/api/?family=fontawesome);

@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,700);

[class*="fontawesome-"]:before {
	font-family: 'FontAwesome', sans-serif;
}

* {
	box-sizing: border-box;
}

html {
	height: 100%;
}

body {
	/* background-color: #2c3338; */
	background-color: gray;
	color: #606468;
	font: 400 0.875rem/1.5 "Open Sans", sans-serif;
	margin: 0;
	min-height: 100%;
}

a {
	color: #eee;
	outline: 0;
	text-decoration: none;
}

a:focus, a:hover {
	text-decoration: underline;
}

/* input {
	border: 0;
	color: inherit;
	font: inherit;
	margin: 0;
	outline: 0;
	padding: 0;
	-webkit-transition: background-color .3s;
	transition: background-color .3s;
} */

.site__container {
	-webkit-box-flex: 1;
	-webkit-flex: 1;
	-ms-flex: 1;
	flex: 1;
	padding: 3rem 0;
}

.form input[type="password"], .form input[type="text"], .form input[type="submit"]
	{
	width: 100%;
}

.form--login {
	color: #606468;
}

.form--login label, .form--login input[type="text"], .form--login input[type="password"],
	.form--login input[type="submit"] {
	border-radius: 0.25rem;
	padding: 1rem;
}

.form--login label {
	/* background-color: #363b41; */
	background-color: yellow;
	border-bottom-right-radius: 0;
	border-top-right-radius: 0;
	padding-left: 1.25rem;
	padding-right: 1.25rem;
}

.form--login input[type="text"], .form--login input[type="password"] {
	/* background-color: #3b4148; */
	background-color: yellow;
	border-bottom-left-radius: 0;
	border-top-left-radius: 0;
}

.form--login input[type="text"]:focus, .form--login input[type="text"]:hover,
	.form--login input[type="password"]:focus, .form--login input[type="password"]:hover
	{
	/* background-color: #434A52; */
	background-color: white;
}

.form--login input[type="submit"] {
	/*  background-color: #ea4c88; */
	background-color: #5D4200;
	color: #eee;
	font-weight: bold;
	text-transform: uppercase;
}

.form--login input[type="submit"]:focus, .form--login input[type="submit"]:hover
	{
	background-color: #6F5400;
}

.form__field {
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	margin-bottom: 1rem;
}

.form__input {
	-webkit-box-flex: 1;
	-webkit-flex: 1;
	-ms-flex: 1;
	flex: 1;
	
	border: 0;
	color: inherit;
	font: inherit;
	margin: 0;
	outline: 0;
	padding: 0;
	-webkit-transition: background-color .3s;
	transition: background-color .3s;
	
}

.align {
	-webkit-box-align: center;
	-webkit-align-items: center;
	-ms-flex-align: center;
	align-items: center;
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-orient: horizontal;
	-webkit-box-direction: normal;
	-webkit-flex-direction: row;
	-ms-flex-direction: row;
	flex-direction: row;
}

.hidden {
	border: 0;
	clip: rect(0, 0, 0, 0);
	height: 1px;
	margin: -1px;
	overflow: hidden;
	padding: 0;
	position: absolute;
	width: 1px;
}

.text--center {
	text-align: center;
}

.grid__container {
	margin: 0 auto;
	max-width: 20rem;
	width: 90%;
}

/* 모달 css */
.findinfo {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* 모달 내용 */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 50%;
}

/* 모달 닫기 버튼 */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.modal__field {
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	margin-bottom: 1rem;
}

.modal__container {
	width: auto;
	height: auto;
	background: #e6e6e6;
	border-radius: 8px;
	box-shadow: 0 0 40px -10px #000;
	margin: auto;
	padding: 20px 30px;
	max-width: calc(100vw - 40px);
	box-sizing: border-box;
	font-family: 'Montserrat', sans-serif;
	position: relative
}

modal__input{
	width:100%;
	padding:10px;
	box-sizing:border-box;
	background:none;
	outline:none;
	resize:none;
	border:0;
	font-family:'Montserrat',sans-serif;
	transition:all .3s;
	border-bottom:2px solid #bebed2
	
}

h2{
margin:10px 0;
padding-bottom:10px;
width:auto;
color:#78788c;
border-bottom:3px solid #78788c
} 


</style>

</head>

<body class="align">


	

	<div class="site__container">

		<div class="grid__container">

			<form action="loginAf.jsp" method="post" class="form form--login">

				<div class="form__field">
					<label class="fontawesome-user" for="login__username"><span
						class="hidden">Username</span></label> <input id="login__username"
						name="input_id" type="text" class="form__input" placeholder="아이디" required>
				</div>

				<div class="form__field">
					<label class="fontawesome-lock" for="login__password"><span
						class="hidden">Password</span></label> <input id="login__password"
						name="input_pw" type="password" class="form__input" placeholder="비밀번호" required>
				</div>

				<div class="form__field">
					<input type="submit" value="로그인">
<<<<<<< HEAD
				</div>				
				
=======
				</div>
			</form>

>>>>>>> a2fec2cc6ee2aa098b00676840e756e1c2c8fbc4
			<p class="text--center">
				회원이 아니신가요? <a href="signup.jsp">지금 가입하세요!</a> <span
					class="fontawesome-ok-circle"></span>
			</p>
			<p class="text--center">
				<a href="javascript:findclick();">아이디나 비밀번호를 잊으셨나요? </a> <span
					class="fontawesome-exclamation-sign"></span>
			</p>
			
			<p class="text--center">
				<label style="cursor: pointer;">로그인 유지하기  <input type="checkbox" name="save_login">
				</label> 
				<span class="fontawesome-exclamation-sign"></span>
			</p>
<<<<<<< HEAD
			</form>

=======
>>>>>>> a2fec2cc6ee2aa098b00676840e756e1c2c8fbc4
		</div>

	</div>

	<!-- 아이디 비밀번호찾기 모달 -->
	<div id="myModal" class="findinfo">

		<!-- 모달 내용 -->
		<div class="modal-content">
		

			<div class="modal__container">
			<span class="close">&times</span>
			
				
				<h2>아이디 찾기</h2>
				<form action="findAf.jsp">
					<input class="modal__input" type="text" name="input-name" placeholder="이름">
					<br>
					<input class="modal__input" type="text" name="input-birth" placeholder="생년월일">
	
					<br>
					<br> <br>
					<br> <input type="submit" value="아이디 찾기">
				</form>
				
				<br><br>							
				<h2>비밀번호 찾기</h2>
				<form action="">

					<input class="modal_input" type="text" name="input-id" placeholder="아이디">
					<br>
					<input class="modal_input" type="text" name="input-email" placeholder="이메일">

				<br>
				<br> <br>
				<br> <input type="submit" value="비밀번호 찾기">
			</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var modal = document.getElementById("myModal");

		var span = document.getElementsByClassName("close")[0];

		function findclick() {
			modal.style.display = "block";
		}

		span.onclick = function() {
			modal.style.display = "none";
		}

		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}

		}
	</script>

</body>
</html>