<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

<head>

<style type="text/css">
#main{
	position: absolute;
	width: 100%;
	height: 100%;
}

#header{

width : 100%;
height: 10%;
padding: 10px;
background-color: #2a5aa8;
color: #ffffff;

}

.left{
width:20%;
height: 30%;
float:left;
margin: 10px;
}

#leftBtn{
	margin: 10px;
}


#calendar {

width:80%;
height: 90%;
float:left;
padding-left: 50px;
padding-top: 50px;
/* padding-right: 100px; */

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
        jQuery("#calendar").fullCalendar({
            header : {
                  left : "prevYear, prev, myCustomButton"
                , center : "title, today"
                , right: 'myCustomButton2,month,agendaWeek,agendaDay, next, nextYear'
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
<div id ="main">
<div id="header" >
	<header><div style="height: 10px;"></div><div>BizPayDay 홈 일정 가계부  아이디 정보 | 로그아웃</div><div style="height: 10px;"></div></header>
</div>

<div class="down">
	<div class="left">
		<div class="leftBtn" align="center">
			<div id="cashBtn" style="height:auto; overflow: y:hidden;" >
				<button type="button" class="btn btn-primary btn-sm">　　　수입　　　</button>
				<button type="button" class="btn btn-primary btn-sm">　　　지출　　　</button>
				<hr>
			</div>
		</div>
		
		
		<div class="left_totalMonth">
			<div id="cashList" style="height:auto; overflow: y:hidden;">
				<b>이달의 가계</b><br><br>
				<ul class="list-group">
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  수입
						<span class="badge badge-primary badge-pill">+ 2,000</span>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  지출
						<span class="badge badge-primary badge-pill">- 1,000</span>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  총액
						<span class="badge badge-primary badge-pill">1,000</span>
					</li>
				</ul>
				<hr>
			</div>
			
		</div>
		
		<div class="left_freshList">
			<div id="" style="height: auto; overflow: y:hidden;">
			<b>최근 내역</b><br><br>
				<ul class="list-group">
					<li class="list-group-item d-flex justify-content-between align-items-center">점심식사
						<span class="badge badge-primary badge-pill">- 2,000</span>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">교통비
						<span class="badge badge-primary badge-pill">- 1,000</span>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">회비
						<span class="badge badge-primary badge-pill">-1,000</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div id="calendar"></div>
</div>


</div>
</body>
</html>