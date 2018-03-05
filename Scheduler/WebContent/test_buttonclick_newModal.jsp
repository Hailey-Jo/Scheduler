<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html>
<head>
    <title>A simple Bootstrap modal example</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" ></script>
<style>
.modal-dialog {
          width: 860px;
        }
.modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }
 

  .container {
 	width: 100%;
 }
</style>
</head>
<body>


<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  Launch Modal window
</button>

<!-- 수입내역입력 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">수입 내역 입력</h4>
      </div>
      
      <div class="modal-body">
		<div class="container">
		    <table class="table">
		      <thead>
		        <tr>
		          <th class="th_inWaru">수입/지출</th>
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
