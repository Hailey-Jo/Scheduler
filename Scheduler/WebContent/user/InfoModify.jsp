<%@page import="User.userDTO"%>
<%@page import="User.userDAO"%>
<%@page import="User.iuserDAO"%>
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
<link href="../fullcalendar-3.8.2/fullcalendar.css" rel="stylesheet" />
<link href="../fullcalendar-3.8.2/fullcalendar.print.css"
	rel="stylesheet" media="print" />
<script type="text/javascript"
	src="../fullcalendar-3.8.2/lib/moment.min.js"></script>
<script type="text/javascript"
	src="../fullcalendar-3.8.2/lib/jquery.min.js"></script>
<script type="text/javascript"
	src="../fullcalendar-3.8.2/fullcalendar.js" charset="euc-kr"></script>
<script type="text/javascript" src="../fullcalendar-3.8.2/gcal.js"></script>
<script type="text/javascript" src="../fullcalendar-3.8.2/locale-all.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- bootstrap date Picker -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="../css/header.css">
<link rel="stylesheet" type="text/css" href="../css/check.css">

</head>
<%
String id = "";
String name = "";
String email = "";
String birth = "";

if(session.getAttribute("login") != null){

	//user
	userDTO user = new userDTO();
	user = (userDTO)session.getAttribute("login");
	
	id = user.getId();
	name = user.getName();
	email = user.getEmail();
	birth = user.getBirth();
	
	System.out.println("id==>"+id);
	System.out.println("name==>"+name);
	System.out.println("email==>"+email);
	System.out.println("birth==>"+birth);

}else{
%>
<script type="text/javascript">
	alert("로그인 후 이용해 주세요.");
	location.href="index.jsp";
</script>
<%	
}
%>
<script>

	$(function() {
		$('#datetimepicker1').datetimepicker({
			format : 'YYYY-MM-DD',
			locale : 'ko'
		});
	});
	
	$('input #input-id').attr('width', '80%');
	
	$('#input-id').text("<%=id%>");
	$('#input-email').text("<%=email%>");
	$('#input-birth').text("<%=birth%>");

	function bs_input_file() {
		$(".input-file")
				.before(
						function() {
							if (!$(this).prev().hasClass('input-ghost')) {
								var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
								element.attr("name", $(this).attr("name"));
								element.change(function() {
									element.next(element).find('input').val(
											(element.val()).split('\\').pop());
								});
								$(this).find("button.btn-choose").click(
										function() {
											element.click();
										});
								$(this).find("button.btn-reset").click(
										function() {
											element.val(null);
											$(this).parents(".input-file")
													.find('input').val('');
										});
								$(this).find('input').css("cursor", "pointer");
								$(this).find('input').mousedown(
										function() {
											$(this).parents('.input-file')
													.prev().click();
											return false;
										});
								return element;
							}
						});
	}
	$(function() {
		bs_input_file();
	});
</script>


<!-- ajax 조건부 부분 -->
<script type="text/javascript">
	$(function() {
		$("#input-id").blur(function() {
			var userID = $('#input-id').val();
			$.ajax({
				type : 'post',
				url : './checkRegi.jsp',
				data : {
					userID : userID
				},
				success : function(data) {
						/* $("#checkMessage").attr('display','block'); */
						$("#checkMessage").html(data);
				},
				error : function() {
					alert("실패");
					
				}
			});
		});
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
	<br>
	<br>
	<br>
	<br>
	<article class="container">
        <div class="col-md-8 col-md-offset-2 well well-sm">
          <form role="form-group" action="signupAf.jsp" method="post" enctype="multipart/form-data">
				<div class="form-group row">
					<div class="col-md-2">
						<label for="input-id" style="line-height: 35px;">아이디</label>&emsp;
					</div>
					<div class="col-md-5">
						<input type="text" class="form-control" name="input-id" placeholder="아이디" id="input-id" readonly>
					</div>					
					<div>
						<p id="checkMessage_ID" style="line-height: 35px;"></p>
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-md-2">
						<label for="input-pw" style="line-height: 35px;">비밀번호</label> 
					</div>
					<div class="col-md-5">
						<input type="password" class="form-control" name="input-pw" placeholder="비밀번호" id="input-pw">
						<strong class="help-block" style="display: block;width: 200%;" id="checkMessage2">영문, 숫자, 언더스코어(_), 하이픈(-)으로 이루어진  6~18 문자.</strong>
					</div>
					<div>
						<p id="checkMessage_PW" style="line-height: 35px;"></p>
					</div>
				</div>
			
				<div class="form-group row">
					<div class="col-md-2">
						<label for="input-repw" style="line-height: 35px;">비밀번호 확인</label>
					</div>
					<div class="col-md-5">
						<input type="password" class="form-control" name="input-repw" placeholder="비밀번호 확인" id="input-repw">
						<p class="help-block" style="display: block;width: 200%;" id="checkpw"></p>
					</div>
				</div>
				
				<!-- 비밀번호 확인창 blur -->
				<script type="text/javascript">
				$(function () {
					// 뿌려줄 문장
					var eqpw = "";
					
					// 비밀번호 같은지 체크
					var beqpw = false;
					
					$("#input-repw").blur(function () {
						if($("#input-pw").val()!=$("#input-repw").val()){
							eqpw = "비밀번호가 동일하지 않습니다";
							beqpw = false;
						}else if($("#input-pw").val().length==0 && $("#input-repw").val().length==0){
							eqpw = "";
							beqpw = false;
						}else {
							eqpw = "동일합니다";
							beqpw = true;
						}
					/* $("#checkpw").attr("display","block" ); */
					$("#checkpw").html(eqpw);
					});
				});
				</script>
				
				<!-- 비밀번호 입력창 blur -->
				<script type="text/javascript">
				$(function () {
					// 뿌려줄 문장
					var eqpw = "";
					
					// 비밀번호 같은지 체크
					var beqpw = false;
					
					$("#input-pw").blur(function () {				
						if($("#input-pw").val()!=$("#input-repw").val()){
							eqpw = "비밀번호가 동일하지 않습니다";
							beqpw = false;
						}else if($("#input-pw").val().length==0 && $("#input-repw").val().length==0){
							eqpw = "";
							beqpw = false;
						
						}else{
							eqpw = "동일합니다";
							beqpw = true;
						}
					/* $("#checkpw").attr("display","block" ); */
					$("#checkpw").html(eqpw);
					});
				});
				</script>
				
				<div class="form-group row">
					<div class="col-md-2">
						<label for="input-name" style="line-height: 35px;">이름</label> 
					</div>
					<div class="col-md-5">
						<input type="text" class="form-control" name="input-name" placeholder="이름을 입력해 주세요" id="input-name">
					</div>
				</div>

				<div class="form-group row">
					<div class="col-md-2">
						<label for="Input-Email" style="line-height: 35px;">이메일 주소</label>
					</div>
					<div class="col-md-5"> 
						<input type="email" class="form-control" name="input-email" placeholder="이메일 주소" id="input-email">
					</div>
				</div>

				<div class="form-group row">
					<div class="col-md-2">
						<label for="Input-birth" style="line-height: 35px;">생년월일</label>
					</div>
					<div class='input-group date col-md-5' id='datetimepicker1'>
						<input type='text' class="form-control" name="input-birth" id="input-birth" style="margin-left: 15px;"/> <!-- width: 285px; --> 
						<span class="input-group-addon"> 
							<span class="glyphicon glyphicon-calendar" style="margin-left: 15px; cursor: pointer;"></span>
						</span>
					</div>
				</div>

				<!-- COMPONENT START -->
				<div class="form-group row">
					<div class="col-md-2">
						<label for="input-pic" style="line-height: 35px;">프로필 사진</label>
					</div>
					<div class="input-group input-file col-md-7" name="input-pic">
						<span class="input-group-btn">
							<button class="btn btn-default btn-choose" type="button" style="margin-left: 15px;">이미지선택</button>
						</span> 
							<input type="text" class="form-control" placeholder='Choose a file...' style="width: 100%;" /> 
						<span class="input-group-btn">
							<button class="btn btn-warning btn-reset" type="button" >Reset</button>
						</span>
					</div>
				</div>
				<!--  -->
				<br><br>
				<div class="checkbox">
					<label> <input type="checkbox" id="agree" name="agree">
						<span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
						<a href="#">이용약관</a>에 동의합니다.
					</label>
				</div>
				
				<!-- 약관 모달 -->
				  <!-- Modal -->
				  <div class="modal fade" id="condition" role="dialog">
				    <div class="modal-dialog">
				    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <h4 class="modal-title">약관</h4>
				        </div>
				        <div class="modal-body">
				          <p>여러분은 그냥 사용하세요 ^^</p>
				        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
				      
				    </div>
				  </div>
				<!-- 약관 모달 끝 -->
				
				<br><br>
				
				<div class="form-group col-sm-offset-4">
					<button type="submit" class="btn btn-info" id="signup" disabled='disabled'>회원가입</button>
					<button type="button" class="btn btn-warning" onclick="location.href='../index.jsp'">뒤로가기<i class="fa fa-times spaceLeft"></i></button>
				</div>
				
				<script type="text/javascript">
				jQuery( function($) {		// html 문서를 모두 읽으면 포함한 코드를 실행			
				
					// 정규식을 변수에 할당
					// 정규식을 직접 작성할 줄 알면 참 좋겠지만
					// 변수 우측에 할당된 정규식은 검색하면 쉽게 찾을 수 있다 
					// 이 변수들의 활약상을 기대한다
					// 변수 이름을 're_'로 정한것은 'Reguar Expression'의 머릿글자
					
					var re_id = /^[a-z0-9_-]{3,16}$/; // 아이디 검사식
					var re_pw = /^[a-z0-9_-]{6,18}$/; // 비밀번호 검사식
					var re_birth = /^(19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
					var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; // 이메일 검사식
					
					// 선택할 요소를 변수에 할당
					// 변수에 할당하지 않으면 매번 HTML 요소를 선택해야 하기 때문에 귀찮고 성능에도 좋지 않다
					// 쉼표를 이용해서 여러 변수를 한 번에 선언할 수 있다
					// 보기 좋으라고 쉼표 단위로 줄을 바꿨다 
					
					var form = $(".signupForm");
					var iid = $("#input-id");
					var ipw = $("#input-pw");
					var ipw2 = $("#input-repw");
					var iname = $("#input-name");
					var iemail = $("#input-email");
					var ibirth = $("#input-birth");
					
					
					// 선택한 form에 서밋 이벤트가 발생하면 실행한다
					// if (사용자 입력 값이 정규식 검사에 의해 참이 아니면) {포함한 코드를 실행}
					// if 조건절 안의 '정규식.test(검사할값)' 형식은 true 또는 false를 반환한다
					// if 조건절 안의 검사 결과가 '!= true' 참이 아니면 {...} 실행
					// 사용자 입력 값이 참이 아니면 alert을 띄운다
					// 사용자 입력 값이 참이 아니면 오류가 발생한 input으로 포커스를 보낸다
					// 사용자 입력 값이 참이 아니면 form 서밋을 중단한다
					
					form.submit(function() {
						if(re_id.test(iid.val()) != true) { // 아이디 검사
							alert('[ID입력 오류] 유효한 ID를 입력해 주세요.');
							iid.focus();
							return false;
						} else if (re_pw.test(ipw.val()) != true){	// 비밀번호 검사
							alert('[PW입력 오류] 유효한 PW를 입력해 주세요.');
							ipw.focus();
							return false;
						} else if (ipw2.val() != ipw.val()){
							alert('[PW 재입력 오류] PW와 동일하게 적어주세요.');
						 	ipw2.focus();
						 	return false;
						} else if (iname.val() == ""){
							alert("[NAME 입력 오류] 이름을 입력해주세요");
							iname.focus();
							return false;
						}else if (re_mail.test(iemail.val()) != true) {
							alert("[EMAIL입력 오류] 유효한 EMAIL을 입력해 주세요");
							iemail.focus();
							return false;
						} else if (re_birth.test(ibirth.val()) != true ) {
							alert(ibirth.val());
							alert("[BIRTH 입력 오류] 생년월일을 입력해 주세요");
							ibirth.focus();
							return false;
						} 
						
					});
										
					// #uid, #upw 인풋에 입력된 값의 길이가 적당한지 알려주려고 한다
					// #uid, #upw 다음 순서에 경고 텍스트 출력을 위한 빈 strong 요소를 추가한다
					// 무턱대고 자바스크립트를 이용해서 HTML 삽입하는 것은 좋지 않은 버릇
					// 그러나 이 경우는 strong 요소가 없어도 누구나 form 핵심 기능을 이용할 수 있으니까 문제 없다
					
					/* $("#input-id, #input-pw").after('<strong></strong>'); */
					
					// #uid 인풋에서 onkeyup 이벤트가 발생하면
					iid.keyup( function() {
						var i = $("#checkMessage_ID");
						/* var s = $(this).next('strong'); // strong 요소를 변수에 할당 */
						
						if (iid.val().length == 0) { // 입력 값이 없을 때
							i.text(''); // strong 요소에 포함된 문자 지움
						} else if (iid.val().length < 3) { // 입력 값이 3보다 작을 때
							i.text('너무 짧아요.'); // strong 요소에 문자 출력
						} else if (iid.val().length > 16) { // 입력 값이 16보다 클 때
							i.text('너무 길어요.'); // strong 요소에 문자 출력
						} else if ( re_id.test(iid.val()) != true ) { // 유효하지 않은 문자 입력 시
							i.text('유효한 문자를 입력해 주세요.'); // strong 요소에 문자 출력
						} else { // 입력 값이 3 이상 16 이하일 때
							i.text('적당해요.'); // strong 요소에 문자 출력
						}
					});
					
					// #upw 인풋에서 onkeyup 이벤트가 발생하면
					ipw.keyup( function() {
						var i = $("#checkMessage_PW");
						/* var s = $(this).next('strong'); // strong 요소를 변수에 할당 */
						
						if (ipw.val().length == 0) { // 입력 값이 없을 때
							i.text(''); // strong 요소에 포함된 문자 지움
						} else if (ipw.val().length < 6) { // 입력 값이 6보다 작을 때
							i.text('너무 짧아요.'); // strong 요소에 문자 출력
						} else if (ipw.val().length > 18) { // 입력 값이 18보다 클 때
							i.text('너무 길어요.'); // strong 요소에 문자 출력
						} else { // 입력 값이 6 이상 18 이하일 때
							i.text('적당해요.'); // strong 요소에 문자 출력
						}
					});
					
				});
				// ]]>
				</script>
			</form>
		</div>

	</article>
	<script type="text/javascript">
		$('#agree').click(function() {
			if ($(this).is(':checked')) {
				alert("약관에 동의하셨습니다");
				$('#signup').removeAttr("disabled");
			} else {
				$('#signup').attr("disabled", "true");
			}
		});
	</script>


</body>
</html>