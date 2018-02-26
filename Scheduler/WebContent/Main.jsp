<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
iScheduleDAO dao = ScheduleDAO.getInstance();
List<ScheduleDTO> list = dao.getAllSchedulList();
String eventstring = "";
for(int i=0; i<list.size();i++){	
	eventstring +="{";
	eventstring += "title : '"+list.get(i).getTitle()+"',";
	eventstring += "start : '"+list.get(i).getStartDate().substring(0, 10)+"',";
	eventstring += "end : '"+list.get(i).getEndDate().substring(0, 10)+"',";
	if(list.get(i).getImportant()==1){
		eventstring += "imageurl : " +" '.\\"+"\\image\\"+"\\"+"star.png',";
	}
	eventstring +="},"+"\n";
	
	//System.out.println(eventstring);
}

String id = request.getParameter("login__username");  

System.out.println("id===>"+id);
%>
<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="./css/header.css">
<link rel="stylesheet" type="text/css" href="./css/calendar.css">  
<style type="text/css">

aside{
	float: left;
	/* width: 300px; */
    max-width: 300px;
    height : auto;
    margin: 0;
    padding: 10px;
    
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

#calendar {

width:80vm;
height: 80vm;
float:left;
padding : 50px;
/* padding-right: 100px; */

}

#loading {
    display:none;
    position:absolute;
    top:10px;
    right:10px;
}

#calendar {
    max-width:1200px;
    margin:auto;
    float:left;
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
<link href="./fullcalendar-3.8.2/fullcalendar.css" rel="stylesheet"/>
<link href="./fullcalendar-3.8.2/fullcalendar.print.css" rel="stylesheet" media="print"/>
<script type="text/javascript" src="./fullcalendar-3.8.2/lib/moment.min.js"></script>
<script type="text/javascript" src="./fullcalendar-3.8.2/lib/jquery.min.js"></script>
<script type="text/javascript" src="./fullcalendar-3.8.2/fullcalendar.js" charset="euc-kr"></script>
<script type="text/javascript" src="./fullcalendar-3.8.2/gcal.js"></script>
<script type="text/javascript" src="./fullcalendar-3.8.2/locale-all.js"></script>
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
    	            , select: function(start, end) {
    	                // Display the modal.
    	                // You could fill in the start and end fields based on the parameters
    	                $('.modal').modal('show');

    	            },
    	            eventClick: function(event, element) {
    	                // Display the modal and set the values to the event values.
    	                $('.modal').modal('show');
    	                $('.modal').find('#title').val(event.title);
    	                $('.modal').find('#starts-at').val(event.start);
    	                $('.modal').find('#ends-at').val(event.end);

    	            },
       	        	eventRender:function (event, element){
	    	        	$('td .fc-event-container').find('a').removeAttr("href");	
    	        	},
    	        });
 
    	        $('#my-today-button').click(function() {
    	            $('#calendar').fullCalendar('today');
    	        });
    	        // Bind the dates to datetimepicker.
    	        // You should pass the options you need
    	        $("#starts-at, #ends-at").datetimepicker();

    	        // Whenever the user clicks on the "save" button om the dialog
    	        $('#save-event').on('click', function() {
    	            var title = $('#title').val();
    	            if (title) {
    	                var eventData = {
    	                    title: title,
    	                    start: $('#starts-at').val(),
    	                    end: $('#ends-at').val()
    	                };
    	                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
    	            }
    	            $('#calendar').fullCalendar('unselect');


    	            // Clear modal inputs
    	            $('.modal').find('input').val('');

    	            // hide modal
    	            $('.modal').modal('hide');
    	        });
    	    });
        jQuery("#calendar").fullCalendar({
        	fixedWeekCount : false,
            header : {
                  left : "prevYear, prev, myCustomButton"
                , center : "title, today"
                , right: 'myCustomButton2,month,agendaWeek,agendaDay, next, nextYear'
            }        	    
        	        
	        , navLinks: true // can click day/week names to navigate views
	        , selectable: true
	        , selectHelper: true
        	, height : 580
            , locale : "ko"
            , editable : true
            , eventLimit : true

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
            ],
            eventRender: function(event, eventElement) {
            	if (event.imageurl)
            		{             		
            		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
            	} 
            }
            , select: function(start, end) {
                // Display the modal.
                // You could fill in the start and end fields based on the parameters
                $('.modal').modal('show');

            },
            eventClick: function(event, element) {
                // Display the modal and set the values to the event values.
                $('.modal').modal('show');
                $('.modal').find('#title').val(event.title);
                $('.modal').find('#starts-at').val(event.start);
                $('.modal').find('#ends-at').val(event.end);

            },
            editable: true,
            eventLimit: true // allow "more" link when too many events

        });
        $('#my-today-button').click(function() {
            $('#calendar').fullCalendar('today');
        });
        

        // Bind the dates to datetimepicker.
        // You should pass the options you need
        $("#starts-at, #ends-at").datetimepicker();

        // Whenever the user clicks on the "save" button om the dialog
        $('#save-event').on('click', function() {
            var title = $('#title').val();
            if (title) {
                var eventData = {
                    title: title,
                    start: $('#starts-at').val(),
                    end: $('#ends-at').val()
                };
                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
            }
            $('#calendar').fullCalendar('unselect');

            // Clear modal inputs
            $('.modal').find('input').val('');

            // hide modal
            $('.modal').modal('hide');
        });
    });

    // addEventSource, removeEventSource의 기능하는데 구별값은 googleCalendarId 이다.
    // 그렇기에 googleCalendarId는 반드시 입력해야한다.
    function scheduleChoice(num, id, distinct, color, text) {
        if(jQuery(".swingBar").eq(num).is(":checked")) {
            jQuery("#calendar").fullCalendar("addEventSource", { googleCalendarId : id, className : distinct, color : color, textColor : text });
        } else {
            jQuery("#calendar").fullCalendar("removeEventSource", { googleCalendarId : id });
        }
    }
    
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
					<li><a class="menuLink" href="NewFile.jsp"><img src="./icon/home-n.png" onmouseover='this.src="./icon/home-w.png"' onmouseout='this.src="./icon/home-n.png"' ></a></li>
					<li><a class="menuLink" href="./schedule/scheduleMain.jsp"><img src="./icon/schedule-n.png" onmouseover='this.src="./icon/schedule-w.png"' onmouseout='this.src="./icon/schedule-n.png"' ></a></li>
					<li><a class="menuLink" href="./cashbook/cashbookMain.jsp"><img src="./icon/cash-w.png" ></a></li>
				</ul>
			</div>
			
			<div class="topMenu_logInOut">
				<ul>
					<!-- <li><img src="./image/m01.jpg" style=""></li> -->
					<li><%=id %></li>
					<li><ul title="<%=id %>"></ul></li>
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
			    <li><a href="./cashbookIn.jsp">Write MoneyBook</a></li>    
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
	<article>
		<div id="calendar"></div>
	</article>
		
	<footer>Copyright &copy; BizPayDay</footer>
	
</body>
</html>