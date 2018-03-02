<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%iScheduleDAO dao = ScheduleDAO.getInstance();
List<ScheduleDTO> list = dao.getAllSchedulList();
String eventstring = "";
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
	
	text-align: center;

}

article {
    margin-left: 10px;
    border-left: 1px solid gray;
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

<!-- bootstrap date Picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/eonasdan-bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('#datetimepicker1').datetimepicker({
        	locale: 'ko'
        	
        });
        $('#datetimepicker2').datetimepicker({
        	locale: 'ko',        	
            useCurrent: false //Important! See issue #1075
        });
        $("#datetimepicker1").on("dp.change", function (e) {
            $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
        });
    });
</script>

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
    	            , editable : true
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
			<div class="topMenu_siteTitle">
				<ul>
					<li>BizPayDay</li>
				</ul>
			</div>
			
			<div class="topMenu_icon" align="center">
				<ul>
					<li><a class="menuLink" href="NewFile.jsp"><img src="../icon/home-n.png" onmouseover='this.src="../icon/home-w.png"' onmouseout='this.src="../icon/home-n.png"' ></a></li>
					<li><a class="menuLink" href="NewFile.jsp"><img src="../icon/schedule-n.png" onmouseover='this.src="../icon/schedule-w.png"' onmouseout='this.src="../icon/schedule-n.png"' ></a></li>
					<li><a class="menuLink" href=""><img src="../icon/cash-w.png" ></a></li>
				</ul>
			</div>
			
			<div class="topMenu_logInOut">
				<ul>
					<!-- <li><img src="../image/m01.jpg" style=""></li> -->
					<li>사용자 이름</li>
					<li>　|　</li>
					<li><a href="">로그아웃</a></li>
				</ul>
			</div>
		</nav>
	</header>
	
	<aside>
	<!-- 하단 -->
		<!-- 좌측 서브 메뉴 -->
		<div align="center">
			<div class="btn-group">
			  <button type="button" class="btn btn-info" style="width: 230px">Write Menu</button>
			  <button type="button" class="btn btn-info dropdown-toggle" style="height: 34px" data-toggle="dropdown" aria-expanded="false">
			    <span class="caret"></span>
			    <span class="sr-only">Toggle Dropdown</span>
			  </button>
			  <ul class="dropdown-menu" role="menu" style="width: 230px">
			    <li><a href="#">Write Scheduler</a></li>
			    <li><a href="#">Write MoneyBook</a></li>    
			  </ul>
			</div>
		</div>
	<br>
		<div id="calendar-mini"></div>
	
	<div style="padding: 10px" class="tablediv">
			<table style="padding-top: 10px">
				<tr>
					<td>　</td>
				</tr>
				<tr>
					<td style="width: 300px"><button type="button" class="btn btn-primary btn-lg btn-block">중요일정보기</button></td>
				</tr>
				<tr>
					<td>
				</tr>
			
			</table>
		</div>
	</aside>
		
			
	<!-- 우측 본문 -->
	<article style="padding: 20px">
		<form action="addscheduleAf.jsp" method="post">
			<table class="table table-striped" style="height: 634px;" >
	  			<col width="10%"><col width="30%"><col width="10%"><col width="30%">
	  			<tr bgcolor="#f9f9f9" >
	  				<td class="first">제목</td>
	  				<td><input type="text" name="title" style="width: 100%"></td>
	  				<td><input type="checkbox" name="important"> 중요</td>  
	  				<td></td>				
	  			</tr>
	  			<tr>
	  				<td class="first">시작일</td>
	  				<td>
		  				<div class='input-group date' id='datetimepicker1'>
		                    <input type='text' class="form-control"  name="startdate" />
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
	                </td>
	                <td></td>
	                <td></td>
	            </tr>
	            <tr>
	  				<td class="first">종료일</td>
	  				<td>
		  				<div class='input-group date' id='datetimepicker2'>
		                    <input type='text' class="form-control"  name="enddate" />
		                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		                </div>
	                </td>
	                <td>
	                <td>
	  			</tr>
	  			<tr>
	  				<td class="first">범주</td>
	  				<td>
	  					<div class="btn-group">
	  <input type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" id="colorbtn" class="colorbtn" 
	   value ="Select Color"><!-- <span class="caret" ></span>	   -->
	  <input type="hidden" value="Select Color" name="colorbtn" class="colorbtn">	  
	  <ul class="dropdown-menu" role="menu">
	    <li class="selectcolor"><a href="#" style="color: red">Red</a></li>
	    <li class="divider"></li>
	    <li class="selectcolor"><a href="#" style="color: orange;">Orange</a></li>
	    <li class="divider"></li>
	    <li class="selectcolor"><a href="#" style="color: yellow;">Yellow</a></li>
	    <li class="divider"></li>
	    <li class="selectcolor"><a href="#" style="color: green;">Green</a></li>
	    <li class="divider"></li>
	    <li class="selectcolor"><a href="#" style="color: blue;">Blue</a></li>
	    <li class="divider"></li>
	    <li class="selectcolor"><a href="#" style="color: navy;">Navy</a></li>
	    <li class="divider"></li>
	    <li class="selectcolor"><a href="#" style="color: purple;">Purple</a></li>
	  </ul>
	  <script type="text/javascript">
	  	$(".selectcolor").click(function() {
	  		alert($(this).children().text());
	  		alert($(this).children().attr("style"));
	  			  		
	  		$("#colorbtn").val($(this).children().text());
	  		$("#colorbtn").attr("style",$(this).children().attr("style"));
	  		$(".colorbtn").val($(this).children().text());			
	});
	  </script>
	</div>
	  				</td>
	  				<td></td>
	  				<td></td>
	  			</tr>
	  			<tr>
	  				<td class="first">내용</td>
	  				<td><textarea rows="10" cols="47" name="content"></textarea></td>
	  				<td></td>
	  				<td></td>
	  			</tr>
	  			<tr>
	  				<td class="first"></td>
	  				<td></td>
	  				<td></td>
	  				<td>
	  					<button type="button" class="btn btn-info" onclick="location='NewFile.jsp'">뒤로가기</button>
	  					<input type="submit" class="btn btn-info" id="savebtn" value="저장">
	  				</td>
	  			</tr>
			</table>
		</form>
	</article>
		
	<footer>Copyright &copy; BizPayDay</footer>
	
	
</body>
</html>