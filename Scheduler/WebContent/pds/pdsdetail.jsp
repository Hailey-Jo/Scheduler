<%@page import="pds.PdsDao"%>
<%@page import="mem.MemberDao"%>
<%@page import="mem.MemberDto"%>
<%@page import="pds.PdsDto"%>

<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8") ;%>

<html>
<head>
<title>pdswrite</title>
</head>
<body>
<%
String pdsseq = request.getParameter("seq");
int seq = Integer.parseInt(pdsseq);
PdsDao dao = PdsDao.getInstance();
dao.pdsReadCount(seq);
PdsDto pds = dao.getPDS(seq);
%>


<h3>자료 상세 내용</h3>
<table border="1" bgcolor="pink">
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
			 onclick="javascript:document.location.href='./filedown?filename=<%=pds.getFilename()%>&pdsid=<%=pds.getSeq()%>'"/></td>
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
<td><textarea name='content' rows="20"  readonly="readonly"
cols="50"><%=pds.getContent() %></textarea></td>
</tr>
</table>
<a href='./pdslist.jsp'>목록</a><br/>
<input type="button" name="btnDown" value="삭제" onclick="<%=dao.pdsDel(seq)%>"/>
</body>
</html>