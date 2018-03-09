<%@page import="pds.PagingBean"%>
<%@page import="java.io.File"%>
<%@page import="User.userDTO"%>
<%@page import="pds.PdsDao"%>
<%@page import="java.util.List"%>
<%@page import="pds.PdsDto"%>
<%@page import="pds.iPdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BizPayDay</title>
<link rel="stylesheet" type="text/css" href="../css/mainHeader.css">
<link rel="stylesheet" type="text/css" href="../css/header.css?ver=1">
<script type="text/javascript" src="../fullcalendar-3.8.2/lib/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
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
.row-centered {
    text-align:center;
    margin: auto;
}
/* a:hover {
	text-decoration:none;
    background-color: #006699;
}
 */
</style>
</head>

<script type="text/javascript">

function logout(){
    alert("일정시간이 지나 로그아웃 되었습니다.");
    location.href="../index.jsp";
}

setTimeout("logout()",1000*600);
</script>
<%
String eventstring = "";
String id = "";
String pic = "";
String imgPath = "";
String serverPath = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getRequestURI()));
String packagePath = request.getContextPath();

List<PdsDto> list = null;

PagingBean paging = new PagingBean();

iPdsDao pdsDAO = PdsDao.getInstance();
//list = pdsDAO.getPdsList(id);

String findWord = request.getParameter("findWord");
if(findWord == null) findWord = "";
list = pdsDAO.getPdsPagingList(paging, findWord);

if(session.getAttribute("login") != null){

	//user
	userDTO user = new userDTO();
	user = (userDTO)session.getAttribute("login");
	
	id = user.getId();
	pic = user.getPic();
	
	if(pic==null){
		imgPath = serverPath+packagePath+File.separator+"icon"+File.separator+"user-g.png";
	}else{
		imgPath = File.separator+"img"+File.separator+id+File.separator+pic;
	}

	if(request.getParameter("nowPage") == null){
		paging.setNowPage(1);
	}else{
		paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
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
<body>
<!-- 상단 메뉴바 -->
	<header>
		<div id="header">
			<div class="col-sm-4" id="headerTitle" style=" float: left;" ><a href="../Main.jsp" style="color: white; text-decoration: none">BizPayDay</a></div>
			<div class="col-sm-4" id="menuRow">
				<ul style="list-style: none; ">
					<li><a class="menuLink" href="../Main.jsp"><img src="../icon/ic_home_white_36px.svg" onmouseover='this.src="../icon/ic_home_black_36px.svg"' onmouseout='this.src="../icon/ic_home_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../schedule/schedulemain.jsp"><img src="../icon/ic_event_available_white_36px.svg" onmouseover='this.src="../icon/ic_event_available_black_36px.svg"' onmouseout='this.src="../icon/ic_event_available_white_36px.svg"'></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li><a class="menuLink" href="../cashbook/cashbookMain.jsp"><img src="../icon/ic_assessment_white_36px.svg" ></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
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
	 
	
		

<table class="table table-bordered" border="1" style="width: 80%; height: auto; margin: auto; text-align: center;">
<col width="50"><col width="70"><col width="100"><col width="70"><col width="70"><col width="50"><col width="100">
<tr style="height: 80px;">
	<td colspan="7" style="text-align: center; border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; font-size: 24px;">자료실</td>
</tr>
<tr>
	<td colspan="7" style="text-align: right; border-top-color: white; border-left-color: white; border-right-color: white; font-size: 15px;"><a href="pdswrite.jsp" style="text-decoration: none;">자료올리기</a></td>
</tr>

<tr>
	<th>번호</th><th>작성자</th><th>제목</th><th>다운로드</th><th>조회수</th><th>다운수</th><th>작성일</th>
</tr>

<%
	for(int i=0; i<list.size(); i++){
		PdsDto pds = list.get(i);
		System.out.println("pds.getFilename()===>"+pds.getFilename());
		String bgcolor = "";
		
		if(i%2 == 0){
			bgcolor = "#ddeebb";
		}else{
			bgcolor = "#ddddcc";
		}
%>
		
		<tr bgcolor="<%=bgcolor %>" align="center" height="5">
			<td><%=i+1 %></td>
			<td><%=pds.getId() %></td>
			<td align="left">
				<a href="pdsdetail.jsp?seq=<%=pds.getSeq() %>">
					<%=pds.getTitle() %>
				</a>
			</td>
			<td>
				<%-- <input type="button" name="btnDown" value="file" onclick="location.href='filedown?filename=<%=pds.getFilename()%>&seq=<%=pds.getSeq()%>'"> --%>
				<button type="button" name="btnDown" class="btn btn-success" onclick="location.href='filedown?filename=<%=pds.getFilename()%>&seq=<%=pds.getSeq()%>'">FileDown</button>
			</td>
			<td><%=pds.getReadcount()%></td>
			<td><%=pds.getDowncount()%></td>
			<td><%=pds.getRegdate()%></td>
		</tr>
<%
	}
%>
<tr>
	<td colspan="7">
		<jsp:include page="paging.jsp">
			<jsp:param name="actionPath" value="pdslist.jsp"/>
			<jsp:param name="nowPage" value="<%=String.valueOf(paging.getNowPage()) %>"/>
			<jsp:param name="totalCount" value="<%=String.valueOf(paging.getTotalCount()) %>"/>
			<jsp:param name="countPerPage" value="<%=String.valueOf(paging.getCountPerPage()) %>"/>
			<jsp:param name="blockCount" value="<%=String.valueOf(paging.getBlockCount()) %>"/>
		</jsp:include>
	</td>
</tr>
</table>
<br><br>
<!-- search -->
<div class="row-centered"">
<input type=text" id="search">
<button name="search" onclick="searchBbs()">검색</button>
</div>

<script type="text/javascript">
function searchBbs() {
	var msg = document.getElementById("search").value;
	
	alert("msg==>"+msg);
	
	location.href = "pdslist.jsp?findWord=" + msg;
	//document.getElementById("search").value = "";
}
</script>
<!--  -->
 </body>
</html>