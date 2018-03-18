<%@page import="pds.PdsDao"%>
<%@page import="User.userDAO"%>
<%@page import="User.userDTO"%>
<%@page import="pds.PdsDto"%>

<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8") ;%>

<html>
<head>
<title>BizPayDay</title>
<style>
.row-centered {
    text-align:center;
}
</style>
<link rel="stylesheet" type="text/css" href="../css/mainHeader.css">
<link rel="stylesheet" type="text/css" href="../css/calendar.css">  
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<%
String pdsseq = request.getParameter("seq");
int seq = Integer.parseInt(pdsseq);
PdsDao dao = PdsDao.getInstance();
dao.pdsReadCount(seq);
PdsDto pds = dao.getPDS(seq);
%>

<!-- 상단 메뉴바 -->
	<header>
		<nav id="topMenu">
			<div class="topMenu_siteTitle" style=" float: left; width: 40%;">
				<ul>
					<li><a href="../Main.jsp" style="vertical-align: middle; color: white">BizPayDay</a></li>
				</ul>
			</div>
		</nav>
	</header>
	<h3>글 수정</h3>
<table class="table table-bordered" border="1" bgcolor="pink">
<col width="200"/><col width="500"/>
<tr>
<td>게시자</td>
<td><%=pds.getId() %></td>
</tr>
<tr>
<td>제목</td>
<td><%=pds.getTitle() %></td>
</tr>
<tr>
<td>다운로드</td>
<td><input type="button" name="btnDown" value="파일"
			 onclick="javascript:document.location.href='filedown?filename=<%=pds.getFilename()%>&seq=<%=pds.getSeq()%>'"/></td>
</tr>
<tr>
<td>조회수</td>
<td><%=pds.getReadcount() %></td>
</tr>
<tr>
<td>다운수</td>
<td><%=pds.getDowncount() %></td>
</tr>
<tr>
<td>파일이름</td>
<td><%=pds.getFilename() %></td>
</tr>
<tr>
<td>등록일</td>
<td><%=pds.getRegdate() %></td>
</tr>
<tr>
<td>내용</td>
<td><textarea name='content' rows="7"  readonly="readonly"
cols="50"><%=pds.getContent() %></textarea></td>
</tr>
</table>
<div class="row-centered">
<a href='pdslist.jsp'>목록</a>&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" name="btnDown" value="삭제" onclick="<%=dao.pdsDel(seq)%>"/>
</div>
</body>
</html>