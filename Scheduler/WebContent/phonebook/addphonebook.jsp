<%@page import="java.io.File"%>
<%@page import="User.userDTO"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	location.href="index.jsp";
</script>
<%	
}
%>
<%

iScheduleDAO dao = ScheduleDAO.getInstance();
List<ScheduleDTO> list = dao.getAllSchedulList(id);

for(int i=0; i<list.size();i++){	
	eventstring +="{";
	eventstring += "title : '"+list.get(i).getTitle()+"',";
	eventstring += "start : '"+list.get(i).getStartDate().substring(0, 10)+"',";
	eventstring += "end : '"+list.get(i).getEndDate().substring(0, 10)+"',";
	eventstring += "backgroundColor : '"+list.get(i).getCategory()+"',";
	if(list.get(i).getImportant()==1){
		eventstring += "imageurl : " +" '..\\"+"\\image\\"+"\\"+"star.png',";
	}	
	eventstring +="},"+"\n";	
}

%>
<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="../css/header.css">
<link rel="stylesheet" type="text/css" href="../css/calendar.css">  
<style type="text/css">

aside{
	float: left;
	/* width: 300px; */
    max-width: 300px;
    height : auto;
    margin: 0;
    padding: 10px;
    
}

td.first{
	vertical-align: middle;
	text-align: center;

}

article {
    margin-left: 10px;
   
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

td.addtable{
	padding: 10px;
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
    
ul li a:hover, ul li a:focus {  
    color:#fff;  
    background-color:#f40;  
}  

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
<script type="text/javascript" src="../js/bootstrap-formhelpers-phone.js"></script>

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
  
</head>
<body>
<!-- <div id ="main"> -->

<!-- 상단 메뉴바 -->
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle" style=" float: left; width: 40%;">
				<ul>
					<li><a href="../Main.jsp" style="color: white">BizPayDay</a></li>
				</ul>
			</div>
			<div class="topMenu_icon" align="center" style=" float: left; width: 40%;">
				<ul>
					<li><a class="menuLink" href="../Main.jsp"><img src="../icon/ic_home_white_36px.svg" onmouseover='this.src="../icon/ic_home_black_36px.svg"' onmouseout='this.src="../icon/ic_home_white_36px.svg"'></a></li>
					<li><a class="menuLink" href="../schedule/schedulemain.jsp"><img src="../icon/ic_event_available_white_36px.svg" onmouseover='this.src="../icon/ic_event_available_black_36px.svg"' onmouseout='this.src="../icon/ic_event_available_white_36px.svg"'></a></li>
					<li><a class="menuLink" href="../cashbook/cashbookMain.jsp"><img src="../icon/ic_assessment_white_36px.svg" onmouseover='this.src="../icon/ic_assessment_black_36px.svg"' onmouseout='this.src="../icon/ic_assessment_white_36px.svg"'></a></li>
					<li><a class="menuLink" href="../phonebook/phonebookMain.jsp"><img src="../icon/ic_cloud_download_white_36px.svg" onmouseover='this.src="../icon/ic_cloud_download_black_36px.svg"' onmouseout='this.src="../icon/ic_cloud_download_white_36px.svg"'></a></li>
					<li><a class="menuLink" href="../phonebook/phonebookMain.jsp"><img src="../icon/ic_phone_white_36px.svg" ></a></li>
					
				</ul>
			</div>
			<div class="login_info" style=" float: left; width: 18%; height: 30px;">
		      <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" style=" padding:5px; height: 30px;"><%=id %><span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a href="#">My List</a></li>
		            <li><a href="#">My Info</a></li>
		            <li><a href="../login.jsp">Log out</a></li>
		          </ul>
		        </li>
		      </ul>
 		  </div>
		</nav>
	</header>
	
	<aside>
	<!-- 하단 -->
		<!-- 좌측 서브 메뉴 -->
		<div align="center">
			<button type="button" class="btn btn-primary btn-sm" style="width: 260px;" onclick = "location.href = '../phonebook/addphonebook.jsp' ">연락처 등록</button>
			<!-- <button type="button" class="btn btn-info" style="width: 260px" onclick = "location.href = '../phonebook/addphonebook.jsp' ">연락처 등록</button> -->
		</div>
	<br>
		<div id="calendar-mini"></div>
	
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
	<article style="padding: 20px">
		<form action="addphonebookAf.jsp" method="post">
			<table class="table table-striped" style="height: 634px;" valign="middle" >
	  			<col width="10%"><col width="30%"><col width="10%"><col width="30%">
	  			<tr bgcolor="#f9f9f9" >
	  				<td class="first" valign="middle">이름</td>
	  				<td><input type="text" name="name" style="width: 100%"></td>
	  				<td></td>
	  				<td></td>
	  			</tr>
	  			<tr>
	  				<td class="first">생년월일</td>
	  				<td><input type="text" name="birth" class="input-medium bfh-phone" data-format="dddd-dd-dd"></td>
	                <td></td>
	                <td></td>
	            </tr>
	            <tr>
	  				<td class="first">전화번호</td>
	  				<td><input type="text" name="phone" class="input-medium bfh-phone" data-format="ddd-dddd-dddd"></td>
	                <td></td>
	                <td></td>	
	  			</tr>
	  			<tr>
	  				<td class="first">이메일</td>
	  				<td><input type="email" name="email" style="width: 100%" placeholder="xxxx@xxxx.xxx 형식으로 입력하세요."></td>
	  				<td></td>
	  				<td></td>
	  			</tr>
	  			
	  			<tr>
	  				<td class="first"></td>
	  				<td></td>
	  				<td></td>
	  				<td>
	  					<!-- <button type="button" class="btn btn-info" onclick="location='../phonebook/phonebookMain.jsp'">뒤로가기</button> -->
	  					<button type="button" class="btn btn-primary btn-sm" onclick="location='../phonebook/phonebookMain.jsp'">뒤로가기</button>
	  					<input type="submit" class="btn btn-primary btn-sm" id="savebtn" value="저장">
	  					<!-- <input type="submit" class="btn btn-info" id="savebtn" value="저장"> -->
	  				</td>
	  			</tr>
			</table>
		</form>
	</article>
		
	<div class="footer navbar-fixed-bottom">
		<footer>Copyright &copy; BizPayDay</footer>
	</div>
	
	
</body>
</html>