<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String actionPath = request.getParameter("actionPath");

String sNowPage = request.getParameter("nowPage");
String sTotalCount = request.getParameter("totalCount");
String sCountPerPage = request.getParameter("countPerPage");
String sBlockCount= request.getParameter("blockCount");

System.out.println("sNowPage : " + sNowPage);
System.out.println("sTotalCount : " + sTotalCount);
System.out.println("sCountPerPage : " + sCountPerPage);
System.out.println("sBlockCount : " + sBlockCount);

int nowPage = (sNowPage==null || sNowPage.trim().equals("")) ? 1 : Integer.parseInt(sNowPage);
int totalCount = (sTotalCount==null || sTotalCount.trim().equals("")) ? 0 : Integer.parseInt(sTotalCount);
int countPerPage = (sCountPerPage==null || sCountPerPage.trim().equals("")) ? 1 : Integer.parseInt(sCountPerPage);
int countPerBlock = (sBlockCount==null || sBlockCount.trim().equals("")) ? 1 : Integer.parseInt(sBlockCount);

int totalPage = (int)((totalCount-1) / countPerPage) +1;
System.out.println("totalPage : " + totalPage);

int totalBlock = (int)((totalPage - 1)/countPerBlock);

int nowBlock = (int)((nowPage - 1) / countPerBlock);

int firstPage = 0;
int prevPage = 0;
int nextPage = 0;
int lastPage = 0;

if(nowBlock > 0){
	firstPage = 1;
}

if(nowPage > 1){
	prevPage = nowPage -1;
}

int startPage = nowBlock * countPerBlock + 1;

int endPage = countPerBlock * (nowBlock + 1);

if(endPage > totalPage) endPage = totalPage;

if(nowPage < totalPage){
	nextPage = nowPage + 1;
}

//현재 페이지가 총 블록보다 작은경우
if(nowBlock < totalBlock){
	lastPage = totalPage;
}




%>

<script>
function gotoPage(pageNum) {
	
	var objForm = document.frmPaging;
	objForm.nowPage.value = pageNum;
	objForm.submit(); //form 의 Action이 실행되도록 하는 함수
}
</script>

<form name="frmPaging" method="get" action="<%=actionPath%>">
	<input type="hidden" name="nowPage">
	
	<div align="center">
		<a href="#" onclick="gotoPage('<%=firstPage %>')">[첫페이지]</a>
		
		<a href="#" onclick="gotoPage('<%=prevPage %>')">[이전페이지]</a>
		
		<%
		for(int i=startPage; i <=endPage; i++){
			if(i == nowPage){%>
				<%=i %>
			<%}else{ %>
				<a href="#" onclick="gotoPage('<%=i %>')">[<%=i %>]</a>
			<%} %>
		<%} %>
				
		<a href="#" onclick="gotoPage('<%=nextPage %>')">[다음]</a>
		
		<a href="#" onclick="gotoPage('<%=endPage %>')">[끝페이지]</a>
		
	</div>

</form>
