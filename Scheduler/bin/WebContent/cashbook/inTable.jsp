<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
/* Latest compiled and minified CSS included as External Resource*/
/* Optional theme */
/*@import url('//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css');*/

body {
  margin: 10px;
}

#myTable thead > tr > th.detail,
#myTable tbody > tr:not(.detail-view) > td:first-of-type {
  display: none;
}

#myTable thead > tr > th:nth-child(2),
#myTable tbody > tr:not(.detail-view) > td:nth-child(2) {
  border-left: none!important;
}


.modal-dialog {
    width: 300px;
}

/*
#myTable thead tr > th.detail > .fht-cell,
#myTable tbody > tr:not(.detail-view) > td:first-of-type > a.detail-icon
{visibility: hidden;
    width: 0px;
    height: 0px;
    display: none;
    position: absolute;}
    */

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<!-- icon 불러오기 -->
<!--core first + styles last-->
<link href="/static/fontawesome/fontawesome-all.css" rel="stylesheet">
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<!--load everything-->
<script defer src="/static/fontawesome/fontawesome-all.js"></script>
<script defer src="/static/fontawesome/fa-v4-shim.js"></script>


<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
</head>
<body>
<!-- <span class="icon"><i class="fas fa-won-sign"></i></span>
<div class="box">
  <div class="container-1">
 	 <span class="icon"><i class="fa fa-won-sign"></i></span>
      <span class="icon"><i class="fa fa-search"></i></span>
      <input type="search" id="search" placeholder="Search..." />
  </div>
</div> -->

<h1>수입 입력</h1>
<div class="modal-dialog" role="document">
<div class="container">
    <table class="table">
      <thead>
        <tr>
          <th>수입/지출</th>
          <th>수입 내역</th>
          <th>금액</th>
          <th>분류</th>
          <th>삭제</th>
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

      
<script type="text/javascript">
$(document).ready(function () {
    var counter = 0;

    $("#addrow").on("click", function () {
        var newRow = $("<tr>");
        var cols = "";
        
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
        $("table").append(newRow);
        counter++;
    });



    $("table").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();       
        counter -= 1
    });


});



function calculateRow(row) {
    var price = +row.find('input[name^="price"]').val();

}

function calculateGrandTotal() {
    var grandTotal = 0;
    $("table.order-list").find('input[name^="price"]').each(function () {
        grandTotal += +$(this).val();
    });
    $("#grandtotal").text(grandTotal.toFixed(2));
}
</script>

</body>
</html>