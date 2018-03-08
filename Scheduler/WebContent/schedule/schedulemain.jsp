<%@page import="User.userDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.iScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

iScheduleDAO dao = ScheduleDAO.getInstance();
List<ScheduleDTO> list = dao.getAllSchedulList(id);

for(int i=0; i<list.size();i++){	
	//2018-03-05 14:12
	eventstring +="{";	
	eventstring += "title : '"+list.get(i).getTitle()+"',";
	eventstring += "id : '"+list.get(i).getSeq()+"',";
	eventstring += "start : '"+list.get(i).getStartDate().substring(0, 16)+"',";
	eventstring += "end : '"+list.get(i).getEndDate().substring(0, 16)+"',";
	eventstring += "description : '"+list.get(i).getContent()+"',";	
	eventstring += "backgroundColor : '"+list.get(i).getCategory()+"',";
	if(list.get(i).getImportant()==1){
		eventstring += "imageurl : " +" '..\\"+"\\image\\"+"\\"+"star.png',";
	}	
	eventstring +="},"+"\n";
	
}

String birth = user.getBirth();
String name = user.getName();


String syear = birth.substring(0, 4);
int year = Integer.parseInt(syear.trim());

for(int i =0; i < 200; i++){
	eventstring +="{";	
	eventstring += "title : '"+user.getName()+"님의 생일♡',";	
	eventstring += "start : '"+(year+i)+birth.substring(4, 10)+"',";
	eventstring += "allday : true,";
	eventstring += "backgroundColor : '#FF00DD',"; 
	eventstring += "borderColor : '#FF00DD',";
	eventstring += "imageurl : " +" '..\\"+"\\image\\"+"\\"+"cake.png',";
	eventstring +="},"+"\n";
}

if(pic==null){
	imgPath = serverPath+packagePath+File.separator+"icon"+File.separator+"user-g.png";
}else{
	imgPath = File.separator+"img"+File.separator+id+File.separator+pic;
}
%>

<script type="text/javascript">
<%
String fullstartdate[] = new String[list.size()];
String fullenddate[] = new String[list.size()];
String startdate[] = new String[list.size()];
String enddate[] = new String[list.size()];
int important[] = new int[list.size()];
String title[] = new String[list.size()];
for(int i=0; i<list.size();i++){
	// 2018-03-07
	fullstartdate[i] = list.get(i).getStartDate().substring(0, 10);
	fullenddate[i] = list.get(i).getEndDate().substring(0, 10);
	startdate[i] = list.get(i).getStartDate().substring(0, 7).replace("-", "");
	important[i] = list.get(i).getImportant();
	enddate[i] = list.get(i).getEndDate().substring(0, 7).replace("-", "");
	title[i] = list.get(i).getTitle();
}%>
var fullstartdate = [<% for (int i = 0; i < fullstartdate.length; i++) { %>"<%= fullstartdate[i] %>"<%= i + 1 < fullstartdate.length ? ",":"" %><% } %>];
var fullenddate = [<% for (int i = 0; i < fullenddate.length; i++) { %>"<%= fullenddate[i] %>"<%= i + 1 < fullenddate.length ? ",":"" %><% } %>];
var startdate = [<% for (int i = 0; i < startdate.length; i++) { %>"<%= startdate[i] %>"<%= i + 1 < startdate.length ? ",":"" %><% } %>];
var enddate = [<% for (int i = 0; i < enddate.length; i++) { %>"<%= enddate[i] %>"<%= i + 1 < enddate.length ? ",":"" %><% } %>];
var important = [<% for (int i = 0; i < important.length; i++) { %>"<%= important[i] %>"<%= i + 1 < important.length ? ",":"" %><% } %>];
var title = [<% for (int i = 0; i < title.length; i++) { %>"<%= title[i] %>"<%= i + 1 < title.length ? ",":"" %><% } %>];
</script>
<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="../css/header.css?ver=2">
<link rel="stylesheet" type="text/css" href="../css/calendar.css?ver=2">  

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

div.fc-center h2{
	size: 0.8em;
}

tr.important{
	border-bottom: 1px solid #EAEAEA;
}

tr.title{
	border-bottom: 1px solid #EAEAEA;
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
    /* padding-right:10px; */
    border-radius:5px;
    font-weight:bold;
}
    
ul li a:hover, ul li a:focus {  
    color:#fff;  
    background-color:#f40;  
}  

</style>
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

<script type="text/javascript">

    jQuery(document).ready(function() {
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
    	            , editable : false
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
    	            <%=eventstring %>
    	        ]
    	        , eventRender: function(event, eventElement) {
    				if (event.imageurl){             		
    					eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
    				}
    				//google link remove
    				$('td .fc-event-container').find('a').removeAttr("href");
    			},
    			eventClick: function(e) {  
    				var target = $(this).find('a').attr('href', '#');

    				return false
    			}
    	    });
    	        
    	        $('#my-today-button').click(function() {
    	            $('#calendar').fullCalendar('today');
    	        });
    	        
    	    });
    	 
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
	        , editable : true
        	, height : 580
            , locale : "ko"
            , editable : false
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
            ]
            , eventRender: function(event, eventElement) {            	
            	if (event.imageurl)
        		{             		
        		eventElement.find("div.fc-content").prepend("<img src='" + event.imageurl +"' width='12' height='12'>"); 
        		}
            	
       		 }
       	    , eventClick:  function(event, jsEvent, view) {
       	    	if(event.id.length > 10 || event.id == null){
					var target = $(this).find('a').attr('href', '#');
					return false
				}else{
					$('#modalTitle').html(event.title);
					$('#modalBody').html(event.description);
					$('#eventUrl').attr('href','updateschedule.jsp?seq='+event.id);
					$('#fullCalModal').modal();
				}
	        }
       	    , dayClick: function(date, allDay, jsEvent, view) {
       	    	$('#eventUrl').attr('href','addschedule.jsp');
       	    	$('#fullCalModal').modal();
       	    }     	   
		  });
        
        $(function() {
			$(".fc-next-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").click(function() {
				
				var aaa = $("#calendar div.fc-center h2").text();
		        if(aaa.length==8){
		        	var thisyear = aaa.substring(0,4);        
		            var thismonth = aaa.substring(6,7);
		            thismonth = "0"+thismonth;
		            var dday = thisyear + thismonth;		            
		            $(".monthbtn").attr('value',dday);	
		            
		        }
		        else if(aaa.length==9){
		        	var thisyear = aaa.substring(0,4); 
		        	var thismonth = aaa.substring(6,8);
		        	var dday = thisyear + thismonth;		        	
		            $(".monthbtn").attr('value',dday);			           
		        }
		        $("#importanttable tbody").find(".important").remove();
			});
		});
        
        $(function() {
			$(".fc-prev-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").click(function() {
				
				var aaa = $("#calendar div.fc-center h2").text();
		        if(aaa.length==8){
		        	var thisyear = aaa.substring(0,4);        
		            var thismonth = aaa.substring(6,7);
		            thismonth = "0"+thismonth;
		            var dday = thisyear + thismonth;		            
		            $(".monthbtn").attr('value',dday);	
		            
		        }
		        else if(aaa.length==9){
		        	var thisyear = aaa.substring(0,4); 
		        	var thismonth = aaa.substring(6,8);
		        	var dday = thisyear + thismonth;		        	
		            $(".monthbtn").attr('value',dday);		           
		           
		        }
		        $("#importanttable tbody").find(".important").remove();
			});
		});
    });    
    
    $(function() {
		$("#btn1").click(function() {	
			 
			var aaa = $("#calendar div.fc-center h2").text();
		        if(aaa.length==8){
		        	var thisyear = aaa.substring(0,4);        
		            var thismonth = aaa.substring(6,7);
		            thismonth = "0"+thismonth;
		            var dday = thisyear + thismonth;		            
		            $(".monthbtn").attr('value',dday);	
		            
		        }
		        else if(aaa.length==9){
		        	var thisyear = aaa.substring(0,4); 
		        	var thismonth = aaa.substring(6,8);
		        	var dday = thisyear + thismonth;		        	
		            $(".monthbtn").attr('value',dday);		           
		           
		        } 
		    var modalstr = "";		    
		    
		    modalstr += '<div class="modal fade" id="importantmodal" tabindex="-1" role="dialog" aria-labelledby="importantmodalLabel" aria-hidden="true">';
		    modalstr += '<div class="modal-dialog" role="document">';
		    modalstr += '<div class="modal-content">';
		    modalstr += '<div class="modal-header">';
		    modalstr += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">';
		    modalstr += '<span aria-hidden="true">&times;</span>';
		    modalstr += '</button>';
		    modalstr += '<h5 class="modal-title" id="importantmodalLabel">중요일정보기</h5>';
		    modalstr += '</div>';
		    modalstr += '<div class="modal-body">';
		      
		    modalstr += '<table id="importanttable" style="text-align: center; ">';
		    modalstr += '<col width="150"><col width="150"><col width="300">';
		    modalstr += '<tr>';
		    modalstr += '<td colspan="3" style="border-bottom: 1px solid gray">';
		    modalstr += '</td>';
		    modalstr += '</tr>';
		    modalstr += '<tr class="title">';
		    modalstr += '<td>시작일</td>';
		    modalstr += '<td>종료일</td>';
		    modalstr += '<td>제목</td>';
		    modalstr += '</tr>';			    
		    
		    modalstr += '</tr>';
		    modalstr += '</table>';
		    
			modalstr += '<script>';
    	    
		    modalstr += 'for (i = 0; i < startdate.length; i++) { ';
		    
		    modalstr += 'if(startdate[i]==$(".monthbtn").attr("value")){'
		    modalstr += 'if(important[i]==1){'
	    	modalstr += '$("#importanttable tbody").append("<tr class="+"important"+"><td>"+fullstartdate[i]+"</td><td>"+fullenddate[i]+"</td><td>"+title[i]+"</td></tr>");';
		    /* modalstr += '$("#importanttable tbody").append("<td>"+fullstartdate[i]+"</td>");';
		    modalstr += '$("#importanttable tbody").append("<td>"+fullenddate[i]+"</td>");';
		    modalstr += '$("#importanttable tbody").append("<td>"+title[i]+"</td>");';
		    modalstr += '$("#importanttable tbody").append("</tr>");'; */
		    
		    modalstr += ' }';
	//	    modalstr += '$(".titletr").append("</tr>");';
		    modalstr += '}';		    
		    modalstr += '}';
		    modalstr += '<\/script>';
		    modalstr += '</div>';
		    modalstr += '<div class="modal-footer">';
		    modalstr += '<button type="button" id="closebtn"class="btn btn-secondary" data-dismiss="modal">Close</button>';
		    modalstr += '</div>';
		    modalstr += '</div>';
		    modalstr += '</div>';
		    modalstr += '</div>';
		    
		    $("article").append(modalstr);
		    
		    
		    $('#importantmodal').on('hidden.bs.modal', function (e) {		    	  
		    	  $("#importanttable tbody").find(".important").remove();
		    	});
		});
	});

</script>
<title>BizPayDay</title>
</head>
<body>
<!-- <div id ="main"> -->

<!-- 상단 메뉴바 -->
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle" style=" float: left; width: 40%;">
				<ul>
					<li><a href="../Main.jsp" style="color: white">BizPayDay</a></li>
				</ul>
			</div>
			<div class="topMenu_icon" align="center" style=" float: left; width: 40%;">
				<ul>
					<li><a class="menuLink" href="../Main.jsp"><img src="../icon/home-n.png" onmouseover='this.src="../icon/home-w.png"' onmouseout='this.src="../icon/home-n.png"' ></a></li>
					<li><a class="menuLink" href="../schedule/schedulemain.jsp"><img src="../icon/schedule-w.png" onmouseover='this.src="../icon/schedule-w.png"' onmouseout='this.src="../icon/schedule-w.png"' ></a></li>
					<li><a class="menuLink" href="../cashbook/cashbookMain.jsp"><img src="../icon/cash-n.png" ></a></li>
				</ul>
			</div>
			<div class="login_info" style=" float: left; width: 18%; height: 30px;">
		      <ul class="nav navbar-nav navbar-right">
		      	<img alt="프로필이미지" src="<%=imgPath%>" class="img-circle" width="40">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" style=" padding:5px; height: 30px;"><%=id %><span class="caret"></span></a>
		          <ul class="dropdown-menu" role="menu">
		            <li><a href="#">My List</a></li>
		            <li><a href="#">My Info</a></li>
		            <li><a href="../index.jsp">Log out</a></li>
		          </ul>
		        </li>
		      </ul>
 		  </div>
		</nav>
	</header>
	
	<aside>
	<!-- 하단 -->
		<!-- 좌측 서브 메뉴 -->
		<form action="../schedule/searchschedule.jsp" method="post">
			<div align="center">
				<input type="text" name="searchtitle" style="width: 236px" placeholder="찾고싶은 제목을 입력하세요.">
				<input TYPE="IMAGE" src="../icon/search-g.png" id="submit" name="Submit" value="Submit"  align="absmiddle" height="26px" width="26px" style="padding-left: 2px">

			</div>	
		</form>
		<div align="center" style="padding-top: 10px">
			<button type="button" class="btn btn-info" style="width: 260px" onclick = "location.href = '../schedule/addschedule.jsp' " >스케줄 등록</button>
		</div>
		
	<br>
		<div id="calendar-mini"></div>
	<!-- btn1 -->
	<div style="padding: 10px" class="tablediv">	
	
		<table style="padding-top: 10px">
			<tr>
				<td>　</td>
			</tr>
			<tr>		
				<input name="monthbtn" class="monthbtn" type="hidden" value="">
				<td style="width: 300px"><button id="btn1" data-toggle="modal" class="btn btn-primary btn-lg btn-block" data-target="#importantmodal">중요일정보기</button></td>
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
                <button class="btn btn-primary"><a id="eventUrl" target="_self" style="color: white; font-weight: 100">Event Page</a></button>
            </div>
        </div>
    </div>
</div>

	


	</article>
	<div class="footer navbar-fixed-bottom">	
		<footer >Copyright &copy; BizPayDay</footer>
	</div>
	

</script>
</body>
</html>