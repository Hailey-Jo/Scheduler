<%@page import="User.userDTO"%>
<%@page import="java.io.File"%>
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
        <%request.setCharacterEncoding("utf-8"); %>
<%
String eventstring = "";
String id = "";
String pic = "";
String imgPath = "";

String serverPath = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getRequestURI()));
String packagePath = request.getContextPath();
userDTO user = new userDTO();

if(session.getAttribute("login") != null){	
	
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
	location.href="../index.jsp";
</script>
<%	
}
%>


<%

//cashbook 연결
iCashbookDAO cashDao = CashbookDAO.getInstance();

//최근 리스트 받아오기
List<CashbookDTO> cList = new ArrayList<CashbookDTO>();
cList = cashDao.getCashDate(id);

/* for(int i=0; i<cList.size(); i++){
	System.out.println(cList.get(i).toString());
} */


//수입
int income = cashDao.getInOutcome(id, 0, "");
System.out.println("수입 : " +income);
//지출
int spending = cashDao.getInOutcome(id, 1, "");
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
	if(cList.get(i).getIoMoney()==0){
		//수입
		eventCash +="{";
		eventCash +=" id : '"+cList.get(i).getIoMoney()+"%"+cList.get(i).getContent()+"%"+cList.get(i).getPrice()+"%"+cList.get(i).getTitle()+"%"+cList.get(i).getMoneyDate().substring(0, 10)+"',";
		eventCash += "title : '"+cList.get(i).getContent()+"　+"+String.format("%,d", cList.get(i).getPrice())+"',";
		eventCash += "start : '"+cList.get(i).getMoneyDate().substring(0, 10)+"',";
		eventCash +=" textColor: '#6699ff' , ";
		eventCash +=" color: '#ffffff' ,";
		if(cList.get(i).getCategory()!=0){
			String iconName="";
			switch(cList.get(i).getCategory()){
				case 1: iconName="alarm";break;
				case 2: iconName="card_giftcard";break;
				case 3: iconName="card_travebreak";break;
				case 4: iconName="face";break;
				case 5: iconName="favorite";break;
				case 6: iconName="flight_takeoff";break;
				case 7: iconName="pets";break;
				case 8: iconName="shopping_cart";break;
				case 9: iconName="call";break;
				case 10: iconName="vpn_key";break;
				case 11: iconName="toys";break;
				case 12: iconName="filter_vintage";break;
				case 13: iconName="linked_camera";break;
				case 14: iconName="directions_bus";break;
				case 15: iconName="directions_subway";break;
				case 16: iconName="local_cafe";break;
				case 17: iconName="local_dining";break;
				case 18: iconName="local_hospital";break;
				case 19: iconName="beach_access";break;
				case 20: iconName="school";break;
				case 21: iconName="star";break;
				case 22: iconName="cake";break;		
			}
			eventCash += "imageurl : '"+iconName+"',";
		}	
		eventCash +="},";
		System.out.println("eventCash :" +eventCash);
		
	}else{
		//지출
		eventCash +="{";
		eventCash +=" id : '"+cList.get(i).getIoMoney()+"%"+cList.get(i).getContent()+"%"+cList.get(i).getPrice()+"%"+cList.get(i).getTitle()+"%"+cList.get(i).getMoneyDate().substring(0, 10)+"',";
		eventCash += "title : '"+cList.get(i).getContent()+"　-"+String.format("%,d", cList.get(i).getPrice())+"',";
		eventCash += "start : '"+cList.get(i).getMoneyDate().substring(0, 10)+"',";
		eventCash +=" textColor: '#ff6666' , ";
		eventCash +=" color: '#ffffff' ,";
		if(cList.get(i).getCategory()!=0){
			String iconName="";
			switch(cList.get(i).getCategory()){
				case 1: iconName="alarm";break;
				case 2: iconName="card_giftcard";break;
				case 3: iconName="card_travebreak";break;
				case 4: iconName="face";break;
				case 5: iconName="favorite";break;
				case 6: iconName="flight_takeoff";break;
				case 7: iconName="pets";break;
				case 8: iconName="shopping_cart";break;
				case 9: iconName="call";break;
				case 10: iconName="vpn_key";break;
				case 11: iconName="toys";break;
				case 12: iconName="filter_vintage";break;
				case 13: iconName="linked_camera";break;
				case 14: iconName="directions_bus";break;
				case 15: iconName="directions_subway";break;
				case 16: iconName="local_cafe";break;
				case 17: iconName="local_dining";break;
				case 18: iconName="local_hospital";break;
				case 19: iconName="beach_access";break;
				case 20: iconName="school";break;
				case 21: iconName="star";break;
				case 22: iconName="cake";break;		
			}
			eventCash += "imageurl : '"+iconName+"',";
		}
		eventCash +="},";
		System.out.println("eventCash :" +eventCash);
	}
		
}




%>

<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/cashbookCalendar.css?ver=1"> 
<link rel="stylesheet" type="text/css" href="../css/header.css?ver=3"> 

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
    border-left: 1px solid  #e6e6e6;
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
  min-width:800px;
  margin: 0px; 
  padding: 0px; 

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


 /* 날짜 선택 모달 */
	#infoModal .modal-dialog {
		max-width: 400px;
	}
	#infoModal .modal-header, .modal-body, .modal-footer {
		padding: 20px 30px;
	}
	#infoModal .modal-content {
		border-radius: 3px;
	}
	#infoModal .modal-footer {
		background: #ecf0f1;
		border-radius: 0 0 3px 3px;
	}
    #infoModal .modal-title {
        display: inline-block;
    }
	#infoModal .form-control {
		border-radius: 2px;
		box-shadow: none;
		border-color: #dddddd;
	}
	#infoModal .modal textarea.form-control {
		resize: vertical;
	}
	#infoModal .modal .btn {
		border-radius: 2px;
		min-width: 100px;
	}	
	#infoModal .modal form label {
		font-weight: normal;
	}	
	
	
	
	/* 리스트 모달 */
	
	#calListBody{
		max-width:800px;
		height: auto; 
	}
	
	.bs-example-modal-lg .modal-header {
	background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
	
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

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- 페이징 처리 -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/jszip-2.5.0/dt-1.10.16/b-1.5.1/b-html5-1.5.1/b-print-1.5.1/r-2.2.1/datatables.min.css"/>
 
 
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
           <%--  <%=eventCash %> --%>
        ]
            , select: function(start, end) {
                // Display the modal.
                // You could fill in the start and end fields based on the parameters
                $('#datepicker .modal').modal('show');

            }, dayClick: function(date, jsEvent, view, resourceObj) {
				$('#outSelectedDate').empty();
				$('#infoModal').modal('show');
				
				//alert('Date: ' + date.format());
				var outSelectedDate = date.format();
				$('#infoModal .modal-title').html("선택한 날짜");
				$('#infoModal .modal-body').html(outSelectedDate);
				$("#outSelectedDate").append(outSelectedDate);
	             //alert('Resource ID: ' + resourceObj.id);
	           }
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
       <%--  <%=eventCash %> --%>
    ]
        , select: function(start, end) {
            // Display the modal.
            // You could fill in the start and end fields based on the parameters
            $('#datepicker .modal').modal('show');

        }, dayClick: function(date, jsEvent, view, resourceObj) {
			$('#outSelectedDateModify').empty();
			$('#infoModal').modal('show');
			
			//alert('Date: ' + date.format());
			var outSelectedDateModify = date.format();
			$('#infoModal .modal-title').html("선택한 날짜");
			$('#infoModal .modal-body').html(outSelectedDateModify);
			$("#outSelectedDateModify").append(outSelectedDateModify);
             //alert('Resource ID: ' + resourceObj.id);
           }
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
   	           <%--  <%=eventCash %> --%>
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
   	             	//alert('Clicked ' + eventObj.title);
   	                //alert($('#datepicker .modal').val(event.start));
   	                
   	            }, dayClick: function(date, jsEvent, view, resourceObj) {
					$('#selectedDate').empty();
					$('#infoModal').modal('show');
					
					//alert('Date: ' + date.format());
					var selectedDate = date.format();
					$('#infoModal .modal-title').html("선택한 날짜");
					$('#infoModal .modal-body').html(selectedDate);
					$("#selectedDate").append(selectedDate);
		             //alert('Resource ID: ' + resourceObj.id);
   	           }
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
    	           <%--  <%=eventCash %> --%>
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
    	             	//alert('Clicked ' + eventObj.title);
    	                //alert($('#datepicker .modal').val(event.start));
    	                
    	            }, dayClick: function(date, jsEvent, view, resourceObj) {
						$('#selectedDateModify').empty();
						$('#infoModal').modal('show');
						
						//alert('Date: ' + date.format());
						var selectedDateModify = date.format();
						$('#infoModal .modal-title').html("선택한 날짜");
						$('#infoModal .modal-body').html(selectedDateModify);
						$("#selectedDateModify").append(selectedDateModify);
			             //alert('Resource ID: ' + resourceObj.id);
    	           }
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
    , editable : false
    , eventLimit : true
    , googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE"      // Google API KEY
	, editable : true
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
    , /* eventRender: function(eventObj, $el) {
        $el.popover({
            title: eventObj.title,
            content: eventObj.description,
            trigger: 'hover',
            placement: 'top',
            container: 'body'
          })
    } */
     
   		eventRender: function(event, eventElement) {            	
     	if (event.imageurl)
 		{             		
 		eventElement.find("div.fc-content").prepend("<i class='material-icons' style='font-size: 12px;'>"+ event.imageurl +"</i>"); 
 		}
     	//google link remove
		$('td .fc-event-container').find('a').removeAttr("href");
		 } 
        

      ,eventClick: function(event){
          /* $('#modalTitle').html(event.title);
          $('#modalBody').html(event.description);
          $('#fullCalModal').modal(); */
          var num = event.id;
          //alert(typeof num);
          var date = event.start;
          //alert(typeof date);
          //alert(date);
          var strArr = num.split('%');
          
          if(strArr[0]==0){
    
			$("#calDetailIo .modal-title").html("수입 내역 수정");
			$("#calDetailIo #inContent").val(strArr[1]);
			$("#calDetailIo #inPrice").val(strArr[2]);
			$("#calDetailIo #inTitle").val(strArr[3]);
			$("#calDetailIo #selectedDateModify").html(strArr[4]);
			$("#calDetailIo").modal({backdrop: 'static', keyboard: false});
          
          }else{
        	  
        	$("#calDetailOut .modal-title").html("지출 내역 수정");
  			$("#calDetailOut #outContent").val(strArr[1]);
  			$("#calDetailOut #outPrice").val(strArr[2]);
  			$("#calDetailOut #outTitle").val(strArr[3]);
  			$("#calDetailOut #selectedDateModify").html(strArr[4]);
  			$("#calDetailOut").modal({backdrop: 'static', keyboard: false});
          }
      },
    });
    
    
    $('#my-today-button').click(function() {
        $('#calendar').fullCalendar('today');
    });
    
    // Bind the dates to datetimepicker.
    // You should pass the options you need
    $("#starts-at, #ends-at").datetimepicker();

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

<title>BizPayDay</title>
</head>
<body>

<div id="loading">loading...</div>

<div id="fullCalModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span> <span class="sr-only">close</span></button>
                <h4 id="modalTitle" class="modal-title"></h4>
            </div>
            <div id="modalBody" class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button class="btn btn-primary">Remove</button>
            </div>
        </div>
    </div>
</div> 


<!-------------------------------------------------------------------------------
	상단 메뉴바
 ------------------------------------------------------------------------------->
	<header>
		<div class="row" id="header">
			<div class="col-sm-4" id="headerTitle" style=" float: left;">BizPayDay</div>
			<div class="col-sm-4" id="menuRow">
				<ul style="list-style: none; ">
					<li><a class="menuLink" href="../Main.jsp"><img src="../icon/ic_home_white_36px.svg" onmouseover='this.src="../icon/ic_home_black_36px.svg"' onmouseout='this.src="../icon/ic_home_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../schedule/schedulemain.jsp"><img src="../icon/ic_event_available_white_36px.svg" onmouseover='this.src="../icon/ic_event_available_black_36px.svg"' onmouseout='this.src="../icon/ic_event_available_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="#"><img src="../icon/ic_assessment_white_36px.svg" ></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../pds/pdslist.jsp"><img src="../icon/ic_cloud_download_white_36px.svg" onmouseover='this.src="../icon/ic_cloud_download_black_36px.svg"' onmouseout='this.src="../icon/ic_cloud_download_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../phonebook/phonebookMain.jsp"><img src="../icon/ic_phone_white_36px.svg" onmouseover='this.src="../icon/ic_local_phone_black_36px.svg"' onmouseout='this.src="../icon/ic_phone_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
				</ul>
			</div>
			<div class="col-sm-4" id="myinfo" class="login_info" style=" float: right;">
			 <ul class="nav navbar-nav navbar-right">
		      	<img alt="프로필이미지" src="<%=imgPath%>" class="img-circle" width="40">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" style=" height: 30px;"><%=id %><span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a href="#">My List</a></li>
		            <li><a href="#">My Info</a></li>
		            <li><a href="../index.jsp">Log out</a></li>
		          </ul>
		        </li>
		      </ul>
			</div>
		</div>
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
				<button type="button" id="btnInPrice" data-backdrop="static" data-keyboard="false" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#inCashMyModal" style="width: 130px;">수입</button>
				<button type="button" id="btnOutPrice" data-backdrop="static" data-keyboard="false" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#outCashMyModal" style="width: 130px;">지출</button>
				<hr>
			</div>
		</div>
			
		<div class="left_totalMonth">
			<div id="cashList" style="height:auto; overflow: y:hidden;">
				<b><%=month %>월 이달의 가계 </b> (<%=month %>월 1일 - <%=month %>월 <%=day %>일)<br><br>
				<ul class="list-group">
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  수입
					  
					  <% 
					  String incomAf = String.format("%,d", income);
					  if(income==0){
						  
						  //수입 0 이면
						  %>
						  <span class="badge badge-primary badge-pill"><%=incomAf %></span>
						  <%
					  }else{
						  %>
						  <span class="badge badge-info">+ <%=incomAf %></span>
						  <%
					  }
					  %>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">
					지출
					  <% 
					  String spendingAf = String.format("%,d", spending);
					  if(spending==0){
						  //지출 0 이면
						  %>
						  <span class="badge badge-primary badge-pill"><%=spendingAf %></span>
						  <%
					  }else{
						  %>
						  <span class="badge badge-error">- <%=spendingAf %></span>
						  <%
					  }
					  %>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center">
					  총액
					 <% String total = String.format("%,d", income-spending); %> 
						<span class="badge badge-primary badge-pill">= <%=total %></span>
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
					<a href="#" data-toggle="modal" data-target=".bs-example-modal-lg" id=moreBtn class="badge badge-light" data-backdrop="static" data-keyboard="false" style="background-color: #fff; color: #777;">... 더보기</a>
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
	 캘린더에서 클릭하면 나오는 수입 내역 상세보기
 ------------------------------------------------------------------------------->
<div class="modal fade">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">Save changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
 
 
 
<!-------------------------------------------------------------------------------
	 캘린더에서 클릭하면 나오는 지출 내역 상세보기
 ------------------------------------------------------------------------------->

	
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
	
<!-------------------------------------------------------------------------------
	 footer
 ------------------------------------------------------------------------------->
	<div class="footer navbar-fixed-bottom">
		<footer>Copyright &copy; BizPayDay</footer>
	</div>
	
<!-------------------------------------------------------------------------------
	 event click
 ------------------------------------------------------------------------------->
<div id="eventContent" title="Event Details" style="display:none;">
    Start: <span id="startTime"></span><br>
    End: <span id="endTime"></span><br><br>
    <p id="eventInfo"></p>
    <p><strong><a id="eventLink" href="" target="_blank">Read More</a></strong></p>
</div>

	
	
	
<!-------------------------------------------------------------------------------
	 수입 내역 입력 modal
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
				<div id="calendar-mini"><br>
				
				<div style="padding-left: 5px;"><b>선택한 날짜 : 
				<span id="selectedDate"><%=todayS %></span></b>
				</div></div>
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
		          <th class="th_inCategory"></th>
		          <th class="th_inDelete"></th>
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
	 지출 내역 입력 modal
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
				<div id="calendar-out"><br>
				<div style="padding-left: 5px;"><b>선택한 날짜 : 
				<span id="outSelectedDate"><%=todayS %></span></b>
				</div></div>
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_outContent">지출 내역</th>
		          <th class="th_outPrice">금액</th>
		          <th class="th_outTitle">분류</th>
		          <th class="th_outCategory"></th>
		          <th class="th_outDelete"></th>
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
	수입 입력 버튼 클릭하면 modal 창 띄우기
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
        cols += '<td align="center"><a href="#iconPlus'+counter+'" data-toggle="collapse"><i class="material-icons">&#xE24E;</i></a></td>';
        //cols += '<td><input id="'+counter+'" type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>';
        cols += '<td align="center"><a href="#" id="'+counter+'" class="ibtnDel" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a></td>';
       
        newRow.append(cols);
        $("#inCashMyModal .table").append(newRow);
        
        newRow = $("<tr id='plusDel"+counter+"'>")
        cols = "";
        cols += '<td colspan="6"><div id="iconPlus'+counter+'" class="collapse">';
        cols += '<div data-toggle="buttons">';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="1"><i class="material-icons">alarm</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="2"><i class="material-icons">card_giftcard</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="3"><i class="material-icons">card_travel</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="4"><i class="material-icons">face</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="5"><i class="material-icons">favorite</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="6"><i class="material-icons">flight_takeoff</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="7"><i class="material-icons">pets</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="8"><i class="material-icons">shopping_cart</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="9"><i class="material-icons">call</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="10"><i class="material-icons">vpn_key</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="11"><i class="material-icons">toys</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="12"><i class="material-icons">filter_vintage</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="13"><i class="material-icons">linked_camera</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="14"><i class="material-icons">directions_bus</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="15"><i class="material-icons">directions_subway</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="16"><i class="material-icons">local_cafe</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="17"><i class="material-icons">local_dining</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="18"><i class="material-icons">local_hospital</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="19"><i class="material-icons">beach_access</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="20"><i class="material-icons">school</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="21"><i class="material-icons">star</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategory'+counter+'" value="22"><i class="material-icons">cake</i></label>';
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
	 지출 입력 버튼 클릭하면 modal 창 띄우기
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
        cols += '<td align="center"><a href="#iconPlus'+out_Counter+'" data-toggle="collapse"><i class="material-icons">&#xE24E;</i></a></td>';
        //cols += '<td><input id="'+out_Counter+'" type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>';
        cols += '<td><a href="#" id="'+out_Counter+'" class="ibtnDel" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a></td>';
        
        newRow.append(cols);
        $("#outCashMyModal .table").append(newRow);
        
        newRow = $("<tr id='minusDel"+out_Counter+"'>")
        cols = "";
        cols += '<td colspan="6"><div id="iconPlus'+out_Counter+'" class="collapse">';
        cols += '<div data-toggle="buttons">';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="1"><i class="material-icons">alarm</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="2"><i class="material-icons">card_giftcard</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="3"><i class="material-icons">card_travel</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="4"><i class="material-icons">face</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="5"><i class="material-icons">favorite</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="6"><i class="material-icons">flight_takeoff</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="7"><i class="material-icons">pets</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="8"><i class="material-icons">shopping_cart</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="9"><i class="material-icons">call</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="10"><i class="material-icons">vpn_key</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="11"><i class="material-icons">toys</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="12"><i class="material-icons">filter_vintage</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="13"><i class="material-icons">linked_camera</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="14"><i class="material-icons">directions_bus</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="15"><i class="material-icons">directions_subway</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="16"><i class="material-icons">local_cafe</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="17"><i class="material-icons">local_dining</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="18"><i class="material-icons">local_hospital</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="19"><i class="material-icons">beach_access</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="20"><i class="material-icons">school</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="21"><i class="material-icons">star</i></label>';
        cols += '<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategory'+out_Counter+'" value="22"><i class="material-icons">cake</i></label>';
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


<!-------------------------------------------------------------------------------
	 수입 입력 후 확인 클릭 정보 보내기
 ------------------------------------------------------------------------------->
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
				//alert("공백 발생!");
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
       		       		
       		arr.push("<%=id%>");
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
                   //alert("success");
                   $("#inCashMyModal").modal().hide();
                   location.reload();
               },
               error : function(request,status,error){
                   //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
           
           });
	});
});
	
</script>


<!-------------------------------------------------------------------------------
	지출 입력 후 확인 클릭 정보 보내기
 ------------------------------------------------------------------------------->
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
				//alert("공백 발생!");
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
	    		
			   arrout.push("<%=id%>");
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
	               //alert("success");
	               $("#outCashMyModal").modal().hide();
	               location.reload();
	           },
	           error : function(request,status,error){
	              // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	       
	       });
	   
	});
});
</script>



 <!-------------------------------------------------------------------------------
	수정 삭제 따로
 ------------------------------------------------------------------------------->
<script type="text/javascript">
$(document).ready(function () {
	$("#btn_delIo").click(function () {	
		//alert("btn_delIo");
	});

	$("#btn_modiIo").click(function () {
		//alert("btn_modiIo");
	});

	$("#btn_delSpend").click(function () {
		//alert("btn_delSpend");
	});


	$("#btn_modiSpend").click(function () {
		//alert("btn_modiSpend");
	});
	
});
</script>

<!-------------------------------------------------------------------------------
	리스트에 있는 항목 클릭하면 호출
 ------------------------------------------------------------------------------->
<script type="text/javascript">
function show (str){
	var afterStr = str.split('%');
	//alert("스플릿 한 개수 : " + afterStr.length);
		
	//메인에서 올라갈 때
		if(afterStr.length==9){
		//alert("본문 if문");
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
		$(".bs-example-modal-lg").modal('hide')
		var title="";
		
		var modiDate = afterStr[3].substring(0,10);
		
		if(afterStr[4]=="0"){
			title= "수입 내역 수정";
			$("#inCashMyModalModify .modal-title").html(title);
			$("#inCashMyModalModify #inContent").val(afterStr[7]);
			$("#inCashMyModalModify #inPrice").val(afterStr[6]);
			$("#inCashMyModalModify #inTitle").val(afterStr[2]);
			$("#inCashMyModalModify #selectedDateModify").html(modiDate);
			$("#inCashMyModalModify").modal({backdrop: 'static', keyboard: false});
			
			//del 버튼 클릭하면
			$("#btn_delIo").click(function () {	
			   	
				//alert("btn_delIo 버튼 클릭!");
				
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
			               //alert("success");
			               $("#inCashMyModalModify").modal().hide();
			               location.reload();
			           },
			           error : function(request,status,error){
			               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			           }
			       
			       });
			   
			});
			
			$("#btn_modiIo").click(function () {
								
				var selectedDateModify = $("#selectedDateModify").html().replace(/\-/g,'');
			   	var inCategoryModi;
			   	//alert("날짜 : " + outSelectedDate);
			     
			   	inCategoryModi = $("input[name='inCategoryModi']:checked").val();
		    		//만약 아이콘 선택 안하면 0으로 입력
		    		if(inCategoryModi==null){
		    			inCategoryModi=0;
		    			//alert("바꾼 후 : " +outCategory)
		    		}
        	   		
				$.ajax({
					
			           type : "get",
			           url : "./cashModiAf.jsp",
			           data : {
			        	   	"seq" : afterStr[0],
			        	    "title" : $("#inCashMyModalModify #inTitle").val(),
				    		"moneyDate" : selectedDateModify,
				    		"category" : inCategoryModi,
				    		"price" : $("#inCashMyModalModify #inPrice").val(),
				    		"content" :$("#inCashMyModalModify #inContent").val(),
							},
						dataType : "text",
						contentType : "application; charset=utf-8",
						traditional : true,
						
			           success : function(data){
			               //alert("success");
			               $("#inCashMyModalModify").modal().hide();
			               location.reload();
			           },
			           error : function(request,status,error){
			              // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
			$("#outCashMyModalModify").modal({backdrop: 'static', keyboard: false});
			
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
			               //alert("success");
			               $("#inCashMyModalModify").modal().hide();
			               location.reload();
			           },
			           error : function(request,status,error){
			               //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			           }
			       
			       });
			});
			
			$("#btn_modiSpend").click(function () {
				
				var outSelectedDateModify = $("#outSelectedDateModify").html().replace(/\-/g,'');
			   	var inCategoryModi;
			   	//alert("날짜 : " + outSelectedDate);
			     
			   	outCategoryModi = $("input[name='outCategoryModi']:checked").val();
		    		//만약 아이콘 선택 안하면 0으로 입력
		    		if(outCategoryModi==null){
		    			outCategoryModi=0;
		    			//alert("바꾼 후 : " +outCategory)
		    		}
			       
				$.ajax({
					
			           type : "get",
			           url : "./cashModiAf.jsp",
			           data : {
			        	   	"seq" : afterStr[0],
			        	    "title" : $("#outCashMyModalModify #outTitle").val(),
				    		"moneyDate" : outSelectedDateModify,
				    		"category" : outCategoryModi,
				    		"price" : $("#outCashMyModalModify #outPrice").val(),
				    		"content" :$("#outCashMyModalModify #outContent").val(),
							},
						dataType : "text",
						contentType : "application; charset=utf-8",
						traditional : true,
						
			           success : function(data){
			               //alert("success");
			               $("#outCashMyModalModify").modal().hide();
			               location.reload();
			           },
			           error : function(request,status,error){
			               //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			           }
			       
			       });
				
			});
		}
		
		//모달에서 할 때
		}else{
			
			//alert("ioMoney : " +afterStr[0]);
			//alert("seq : " +afterStr[5]);
			//alert("else로 들어옴")
			/* 
			[0] : ioMoney
			[1] : content
			[2] : price
			[3] : Title
			[4] : date
			[5] : seq
			*/
			
			var title="";
			
			if(afterStr[0]=="0"){
				title= "수입 내역 수정";
				//alert("ioMoney : " +afterStr[0]);
				//alert("seq : " +afterStr[5]);
				//alert("money : " +afterStr[2]);
				
				$("#inCashMyModalModify .modal-title").html(title);
				$("#inCashMyModalModify #inContent").val(afterStr[1]);
				$("#inCashMyModalModify #inPrice").val(afterStr[2]);
				$("#inCashMyModalModify #inTitle").val(afterStr[3]);
				$("#inCashMyModalModify #selectedDateModify").html(afterStr[4]);
				$("#chchList").modal().hide();
				$("#inCashMyModalModify").modal({backdrop: 'static', keyboard: false});
				
				//del 버튼 클릭하면
				$("#btn_delIo").click(function () {	
				   	
						$.ajax({
							
				           type : "get",
				           url : "./cashDelAf.jsp",
				           
				           data : {
								"cashDelAf" : afterStr[5]
								},
							dataType : "text",
							contentType : "application; charset=utf-8",
							traditional : true,
							
				           success : function(data){
				               //alert("success");
				               $("#inCashMyModalModify").modal().hide();
				               location.reload();
				           },
				           error : function(request,status,error){
				               //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				           }
				       
				       });
				   
				});
				
				
				$("#btn_modiIo").click(function () {
					var selectedDateModify = $("#selectedDateModify").html().replace(/\-/g,'');
				   	var inCategoryModi;
				   	//alert("날짜 : " + outSelectedDate);
				     
				   	inCategoryModi = $("input[name='inCategoryModi']:checked").val();
			    		//만약 아이콘 선택 안하면 0으로 입력
			    		if(inCategoryModi==null){
			    			inCategoryModi=0;
			    			//alert("바꾼 후 : " +outCategory)
			    		}
			    		/* 

						[0] : seq
						[1] : content
						[2] : price
						[3] : Title
						[4] : date
						[5] : inMoney
						*/
						$.ajax({
						
				           type : "get",
				           url : "./cashModiAf.jsp",
				           data : {
				        	   	"seq" : afterStr[5],
				        	    "title" : $("#inCashMyModalModify #inTitle").val(),
					    		"moneyDate" : selectedDateModify,
					    		"category" : inCategoryModi,
					    		"price" : $("#inCashMyModalModify #inPrice").val(),
					    		"content" :$("#inCashMyModalModify #inContent").val(),
								},
							dataType : "text",
							contentType : "application; charset=utf-8",
							traditional : true,
							
				           success : function(data){
				               //alert("success");
				               $("#inCashMyModalModify").modal().hide();
				               location.reload();
				           },
				           error : function(request,status,error){
				               //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				           }
				       
				       });
					
				});
				
				
			}else if(afterStr[0]=="1"){
				//alert("seq : " +afterStr[0]);
				//alert("ioMoney : " +afterStr[5]);
				
				title="지출 내역 수정";
				$("#outCashMyModalModify .modal-title").html(title);
				$("#outCashMyModalModify #outContent").val(afterStr[1]);
				$("#outCashMyModalModify #outPrice").val(afterStr[2]);
				$("#outCashMyModalModify #outTitle").val(afterStr[3]);
				$("#outCashMyModalModify #outSelectedDateModify").html(afterStr[4]);
				$("#chchList").modal().hide();
				$("#outCashMyModalModify").modal({backdrop: 'static', keyboard: false});
				
				//del 버튼 클릭하면
				$("#btn_delSpend").click(function () {	
				   	
						$.ajax({
							
				           type : "get",
				           url : "./cashDelAf.jsp",
				           
				           data : {
								"cashDelAf" : afterStr[5]
								},
							dataType : "text",
							contentType : "application; charset=utf-8",
							traditional : true,
							
				           success : function(data){
				               //alert("success");
				               $("#outCashMyModalModify").modal().hide();
				               location.reload();
				           },
				           error : function(request,status,error){
				              // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				           }
				       
				       });
				});
				
				$("#btn_modiSpend").click(function () {
					var outSelectedDateModify = $("#outSelectedDateModify").html().replace(/\-/g,'');
				   	var outCategoryModi;
				   	//alert("날짜 : " + outSelectedDate);
				     
				   	outCategoryModi = $("input[name='outCategoryModi']:checked").val();
			    		//만약 아이콘 선택 안하면 0으로 입력
			    		if(outCategoryModi==null){
			    			outCategoryModi=0;
			    			//alert("바꾼 후 : " +outCategory)
			    		}
				     
	        	   		
					$.ajax({
						
				           type : "get",
				           url : "./cashModiAf.jsp",
				           data : {
				        	   	"seq" : afterStr[5],
				        	    "title" : $("#outCashMyModalModify #outTitle").val(),
					    		"moneyDate" : outSelectedDateModify,
					    		"category" : outCategoryModi,
					    		"price" : $("#outCashMyModalModify #outPrice").val(),
					    		"content" :$("#outCashMyModalModify #outContent").val(),
								},
							dataType : "text",
							contentType : "application; charset=utf-8",
							traditional : true,
							
				           success : function(data){
				               //alert("success");
				               $("#outCashMyModalModify").modal().hide();
				               location.reload();
				           },
				           error : function(request,status,error){
				               //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				           }
				       
				       });
					
				});
			}
			
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
				<div id="calendar-mini-Modify"><br><div style="padding-left: 5px;"><b>선택한 날짜 : <span id="selectedDateModify"><%=todayS %></span></b></div></div>
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
		          <th></th>
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
		          <td align="center">
		          <a href="#iconPlusIn" data-toggle="collapse"><i class="material-icons">&#xE24E;</i></a>
		          </td>
		        </tr>
		        <tr id="plusDel">
		        <td colspan="4"><div id="iconPlusIn" class="collapse"><div data-toggle="buttons">
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="1"><i class="material-icons">alarm</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="2"><i class="material-icons">card_giftcard</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="3"><i class="material-icons">card_travel</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="4"><i class="material-icons">face</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="5"><i class="material-icons">favorite</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="6"><i class="material-icons">flight_takeoff</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="7"><i class="material-icons">pets</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="8"><i class="material-icons">shopping_cart</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="9"><i class="material-icons">call</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="10"><i class="material-icons">vpn_key</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="11"><i class="material-icons">toys</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="12"><i class="material-icons">filter_vintage</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="13"><i class="material-icons">linked_camera</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="14"><i class="material-icons">directions_bus</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="15"><i class="material-icons">directions_subway</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="16"><i class="material-icons">local_cafe</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="17"><i class="material-icons">local_dining</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="18"><i class="material-icons">local_hospital</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="19"><i class="material-icons">beach_access</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="20"><i class="material-icons">school</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="21"><i class="material-icons">star</i></label>
				<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="inCategoryModi" value="22"><i class="material-icons">cake</i></label>
				</div></div></td></tr>
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
        <button type="button" id="btn_modiIo" class="btn btn btn-primary">Save</button>
        <button type="button" id="btn_delIo" class="btn btn-danger">Delete</button>
        <button type="button" class="btn btn-orange" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
 
 
<!-------------------------------------------------------------------------------
	 지출내역수정
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
				<div id="calendar-out-Modify"><br><div style="padding-left: 5px;"><b>선택한 날짜 : <span id="outSelectedDateModify"><%=todayS %></span></b></div></div>
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_outContent">지출 내역</th>
		          <th class="th_outPrice">금액</th>
		          <th class="th_outTitle">분류</th>
		          <th></th>
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
		          <td align="center">
		          <a href="#iconPlusOut" data-toggle="collapse"><i class="material-icons">&#xE24E;</i></a>
		          </td>
		        </tr>
		        <tr id="minusDel">
		        <td colspan="4"><div id="iconPlusOut" class="collapse"><div data-toggle="buttons">
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="1"><i class="material-icons">alarm</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="2"><i class="material-icons">card_giftcard</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="3"><i class="material-icons">card_travel</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="4"><i class="material-icons">face</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="5"><i class="material-icons">favorite</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="6"><i class="material-icons">flight_takeoff</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="7"><i class="material-icons">pets</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="8"><i class="material-icons">shopping_cart</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="9"><i class="material-icons">call</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="10"><i class="material-icons">vpn_key</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="11"><i class="material-icons">toys</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="12"><i class="material-icons">filter_vintage</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="13"><i class="material-icons">linked_camera</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="14"><i class="material-icons">directions_bus</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="15"><i class="material-icons">directions_subway</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="16"><i class="material-icons">local_cafe</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="17"><i class="material-icons">local_dining</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="18"><i class="material-icons">local_hospital</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="19"><i class="material-icons">beach_access</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="20"><i class="material-icons">school</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="21"><i class="material-icons">star</i></label>
					<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="outCategoryModi" value="22"><i class="material-icons">cake</i></label>
					</div></div></td>
		        </tr>
		      </tbody>
		       <tfoot>
		        	
		    </tfoot>
		    </table>
		  </div>
      </div>
      <div class="modal-footer">
		<button type="button" id="btn_modiSpend" class="btn btn btn-primary">Save</button>
		<button type="button" id="btn_delSpend" class="btn btn-danger">Delete</button>
        <button type="button" class="btn btn-orange" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div> 



<!-------------------------------------------------------------------------------
	 미니 달력 선택, 후 뜨는 모달 창 
 ------------------------------------------------------------------------------->
	<div id="infoModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header" style="background-color: #234790; color: #fff;" >						
						<h4 class="modal-title">Delete Employee</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body" align="center">		
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning"><small>This action cannot be undone.</small></p>
					</div>
					<div class="modal-footer">
					<button type="button" class="btn btn btn-primary" data-dismiss="modal">확인</button>
						<!-- <input type="submit" class="btn btn-danger" value="Delete"> -->
					</div>
				</form>
			</div>
		</div>
	</div>
	


<!-------------------------------------------------------------------------------
	최근 리스트 더 보기 누르면 나오는 모달
 ------------------------------------------------------------------------------->
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="chchList">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">가계부 전체 보기</h4>
      </div>
<div class="container" id="calListBody">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                </div>
            </div>
            <br>
            <table id="example" class="table table-striped table-hover" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>수입/지출</th>						
						<th>상세내역</th>
						<th>날짜</th>
						<th>금액</th>
                        <th>분류</th>
						<th></th>
                    </tr>
                </thead>
                <tbody id="exampleBody">
                	<%
                	for(int i=0; i<cList.size(); i++){
                		%>
                		<tr>
                        <td><%=i+1 %></td>
                        <td>
                        <% if(cList.get(i).getIoMoney()==0){
                        	%>수입<%
                        }else {
                        	%>지출<%
                        }
                        	%></td>
                        	
                        <td><%=cList.get(i).getContent()%></td>                        
                        <td><%=cList.get(i).getMoneyDate().substring(0, 10) %></td>                        
                        <td><%=String.format("%,d", cList.get(i).getPrice()) %></td>                        
                        <td><%=cList.get(i).getTitle() %></td>
						<td>
							<a href="#" onclick="show('<%=cList.get(i) %>')"  class="settings" title="Settings" data-toggle="tooltip"><i class="material-icons">&#xE8B8;</i></a>
							<a href="#" onclick="ListDelete('<%=cList.get(i).getSeq() %>')" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE5C9;</i></a>
						</td>
                    </tr>
                	<%
                	}
                	%>
                </tbody>
            </table>
        </div>
    </div>   
    <div class="modal-footer">
		<button type="button" class="btn btn btn-primary" id="closeReload">확인</button>
	</div>
    </div>
  </div>
</div>

 
<script type="text/javascript" src="https://cdn.datatables.net/v/bs/jszip-2.5.0/dt-1.10.16/b-1.5.1/b-html5-1.5.1/b-print-1.5.1/r-2.2.1/datatables.min.js"></script>

<!-- 페이지 처리! -->
<script type="text/javascript">
$(document).ready(function() {
	  $.fn.DataTable.ext.pager.numbers_length = 5;
	    $('#example').DataTable( {
	       "pagingType":"full_numbers",
	    } );  
	} );
</script>


<!-- list에서 수정버튼 누를 때 -->
<script type="text/javascript">
function ListDelete(seq){
	$.ajax({
		
       type : "get",
       url : "./cashDelAf.jsp",
       
       data : {
			"cashDelAf" : seq
			},
		dataType : "text",
		contentType : "application; charset=utf-8",
		traditional : true,
		
       success : function(data){
           alert(data);
           //alert(typeof data);
           //showempinfo(data);
			//console.log(data);
			//var obj = JSON.parse(data);
			//data = JSON.parse(data);

			var strArr = data.split('"');
			/* alter(strArr.length); */
		   var div = document.querySelector('#example');
		    html = '<table>';
		    html += '<th>#</th><th>수입/지출</th><th>상세내역</th><th>날짜</th><th>금액</th><th>분류</th><th></th>';
		    html += '<tbody id="exampleBody">';
		    
		     var counter=0;
		     var ioMoney ="";
		     var modiStr ="";
		    for(var i=0; i<strArr.length-1; i=i+24){
		    	counter++;
		    	
		    	if(strArr[i+3]==0){
		    		ioMoney="수입";
		    	}else{
		    		ioMoney="지출";
		    	}
		    	
		    	modiStr = "'"+strArr[i+3] +"%"+ strArr[i+23] + "%" + strArr[i+7] + "%" + strArr[i+15] + "%" + strArr[i+11]+ "%" + strArr[i+19]+"'";
		        //alert(modiStr);
		    	
				html += '<tr>';
				html += '<td>'+counter+'</td>';
				html += '<td>'+ioMoney+'</td>';
				html += '<td>'+strArr[i+23]+'</td>';
				html += '<td>'+strArr[i+11]+'</td>';
				html += '<td>'+strArr[i+7]+'</td>';
				html += '<td>'+strArr[i+15]+'</td>';
				html += '<td>';
				html += '<a href="#" onclick="show('+modiStr+')"  class="settings" title="Settings" data-toggle="tooltip"><i class="material-icons">&#xE8B8;</i></a>';
				html += '<a href="#" onclick="ListDelete('+strArr[i+19]+')" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE5C9;</i></a>';
				html += '</td>';
				html += '</tr>';
			}
		    
		    console.log("전" + html);
		    div.innerHTML = html;
		    console.log("후" + html);
		    
       },
       error : function(request,status,error){
           alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
     
   });
};

</script>

<!-- 모달 확인 버튼 눌러도 부모 테이블 갱신하도록 -->
<script type="text/javascript">
$(document).ready(function () {
	$("#closeReload").click(function () {
		$(this).modal().hide();
	    location.reload();
	});
});
</script>



</body>
</html>