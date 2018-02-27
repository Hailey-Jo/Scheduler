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
<!-- bootstrap -->
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

  
  <h1>지출 입력</h1>

<div class="container">
    <table class="table">
      <thead>
        <tr>
          <th>구분</th>
          <th>수입 내역</th>
          <th>금액</th>
          <th>분류</th>
          <th>삭제</th>
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
                <input type="button" class="btn btn-lg btn-block " id="addrow" value="지출 내역 입력" />
            </td>
        </tr>
        <tr>
        </tr>
    </tfoot>
    </table>
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
        
        cols += '<td><class="form-control-static">지출</p></td>';
        cols += '<td><input type="text" class="form-control" size="16" placeholder="내역 입력" name="cashContent' + counter + '"/></td>';
        cols += '<td><div class="input-group"><span class="input-group-addon"><i class="fas fa-won-sign"></i></span><input type="number" class="form-control" value="1,000" size="12" placeholder="금액 입력" name="cashPrice'+counter+'"/></div></td>';
        cols += '<td><select class="form-control match-content" name="cashCategory'+counter+'"><option selected="">분류</option><option>식비</option><option>통신비</option><option>공과금</option><option>의류/미용</option><option>건강/문화생활</option><option>교육/육아</option><option>교통/차량</option><option>경조사/회비</option><option>기타</option></select></td>';
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