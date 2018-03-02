<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Sign Up</title>
<style type="text/css">
</style>
<!-- DatePicker -->

<link href="../fullcalendar-3.8.2/fullcalendar.css" rel="stylesheet"/>
<link href="../fullcalendar-3.8.2/fullcalendar.print.css" rel="stylesheet" media="print"/>
<script type="text/javascript" src="../fullcalendar-3.8.2/lib/moment.min.js"></script>
<script type="text/javascript" src="../fullcalendar-3.8.2/lib/jquery.min.js"></script>
<script type="text/javascript" src="../fullcalendar-3.8.2/fullcalendar.js" charset="euc-kr"></script>
<script type="text/javascript" src="../fullcalendar-3.8.2/gcal.js"></script>
<script type="text/javascript" src="../fullcalendar-3.8.2/locale-all.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- bootstrap date Picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="../css/header.css">
<link rel="stylesheet" type="text/css" href="../css/check.css">

<script>
$(function () {
    $('#datetimepicker1').datetimepicker({
    	format:'YYYY-MM-DD',
    	locale: 'ko'
    });
});

function bs_input_file() {
	$(".input-file").before(
		function() {
			if ( ! $(this).prev().hasClass('input-ghost') ) {
				var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
				element.attr("name",$(this).attr("name"));
				element.change(function(){
					element.next(element).find('input').val((element.val()).split('\\').pop());
				});
				$(this).find("button.btn-choose").click(function(){
					element.click();
				});
				$(this).find("button.btn-reset").click(function(){
					element.val(null);
					$(this).parents(".input-file").find('input').val('');
				});
				$(this).find('input').css("cursor","pointer");
				$(this).find('input').mousedown(function() {
					$(this).parents('.input-file').prev().click();
					return false;
				});
				return element;
			}
		}
	);
}
$(function() {
	bs_input_file();
});
</script>
<body class="align">
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle">
				<ul>
					<li>Sign Up</li>
				</ul>
			</div>
		</nav>
	</header>
	<article class="container">
        <div class="col-md-6 col-md-offset-3">
          <form role="form-group" action="signupAf.jsp" method="post">
      	<div class="form-group">
          <label for="input-id">아이디</label>
          <input type="text" class="form-control" name="input-id" placeholder="아이디">
        </div>
        <div class="form-group">
          <label for="input-pw">비밀번호</label>
          <input type="password" class="form-control" name="input-pw" placeholder="비밀번호">
        </div>
        <div class="form-group">
          <label for="input-repw">비밀번호 확인</label>
          <input type="password" class="form-control" name="input-repw" placeholder="비밀번호 확인">
          <p class="help-block">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
        </div>
        <div class="form-group">
          <label for="input-name">이름</label>
          <input type="text" class="form-control" name="input-name" placeholder="이름을 입력해 주세요">
        </div>
        
        <div class="form-group">
          <label for="InputEmail">이메일 주소</label>
          <input type="email" class="form-control" name="input-email" placeholder="이메일 주소">
        </div>
        
      	<div class="form-group">
			<label for="Inputbirth">생년월일</label>
			<div class='input-group date' id='datetimepicker1'>
                <input type='text' class="form-control" name="input-birth"/>
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
			</div>
        </div>
        
				<!-- COMPONENT START -->
				<div class="form-group">
					<div class="input-group input-file" name="Fichier1">
						<span class="input-group-btn">
			        		<button class="btn btn-default btn-choose" type="button">이미지선택</button>
			    		</span>
			    		<input type="text" class="form-control" placeholder='Choose a file...' />
			    		<span class="input-group-btn">
			       			 <button class="btn btn-warning btn-reset" type="button">Reset</button>
			    		</span>
					</div>
				</div>
				<!--  -->
				<div class="checkbox">
				  <label>
				    <input type="checkbox" id="agree" name="agree">
				    <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
				    <a href="#">이용약관</a>에 동의합니다.
				  </label>
				</div>
				<div class="form-group text-center">
				  <button type="submit" class="btn btn-info" id="signup" disabled='disabled'>회원가입</button>
				  <button type="submit" class="btn btn-warning">가입취소<i class="fa fa-times spaceLeft"></i></button>
				</div>
   			</form>
		</div>
    </article>
	<script type="text/javascript">
    	$('#agree').click(function(){
    	    if($(this).is(':checked')){
    	    	alert("약관에 동의하셨습니다");
    	        $('#signup').removeAttr("disabled");
    	    }else {
    	        $('#signup').attr("disabled", "true");
    	    }
    	});
	</script>
	
</body>
</html>