<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>Scheduler</title>
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
    
<!-- Side Calendar -->
#calendar-mini {
    width: 200px;
    margin: 0 auto;
    font-size: 10px;
}
.fc-header-title h2 {
    font-size: .6em;
    white-space: normal !important;
}
.fc-view-month .fc-event, .fc-view-agendaWeek .fc-event {
    font-size: 0;
    overflow: hidden;
    height: 2px;
}
.fc-view-agendaWeek .fc-event-vert {
    font-size: 0;
    overflow: hidden;
    width: 2px !important;
}
.fc-agenda-axis {
    width: 20px !important;
    font-size: .7em;
}

.fc-button-content {
    padding: 0;
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
height: 300px;
float: left;
padding: 10px;
margin-left: 10px;
margin-right: 10px;

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

<script type="text/javascript">

$(document).ready(function() {

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#calendar-mini').fullCalendar({
        theme: true,
        header: {
            left: 'prev, today',
            center: 'title',
            right: 'next'
        },
        editable: true,
        locale: "ko",
        
        // add event name to title attribute on mouseover
        eventMouseover: function(event, jsEvent, view) {
            if (view.name !== 'agendaDay') {
                $(jsEvent.target).attr('title', event.title);
            }
        },
        
        // For DEMO only
        // *************
        events: [
            {
            title: 'All Day Event',
            start: new Date(y, m, 1)},
        {
            title: 'Long Event',
            start: new Date(y, m, d - 5),
            end: new Date(y, m, d - 2)},
        {
            id: 999,
            title: 'Repeating Event',
            start: new Date(y, m, d - 3, 16, 0),
            allDay: false},
        {
            id: 999,
            title: 'Repeating Event',
            start: new Date(y, m, d + 4, 16, 0),
            allDay: false},
        {
            title: 'Meeting',
            start: new Date(y, m, d, 10, 30),
            allDay: false},
        {
            title: 'Lunch',
            start: new Date(y, m, d, 12, 0),
            end: new Date(y, m, d, 14, 0),
            allDay: false},
        {
            title: 'Birthday Party',
            start: new Date(y, m, d + 1, 19, 0),
            end: new Date(y, m, d + 1, 22, 30),
            allDay: false},
        {
            title: 'Click for Google',
            start: new Date(y, m, 28),
            end: new Date(y, m, 29),
            url: 'http://google.com/'}
        ]
    });

});

    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
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
    
	<div id="wrapper">
	

	<div style="padding: 10px; margin-left: 10px;">
	<header><div style="height: 10px;"></div><div>Scheduler</div><div style="height: 10px;"></div></header>
	</div>
	
	<div id="calendar-mini"></div>
	
    <div id="calendar" ></div>

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
