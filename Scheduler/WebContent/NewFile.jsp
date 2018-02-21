<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>풀캘린더::구글캘린더</title>
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
        max-width:900px;
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#calendar").fullCalendar({
            header : {
                  left : "prev"
                , center : "title, month"
                , right : "next"
            }
            , lang : "ko"
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
                    end    : '2018-02-07'
                },
                {
                    title  : 'event3',
                    start  : '2018-02-09T12:30:00',
                    allDay : false // will make the time show
                }
            ]
            , eventClick:function(event) {
                if(event) {
                    alert(event.title + "\n");
                }
            }
            , eventClick:  function(event) {
                $('#modalTitle').html(event.title);
                $('#modalBody').html(event.description);
                $('#eventUrl').attr('href',event.url);
                $('#fullCalModal').modal();
            }
            
            ,  dayClick: function(date, jsEvent, view) {

                alert('Clicked on: ' + date.format());
                alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
                alert('Current view: ' + view.name);
                
                $('#modalTitle').html(event.title);
                $('#modalBody').html(event.description);
                $('#eventUrl').attr('href',event.url);
                $('#fullCalModal').modal();
                // change the day's background color just for fun
                //$(this).css('background-color', 'red');

            }
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
    <div style="width:100%;display:table-cell;float:center;">
        <div class="barKategorie" style="background-color:#FF0000;color:#FFFFFF;">
            <label>
                <input type="checkbox" class="swingBar" onChange="scheduleChoice(0, 'ko.south_korea#holiday@group.v.calendar.google.com', 'usaHolidays', '#FF0000', '#FFFFFF');" checked/>
                &nbsp;한국 공휴일
            </label>
        </div>

    <div style="height:30px;"></div>
    <div id="loading">loading...</div>
    <div id="calendar"></div>
</body>
</html>
