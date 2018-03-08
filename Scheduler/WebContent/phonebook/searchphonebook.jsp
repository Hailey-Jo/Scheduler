<%@page import="java.io.File"%>
<%@page import="phonebook.PhonebookDTO"%>
<%@page import="phonebook.PhonebookDAO"%>
<%@page import="phonebook.iPhonebookDAO"%>
<%@page import="User.userDTO"%>
<%@page import="Schedule.ScheduleDAO"%>
<%@page import="Schedule.ScheduleDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 페이징 처리 -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/jszip-2.5.0/dt-1.10.16/b-1.5.1/b-html5-1.5.1/b-print-1.5.1/r-2.2.1/datatables.min.css"/>
</head>
<body>
<%
String eventstring = "";
String id = "";
String pic = "";
String imgPath = "";
String serverPath = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getRequestURI()));
String packagePath = request.getContextPath();

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
	
}else{
%>
<script type="text/javascript">
	alert("로그인 후 이용해 주세요.");
	location.href="index.jsp";
</script>
<%	
}
%>
 <%
 	String searchtitle = request.getParameter("searchtitle");
 	System.out.println("searchtitle: " + searchtitle);
 	iPhonebookDAO dao = PhonebookDAO.getInstance();
 	List<PhonebookDTO> list = dao.searchphonebook(searchtitle, id);
 %>
 
 	<script type="text/javascript" src="https://cdn.datatables.net/v/bs/jszip-2.5.0/dt-1.10.16/b-1.5.1/b-html5-1.5.1/b-print-1.5.1/r-2.2.1/datatables.min.js"></script>
<!-------------------------------------------------------------------------------
	스케쥴 검색시 모달
 ------------------------------------------------------------------------------->

 <div id="searchmodal"class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
<div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">검색 결과</h4>
      </div>
<div class="container" id="calListBody">
        <div class="table-wrapper" style="width: 878px">
            <div class="table-title">
                <div class="row">
                </div>
            </div>
            <br>
            <table id="example" class="table table-striped table-hover" cellspacing="0" width="100%">
                <col width="10%"><col width="20%"><col width="20%"><col width="25%"><col width="25%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>이름</th>						
						<th>생일</th>
						<th>전화번호</th>        
						<th>이메일</th>                
                    </tr>
                </thead>
                <tbody id="exampleBody">
                	<%
                	for(int i=0; i<list.size(); i++){
                		%>
                		<tr>
	                        <td><%=i+1 %></td>
	                        <td><%=list.get(i).getName() %></td>
	                        <td><%=list.get(i).getBirth() %></td>
	                        <td><%=list.get(i).getPhone() %></td>
	                        <td><%=list.get(i).getEmail() %></td>
                        </tr>
                	<%
                	}
                	%>
                </tbody>
            </table>			
        </div>
    </div>   
    <div class="modal-footer">
		<button type="button" class="btn btn btn-primary" data-dismiss="modal">확인</button>
	</div>
    </div>
  </div>
</div>
<!-- 페이지 처리! -->
<script type="text/javascript">
	$('#searchmodal').modal('show')
</script>
<script type="text/javascript">
$(document).ready(function() {
	  $.fn.DataTable.ext.pager.numbers_length = 5;
	    $('#example').DataTable( {
	       "pagingType":"full_numbers",
	    } );  
	} );
</script>
<script type="text/javascript">
$('#searchmodal').on('hidden.bs.modal', function (e) {		    	  
	 location.href="../phonebook/phonebookMain.jsp"
	});
</script>
</body>
</html>