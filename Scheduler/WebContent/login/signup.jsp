<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
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
	background-color: navy;
	color: #606468;
	font: 400 0.875rem/1.5 "Open Sans", sans-serif;
	margin: 0;
	min-height: 100%;
}

input {
	border: 0;
	color: inherit;
	font: inherit;
	margin: 0;
	outline: 0;
	padding: 0;
	-webkit-transition: background-color .3s;
	transition: background-color .3s;
}

.site__container {
	-webkit-box-flex: 10;
	-webkit-flex: 10;
	-ms-flex: 10;
	flex: 10;
	padding: 3rem 0;
	background-color: LightGray;
}

.form input[type="text"],
.form input[type="password"],
.form input[type="submit"]
	{
	width: 100%;
}

.form input[type="text"],
.form input[type="password"],
.form input[type="submit"]
	{
	border-radius: 0.25rem;
	padding: 1rem;
}

.form--login input[type="submit"] {
	background-color: teal;
	color: #eee;
	font-weight: bold;
	text-transform: uppercase;
}

.form--login input[type="submit"]:focus, .form--login input[type="submit"]:hover
	{
	background-color: silver;
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
}

/* .align {
	-webkit-box-align: center;
	-webkit-align-item: center;
		-ms-flex-align: center;
			align-item: center;
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-orient: horizontal;
	-webkit-box-direction: normal;
		  -ms-flex-direction: row;
		  flex-direction: row;	
} */
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

.grid-container {
	margin: 0 auto;
	max-width: 30rem;
	width: 90%;
	
}

.text--center {
	text-align: center;
}

.no-resize {
	resize: vertical; /* 상하만 가능 */
}
</style>

<h2 align="center">회원가입</h2>
<body class="align">
	<div class="site__container">
		<div class="grid-container">
			
			<form action="signupAf.jsp" method="post" class="form form--login" name="sign_form">
				<div class="form__field">
					<input class="form__input" name="input-id" type="text" placeholder="아이디">
				</div> 

				<div class="form__field">
					<input class="form__input" name="input-pw" type="password" placeholder="비밀번호">
				</div>
				
				<div class="form__field">
					<input class="form__input" name="input-repw" type="password" placeholder="비밀번호 확인">
				</div>
				
				<div class="form__field">
					<input class="form__input" name="input-name" type="text" placeholder="이름">
				</div>
				
				<div class="form__field">
					<div>
						<input type="text" placeholder="생년월일" readonly="readonly"> 						
					</div>
					<div>
						<input name="input-birth" type="date" style="width: 300px; height: 100%;">
					</div>
				</div>

				<div class="form__field">
					<input class="form__input" name="input-email" type="text" placeholder="이메일">
				</div>
				
				<textarea name="agreement" rows="10" cols="65" readonly="readonly" class="no-resize">
				약관 입니다
				</textarea>
				
				<label style="cursor: pointer;"> <input class="chk-box" type="checkbox" name="CheckForm"> 
				동의합니다
				</label>
				<div class="form__field">
					<input type="submit" value="가입하기">
				</div>
			</form>
		</div>
		
	</div>	
	
	<script type="text/javascript">
    	$(".chk-box").click(function () {
    		var b = $(".chk-box").is(":checked");
			
    		if(b){
    			alert("약관에 동의하셨습니다");
    		}
		});
        
	</script>
	
</body>
</html>