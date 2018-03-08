<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="Cashbook.CashbookDTO"%>
<%@page import="Cashbook.CashbookDAO"%>
<%@page import="java.io.File"%>
<%@page import="User.userDTO"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String eventstring = "";
String id = "";
String pic = "";
String imgPath = "";
String serverPath = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getRequestURI()));
String packagePath = request.getContextPath();

if(session.getAttribute("login") != null){

	//user
	userDTO user = new userDTO();
	user = (userDTO)session.getAttribute("login");
	
	id = user.getId();
	pic = user.getPic();
	
	System.out.println("===Main===");
	System.out.println("pic===>"+pic);
	
	if(pic==null){
		imgPath = serverPath+packagePath+File.separator+"icon"+File.separator+"user-g.png";
		System.out.println("imgPath==>"+imgPath);
	}else{
		imgPath = serverPath+File.separator+"img"+File.separator+user.getId()+File.separator+pic;
		System.out.println("imgPath==>"+imgPath);
	}
	
}else{
%>
<script type="text/javascript">
	alert("로그인 후 이용해 주세요.");
	location.href="index.jsp";
</script>
<%	
}
%>
<!DOCTYPE HTML>
<html>

<head>
<style type="text/css">
footer {
    color: white;
    background-color: #006699;
    clear: left;
    text-align: right;
}
.row-centered {
    text-align:center;
}
</style>
<link rel="stylesheet" type="text/css" href="./css/header.css">
<link rel="stylesheet" type="text/css" href="./css/calendar.css">  
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

<!-- chart -->
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<%
	TimeZone jst =TimeZone.getTimeZone ("JST");
	Calendar cal =Calendar.getInstance (jst);
	// 주어진 시간대에 맞게 현재 시각으로 초기화된 GregorianCalender 객체를 반환.
	// 또는 Calendar now = Calendar.getInstance(Locale.KOREA);
	
	String todayStr = cal.get (Calendar.YEAR )+"년 "+(cal.get (Calendar.MONTH )+1)+"월 "+cal.get (Calendar.DATE )+"일 ";
	
	System.out.println (cal.get (Calendar.YEAR )+"년 "+(cal.get (Calendar.MONTH )+1)+"월 "+cal.get (Calendar.DATE )+"일 ");
	
	CashbookDAO cashDao = CashbookDAO.getInstance();
	
	//수입
	int income = cashDao.getInOutcome(id, 0, "");
	System.out.println("수입 : " +income);
	//지출
	int spending = cashDao.getInOutcome(id, 1, "");
	System.out.println("지출 : " +spending);
	
	DecimalFormat df = new DecimalFormat("#,###");
	int totalMoney = income - spending;
	
	//금액 천단위 콤마
	String totMomey = df.format(totalMoney);

%>
<script type="text/javascript">
//현재 시간
setInterval("dpTime()",1000);
function dpTime(){
 var now = new Date();
  hours = now.getHours();
  minutes = now.getMinutes();
  seconds = now.getSeconds();

  if (hours > 12){
      hours -= 12;
  ampm = "오후 ";
  }else{
      ampm = "오전 ";
  }
  if (hours < 10){
      hours = "0" + hours;
  }
  if (minutes < 10){
      minutes = "0" + minutes;
  }
  if (seconds < 10){
      seconds = "0" + seconds;
  }
	document.getElementById("dpTime").innerHTML =  "<%=todayStr%>" + ampm + hours + ":" + minutes + ":" + seconds;
}

window.onload = function () {

	var options = {
		title: {
			text: "총 금액: "+"<%=totMomey%>" + "원"
		},
		subtitles: [{
			text: ""
		}],
		animationEnabled: true,
		locale: 'ko',
		data: [{
			type: "pie",
			startAngle: 40,
			toolTipContent: "<b>{label}</b>: {y}%",
			showInLegend: "true",
			legendText: "{label}",
			indexLabelFontSize: 16,
			indexLabel: "{label} - {y}원",
			dataPoints: [
				{ y: <%=income%>, label: "수입" },
				{ y: <%=spending%>, label: "지출" },
			]
		}]
	};
	$("#chartContainer").CanvasJSChart(options);

	}
</script>

<title>BizPayDay</title>
</head>
<body>
<!-- 상단 메뉴바 -->
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle" style=" float: left; width: 40%;">
				<ul>
					<li><a href="Main.jsp" style="color: white">BizPayDay</a></li>
				</ul>
			</div>
			<div>
				<ul>
					<li id="dpTime" style=" float: right; padding:5px;"></li>
				</ul>
			</div>
		</nav>
	</header>

	<!-- left -->
	<div class="col-md-3" style="height:85vh; background-color:gray;">
	 	<div class="row row-centered" style="padding: 30px; height: 80vh;">
			<div><img src="<%=imgPath%>" class="img-thumbnail" style="height: 200px;"></img></div>
			<div><br><p align="center"><font size="3" color="white"><%=id %> 님 즐거운 하루 되세요!</font></p></div>
			<div class="col-md-12" style="padding:5px;">
				<button type="button" class="btn btn-defult" style="padding: 1px; width: 100px; height: 50px;" onclick="location.href='./schedule/schedulemain.jsp'">나의 일정</button>&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-defult" style="padding: 1px; width: 100px; height: 50px;" onclick="location.href='./cashbook/cashbookMain.jsp'">나의 가계</button>
			</div><br>
			<div class="col-md-12" style="padding:5px;">
				 <button type="button" class="btn btn-defult"style="padding: 1px; width: 100px; height: 50px;" onclick="location.href='./phonebook/phonebookMain.jsp'">전화번호부</button>&nbsp;&nbsp;&nbsp;
				 <button type="button" class="btn btn-defult"style="padding: 1px; width: 100px; height: 50px;" onclick="location.href='./pds/pdslist.jsp'">자료실</button>
			</div><br>
			<div class="col-md-12" style="padding:5px;">
				 <button type="button" class="btn btn-defult"style="padding: 1px; width: 100px; height: 50px;" onclick="location.href='./user/password_change.jsp'">정보수정</button>&nbsp;&nbsp;&nbsp;
				 <button type="button" class="btn btn-defult"style="padding: 1px; width: 100px; height: 50px;" onclick="location.href='index.jsp'">로그아웃</button>
			</div>
		</div>
	</div>
	
	<!-- 우측 본문 -->
	<div class="col-md-9" style="height: 40vh;">
		<div class="col-md-6">
		<!-- tobe -->
			<p style="padding:3px; background-color: lightgray">이달의 중요일정</p>
			<table class="table table-striped">
			  <thead>
			    <tr>
			      <th>No</th>
			      <th>제목</th>
			      <th>내용</th>
			      <th>시작날짜</th>
			      <th>종료날짜</th>
			    </tr>
			  </thead>
			  <tbody>
			  <tr></tr>
			  <%
				//list get
				iScheduleDAO dao = ScheduleDAO.getInstance();
				List<ScheduleDTO> scheduleList = dao.getImportentSchedulList(id);
				
				System.out.println("scheduleList"+scheduleList);
				
				for(int i=0; i<scheduleList.size();i++){
			  %>
			    <tr>
			      <th scope="row"><%=i+1 %></th>
			      <td><%=scheduleList.get(i).getTitle() %></td>
			      <td><%=scheduleList.get(i).getContent() %></td>
			      <td><%=scheduleList.get(i).getStartDate().substring(0,10) %></td>
			      <td><%=scheduleList.get(i).getEndDate().substring(0,10) %></td>
			    </tr>
			    <%
				}
			    %>
			  </tbody>
			</table>
		</div>
		<div class="col-md-6">
			<p style="padding:3px; background-color: lightgray">이달의 가계</p>
			<div id="chartContainer" style="width:100%; height:200px;"></div>
		</div>
	</div>
	<br>
	<div class="col-md-9">
		<div class="col-md-6">
			<p style="padding:3px; background-color: lightgray">연락처</p>
						<table class="table">
			  <thead>
			    <tr>
			      <th>#</th>
			      <th>First Name</th>
			      <th>Last Name</th>
			      <th>Username</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <th scope="row">1</th>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <th scope="row">2</th>
			      <td>Jacob</td>
			      <td>Thornton</td>
			      <td>@fat</td>
			    </tr>
			    <tr>
			      <th scope="row">3</th>
			      <td>Larry</td>
			      <td>the Bird</td>
			      <td>@twitter</td>
			    </tr>
			  </tbody>
			</table>
		</div>
		<div class="col-md-6">
			<p style="padding:3px; background-color: lightgray">자료실</p>
						<table class="table">
			  <thead>
			    <tr>
			      <th>#</th>
			      <th>First Name</th>
			      <th>Last Name</th>
			      <th>Username</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <th scope="row">1</th>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <th scope="row">2</th>
			      <td>Jacob</td>
			      <td>Thornton</td>
			      <td>@fat</td>
			    </tr>
			    <tr>
			      <th scope="row">3</th>
			      <td>Larry</td>
			      <td>the Bird</td>
			      <td>@twitter</td>
			    </tr>
			  </tbody>
			</table>
		</div>
	</div>

	<!-- footer -->
	<div class="footer navbar-fixed-bottom">
		<footer>Copyright &copy; BizPayDay</footer>
	</div>
</body>
</html>