<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
  <%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
		var pageNum = 1;
		var pageSize = 10;
        $(function () {
        	queryAreaList();
            queryOrderListByPage();
            $("#queryBtn").click(function(){
            	queryOrderListByPage();
            });
            $("#resetBtn").click(function(){
                $("#queryForm")[0].reset();
            });
            
        });
        
        function queryAreaList(){
        	$.ajax({
                url : "${APP_PATH}/order/queryAreaList",  
                type : 'POST',
                async : false,
                datatype : 'json',
                data : JSON.stringify({state:"0"}),
                contentType:"application/json",
                success : function(result) {
               	 if ( result.code==100 ) {
               		 var data = result.extend.data || [];
               		 var options = [];
               		  options.push('<option value="">'+$.i18n.prop('bootstrap-select-noneSelectedText')+'</option>') 
               		  for(var i=0;i<data.length;i++){
                            var item = data[i];
　　　　　　　　　　　　　　　　       　options.push('<option value="'+item.id+'">'+item.name+'</option>') 
                      }
                      $("#queryForm #buyerId").html(options.join(' ')); 
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                },
                error : function() {
               	 layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                    });
                }
            });
        }

        /***分页查询构建表格***/
        function queryOrderListByPage( pageno ) {
        	
        	var loadingIndex = null;
        	var params  = $("#queryForm").serializeJSON();
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/order/queryOrderListByPage",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                        $("#queryOrderListResult tbody").html(template("tpl-data",data));
                        /* $("#queryOrderListResult tbody").on('click','.edit',function(){
                        	var data = JSON.parse($(this).attr('item'));
                        	$("#printerForm").autofill(data);
                        	if(data.status == "0"){
                                $("#statusSwitch").bootstrapSwitch('state',true,false);
                            }else{
                                $("#statusSwitch").bootstrapSwitch('state',false,true);
                            }
                         	//弹出模态框
                            $("#printer_modal").modal({
                                backdrop:"static"
                            }).on('hidden.bs.modal', function() {
                                $("#printerForm").data('bootstrapValidator').destroy();
                                $('#printerForm').data('bootstrapValidator', null);
                                bindPrinterForm();
                            });;
                        }).on('click','.del',function(){
                        	var params = JSON.parse($(this).attr('item'));
                        	delPrinter(params)
                        }); */
                        setPage(data.pageNum, data.total, queryOrderListByPage)
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
            
        }
        
        function setPage(pageCurrent, total, callback) {
        	$(".pagination").html('');
        	if(total<1) return;
        	$(".pagination").bootstrapPaginator({
                //设置版本号
                bootstrapMajorVersion: 3,
                // 显示第几页
                currentPage: pageCurrent,
                numberOfPages: 5,
                // 总页数
                total: total,
                pageSize:10,
                size:"mini",
                alignment:"center",
                itemTexts: function (type, page, current) {//设置显示的样式，默认是箭头
                    switch (type) {
                        case "first":
                            return $.i18n.prop('bootstrap-paginator-first');
                        case "prev":
                            return $.i18n.prop('bootstrap-paginator-prev');
                        case "next":
                            return $.i18n.prop('bootstrap-paginator-next');
                        case "last":
                            return $.i18n.prop('bootstrap-paginator-last');
                        case "page":
                            return page;
                    }
                },
                //当单击操作按钮的时候, 执行该函数, 调用ajax渲染页面
                onPageClicked: function (event,originalEvent,type,page) {
                    // 把当前点击的页码赋值给currentPage, 调用ajax,渲染页面
                    pageNum = page
                    callback && callback()
                }
            })
        }
        
    </script>
    
    <script type="text/html" id="tpl-data">
		{{each list}}
           	<tr>
                <td>{{((pageNum-1)*pageSize)+($index+1)}}</td>
                <td>{{$value.orderNo}}</td>
                <td>
                {{if $value.area}}
                      {{$value.area.name}}
                {{/if}}
                </td>
				<td>{{$value.tableNum}}</td>
                <td>{{convertOrderType($value.orderType)}}</td>
                <td>{{$value.adult}}</td>
                <td>{{$value.child}}</td>
                <td>{{$value.totalAmount}}</td>
                <td style='white-space: nowrap;'>{{formatDateTime($value.openTime)}}</td>
				<td>{{convertOrderStatus($value.status)}}</td>
                <td>
                   <button type="button" item='{{obj2Str($value)}}'  class="btn btn-primary btn-xs edit"><i class=" glyphicon glyphicon-pencil"></i></button>
                   &nbsp;&nbsp;&nbsp;
                   <button type="button" item='{{obj2Str($value)}}' class="btn btn-danger btn-xs del"><i class=" glyphicon glyphicon-remove"></i></button>
                </td>
            </tr>
		{{/each}}

   </script>
  <body>

	<div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th i18n" data-properties="order-data-list" data-ptype="text" ></i>
				</h3>
			</div>
			<div class="panel-body">
				<form id="queryForm" class="form-horizontal" role="form" >
					<div class="form-group">
					      <label for="order" class="col-sm-1 control-label i18n" data-properties="order-no" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <input autocomplete="off" type="text" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder"  name="orderNo"  placeholder="">
						  </div>
						  <label for="tableNum" class="col-sm-1 control-label i18n" data-properties="order-tableNum" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <input autocomplete="off" type="text" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder"  name="tableNum"  placeholder="">
						  </div>
						  <label for="buyerId" class="col-sm-1 control-label i18n" data-properties="area-name" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <select  class="form-control" id="buyerId" name="buyerId" >
						      </select>
						  </div>
					</div>
					<div class="form-group">
						  <label for="status" class="col-sm-1 control-label i18n" data-properties="order-status" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <select  class="form-control" id="status" name="status" >
						         <option value="" class="i18n" data-properties="bootstrap-select-noneSelectedText" data-ptype="text"></option>
						         <option value="0" class="i18n" data-properties="order-status-0" data-ptype="text"></option>
						         <option value="1" class="i18n" data-properties="order-status-1" data-ptype="text"></option>
						         <option value="2" class="i18n" data-properties="order-status-2" data-ptype="text"></option>
						         <option value="3" class="i18n" data-properties="order-status-3" data-ptype="text"></option>
						      </select>
						  </div>
						  <label for="orderType" class="col-sm-1 control-label i18n" data-properties="order-type" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <select  class="form-control" id="orderType" name="orderType" >
						         <option value="" class="i18n" data-properties="bootstrap-select-noneSelectedText" data-ptype="text"></option>
						         <option value="1" class="i18n" data-properties="order-type-1" data-ptype="text"></option>
						         <option value="2" class="i18n" data-properties="order-type-2" data-ptype="text"></option>
						      </select>
						  </div>
					</div>
					
					<div style="float: right; margin-right: 30%">
					       <button id="queryBtn" type="button" class="btn btn-primary i18n" data-properties="btn-search" data-ptype="text"> 
					           <i class="glyphicon glyphicon-search"></i>
					        </button>
					        <button id="resetBtn" type="button" class="btn btn-default">
							   <i class="glyphicon glyphicon-refresh i18n" data-properties="btn-reset" data-ptype="text" ></i>
						    </button>
					</div>
					
				</form>
				<br>
				<hr style="clear: both;">
				<div class="table-responsive">
					<form id="queryOrderListResult">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th style="width: 5%;text-align: center;" class="i18n" data-properties="thead-serial-number" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-no" data-ptype="text"></th>
									<th style="width: 8%;text-align: center;" class="i18n" data-properties="area-name" data-ptype="text"></th>
									<th style="width: 8%;text-align: center;" class="i18n" data-properties="order-tableNum" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-type" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-adult" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-child" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-total-amount" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-open-time" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-status" data-ptype="text"></th>
									<th style="width:15%" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
								</tr>
							</thead>

							<tbody id="orderData">

							</tbody>

							<tfoot>
								<tr>
									<td colspan="9" align="center">
										<ul class="pagination"></ul>
									</td>
								</tr>

							</tfoot>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%--订单详情模态框--%>
    <div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="orderDetailTitle">New message</h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;padding-top: 5px">
                    <table class="table ">
                        <thead>
                        <tr >
                            <th>#</th>
                            <th>商品ID</th>
                            <th>商品名</th>
                            <th>价格</th>
                            <th>数量</th>
                            <th>金额</th>
                        </tr>
                        </thead>
                        <tbody id="orderDetailData">
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer" id="all_money" style="padding: 10px">
                </div>
            </div>
        </div>
    </div>
    
  </body>
</html>
