<%@page import="User.userDTO"%>
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
	
	String userimgPath = "";
	
	//System.out.println(eventstring);
}

userDTO user = new userDTO();

user = (userDTO)session.getAttribute("login");

String id = user.getId();
String pic = user.getPic();

System.out.println("pic==>"+pic);
System.out.println("id===>"+id);
%>
<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="./css/header.css">
<link rel="stylesheet" type="text/css" href="./css/calendar.css">  
<style type="text/css">
#topMenu a:hover {
	text-decoration:none;
    background-color: #006699;
}
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
    border-left: 1px solid;
    overflow: hidden;
    height: auto;
}

footer {
    color: white;
    background-color: #006699;
    clear: left;
    text-align: right;
}
/* hover 시 color */
a:hover {
    background-color: #006699;
}
.jktCD-click:hover{
	color:#FFFFFF;
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
    max-width:2500px;
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
//좌측 fullcalender
jQuery(document).ready(function() {
	jQuery("#calendar-mini").fullCalendar({
		header : {
		      left : "prev"
		    , center : "title"
		    , right: 'next'
		}
		, selectable: true
		, selectHelper: true
		, navLinks: false
		, locale : "ko"
		, eventLimit : true
		, fixedWeekCount : false
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
        , events: [ <%=eventstring %> ]
        
        , eventRender: function(event, eventElement) {
        	if (event.imageurl){             		
        		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
        	}
        	
        	$('td .fc-event-container').find('a').removeAttr("href");
        }
        , eventClick: function(e) {  
            var target = $(this).find('a').attr('href', '#');
            //alert(target);
            return false
        }
	});
});	

//우측 fullcalendar
jQuery(document).ready(function() {
    jQuery("#calendar").fullCalendar({
    	
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
        	, fixedWeekCount : false

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
            	if (event.imageurl){             		
            		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
            	}
            	
            	$('#calendar td .fc-event-container').find('a').removeAttr("href");
            	
            }
            , select: function(start, end) {
                // Display the modal.
                // You could fill in the start and end fields based on the parameters
                $('.modal').modal('show');

            },
            eventClick: function(event, element) {
 
       			var moment = $('#calendar').fullCalendar('getDate').format('YYYYMM');
	     	
       			if(event.id.length > 10){
    				var target = $(this).find('a').attr('href', '#');
    				return false
    			}
       			else{
         				$('#modalTitle').html(event.title);
         				$('#modalBody').html(event.description);
         				$('#eventUrl').attr('href','updateschedule.jsp?seq='+event.id);
         				$('#fullCalModal').modal();
         		}
           
                // Display the modal and set the values to the event values.
                $('.modal').modal('show');
                $('.modal').find('#title').val(event.title);
                $('.modal').find('#starts-at').val(event.start);
                $('.modal').find('#ends-at').val(event.end);
            },

        });    

        $('#my-today-button').click(function() {
            $('#calendar').fullCalendar('today');
        });
            	
        //날짜 선택 시 datepicker 로 날짜 선택
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

</script>
<%
	
%>
<title>BizPayDay</title>
</head>
<body>
<!-- 상단 메뉴바 -->
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle" style=" float: left; width: 40%;">
				<ul>
					<li>BizPayDay</li>
				</ul>
			</div>
			<div class="topMenu_icon" align="center" style=" float: left; width: 40%;">
				<ul>
					<li><a class="menuLink" href="Main.jsp"><img src="./icon/home-w.png" onmouseover='this.src="./icon/home-n.png"' onmouseout='this.src="./icon/home-w.png"' ></a></li>
					<li><a class="menuLink" href="./schedule/scheduleMain.jsp"><img src="./icon/schedule-n.png" onmouseover='this.src="./icon/schedule-w.png"' onmouseout='this.src="./icon/schedule-n.png"' ></a></li>
					<li><a class="menuLink" href="./cashbook/cashbookMain.jsp"><img src="./icon/cash-n.png" ></a></li>
				</ul>
			</div>
			<div class="login_info" style=" float: left; width: 18%; height: 30px;">
				<img alt="프로필이미지" src="<%=pic%>">
		      <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" style=" padding:5px; height: 30px;"><%=id %><span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a href="#">My List</a></li>
		            <li><a href="#">My Info</a></li>
		            <li><a href="login.html">Log out</a></li>
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
	<!-- footer -->
	<footer>Copyright &copy; BizPayDay</footer>
	
</body>
</html>