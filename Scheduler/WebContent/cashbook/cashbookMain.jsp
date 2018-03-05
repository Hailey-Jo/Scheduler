<%@page import="java.util.Calendar"%>
<%@page import="com.sun.javafx.binding.StringFormatter"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Cashbook.CashbookDTO"%>
<%@page import="Cashbook.CashbookDAO"%>
<%@page import="Cashbook.iCashbookDAO"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

String id = request.getParameter("login_username");  
System.out.println("id : "+id);

//cashbook 연결
iCashbookDAO cashDao = CashbookDAO.getInstance();

//최근 리스트 받아오기
List<CashbookDTO> cList = new ArrayList<CashbookDTO>();
cList = cashDao.getCashDate("creepin");

/* for(int i=0; i<cList.size(); i++){
	System.out.println(cList.get(i).toString());
} */


//수입
int income = cashDao.getInOutcome("creepin", 0, "");
System.out.println("수입 : " +income);
//지출
int spending = cashDao.getInOutcome("creepin", 1, "");
System.out.println("지출 : " +spending);

Calendar cal = Calendar.getInstance();

//현재 년도, 월
int year = cal.get ( cal.YEAR );
int month = cal.get ( cal.MONTH )+1;
int day = cal.get ( cal.DATE );
String monthAf;
String dayAf;
if(month<10) {
	monthAf="0"+month;
}else {
	monthAf=month+"";
}

if(day<10) {
	dayAf="0"+day;
}else {
	dayAf=day+"";
}

String todayS = year+"-"+monthAf+"-"+dayAf;

%>

<%

String eventCash = "";
for(int i=0; i<cList.size();i++){
	if(cList.get(i).getDel()!=1){
		eventCash +="{";
		eventCash += "title : '"+cList.get(i).getContent()+"  "+cList.get(i).getPrice()+"',";
		eventCash += "start : '"+cList.get(i).getMoneyDate().substring(0, 10)+"',";
		eventCash +="},";
	}
}


%>

<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="../css/header.css"> 

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

#loading {
    display:none;
    position:absolute;
    top:10px;
    right:10px;
}

#calendar {
width:80vm;
height: 80vm;
float:left;
padding : 50px;
/* padding-right: 100px; */
}

/* #calendar-mini{
border: 1px solid #487BE1;
width: 100%;
height: auto;
float: left;
padding: 10px;
margin-left: 10px;
margin-right: 10px;
} */


/* 본문 캘린더 */
#calendar-mini div.fc-content{
	height: 1px;
}
#calendar-mini div.fc-center h2{
	font-size: 15px;
}
#calendar-mini a.fc-day-number{
	font-size: 5px;
}

#calendar-out div.fc-content{
	height: 1px;
}
#calendar-out div.fc-center h2{
	font-size: 15px;
}
#calendar-out a.fc-day-number{
	font-size: 5px;
}


#calendar-mini-Modify div.fc-content{
	height: 1px;
}
#calendar-mini-Modify div.fc-center h2{
	font-size: 15px;
}
#calendar-mini-Modify a.fc-day-number{
	font-size: 5px;
}


#calendar-out-Modify div.fc-content{
	height: 1px;
}
#calendar-out-Modify div.fc-center h2{
	font-size: 15px;
}
#calendar-out-Modify a.fc-day-number{
	font-size: 5px;
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


aside .badge-error { 
  background-color: #b94a48;
}
aside .badge-error:hover {
  background-color: #953b39;
}

aside .badge-info { 
  background-color: #3a87ad;
}
aside .badge-info:hover {
  background-color: #2d6987;
}

/*더보기 버튼*/
#moreBtn{
	float: right;
}

 
/* 수입  내역 입력 */
#inCashMyModal  .modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }

#inCashMyModal  .modal-body {
	height: 500px;
	padding: 10px;
	margin-bottom: 30px;
}

#inCashMyModal .modal-body .container {
 	width: 70%;
 	float: right;
 	height: inherit;
 	overflow-y: scroll;
 }

 
#inCashMyModal  .modal-body .modal-inLeft{
	float: left;
 	width: 30%;
 	height: auto;
 	padding: 5px;
 	padding-top: 50px;
 }
 
#inCashMyModal  .modal-dialog .modal-content .modal-footer {
    bottom: 0;
    height: 60px;
}

#inCashMyModal .th_inTitle{
	width: 50px;
}

#inCashMyModal .th_inPrice{
	width: 150px;
}


/* 모달수정 수입 수정 */

#inCashMyModalModify  .modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }

#inCashMyModalModify  .modal-body {
	height: 500px;
	padding: 10px;
	margin-bottom: 30px;
}

#inCashMyModalModify .modal-body .container {
 	width: 70%;
 	float: right;
 	height: inherit;
 	overflow-y: scroll;
 }
 

#inCashMyModalModify  .modal-body .modal-inLeft{
	float: left;
 	width: 30%;
 	height: auto;
 	padding: 5px;
 	padding-top: 50px;
 }
 
#inCashMyModalModify  .modal-dialog .modal-content .modal-footer {
    bottom: 0;
    height: 60px;
}

#inCashMyModalModify .th_inTitle{
	width: 50px;
}

#inCashMyModalModify .th_inPrice{
	width: 150px;
}


/* 지출  내역 입력 */

#outCashMyModal  .modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }
 
#outCashMyModal .modal-body {
	height: 500px;
	padding: 10px;
	margin-bottom: 30px;
}

#outCashMyModal  .modal-body .modal-outLeft{
	float: left;
 	width: 30%;
 	height: auto;
 	padding: 5px;
 	padding-top: 50px;
 }
 
#outCashMyModal .modal-body .container {
 	width: 70%;
 	float: right;
 	height: inherit;
 	overflow-y: scroll;
 }
 
 
#outCashMyModal .modal-dialog .modal-content .modal-footer {
    bottom: 0;
    height: 60px;
}



#outCashMyModal .th_outTitle{
	width: 150px;
}

#outCashMyModal .th_outPrice{
	width: 150px;
}

#outCashMyModal .th_outCategory{
	width: 60px;
}
#outCashMyModal .th_outDelete{
	width: 50px;
}



/* 지출  내역 수정*/

#outCashMyModalModify  .modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }
 
#outCashMyModalModify .modal-body {
	height: 500px;
	padding: 10px;
	margin-bottom: 30px;
}

#outCashMyModalModify  .modal-body .modal-outLeft{
	float: left;
 	width: 30%;
 	height: auto;
 	padding: 5px;
 	padding-top: 50px;
 }
 
#outCashMyModalModify .modal-body .container {
 	width: 70%;
 	float: right;
 	height: inherit;
 	overflow-y: scroll;
 }
 
 
#outCashMyModalModify .modal-dialog .modal-content .modal-footer {
    bottom: 0;
    height: 60px;
}

#outCashMyModalModify .th_outTitle{
	width: 150px;
}

#outCashMyModalModyfy .th_outPrice{
	width: 150px;
}

#outCashMyModalModify .th_outCategory{
	width: 60px;
}
#outCashMyModalModify .th_outDelete{
	width: 50px;
}



/* 아이콘 버튼 스타일 */
.btn-circle {
        width: 30px;
        height: 30px;
        text-align: center;
        padding: 6px 0;
        font-size: 12px;
        line-height: 1.428571429;
        border-radius: 15px;
}
.btn-circle.btn-lg {
        width: 50px;
        height: 50px;
        padding: 13px 13px;
        font-size: 18px;
        line-height: 1.33;
        border-radius: 25px;
}

</style>
<meta name="viewport" content="width=device-width, initial-scale=1">

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

<!-- icon 불러오기 -->
<!--core first + styles last-->
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>



<script type="text/javascript">
jQuery(document).ready(function() {
/* -------------------------------------------------------------------------------
	 지출 내역 입력 창 미니 캘린더
------------------------------------------------------------------------------- */
 jQuery(document).ready(function() {
	jQuery("#calendar-out").fullCalendar({
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
            <%=eventCash %>
        ]
            , select: function(start, end) {
                // Display the modal.
                // You could fill in the start and end fields based on the parameters
                $('#datepicker .modal').modal('show');

            }, dayClick: function(date, jsEvent, view, resourceObj) {
				$('#outSelectedDate').empty();
				alert('Date: ' + date.format());
				var outSelectedDate = date.format();
				$("#outSelectedDate").append(outSelectedDate);
	             //alert('Resource ID: ' + resourceObj.id);
	           }
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
                $('calendar-out').fullCalendar('renderEvent', eventData, true); // stick? = true
            }
            $('calendar-out').fullCalendar('unselect');


            // Clear modal inputs
            $('.modal fade .modal').find('input').val('');

            // hide modal
            $('.modal fade .modal').modal('hide');
        });
    });
	
	
	
/* -------------------------------------------------------------------------------
 지출 내역 수정
------------------------------------------------------------------------------- */
jQuery(document).ready(function() {
jQuery("#calendar-out-Modify").fullCalendar({
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
        <%=eventCash %>
    ]
        , select: function(start, end) {
            // Display the modal.
            // You could fill in the start and end fields based on the parameters
            $('#datepicker .modal').modal('show');

        }, dayClick: function(date, jsEvent, view, resourceObj) {
			$('#outSelectedDateModify').empty();
			alert('Date: ' + date.format());
			var outSelectedDateModify = date.format();
			$("#outSelectedDateModify").append(outSelectedDateModify);
             //alert('Resource ID: ' + resourceObj.id);
           }
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
            $('#calendar-out-Modify').fullCalendar('renderEvent', eventData, true); // stick? = true
        }
        $('#calendar-out-Modify').fullCalendar('unselect');


        // Clear modal inputs
        $('.modal fade .modal').find('input').val('');

        // hide modal
        $('.modal fade .modal').modal('hide');
    });
});


 
/* -------------------------------------------------------------------------------
	수입 내역 창 미니 캘린더
------------------------------------------------------------------------------- */
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
   	            <%=eventCash %>
   	        ]
   	            , select: function(start, end) {
   	                // Display the modal.
   	                // You could fill in the start and end fields based on the parameters
   	                $('#datepicker .modal').modal('show');

   	                
   	            }, eventClick: function(event, element) {
   	                // Display the modal and set the values to the event values.
   	                /* $('.modal').modal('show');
   	                $('.modal').find('#title').val(event.title);
   	                $('.modal').find('#starts-at').val(event.start);
   	                $('.modal').find('#ends-at').val(event.end); */
					//$('#datepicker .modal').modal('show');
   	             	alert('Clicked ' + eventObj.title);
   	                //alert($('#datepicker .modal').val(event.start));
   	                
   	            }, dayClick: function(date, jsEvent, view, resourceObj) {
					$('#selectedDate').empty();
					alert('Date: ' + date.format());
					var selectedDate = date.format();
					$("#selectedDate").append(selectedDate);
   	             //alert('Resource ID: ' + resourceObj.id);
   	           }
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
   	                $('#calendar-mini').fullCalendar('renderEvent', eventData, true); // stick? = true
   	            }
   	            $('#calendar-mini').fullCalendar('unselect');


   	            // Clear modal inputs
   	            $('.modal fade .modal').find('input').val('');

   	            // hide modal
   	            $('.modal fade .modal').modal('hide');
   	        });
   	    });
    	 
/* -------------------------------------------------------------------------------
 	수입 내역 창 미니 캘린더  수정창
 ------------------------------------------------------------------------------- */
    	 jQuery(document).ready(function() {
    	        jQuery("#calendar-mini-Modify").fullCalendar({
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
    	            <%=eventCash %>
    	        ]
    	            , select: function(start, end) {
    	                // Display the modal.
    	                // You could fill in the start and end fields based on the parameters
    	                $('#datepicker .modal').modal('show');

    	                
    	            }, eventClick: function(event, element) {
    	                // Display the modal and set the values to the event values.
    	                /* $('.modal').modal('show');
    	                $('.modal').find('#title').val(event.title);
    	                $('.modal').find('#starts-at').val(event.start);
    	                $('.modal').find('#ends-at').val(event.end); */
 					//$('#datepicker .modal').modal('show');
    	             	alert('Clicked ' + eventObj.title);
    	                //alert($('#datepicker .modal').val(event.start));
    	                
    	            }, dayClick: function(date, jsEvent, view, resourceObj) {
 					$('#selectedDateModify').empty();
 					alert('Date: ' + date.format());
 					var selectedDateModify = date.format();
 					$("#selectedDateModify").append(selectedDateModify);
    	             //alert('Resource ID: ' + resourceObj.id);
    	           }
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
    	                $('#calendar-mini-Modify').fullCalendar('renderEvent', eventData, true); // stick? = true
    	            }
    	            $('#calendar-mini-Modify').fullCalendar('unselect');


    	            // Clear modal inputs
    	            $('.modal fade .modal').find('input').val('');

    	            // hide modal
    	            $('.modal fade .modal').modal('hide');
    	        });
    	    });
/* -------------------------------------------------------------------------------
	본문 캘린더
------------------------------------------------------------------------------- */
jQuery("#calendar").fullCalendar({
	fixedWeekCount : false,
    header : {
          left : "prevYear, prev"
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
            , url : "http://www.naver.com"
        }
    ]
    , loading:function(bool) {
        jQuery("#loading").toggle(bool);
    }
    , events: [
        <%=eventCash %>
        ],eventRender: function(event, eventElement) { 
        	if (event.imageurl)
    		{             		
    		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
    		} 
   		 },
   	  eventClick:  function(event, jsEvent, view) {

		var moment = $('#calendar').fullCalendar('getDate').format('YYYYMM');
		var eid = event.id;
/* 			
		alert("moment==>"+moment);
		alert("eid.substring(0,8)==>"+eid.substring(0,8));
*/		     	
		if(eid.indexOf(moment) == 0){
			var target = $(this).find('a').attr('href', '#');
			return false
		}else{
			$('#modalTitle').html(event.title);
			$('#modalBody').html(event.description);
			$('#eventUrl').attr('href','updateschedule.jsp?seq='+event.id);
			$('#fullCalModal').modal();
		}
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
        $('.modal fade .modal').find('input').val('');

        // hide modal
        $('.modal fade .modal').modal('hide');
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

<div id="loading">loading...</div>

<!-------------------------------------------------------------------------------
	상단 메뉴바
 ------------------------------------------------------------------------------->
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle">
				<ul>
					<li>BizPayDay</li>
				</ul>
			</div>
			
			<div class="topMenu_icon" align="center">
				<ul>
					<li><a class="menuLink" href="../Main.jsp"><img src="../icon/home-n.png" onmouseover='this.src="../icon/home-w.png"' onmouseout='this.src="../icon/home-n.png"' ></a></li>
					<li><a class="menuLink" href="../schedule/scheduleMain.jsp"><img src="../icon/schedule-n.png" onmouseover='this.src="../icon/schedule-w.png"' onmouseout='this.src="../icon/schedule-n.png"' ></a></li>
					<li><a class="menuLink" href=""><img src="../icon/cash-w.png" ></a></li>
				</ul>
			</div>
			
			<div class="topMenu_logInOut">
				<ul>
					<!-- <li><img src="./image/m01.jpg" style=""></li> -->
					<li>사용자 이름</li>
					<li>　|　</li>
					<li><a href="">로그아웃</a></li>
				</ul>
			</div>
		</nav>
	</header>
	
	
<!-------------------------------------------------------------------------------
	좌측 서브 메뉴
 ------------------------------------------------------------------------------->
	<aside>
		<div class="leftBtn" align="center">
			<div id="cashBtn" style="height:auto; overflow: y:hidden;" >
			<!-- Button trigger modal -->
				<!-- <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
				  Launch Modal window
				</button> -->
				<button type="button" id="btnInPrice" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#inCashMyModal">　　수입　　</button>
				<button type="button" id="btnOutPrice" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#outCashMyModal">　　지출　　</button>
				<hr>
			</div>
		</div>
			
		<div class="left_totalMonth">
			<div id="cashList" style="height:auto; overflow: y:hidden;">
				<b>이달의 가계</b><br><br>
				<ul class="list-group">
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  수입
					  <% if(income==0){
						  //수입 0 이면
						  %>
						  <span class="badge badge-primary badge-pill"><%=income %></span>
						  <%
					  }else{
						  %>
						  <span class="badge badge-info">+ <%=income %></span>
						  <%
					  }
					  %>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">
					지출
					  <% if(spending==0){
						  //지출 0 이면
						  %>
						  <span class="badge badge-primary badge-pill"><%=spending %></span>
						  <%
					  }else{
						  %>
						  <span class="badge badge-error">- <%=spending %></span>
						  <%
					  }
					  %>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  총액
						<span class="badge badge-primary badge-pill">= <%=income-spending %></span>
					</li>
				</ul>
				<hr>
			</div>
		</div>
			
		<div class="left_freshList">
			<div id="" style="height: auto; overflow: y:hidden;">
			<b>최근 내역</b><br><br>
				<ul class="list-group">
					<% 
					if(cList.size()==0){
						//자료가 하나도 없으면
						%>
						<li class="list-group-item d-flex justify-content-between align-items-center">
						가계부를 작성하세요
						</li>
						<%
					
					//만약 불러올 리스트 5개 이하이면
					}else if(cList.size()<6){
						for(int i=0; i<cList.size(); i++) {
							//천단위 콤마
							int price = cList.get(i).getPrice();
							String priceAf =String.format("%,d", price);
							
							//수입일 때
							if(cList.get(i).getIoMoney()==0){
								%>
								<li><a href="#" class="list-group-item list-group-item-action" onclick="show('<%=cList.get(i) %>')">
								<%=cList.get(i).getContent() %>
								<span class="badge badge-info">+ <%=priceAf  %> 원</span>
								</a>
								</li>
								<%
							}else{
								//지출일 때
								%>
								<li><a href="#" class="list-group-item list-group-item-action" onclick="show('<%=cList.get(i) %>')">
								<%=cList.get(i).getContent() %>
								<span class="badge badge-error">- <%=priceAf %> 원</span>
								</a>
								</li>
								<%
							}
						}
					}else {
						//리스트 5개 초과
						for(int i=0; i<5; i++) {
							//천단위 콤마
							int price = cList.get(i).getPrice();
							String priceAf =String.format("%,d", price);
							
							//수입일 때
							if(cList.get(i).getIoMoney()==0){
								%>
								<li><a href="#" class="list-group-item list-group-item-action"  onclick="show('<%=cList.get(i) %>')">
								<%=cList.get(i).getContent() %>
								<span class="badge badge-info">+ <%=priceAf  %> 원</span>
								</a>
								</li>
								<%
							}else{
								//지출일 때
								%>
								<li><a href="#" class="list-group-item list-group-item-action"  onclick="show('<%=cList.get(i) %>')">
								<%=cList.get(i).getContent() %>
								<span class="badge badge-error">- <%=priceAf %> 원</span>
								</a>
								</li>
								<%
							}
						}
					}
					%>
				</ul>
				
				<%if(cList.size()>6){
					%>
					<a href="#" id=moreBtn class="badge badge-light" style="background-color: #fff; color: #777;">... 더보기</a>
					<%
				}
				%>
			</div>
		</div>
	</aside>
		
<!-------------------------------------------------------------------------------
	캘린더 본문 (article)
 ------------------------------------------------------------------------------->
	<article>
		<div id="calendar"></div>	
		<div id="fullCalModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
                <h4 id="modalTitle" class="modal-title"></h4>
            </div>
            <div id="modalBody" class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button class="btn btn-primary"><a id="eventUrl" target="_blank" style="color: white; font-weight: 100">Event Page</a></button>
            </div>
        </div>
    </div>
</div>
	</article>
	
<!-------------------------------------------------------------------------------
	 데이터 관련 modal
 ------------------------------------------------------------------------------->
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
	
		
	<footer>Copyright &copy; BizPayDay</footer>
	
	
<!-------------------------------------------------------------------------------
	 수입내역입력 기능
 ------------------------------------------------------------------------------->
<div class="modal fade" id="inCashMyModal" role="dialog">
    <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">수입 내역 입력</h4>
      </div>
      <div class="modal-body">
	      <div class="modal-inLeft">
				<div id="calendar-mini"><br><div style="padding-left: 5px;">선택한 날짜 : <span id="selectedDate"><%=todayS %></span></div></div>
				<!-- 
				<div id="grandtotal">총 금액 : </div> -->
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inContent">수입 내역</th>
		          <th class="th_inPrice">금액</th>
		          <th class="th_intitle">분류</th>
		          <th class="th_inCategory">아이콘</th>
		          <th class="th_inDelete">삭제</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr onclick='myFunction(this)'>
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="내역 입력" id="inContent"/>
		          </td>
		          
		          <td>
		            <div class="input-group">
		            <span class="input-group-addon">
		            <i class="fas fa-won-sign"></i>
		            </span>
		            <input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" id="inPrice" />
		            </div>
		          </td>
		          
		          <td>
		            <select class="form-control match-content" id="inTitle">
		            <option selected="selected">주수입</option>
		            <option>부수입</option>
		            <option>기타</option>
		            </select>
		          </td>
		          	<td><a href="#iconPlus" class="btn btn-info" data-toggle="collapse">+</a></td>
					<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>
		        </tr>
		        <tr id="plusDel">
				<td colspan="6"><div id="iconPlus" class="collapse">
				<div data-toggle="buttons">
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="1"><i class="far fa-smile"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="2"><i class="fab fa-angellist"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="3"><i class="fas fa-suitcase"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="4"><i class="far fa-thumbs-up"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="5"><i class="fas fa-bicycle"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="6"><i class="fas fa-bus"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="7"><i class="fas fa-camera-retro"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="8"><i class="fas fa-coffee"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="9"><i class="fas fa-film"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="10"><i class="fas fa-gift"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="11"><i class="fas fa-headphones"></i></label>
				</div></div></td></tr>
		      </tbody>
		       <tfoot>
		        <tr>
		           <td colspan="5" style="text-align: center;">
		                <input type="button" class="btn btn-lg btn-block " id="addrow" value="수입 내역 입력" />
		            </td>
		        </tr>
		        <tr>
		        </tr>
		    </tfoot>
		    </table>
		  </div>
      </div>
		<div id="myAlert">
		</div>
      <div class="modal-footer">
        <button type="button" id="btn_saveIo" class="btn btn btn-primary">Save</button>
        <button type="button" class="btn btn-orange" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
 
<!-------------------------------------------------------------------------------
	 지출내역입력
 ------------------------------------------------------------------------------->
  <div class="modal fade" id="outCashMyModal" role="dialog">
    <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">지출 내역 입력</h4>
      </div>
      
      <div class="modal-body">
	       <div class="modal-outLeft">
				<div id="calendar-out"><br><div style="padding-left: 5px;">선택한 날짜 : <span id="outSelectedDate"><%=todayS %></span></div></div>
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_outContent">지출 내역</th>
		          <th class="th_outPrice">금액</th>
		          <th class="th_outTitle">분류</th>
		          <th class="th_outCategory">아이콘</th>
		          <th class="th_outDelete">삭제</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="내역 입력" id="outContent"/>
		          </td>
		          
		          <td>
		          <div class="input-group">
		          <span class="input-group-addon">
		          <i class="fas fa-won-sign"></i></span>
		          <input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" id="outPrice'+out_Counter+'" />
		          </div></td>
		          
		          <td>
		            <select class="form-control match-content" id="outTitle">
		              <option>식비</option>
		              <option>통신비</option>
		              <option>공과금</option>
		              <option>의류/미용</option>
		              <option>건강/문화생활</option>
		              <option>교육/육아</option>
		              <option>교통/차량</option>
		              <option>경조사/회비</option>
		              <option>기타</option>
		            </select>
		          </td>
		          <td><a href="#iconPlus" class="btn btn-info" data-toggle="collapse">+</a></td>
		          <td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>
		        </tr>
		        <tr id="minusDel">
		        <td colspan="6"><div id="iconPlus" class="collapse">';
					<div data-toggle="buttons">';
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="1"><i class="far fa-smile"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="2"><i class="fab fa-angellist"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="3"><i class="fas fa-suitcase"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="4"><i class="far fa-thumbs-up"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="5"><i class="fas fa-bicycle"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="6"><i class="fas fa-bus"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="7"><i class="fas fa-camera-retro"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="8"><i class="fas fa-coffee"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="9"><i class="fas fa-film"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="10"><i class="fas fa-gift"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="11"><i class="fas fa-headphones"></i></label>
					</div></div></td>
		        </tr>
		      </tbody>
		       <tfoot>
		        <tr>
		           <td colspan="6" style="text-align: left;">
		                <input type="button" class="btn btn-lg btn-block " id="addrowOut" value="지출 내역 입력" />
		            </td>
		        </tr>
		        <tr>
		        </tr>
		    </tfoot>
		    </table>
		  </div>
      </div>
      <div class="modal-footer">
		<button type="button" id="btn_saveSpend" class="btn btn btn-primary">Save</button>
        <button type="button" class="btn btn-orange" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div> 

<!-------------------------------------------------------------------------------
	수입내역입력 기능
 ------------------------------------------------------------------------------->
        	
 <script type="text/javascript">
 var counter = 0;
 $(document).ready(function () {
	 
	$("#btnInPrice").on("click", function () {
    	 counter=0;
		//alert("수입 입력 버튼 클릭 counter 값 :" +counter);
    	//테이블 초기화
		$( '#inCashMyModal .table > tbody').empty();
		
	});
	
    $("#addrow").on("click", function () {
        var newRow = $("<tr onclick='myFunction(this)'>");
        var cols = "";
        
        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" id="inContent'+counter+'"/></td>';
        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" id="inPrice'+counter+'" /></div></td>';
        cols += '<td><select class="form-control match-content" id="inTitle'+counter+'"><option selected="selected">주수입</option><option>부수입</option><option>기타</option></select></td>';
        cols += '<td><a href="#iconPlus'+counter+'" class="btn btn-info" data-toggle="collapse">+</a></td>';
        cols += '<td><input id="'+counter+'" type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>';
       
        newRow.append(cols);
        $("#inCashMyModal .table").append(newRow);
        
        newRow = $("<tr id='plusDel"+counter+"'>")
        cols = "";
        cols += '<td colspan="6"><div id="iconPlus'+counter+'" class="collapse">';
        cols += '<div data-toggle="buttons">';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="1"><i class="far fa-smile"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="2"><i class="fab fa-angellist"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="3"><i class="fas fa-suitcase"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="4"><i class="far fa-thumbs-up"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="5"><i class="fas fa-bicycle"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="6"><i class="fas fa-bus"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="7"><i class="fas fa-camera-retro"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="8"><i class="fas fa-coffee"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="9"><i class="fas fa-film"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="10"><i class="fas fa-gift"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="11"><i class="fas fa-headphones"></i></label>';
        cols += '</div></div></td></tr>';
        
        newRow.append(cols);
        $("#inCashMyModal .table").append(newRow);
        counter++;
        
    });

	
	/* 삭제 */
    $("#inCashMyModal .table").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
        //alert(typeof counter);
        //alert(counter);
        //alert($(this).attr('id'));

         $("#plusDel"+$(this).attr('id')).remove();
         counter -= 1 
     }); 
});



/* 	function calculateRow(row) {
	    var price = +row.find('input[name^="cashPrice"]').val();
	    alert(price)
	}

	function calculateGrandTotal() {
	    var grandTotal = 0;
	    $(".table.order-list").find('input[name^="cashPrice"]').each(function () {
	        grandTotal += +$(this).val();
	    });
	    $("#grandtotal").text(grandTotal.toFixed(2));
	} 
	 */
</script>


<!-------------------------------------------------------------------------------
	 지출내역입력 기능
 ------------------------------------------------------------------------------->
 <script type="text/javascript">
 var out_Counter = 0;
 $(document).ready(function () {
	 
	 $("#btnOutPrice").on("click", function () {
		 out_Counter = 0;
		$( '#outCashMyModal .table > tbody').empty();
		
	});
 
    $("#addrowOut").on("click", function () {
        var newRow = $("<tr onclick='myFunction(this)'>");
        var cols = "";
        
        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" id="outContent'+out_Counter+'"/></td>';
        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" id="outPrice'+out_Counter+'" /></div></td>';
        cols += '<td><select class="form-control match-content" id="outTitle'+out_Counter+'"><option>식비</option><option>통신비</option><option>공과금</option><option>의류/미용</option><option>건강/문화생활</option><option>교육/육아</option><option>교통/차량</option><option>경조사/회비</option><option>기타</option></select></td>';
        cols += '<td><a href="#iconPlus'+out_Counter+'" class="btn btn-info" data-toggle="collapse">+</a></td>';
        cols += '<td><input id="'+out_Counter+'" type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>';
        
        newRow.append(cols);
        $("#outCashMyModal .table").append(newRow);
        
        newRow = $("<tr id='minusDel"+out_Counter+"'>")
        cols = "";
        cols += '<td colspan="6"><div id="iconPlus'+out_Counter+'" class="collapse">';
        cols += '<div data-toggle="buttons">';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="1"><i class="far fa-smile"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="2"><i class="fab fa-angellist"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="3"><i class="fas fa-suitcase"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="4"><i class="far fa-thumbs-up"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="5"><i class="fas fa-bicycle"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="6"><i class="fas fa-bus"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="7"><i class="fas fa-camera-retro"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="8"><i class="fas fa-coffee"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="9"><i class="fas fa-film"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="10"><i class="fas fa-gift"></i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+out_Counter+'" value="11"><i class="fas fa-headphones"></i></label>';
        cols += '</div></div></td></tr>';
        
        newRow.append(cols);
        $("#outCashMyModal .table").append(newRow);
        out_Counter++;
    });


	/* 삭제 */
    $("#outCashMyModal .table").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
        //alert(typeof out_Counter);
        //alert(out_Counter);
        //alert($(this).attr('id'));

         $("#minusDel"+$(this).attr('id')).remove();
         out_Counter -= 1 
     }); 
    
    
});
</script>


<!-- 	
	private int seq; 
	private String id;
	private String title; //ex)식비, 교통비 분류
	private String moneyDate; //기입 날짜
	private int ioMoney; //지출(1), 수입(0) 구분
	private int category; //이미지
	private int price; //금액
	private String content; //상세 내역
	private int del; //삭제 여부 -->


<!-- 수입 입력 내역 가져오기 -->
<script type="text/javascript">
$(document).ready(function () {
	$("#btn_saveIo").click(function () {	
		//counter
       //alert("addrow 후 counter 값 :" +counter);
		var row = parseInt(counter);
		//alert(typeof row);($('input[ var checkNull = -1;
		//alert($("input[name='inCategory']:checked").val());

		for(var i=0; i<row; i++){
			if($("#inContent"+i).val()==null){
				alert("공백 발생!");
			}
		};
			
       	/* private int seq; 
       	private String id;
       	private String title; //ex)식비, 교통비 분류
       	private String moneyDate; //기입 날짜
       	private int ioMoney; //수입 0 , 지출1
       	private int category; //이미지
       	private int price; //금액
       	private String content; //상세 내역
       	private int del; //삭제 여부 */
       	
       	//날짜 데이터 - 제거 후 보내기
       	var lastSelectedDate = $("#selectedDate").html().replace(/\-/g,'');
       	//alert("날짜 : " + lastSelectedDate);
       	var arr = [];
           for(var i=0; i<row; i++){
        	   
        	inCategory = $("input[name='inCategory"+i+"']:checked").val();
       		//만약 아이콘 선택 안하면 0으로 입력
       		if(inCategory==null){
       			inCategory=0;
       			//alert("바꾼 후 : " +inCategory)
       		}
        	   
           	arr.push($("#inTitle"+i).val());
           	arr.push(lastSelectedDate);
           	arr.push(inCategory);
           	arr.push($("#inPrice"+i).val());
           	arr.push($("#inContent"+i).val());
			};
       	
   		$.ajax({
   			
               type : "get",
               url : "./cashIoAf.jsp",
               
               data : {
   				"cashIoAf" : arr
   			},
   			dataType : "text",
   			contentType : "application; charset=utf-8",
   			traditional : true,
   			
               success : function(data){
                   alert("success");
                   $("#inCashMyModal").modal().hide();
                   location.reload();
               },
               error : function(request,status,error){
                   alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
           
           });
	});
});
	
</script>

<script type="text/javascript">
$(document).ready(function () {
	$("#btn_saveSpend").click(function () {	
		//counter
	   //alert("addrow 후 counter 값 :" +out_Counter);
		var rowOut = parseInt(out_Counter);
		//alert(typeof row);($('input[ var checkNull = -1;
		//alert($("input[name='inCategory']:checked").val());
		
		
		
		for(var i=0; i<rowOut; i++){
			if($("#outContent"+i).val()==null){
				alert("공백 발생!");
			}
		};
			
	   	/* private int seq; 
	   	private String id;
	   	private String title; //ex)식비, 교통비 분류
	   	private String moneyDate; //기입 날짜
	   	private int ioMoney; //수입 0 , 지출1
	   	private int category; //이미지
	   	private int price; //금액
	   	private String content; //상세 내역
	   	private int del; //삭제 여부 */
	   	
	   	//날짜 데이터 - 제거 후 보내기
	   	var outSelectedDate = $("#outSelectedDate").html().replace(/\-/g,'');
	   	var outCategory;
	   	//alert("날짜 : " + outSelectedDate);
	   	var arrout = [];
	       for(var i=0; i<rowOut; i++){
	    	   
	    	   outCategory = $("input[name='outCategory"+i+"']:checked").val();
	    		//만약 아이콘 선택 안하면 0으로 입력
	    		if(outCategory==null){
	    			outCategory=0;
	    			//alert("바꾼 후 : " +outCategory)
	    		}
	    	   
	    	   arrout.push($("#outTitle"+i).val());
	    	   arrout.push(outSelectedDate);
	    	   arrout.push(outCategory);
	    	   arrout.push($("#outPrice"+i).val());
	    	   arrout.push($("#outContent"+i).val());
	   	};
	   	
			$.ajax({
				
	           type : "get",
	           url : "./cashSpAf.jsp",
	           
	           data : {
					"cashSpAf" : arrout
					},
				dataType : "text",
				contentType : "application; charset=utf-8",
				traditional : true,
				
	           success : function(data){
	               alert("success");
	               $("#outCashMyModal").modal().hide();
	               location.reload();
	           },
	           error : function(request,status,error){
	               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	       
	       });
	   
	});
});
</script>


<!-- 최근 list 클릭하면 modal 창으로 상세 정보 보여주기 -->
<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="popupInfo" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
			<button type="button" class="btn btn-default">수정</button>
			<button type="button" class="btn btn-default">삭제</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
      
    </div>
  </div>
</div>
  

<!-- 리스트에 있는 항목 클릭하면 호출 -->
<script type="text/javascript">
	function show(str){
	
		var afterStr = str.split('%');
		/* 
		[0] : seq
		[1] : id
		[2] : title 분류
		[3] : moneyDate
		[4] : ioMoney 수입/지출
		[5] : category 아이콘
		[6] : price
		[7] : content 사용자 입력 내용
		[8] : del */
		
		var title="";
		alert(typeof afterStr[4]);
		
		var modiDate = afterStr[3].substring(0,10);
		
		if(afterStr[4]=="0"){
			title= "수입 내역 수정";
			$("#inCashMyModalModify .modal-title").html(title);
			$("#inCashMyModalModify #inContent").val(afterStr[7]);
			$("#inCashMyModalModify #inPrice").val(afterStr[6]);
			$("#inCashMyModalModify #inTitle").val(afterStr[2]);
			$("#inCashMyModalModify #selectedDateModify").html(modiDate);
			$("#inCashMyModalModify").modal('show');
			
			//del 버튼 클릭하면
			$("#btn_delIo").click(function () {	
			   	
					$.ajax({
						
			           type : "get",
			           url : "./cashDelAf.jsp",
			           
			           data : {
							"cashDelAf" : afterStr[0]
							},
						dataType : "text",
						contentType : "application; charset=utf-8",
						traditional : true,
						
			           success : function(data){
			               alert("success");
			               $("#inCashMyModalModify").modal().hide();
			               location.reload();
			           },
			           error : function(request,status,error){
			               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			           }
			       
			       });
			   
			});
			
		}else if(afterStr[4]=="1"){
			title="지출 내역 수정";
			$("#outCashMyModalModify .modal-title").html(title);
			$("#outCashMyModalModify #outContent").val(afterStr[7]);
			$("#outCashMyModalModify #outPrice").val(afterStr[6]);
			$("#outCashMyModalModify #outTitle").val(afterStr[2]);
			$("#outCashMyModalModify #outSelectedDateModify").html(modiDate);
			$("#outCashMyModalModify").modal('show');
			
			//del 버튼 클릭하면
			$("#btn_delSpend").click(function () {	
			   	
					$.ajax({
						
			           type : "get",
			           url : "./cashDelAf.jsp",
			           
			           data : {
							"cashDelAf" : afterStr[0]
							},
						dataType : "text",
						contentType : "application; charset=utf-8",
						traditional : true,
						
			           success : function(data){
			               alert("success");
			               $("#inCashMyModalModify").modal().hide();
			               location.reload();
			           },
			           error : function(request,status,error){
			               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			           }
			       
			       });
			});
		}
	}
</script>





	
<!-------------------------------------------------------------------------------
	 수입 내역 수정
 ------------------------------------------------------------------------------->
<div class="modal fade" id="inCashMyModalModify" role="dialog">
    <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">수입 내역 입력</h4>
      </div>
      <div class="modal-body">
	      <div class="modal-inLeft">
				<div id="calendar-mini-Modify"><br><div style="padding-left: 5px;">선택한 날짜 : <span id="selectedDateModify"><%=todayS %></span></div></div>
				<!-- 
				<div id="grandtotal">총 금액 : </div> -->
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inContent">수입 내역</th>
		          <th class="th_inPrice">금액</th>
		          <th class="th_intitle">분류</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr onclick='myFunction(this)'>
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="내역 입력" id="inContent"/>
		          </td>
		          
		          <td>
		            <div class="input-group">
		            <span class="input-group-addon">
		            <i class="fas fa-won-sign"></i>
		            </span>
		            <input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" id="inPrice" />
		            </div>
		          </td>
		          
		          <td>
		            <select class="form-control match-content" id="inTitle">
		            <option selected="selected">주수입</option>
		            <option>부수입</option>
		            <option>기타</option>
		            </select>
		          </td>
		        </tr>
		        <tr id="plusDel">
				<td colspan="4">
				<div data-toggle="buttons">
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="1"><i class="far fa-smile"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="2"><i class="fab fa-angellist"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="3"><i class="fas fa-suitcase"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="4"><i class="far fa-thumbs-up"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="5"><i class="fas fa-bicycle"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="6"><i class="fas fa-bus"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="7"><i class="fas fa-camera-retro"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="8"><i class="fas fa-coffee"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="9"><i class="fas fa-film"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="10"><i class="fas fa-gift"></i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="11"><i class="fas fa-headphones"></i></label>
				</div></td></tr>
		      </tbody>
		       <tfoot>
		        
		        <tr>
		        </tr>
		    </tfoot>
		    </table>
		  </div>
      </div>
		<div id="myAlert">
		</div>
      <div class="modal-footer">
        <button type="button" id="btn_saveIo" class="btn btn btn-primary">Save</button>
        <button type="button" id="btn_delIo" class="btn btn-danger">Delete</button>
        <button type="button" class="btn btn-orange" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
 
 
<!-------------------------------------------------------------------------------
	 지출내역입력
 ------------------------------------------------------------------------------->
  <div class="modal fade" id="outCashMyModalModify" role="dialog">
    <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">지출 내역 입력</h4>
      </div>
      
      <div class="modal-body">
	       <div class="modal-outLeft">
				<div id="calendar-out-Modify"><br><div style="padding-left: 5px;">선택한 날짜 : <span id="outSelectedDateModify"><%=todayS %></span></div></div>
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_outContent">지출 내역</th>
		          <th class="th_outPrice">금액</th>
		          <th class="th_outTitle">분류</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="내역 입력" id="outContent"/>
		          </td>
		          
		          <td>
		          <div class="input-group">
		          <span class="input-group-addon">
		          <i class="fas fa-won-sign"></i></span>
		          <input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" id="outPrice" />
		          </div></td>
		          
		          <td>
		            <select class="form-control match-content" id="outTitle">
		              <option>식비</option>
		              <option>통신비</option>
		              <option>공과금</option>
		              <option>의류/미용</option>
		              <option>건강/문화생활</option>
		              <option>교육/육아</option>
		              <option>교통/차량</option>
		              <option>경조사/회비</option>
		              <option>기타</option>
		            </select>
		          </td>
		        </tr>
		        <tr id="minusDel">
		        <td colspan="3">
					<div data-toggle="buttons">
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="1"><i class="far fa-smile"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="2"><i class="fab fa-angellist"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="3"><i class="fas fa-suitcase"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="4"><i class="far fa-thumbs-up"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="5"><i class="fas fa-bicycle"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="6"><i class="fas fa-bus"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="7"><i class="fas fa-camera-retro"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="8"><i class="fas fa-coffee"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="9"><i class="fas fa-film"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="10"><i class="fas fa-gift"></i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory" value="11"><i class="fas fa-headphones"></i></label>
					</div></td>
		        </tr>
		      </tbody>
		       <tfoot>
		        	
		    </tfoot>
		    </table>
		  </div>
      </div>
      <div class="modal-footer">
		<button type="button" id="btn_saveSpend" class="btn btn btn-primary">Save</button>
		<button type="button" id="btn_delSpend" class="btn btn-danger">Delete</button>
        <button type="button" class="btn btn-orange" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div> 




</body>
</html>