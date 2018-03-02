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

for(int i=0; i<cList.size(); i++){
	System.out.println(cList.get(i).toString());
}


//수입
int income = cashDao.getInOutcome("creepin", 0, "");
System.out.println("수입 : " +income);
//지출
int spending = cashDao.getInOutcome("creepin", 1, "");
System.out.println("지출 : " +spending);

%>

<%
String eventCash = "";
for(int i=0; i<cList.size();i++){
	eventCash +="{";
	eventCash += "title : '"+cList.get(i).getContent()+"  "+cList.get(i).getPrice()+"',";
	eventCash += "start : '"+cList.get(i).getMoneyDate().substring(0, 10)+"',";
	eventCash +="},";
	
	System.out.println(eventCash);
}
%>

<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="./css/header.css"> 

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

#calendar-mini{
border: 1px solid #487BE1;
width: 100%;
height: auto;
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

#calendar-out div.fc-content{
	height: 1px;
}
#calendar-out div.fc-center h2{
	font-size: 15px;
}
#calendar-out a.fc-day-number{
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

 
/* 수입 */

 
.modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }

.modal-body {
	height: 500px;
	padding: 10px;
	margin-bottom: 30px;
}

.modal-body .container {
 	width: 70%;
 	float: right;
 	height: inherit;
 	overflow-y: scroll;
 }
 
 .modal-body .modal-outLeft{
	float: left;
 	width: 30%;
 	height: auto;
 	padding: 5px;
 	padding-top: 50px;
 }
 
 .modal-dialog .modal-content .modal-footer {
    bottom: 0;
    height: 60px;
}

.th_inWaru{
	width: 50px;
}

.th_inPrice{
	width: 150px;
}



</style>
<meta name="viewport" content="width=device-width, initial-scale=1">

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
                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
            }
            $('#calendar').fullCalendar('unselect');


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
   	                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
   	            }
   	            $('#calendar').fullCalendar('unselect');


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
        ], eventRender: function(event, eventElement) {        
        	eventElement.find("td.fc-event-container").remove();
        	if (event.imageurl)
    		{             		
    		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
    		} 
   		 }            
    	,  select: function(start, end) {
            // Display the modal.
            // You could fill in the start and end fields based on the parameters
            $('#datepicker .modal').modal('show');

        },
         eventClick: function(event, element) {
            // Display the modal and set the values to the event values.
            $('.modal fade .modal').modal('show');
            $('.modal fade .modal').find('#title').val(event.title);
            $('.modal fade .modal').find('#starts-at').val(event.start);
            $('.modal fade .modal').find('#ends-at').val(event.end);
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
					<li><a class="menuLink" href="NewFile.jsp"><img src="./icon/home-n.png" onmouseover='this.src="./icon/home-w.png"' onmouseout='this.src="./icon/home-n.png"' ></a></li>
					<li><a class="menuLink" href="NewFile.jsp"><img src="./icon/schedule-n.png" onmouseover='this.src="./icon/schedule-w.png"' onmouseout='this.src="./icon/schedule-n.png"' ></a></li>
					<li><a class="menuLink" href=""><img src="./icon/cash-w.png" ></a></li>
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
								<li><a href="#" class="list-group-item list-group-item-action"><%=cList.get(i).getContent() %>
								<span class="badge badge-info">+ <%=priceAf  %> 원</span>
								</a>
								</li>
								<%
							}else{
								//지출일 때
								%>
								<li><a href="#" class="list-group-item list-group-item-action">
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
								<li><a href="#" class="list-group-item list-group-item-action">
								<%=cList.get(i).getContent() %>
								<span class="badge badge-info">+ <%=priceAf  %> 원</span>
								</a>
								</li>
								<%
							}else{
								//지출일 때
								%>
								<li><a href="#" class="list-group-item list-group-item-action">
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
	      <div class="modal-outLeft">
				<div id="calendar-mini"></div>
				<div>선택한 날짜</div>
		  </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inContent">수입 내역</th>
		          <th class="th_inPrice">금액</th>
		          <th class="th_inCategory">분류</th>
		          <th class="th_inDelete">아이콘</th>
		          <th class="th_inDelete">삭제</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>
		            <input type="text" id="inContent" class="form-control" size="16" placeholder="내역 입력" name="cashContent"/>
		          </td>
		          
		          <td>
		            <div class="input-group">
		              <span class="input-group-addon"><i class="fas fa-won-sign"></i></span>
		              <input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" name="cashPrice" id="inPrice"/>
		            </div>
		          </td>
		          
		          <td>
		            <select class="form-control match-content" name="cashCategory">
		              <option selected="selected">주수입</option>
		              <option>부수입</option>
		              <option>기타</option>
		            </select>
		          </td>
					<td><a class="deleteRow"></a></td>
					<!-- <td><button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span></button></td> -->
		        </tr>
		      </tbody>
		       <tfoot>
		        <tr>
		           <td colspan="5" style="text-align: left;">
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
        <button type="button" id="btn_saveIo" class="btn btn btn-primary" data-dismiss="modal">Save</button>
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
			<div id="calendar-out"></div>
	      </div>
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inContent">지출 내역</th>
		          <th class="th_inPrice">금액</th>
		          <th class="th_inCategory">분류</th>
		          <th class="th_inDelete">삭제</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="지출 입력" name="cashContent"/>
		          </td>
		          
		          <td>
		            <div class="input-group">
		              <span class="input-group-addon"><i class="fas fa-won-sign"></i></span>
		              <input type="number" class="form-control" value="0" size="12" placeholder="금액 입력" name="cashPrice"/>
		            </div>
		          </td>
		          
		          <td>
		            <select class="form-control match-content" name="cashCategory">
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
		          <td><a class="deleteRow"></a></td>
		        </tr>
		      </tbody>
		       <tfoot>
		        <tr>
		           <td colspan="5" style="text-align: left;">
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
        <button type="button" class="btn btn btn-primary" data-dismiss="modal">Save</button>
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
	        var newRow = $("<tr>");
	        var cols = "";
	        
	        /* 
	        <th>수입/지출</th>
	        <th>수입 내역</th>
	        <th>금액</th>
	        <th>분류</th>
	        <th>삭제</th> */

	        
	        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" name="cashContent'+ counter +'" id="inContent'+counter+'"/></td>';
	        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="0" size="15" placeholder="금액 입력" name="cashPrice'+counter+'" id="inPrice'+counter+'" /></div></td>';
	        cols += '<td><select class="form-control match-content" id="inCategory'+counter+'"><option selected="selected">주수입</option><option>부수입</option><option>기타</option></select></td>';
	        cols += '<td><a href="#iconPlus'+counter+'" class="btn btn-info" data-toggle="collapse">+</a></td>';
	        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="-"></td>';
	        
	        newRow.append(cols);
	        $("#inCashMyModal .table").append(newRow);
	        
	        newRow = $("<tr>");
	        cols = "";
	        cols += '<td colspan="6"><div id="iconPlus'+counter+'" class="collapse">Lorem ipsum dolor text....</div></td>';
	        newRow.append(cols);
	        $("#inCashMyModal .table").append(newRow);
	        
	        counter++;
	    });


		/* 삭제 */
	    $("#inCashMyModal .table").on("click", ".ibtnDel", function (event) {
	        $(this).closest("tr").remove();
	        counter -= 1
	    });


	});



	/* function calculateRow(row) {
	    var price = +row.find('input[name^="price"]').val();
	}

	function calculateGrandTotal() {
	    var grandTotal = 0;
	    $(".table.order-list").find('input[name^="price"]').each(function () {
	        grandTotal += +$(this).val();
	    });
	    $("#grandtotal").text(grandTotal.toFixed(2));
	} */
	
</script>


<!-------------------------------------------------------------------------------
	 지출내역입력 기능
 ------------------------------------------------------------------------------->
 <script type="text/javascript">
 var out_Counter = 0;
 $(document).ready(function () {
	 
	     $("#btnOutPrice").on("click", function () {
	    	 out_Counter=0;
			//alert("수입 입력 버튼 클릭 counter 값 :" +counter);
	    	//테이블 초기화
			$( '#outCashMyModal .table > tbody').empty();
		});
 
	    $("#addrowOut").on("click", function () {
	        var newRow = $("<tr>");
	        var cols = "";
	        alert("addrow 후 counter 값 :" +counter);
	        
	        /* 
	        <th>수입/지출</th>
	        <th>수입 내역</th>
	        <th>금액</th>
	        <th>분류</th>
	        <th>삭제</th> */
	        
	        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" name="cashContent' + out_Counter + '" id="outContent'+counter+'"/></td>';
	        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="1000" size="12" placeholder="금액 입력" name="cashPrice'+out_Counter+'" id="outPrice'+counter+'"/></div></td>';
	        cols += '<td><select class="form-control match-content" id="outCategory'+out_Counter+'"><option>식비</option><option>통신비</option><option>공과금</option><option>의류/미용</option><option>건강/문화생활</option><option>교육/육아</option><option>교통/차량</option><option>경조사/회비</option><option>기타</option></select></td>';
	        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="삭제"></td>';
	        newRow.append(cols);
	        $("#outCashMyModal .table").append(newRow);
	        out_Counter++;
	    });


		/* 삭제 */
	    $("#outCashMyModal .table").on("click", ".ibtnDel", function (event) {
	        $(this).closest("tr").remove();       
	        out_Counter -= 1
	    });
	});


	/* function calculateRow(row) {
	    var price = +row.find('input[name^="price"]').val();

	}

	function calculateGrandTotal() {
	    var grandTotal = 0;
	    $(".table.order-list").find('input[name^="price"]').each(function () {
	        grandTotal += +$(this).val();
	    });
	    $("#grandtotal").text(grandTotal.toFixed(2));
	} */
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


<!-- 참고 http://egloos.zum.com/dreamform/v/2805065 -->
<!-- 수입 입력 내역 가져오기 -->
<script type="text/javascript">
$(document).ready(function () {
	$("#btn_saveIo").click(function () {	
		//수입내역
		//counter
        alert("addrow 후 counter 값 :" +counter);
		var row = parseInt(counter);
		alert(typeof row);
		
		var checkNull = -1;
		for(var i=0; i<row; i++){
			alert($("#inPrice"+i).val());
			var inContentAf = $("#inContent"+i).val();
			var inPriceAf = $("#inPrice"+i).val();
	
			if(inContentAf==null || inPriceAf==null || inPriceAf=="0"){
				checkNull=i;
			}
        };
        
        if(checkNull==-1){
        	
        	var arr = [];
            for(var i=0; i<row; i++){
            	arr.push($("#inCategory"+i).val());
            	arr.push($("#inPrice"+i).val());
            	arr.push($("#inContent"+i).val());
        	};
        	
    		$.ajax({
    			
                type : "get",
                url : "./check.jsp",
                //여러개 데이터 보낼 때 Json 방식
                data : {
    				"test" : arr
    			},
    			dataType : "text",
    			contentType : "application; charset=utf-8",
    			traditional : true,
    			
                success : function(data){
                    alert("success");
                },
                error : function(request,status,error){
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            
            });
      	}else{
      		var newRow = $("<div>");
      		var cols="";
      		cols += '<div class="alert alert-danger">';
	        cols += '<a href="#" class="close">&times;</a>';
	        cols += '<strong>Hey you!</strong> Try to close this alert message.';
	        cols += '</div>';
	        newRow.append(cols);
	        $("#myAlert").append(newRow);
	        
	       	$('#inCashMyModal').modal({
	       	  backdrop: 'static',
	       	  keyboard: false
	       	});
      	
      	}
        
        
        
	});
});
</script>


</body>
</html>