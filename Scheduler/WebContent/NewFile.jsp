<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>Scheduler</title>
<link rel="stylesheet" href="Calendar.css" type="text/css">
<style type="text/css">
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
.left{
width: 20%;
height: 90%;
float: left;
}
/* misc demo css */


<!-- Main div css -->
#wrapper{
border: 1px solid #FFBB00;
position: absolute;
height: 100%;
width: 100%;
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
    jQuery("#calendar-mini").fullCalendar({
    	height: 347,
    	fixedWeekCount : false,
    	
    	/* eventAfterAllRender: function(){
    		  $('.fc-week.fc-widget-content.fc-rigid').attr('style', 'min-height: 3em');
    	}, */

    	eventAfterAllRender: function(){
  		  $('#calendar-mini .fc-row').css('min-height','10px'); 
  		  $('#calendar-mini .fc-week, #calendar-mini .fc-widget-content, #calendar-mini .fc-rigid').attr('style','height: 5px');
  		},
  		
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
        , eventLimit : false

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
            {
                title  : 'event1',
                start  : '2018-02-01'
            },
            {
                title  : 'event2',
                start  : '2018-02-05',
                end    : '2018-02-07',
            },
            {
                title  : 'event3',
                start  : '2018-02-09T12:30:00',
                allDay : false // will make the time show
            }
        ]

    });
});

    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
        	fixedWeekCount : false,
            header : {
                  left : "prev"
                , center : "title"
                , right: 'month, agendaWeek, agendaDay, next'
            }
	        , navLinks: true // can click day/week names to navigate views
	        , selectable: true
	        , selectHelper: true
        
            , locale : "ko"
            , editable : true
            , eventLimit : true
            , height : 650

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
                {
                    title  : 'event1',
                    start  : '2018-02-01'
                },
                {
                    title  : 'event2',
                    start  : '2018-02-05',
                    end    : '2018-02-07',
                },
                {
                    title  : 'event3',
                    start  : '2018-02-09T12:30:00',
                    allDay : false // will make the time show
                }
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

<body>
    <div id="loading">loading...</div>
    
	<div id="wrapper" style="position: absolute; width: 100%; height: 100%">
	

	<div style="padding: 10px; margin-left: 10px;">
	<header><div style="height: 10px;"></div><div>헤더부부</div><div style="height: 10px;"></div></header>
	</div>
	
	<div class="left">
		<div align="center">
			<div class="btn-group">
			  <button type="button" class="btn btn-info">Write Menu</button>
			  <button type="button" class="btn btn-info dropdown-toggle" style="height: 34px" data-toggle="dropdown" aria-expanded="false">
			    <span class="caret"></span>
			    <span class="sr-only">Toggle Dropdown</span>
			  </button>
			  <ul class="dropdown-menu" role="menu" >
			    <li><a href="#">Write Scheduler</a></li>
			    <li><a href="#">Write MoneyBook</a></li>    
			  </ul>
			</div>
		</div>
	<br>
		<div id="calendar-mini"></div>
		<br><br>
	
		<div style="padding: 10px" class="tablediv">
			<table style="padding-top: 10px">
				<tr>
					<td>　</td>
				</tr>
				<tr>
					<td>중요일정보기</td>
				</tr>
				<tr>
					<td>
				</tr>
			
			</table>
		</div>
	</div>
	
    	<div id="calendar"></div>
	
</div>
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
</body>
</html>
