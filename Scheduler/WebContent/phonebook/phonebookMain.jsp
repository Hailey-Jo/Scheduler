<%@page import="phonebook.PhonebookDTO"%>
<%@page import="phonebook.PhonebookDAO"%>
<%@page import="phonebook.iPhonebookDAO"%>
<%@page import="User.userDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
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
	
	if(pic==null){
		imgPath = serverPath+packagePath+File.separator+"icon"+File.separator+"user-g.png";
	}else{
		imgPath = File.separator+"img"+File.separator+id+File.separator+pic;
	}
	
}else{
%>
<script type="text/javascript">
	alert("로그인 후 이용해 주세요.");
	location.href="../index.jsp";
</script>
<%	
}
%>
<%

iScheduleDAO dao = ScheduleDAO.getInstance();
List<ScheduleDTO> list = dao.getAllSchedulList(id);

for(int i=0; i<list.size();i++){	
	//2018-03-05 14:12
	eventstring +="{";	
	eventstring += "title : '"+list.get(i).getTitle()+"',";
	eventstring += "id : '"+list.get(i).getSeq()+"',";
	eventstring += "start : '"+list.get(i).getStartDate().substring(0, 16)+"',";
	eventstring += "end : '"+list.get(i).getEndDate().substring(0, 16)+"',";
	eventstring += "description : '"+list.get(i).getContent()+"',";	
	eventstring += "backgroundColor : '"+list.get(i).getCategory()+"',";
	if(list.get(i).getImportant()==1){
		eventstring += "imageurl : " +" '..\\"+"\\image\\"+"\\"+"star.png',";
	}	
	eventstring +="},"+"\n";
	
}


iPhonebookDAO pdao = PhonebookDAO.getInstance();
List<PhonebookDTO> plist = pdao.getAllPhoneList(id);

if(pic==null){
	imgPath = serverPath+packagePath+File.separator+"icon"+File.separator+"user-g.png";
}else{
	imgPath = File.separator+"img"+File.separator+id+File.separator+pic;
}
%>

<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="../css/header.css?ver=2">
<link rel="stylesheet" type="text/css" href="../css/calendar.css?ver=2">  
<style type="text/css">


.form-control{
	display : block;
}

aside{
	float: left;
	width: 300px;
    max-width: 300px;
    height : auto;
    margin: 0;
    padding: 10px;
}


article {
    margin-left: 10px;
    border-left: 1px solid  #e6e6e6;
    overflow: hidden;
    height: auto;
}

footer {
    color: white;
    background-color: #006699;
    clear: left;
    text-align: right;
}

#main{
	position: absolute;
	width: 100%;
	height: 100%;
}

body {
  width: 100%;
  height: 100%;
  min-width:800px; /* 최소 넓이가 지원되는 브라우져를 위해서 ...FF, IE7, safari */
  margin: 0px; 
  padding: 0px;  /* 옵션입니다.*/
  /* 만약 콘텐츠를 가운데 정렬로 하고 싶은 경우 text-align: center 를 타이핑 하시고, 
     패딩값을 적당하게 올려주시면 됩니다.*/
}

div.fc-center h2{
	size: 0.8em;
}

tr.important{
	border-bottom: 1px solid #EAEAEA;
}

tr.title{
	border-bottom: 1px solid #EAEAEA;
}

#loading {
    display:none;
    position:absolute;
    top:10px;
    right:10px;
}


div.barKategorie {
    float:left;
    margin:5px;
    padding-top:5px;
    padding-bottom:5px;
    padding-left:5px;
    /* padding-right:10px; */
    border-radius:5px;
    font-weight:bold;
}


tr.phonetitle th{
	background-color: #F6F6F6;
	border-left-color: #F6F6F6;
	border-right-color: #F6F6F6;
	height: 30px;
}

tr.phonedetail td{
	border-bottom: 1px solid #F6F6F6;
	height: 30px;
}

</style>
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

<script type="text/javascript">

    jQuery(document).ready(function() {
    	 jQuery(document).ready(function() {
    	        jQuery("#calendar-mini").fullCalendar({
    	        	fixedWeekCount : false,
    	            header : {
    	                  left : "prev"
    	                , center : "title"
    	                , right: 'next'
    	            }     	   
    	        	        
    		        , navLinks: true // can click day/week names to navigate views
    		        , selectable: true
    		        , selectHelper: true
    	        	, navLinks: false
    	            , locale : "ko"
    	            , editable : false
    	            , eventLimit : true
					, height : 347
    	            , googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"      // Google API KEY

    	            , eventSources : [
    	                // 대한민국의 공휴일
    	                {
    	                      googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
    	                    , className : "koHolidays"
    	                    , color : "#FF0000"
    	                    , textColor : "#FFFFFF"
    	                    , editable : false
    	                }
    	            ]
    	            , loading:function(bool) {
    	                jQuery("#loading").toggle(bool);
    	            }
    	        , events: [
    	            <%=eventstring %>
    	        ]
    	        , eventRender: function(event, eventElement) {
    				if (event.imageurl){             		
    					eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
    				}
    				//google link remove
    				$('td .fc-event-container').find('a').removeAttr("href");
    			},
    			eventClick: function(e) {  
    				var target = $(this).find('a').attr('href', '#');

    				return false
    			}
    	    });
    	        
    	        
    	    });
    	
	});

</script>
<title>BizPayDay</title>
</head>
<body>
<!-- <div id ="main"> -->

<!-- 상단 메뉴바 -->
		<header>
		<div class="row" id="header">
			<div class="col-sm-4" id="headerTitle" style=" float: left;">BizPayDay</div>
			<div class="col-sm-4" id="menuRow">
				<ul style="list-style: none; ">
					<li><a class="menuLink" href="../Main.jsp"><img src="../icon/ic_home_white_36px.svg" onmouseover='this.src="../icon/ic_home_black_36px.svg"' onmouseout='this.src="../icon/ic_home_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../schedule/schedulemain.jsp"><img src="../icon/ic_event_available_white_36px.svg" onmouseover='this.src="../icon/ic_event_available_black_36px.svg"' onmouseout='this.src="../icon/ic_event_available_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../cashbook/cashbookMain.jsp"><img src="../icon/ic_assessment_white_36px.svg" onmouseover='this.src="../icon/ic_assessment_black_36px.svg"' onmouseout='this.src="../icon/ic_assessment_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../phonebook/phonebookMain.jsp"><img src="../icon/ic_cloud_download_white_36px.svg" onmouseover='this.src="../icon/ic_cloud_download_black_36px.svg"' onmouseout='this.src="../icon/ic_cloud_download_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../phonebook/phonebookMain.jsp"><img src="../icon/ic_phone_white_36px.svg" onmouseover='this.src="../icon/ic_local_phone_black_36px.svg"' onmouseout='this.src="../icon/ic_phone_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
				</ul>
			</div>
			<div class="col-sm-4" id="myinfo" class="login_info" style=" float: right;">
			 <ul class="nav navbar-nav navbar-right">
		      	<img alt="프로필이미지" src="<%=imgPath%>" class="img-circle" width="40">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" style=" height: 30px;"><%=id %><span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a href="#">My List</a></li>
		            <li><a href="#">My Info</a></li>
		            <li><a href="../index.jsp">Log out</a></li>
		          </ul>
		        </li>
		      </ul>
			</div>
		</div>
	</header>
	
	<aside>
	<!-- 하단 -->
		<!-- 좌측 서브 메뉴 -->
		<form class="form-inline" action="../phonebook/searchphonebook.jsp" method="post">
			<div align="center">
				<input type="text" class="form-control" id="exampleFormControlInput1" name="searchtitle" style="width: 230px" placeholder="찾고싶은 이름을 입력하세요.">
				<!-- <input type="text" name="searchtitle" style="width: 236px" placeholder="찾고싶은 이름을 입력하세요."> -->
				<input TYPE="IMAGE" src="../icon/ic_search_black_24px.svg" id="submit" name="Submit" value="Submit"  align="absmiddle" height="26px" width="26px" style="padding-left: 2px">
		</div>
		</form>	
		
		<div align="center" style="padding-top: 10px">
			<!-- <button type="button" class="btn btn-info" style="width: 260px" onclick = "location.href = '../phonebook/addphonebook.jsp' " >연락처 등록</button> -->
			<button type="button" class="btn btn-primary btn-sm" style="width: 260px;" onclick = "location.href = '../phonebook/addphonebook.jsp' ">연락처 등록</button>
		</div>
	<br>
		<div id="calendar-mini"></div>
	<!-- btn1 -->
	<div style="padding: 10px" class="tablediv">	
	
		<table style="padding-top: 10px">
			<tr>
				<td>　</td>
			</tr>
			
			<tr>
				<td>
			</tr>
			
		</table>	
			
	</div>
	</aside>
		
			
	<!-- 우측 본문 -->
	<article style="padding: 10px"> <!--150/250/300/350  -->
	<table style= "padding: 10px; text-align: center">
		<col width="130"><col width="230"><col width="280"><col width="330"><col width="60"><col width="60">
		<tr class="phonetitle" >
			<th style="text-align: center">이름</th>
			<th style="text-align: center">생년월일</th>
			<th style="text-align: center">전화번호</th>
			<th style="text-align: center">이메일</th>
			<th style="text-align: center">수정</th>
			<th style="text-align: center">삭제</th>
		</tr>
		<%for(int i=0; i < plist.size(); i++){ %>
			<tr class="phonedetail">
				<td class="phonename"><%=plist.get(i).getName() %></td>
				<td class="phonebirth"><%=plist.get(i).getBirth() %></td>
				<td class="phonenumber"><%=plist.get(i).getPhone() %></td>
				<td class="phoneemail"><%=plist.get(i).getEmail() %></td>
				<td>
					<form action="updatephonebook.jsp" method="post">
						<input type="hidden" name="seq" value="<%=plist.get(i).getSeq() %>">
						<input type="submit" class="btn btn-link" value="수정">				
					</form>
				</td>
				<td>
					<form action="deletephonebook.jsp" method="post">
						<input type="hidden" name="seq" value="<%=plist.get(i).getSeq() %>">
						<input type="submit" class="btn btn-link" value="삭제">				
					</form>
				</td>
			</tr>		
		<%
		}
		%>	
	</table>
		
	</article>
	<div class="footer navbar-fixed-bottom">	
		<footer >Copyright &copy; BizPayDay</footer>
	</div>
</body>
</html>