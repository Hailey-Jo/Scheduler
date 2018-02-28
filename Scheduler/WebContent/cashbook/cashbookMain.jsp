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


/* 
body {
    margin:40px 10px;
    padding:0;
    font-family:"Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
    font-size:14px;
}
 */
#loading {
    display:none;
    position:absolute;
    top:10px;
    right:10px;
}

/* #calendar {
    max-width:1200px;
    margin:0 auto;
}
 */
#calendar {

width:80vm;
height: 80vm;
float:left;
padding : 50px;
/* padding-right: 100px; */

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

/* #calendar{
border: 1px solid #487BE1;
width: 950px;
float: left;
padding: 10px;
margin-right: 10px;
}

 */
 
 /* 수입내역입력 */
.modal-dialog .modal-content {
          width: 900px;
 }
.modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }

 .modal-body .container {
 	width: 100%;
 }
 
 .th_inPrice{
 	width: 200px;
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

<div id="loading">loading...</div>
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
	
	<aside>
	<!-- 하단 -->
		<!-- 좌측 서브 메뉴 -->
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
	</aside>
		
			
	<!-- 우측 본문 -->
	<article>
		<div id="calendar"></div>
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
	
		
	<footer>Copyright &copy; BizPayDay</footer>
	
	
<!-- 수입내역입력 -->
<div class="modal fade" id="inCashMyModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">수입 내역 입력</h4>
      </div>
      
      <div class="modal-body">
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inWaru">구분</th>
		          <th class="th_inContent">수입 내역</th>
		          <th class="th_inPrice">금액</th>
		          <th class="th_inCategory">분류</th>
		          <th class="th_inDelete">삭제</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>
		            <p class="form-control-static">수입</p>
		          </td>
		          
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="내역 입력" name="cashContent"/>
		          </td>
		          
		          <td>
		            <div class="input-group">
		              <span class="input-group-addon"><i class="fas fa-won-sign"></i></span>
		              <input type="number" class="form-control" value="1,000" size="12" placeholder="금액 입력" name="cashPrice"/>
		            </div>
		          </td>
		          
		          <td>
		            <select class="form-control match-content" name="cashCategory">
		              <option selected="">주수입</option>
		              <option>부수입</option>
		              <option>기타</option>
		            </select>
		          </td>
		          <td><a class="deleteRow"></a></td>
		        </tr>
		      </tbody>
		       <tfoot>
		        <tr>
		           <td colspan="6" style="text-align: left;">
		                <input type="button" class="btn btn-lg btn-block " id="addrow" value="수입 내역 입력" />
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
 
 
 <!-- 지출내역입력 -->
<div class="modal fade" id="outCashMyModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">수입 내역 입력</h4>
      </div>
      
      <div class="modal-body">
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inWaru">구분</th>
		          <th class="th_inContent">지출 내역</th>
		          <th class="th_inPrice">금액</th>
		          <th class="th_inCategory">분류</th>
		          <th class="th_inDelete">삭제</th>
		        </tr>
		      </thead>
		      <tbody>
		        <tr>
		          <td>
		            <p class="form-control-static">지출</p>
		          </td>
		          
		          <td>
		            <input type="text" class="form-control" size="16" placeholder="지출 입력" name="cashContent"/>
		          </td>
		          
		          <td>
		            <div class="input-group">
		              <span class="input-group-addon"><i class="fas fa-won-sign"></i></span>
		              <input type="number" class="form-control" value="1,000" size="12" placeholder="금액 입력" name="cashPrice"/>
		            </div>
		          </td>
		          
		          <td>
		            <select class="form-control match-content" name="cashCategory">
		              <option selected="">분류</option>
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
		           <td colspan="6" style="text-align: left;">
		                <input type="button" class="btn btn-lg btn-block " id="addrow_outCash" value="지출 내역 입력" />
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

	
<!-- 수입내역입력 기능 -->
 <script type="text/javascript">
var counter = 0;
 $(document).ready(function () {
	     $("#btnInPrice").on("click", function () {
	    	counter = 0;
			alert("수입 입력 버튼 클릭 counter 값 :" +counter);
		});
 
	    $("#addrow").on("click", function () {
	        var newRow = $("<tr>");
	        var cols = "";
	        alert("addrwo 후 counter 값 :" +counter);
	        
	        /* 
	        <th>수입/지출</th>
	        <th>수입 내역</th>
	        <th>금액</th>
	        <th>분류</th>
	        <th>삭제</th> */
	        
	        cols += '<td><class="form-control-static">수입</p></td>';
	        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" name="cashContent' + counter + '"/></td>';
	        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="1,000" size="12" placeholder="금액 입력" name="cashPrice'+counter+'"/></div></td>';
	        cols += '<td><select class="form-control match-content" name="cashCategory'+counter+'"><option selected="">주수입</option><option>부수입</option><option>기타</option></select></td>';
	        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
	        newRow.append(cols);
	        $(".table").append(newRow);
	        counter++;
	    	$(".table").closest("tr").remove();
	        
	        
	    });


		/* 삭제 */
	    $(".table").on("click", ".ibtnDel", function (event) {
	        $(this).closest("tr").remove();       
	        counter -= 1
	    });


	});



	function calculateRow(row) {
	    var price = +row.find('input[name^="price"]').val();

	}

	function calculateGrandTotal() {
	    var grandTotal = 0;
	    $(".table.order-list").find('input[name^="price"]').each(function () {
	        grandTotal += +$(this).val();
	    });
	    $("#grandtotal").text(grandTotal.toFixed(2));
	}
</script>


<!-- 지출내역입력 기능 -->
<script type="text/javascript">
$(document).ready(function () {
$("#btnOutPrice").on("click", function () {
	var in_Counter = 0;
	$("#btnOutPrice").on("click", function () {
	    var in_Counter = 0;
	});

    $("#addrow_outCash").on("click", function () {
        var newRow = $("<tr>");
        var cols = "";
        
        /* 
        <th>수입/지출</th>
        <th>수입 내역</th>
        <th>금액</th>
        <th>분류</th>
        <th>삭제</th> */
        
        cols += '<td><class="form-control-static">지출</p></td>';
        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" name="cashContent' + out_Counter + '"/></td>';
        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="1,000" size="12" placeholder="금액 입력" name="cashPrice'+out_Counter+'"/></div></td>';
        cols += '<td><select class="form-control match-content" name="cashCategory'+out_Counter+'"><option selected="">분류</option><option>식비</option><option>통신비</option><option>공과금</option><option>의류/미용</option><option>건강/문화생활</option><option>교육/육아</option><option>교통/차량</option><option>경조사/회비</option><option>기타</option></select></td>';
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
        newRow.append(cols);
        $(".table").append(newRow);
        out_Counter++;
    });



    $(".table").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();       
        out_Counter -= 1
    });


});
});



function calculateRow(row) {
    var price = +row.find('input[name^="price"]').val();

}

function calculateGrandTotal() {
    var grandTotal = 0;
    $(".table.order-list").find('input[name^="price"]').each(function () {
        grandTotal += +$(this).val();
    });
    $("#grandtotal").text(grandTotal.toFixed(2));
}
</script>



</body>
</html>