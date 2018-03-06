<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%iScheduleDAO dao = ScheduleDAO.getInstance();
List<ScheduleDTO> list = dao.getAllSchedulList();
String eventstring = "";
for(int i=0; i<list.size();i++){
	System.out.println(list.get(i).toString());
	eventstring +="{";
	eventstring += "title : '"+list.get(i).getTitle()+"',";
	eventstring += "start : '"+list.get(i).getStartDate().substring(0, 10)+"',";
	eventstring += "end : '"+list.get(i).getEndDate().substring(0, 10)+"'";
	eventstring +="},";
	
	System.out.println(eventstring);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>Scheduler</title>
<style type="text/css">
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
    border-left: 1px solid gray;
    overflow: hidden;
    height: auto;
}

body {
    margin:40px 10px;
    padding:0;
    font-family:"Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
    font-size:14px;
}

#loading {
    display:none;
    position:absolute;
    top:10px;
    right:10px;
}

#calendar {
    max-width:1200px;
    margin:0 auto;
}

div.barKategorie {
    float:left;
    margin:5px;
    padding-top:5px;
    padding-bottom:5px;
    padding-left:5px;
    padding-right:10px;
    border-radius:5px;
    font-weight:bold;
}

/* misc demo css */
h2 { text-align: center; }
.buttons { display: block; margin: 0 auto; text-align: center; }
.buttons button { margin-bottom: 5px; }

<!-- Main div css -->
#wrapper{
border: 1px solid #FFBB00;
width:1400px; 
padding: 10px; 
position: absolute;
top: 10px;
left: 50%;
margin-left: -533px;
overflow: hidden; 
}
#calendar-mini{
border: 1px solid #487BE1;
width: 300px;
height: 411px;
float: left;
padding: 10px;
margin-left: 10px;
margin-right: 10px;
}
#calendar-mini div.fc-content{
	height: 1px;
}
#calendar-mini div.fc-center h2{
	font-size: 15px;
}
#calendar-mini a.fc-day-number{
	font-size: 5px;
}

#calendar{
border: 1px solid #487BE1;
width: 950px;
float: left;
padding: 10px;
margin-right: 10px;
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

<!-- icon 불러오기 -->
<!--core first + styles last-->
<link href="/static/fontawesome/fontawesome-all.css" rel="stylesheet">
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<!--load everything-->
<script defer src="/static/fontawesome/fontawesome-all.js"></script>
<script defer src="/static/fontawesome/fa-v4-shim.js"></script>

<script type="text/javascript">



jQuery(document).ready(function() {
    jQuery("#calendar").fullCalendar({
    	fixedWeekCount : false,
        header : {
              left : "prev"
            , center : "title"
            , right: 'month,agendaWeek,agendaDay, next'
        }
        , navLinks: true // can click day/week names to navigate views
        , selectable: true
        , selectHelper: true
    
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
            {
            	title : 'star',
            	start : '2018-02-05',
            	end : '2018-02-08',
            	imageurl:'.\\image\\star.png'
            }
        ],
        eventRender: function(event, eventElement) {
        	if (event.imageurl)
        		{             		
        		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
        	} 
        },
                
         select: function(start, end) {
            // Display the modal.
            // You could fill in the start and end fields based on the parameters
            $('.modal').modal('show');

        },
        eventClick: function(event, element) {
            // Display the modal and set the values to the event values.
            alert('Event: ' + event.imageurl);
            $('.modal').modal('show');
            $('.modal').find('#title').val(event.title);
            $('.modal').find('#starts-at').val(event.start);
            $('.modal').find('#ends-at').val(event.end);

        },
        editable: true,
        eventLimit: true // allow "more" link when too many events

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


   <%--  <aside>
	<jsp:include page="miniCalendar.jsp"></jsp:include>
	안녕
    </aside> --%>
    
    	<!-- 우측 본문 -->
	<aside>
		<div id="calendar-mini"></div>
	</aside>
	
		
	<article>
	<!-- include 불러오기 방법1) -->
	<div id="loading">loading...</div>
	<%@ include file="inTable.jsp" %>
	</article>
	
	<div id='datepicker'></div>

	<div class="modal fade" tabindex="-1" role="dialog">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                <h4 class="modal-title">Create new event</h4>
	            </div>
	            <div class="modal-body">
	                <div class="row">
	                    <div class="col-xs-12">
	                        <label class="col-xs-4" for="title">Event title</label>
	                        <input type="text" name="title" id="title" />
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-xs-12">
	                        <label class="col-xs-4" for="starts-at">Starts at</label>
	                        <input type="text" name="starts_at" id="starts-at" />
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-xs-12">
	                        <label class="col-xs-4" for="ends-at">Ends at</label>
	                        <input type="text" name="ends_at" id="ends-at" />
	                    </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                <button type="button" class="btn btn-primary" id="save-event">Save changes</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<script type="text/javascript">
	
	</script>
</body>
</html>
