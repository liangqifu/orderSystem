<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
  <%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
		var pageNum = 1;
		var pageOrderDetailNum = 1;
        $(function () {
        	queryAreaList();
            queryOrderListByPage();
            $("#queryBtn").click(function(){
            	pageNum = 1;
        		pageOrderDetailNum = 1;
            	queryOrderListByPage();
            });
            $("#refreshBtn").click(function(){
            	pageNum = 1;
        		pageOrderDetailNum = 1;
            	queryOrderListByPage();
            });
            
            $("#resetBtn").click(function(){
            	pageNum = 1;
        		pageOrderDetailNum = 1;
                $("#queryForm")[0].reset();
            });
            
            $("#exportBtn").click(function(){
                
            	exportOrderList()
                
            });
            
            var daysOfWeek = [];
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-1'))
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-2'))
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-3'))
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-4'))
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-5'))
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-6'))
            daysOfWeek.push($.i18n.prop('daterangepicker-daysOfWeek-7'))
            
            var monthNames = [];
            monthNames.push($.i18n.prop('daterangepicker-monthNames-1'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-2'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-3'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-4'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-5'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-6'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-7'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-8'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-9'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-10'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-11'))
            monthNames.push($.i18n.prop('daterangepicker-monthNames-12'))
            var locale = {
                    "format": $.i18n.prop('daterangepicker-format'),
                    "separator": " - ",
                    "applyLabel": $.i18n.prop('daterangepicker-applyLabel'),
                    "cancelLabel": $.i18n.prop('daterangepicker-cancelLabel'),
                    "fromLabel": $.i18n.prop('daterangepicker-fromLabel'),
                    "toLabel": $.i18n.prop('daterangepicker-toLabel'),
                    "customRangeLabel": $.i18n.prop('daterangepicker-customRangeLabel'),
                    "daysOfWeek": daysOfWeek,
                    "monthNames": monthNames
                };
            var ranges = {};
            ranges[$.i18n.prop('daterangepicker-ranges-today')]=[moment(),moment()];
            ranges[$.i18n.prop('daterangepicker-ranges-yesterday')]=[moment().subtract(1, 'days'),moment().subtract(1, 'days')];
            ranges[$.i18n.prop('daterangepicker-ranges-nearly7days')]=[moment().subtract(7, 'days'), moment()];
            ranges[$.i18n.prop('daterangepicker-ranges-this-month')]=[moment().startOf('month'), moment().endOf('month')];
            ranges[$.i18n.prop('daterangepicker-ranges-last-month')]=[moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];
            $("#queryForm #openTime").daterangepicker(
   	    		 {
   	    	        autoUpdateInput: false,
   	    	        ranges: ranges,
   	    	        locale: locale
   	    	     }
		   	     ).on('cancel.daterangepicker', function(ev, picker) {
		   	            $("#queryForm #openTime").val("");
		                $("#queryForm #startTime").val("");
		                $("#queryForm #endTime").val("");
		   	     }).on('apply.daterangepicker', function(ev, picker) {
		                $("#queryForm #startTime").val(picker.startDate.format('YYYY-MM-DD'));
		                $("#queryForm #endTime").val(picker.endDate.format('YYYY-MM-DD'));
		                $("#queryForm #openTime").val(picker.startDate.format($.i18n.prop('daterangepicker-format'))+" - "+picker.endDate.format($.i18n.prop('daterangepicker-format')));
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

        function exportOrderList(){
        	
        	$("#queryForm").attr('action','${APP_PATH}/order/exportExcel');
        	$("#queryForm").submit();
        	$("#queryForm").attr('action','');
        }
        /***分页查询构建表格***/
        function queryOrderListByPage() {
        	
        	var loadingIndex = null;
        	var params  = $("#queryForm").serializeJSON();
        	params.pageNum=pageNum;
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
                         $("#queryOrderListResult tbody").on('click','.edit',function(){
                        	var data = JSON.parse($(this).attr('item'));
                        	queryOrderInfo(data.orderId);
                          }).on('click','.del',function(){
                        	var params = JSON.parse($(this).attr('item'));
                        	delOrder(params);
                          }).on('click','.print',function(){
                        	var params = JSON.parse($(this).attr('item'));
                        	openPrintInfoWin(params.orderId);
                          }); 
                        if($("#orderDel").val() == 'true'){
                        	$("#queryOrderListResult tbody").find('.del').show(); 
                        }else{
                        	$("#queryOrderListResult tbody").find('.del').hide();
                        }
                        setPage(data.pageNum, data.total, data.pageSize,queryOrderListByPage)
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
            
        }
        
        function setPage(pageCurrent, total,pageSize, callback) {
        	$("#queryOrderListResult .pagination").html('');
        	$("#queryOrderListResult .total").text($.format($.i18n.prop('query-result-total'),total));
        	if(total<1) return;
        	$("#queryOrderListResult .pagination").bootstrapPaginator({
                //设置版本号
                bootstrapMajorVersion: 3,
                // 显示第几页
                currentPage: pageCurrent,
                numberOfPages: 5,
                // 总页数
                total: total,
                pageSize:pageSize,
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
        
        function delOrder(params){
        	layer.confirm($.format($.i18n.prop('layer-confirm-delete-msg'), (!params.orderNo?params.orderId:params.orderNo)),  {
        		icon: 3, 
        		title:$.i18n.prop('layer-title'),
        		btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')] 
        		}, function(cindex){
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/order/delOrder",
                    dataType : 'json',
                    data:JSON.stringify(params),
                    contentType:"application/json",
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg($.i18n.prop('delete-success'), {time:2000, icon:6}, function(){});
                            queryOrderListByPage();
                        } else {
                            layer.msg($.i18n.prop('delete-fail'), {time:2000, icon:5, shift:6}, function(){});
                        }
                    }
                });
                layer.close(cindex);

            }, function(cindex){
                layer.close(cindex);
            });
        }
        function queryOrderInfo(orderId){
        	var loadingIndex = null;
        	$.ajax({
                type : "GET",
                dataType : 'json',
                url  : "${APP_PATH}/app/order/"+orderId+"/info",
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                         $("#orderDetailModal .left ul").html(template("tpl-order-data",data));
                         $("#orderDetailModal").autofill(data);
                         $("#orderDetailModal #openTime").text(jQuery.formatDateTime('hh:ii', new Date(data.openTime)));
                         
                         $("#orderDetailModal .left ul li").off().on('click',function(e){
                        	 e.preventDefault();
                        	 $("#orderDetailModal .left ul li").removeClass('active');
                        	 $(this).addClass('active');
                        	 pageOrderDetailNum = 1;
                        	 queryOrderDetailList({detailType:$(this).attr("detailType"),orderId:$(this).attr("orderId"),roundId:$(this).attr("id")})
                         });
                        //弹出模态框
                         $("#orderDetailModal").modal({
                             backdrop:"static"
                         });
                         $($("#orderDetailModal .left ul li")[0]).trigger("click")
                        
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        }
        
        function openPrintInfoWin(orderId){
        	var loadingIndex = null;
        	$.ajax({
                type : "GET",
                dataType : 'json',
                url  : "${APP_PATH}/app/order/"+orderId+"/print/info",
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                         $("#orderPrintInfoModal .left ul").html('');
                         $("#orderPrintInfoModal .left ul").html(template("tpl-order-print-data",data));
                         $("#orderPrintInfoModal").autofill(data);
                         $("#orderPrintInfoModal #openTime").text(jQuery.formatDateTime('hh:ii', new Date(data.openTime)));
                         
                         $("#orderPrintInfoModal .left ul li").off().on('click',function(e){
                        	 e.preventDefault();
                        	 $("#orderPrintInfoModal .left ul li").removeClass('active');
                        	 $(this).addClass('active');
                        	 queryOrderPrintInfoDetailList({pinterType:$(this).attr("pinterType"),orderId:$(this).attr("orderId")})
                         });
                        //弹出模态框
                         $("#orderPrintInfoModal").modal({
                             backdrop:"static"
                         });
                         $($("#orderPrintInfoModal .left ul li")[0]).trigger("click")
                        
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        }
        
        function queryOrderDetailList(params){
        	params.pageNum=pageOrderDetailNum;
        	var loadingIndex = null;
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/app/order/queryOrderDetail",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                         $("#queryOrderDetailListResult tbody").html(template("tpl-order-detail-data",data));
                         setOrderDetailPage(data.pageNum, data.total,data.pageSize, queryOrderDetailList)
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        }
        
        function setOrderDetailPage(pageCurrent, total,pageSize, callback) {
        	$("#queryOrderDetailListResult .pagination").html('');
        	$("#queryOrderDetailListResult .total").text($.format($.i18n.prop('query-result-total'),total));
        	if(total<1) return;
        	$("#queryOrderDetailListResult .pagination").bootstrapPaginator({
                //设置版本号
                bootstrapMajorVersion: 3,
                // 显示第几页
                currentPage: pageCurrent,
                numberOfPages: 5,
                // 总页数
                total: total,
                pageSize:pageSize,
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
                    pageOrderDetailNum = page
                    callback && callback()
                }
            })
        }
        
        function queryOrderPrintInfoDetailList(params){
        	var loadingIndex = null;
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/app/order/queryOrderPrintInfoDetail",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                        $("#queryOrderPrintInfoDetailListResult tbody").html('');
                         $("#queryOrderPrintInfoDetailListResult tbody").html(template("tpl-order-printInfo-detail-data",{list:data}));
                         $("#queryOrderPrintInfoDetailListResult tbody").off().on('click','.reprint',function(){
                         	  var params = JSON.parse($(this).attr('item'));
                             	doPrint(params);
                         }); 
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        }
        function doPrint(params){
        	var loadingIndex = null;
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/app/order/doPrint",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                    	layer.msg($.i18n.prop('print-success'), {time:1000, icon:6}, function(){
                        });
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
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
                <td style="text-align: right;">{{$value.totalAmount}}</td>
                <td style='white-space: nowrap;'>{{formatDateTime($value.openTime)}}</td>
				<td>{{convertOrderStatus($value.status)}}</td>
                <td>
                   <button type="button" item='{{obj2Str($value)}}'  class="btn btn-primary btn-xs edit"><i class=" glyphicon glyphicon-pencil"></i></button>
                   &nbsp;&nbsp;&nbsp;
                   <button type="button" item='{{obj2Str($value)}}'  class="btn btn-info btn-xs print"><i class="glyphicon glyphicon-print"></i></button>
                   &nbsp;&nbsp;&nbsp;
                   <button type="button" item='{{obj2Str($value)}}' class="btn btn-danger btn-xs del"><i class=" glyphicon glyphicon-remove"></i></button>
                </td>
            </tr>
		{{/each}}

   </script>
   
   <script type="text/html" id="tpl-order-data">

		{{each orderRounds}}
            {{if $index == 0}}
                  <li class="active" detailType="2" id="{{$value.id}}" orderId="{{$value.orderId}}" ><a>{{convertOrderRound($value.num)}}</a></li>
            {{else}} 
                  <li id="{{$value.id}}" detailType="2" orderId="{{$value.orderId}}" ><a>{{convertOrderRound($value.num)}}</a></li>
            {{/if}}
		{{/each}}
        {{if orderDrinksCount > 0}}
            <li detailType="1"  orderId="{{orderId}}" ><a>{{convertOrderDrinks()}}</a></li>
        {{/if}}

        {{if orderServiceCount > 0}}
            <li detailType="3"  orderId="{{orderId}}" ><a>{{convertOrderService()}}</a></li>
        {{/if}}
       
   </script>
   
   <script type="text/html" id="tpl-order-detail-data">

		{{each list}}
           	<tr>
                <td>{{((pageNum-1)*pageSize)+($index+1)}}</td>
                <td>{{$value.productName}}</td>
                <td style="text-align: right;">{{$value.productPrice}}</td>
                <td style="text-align: right;">{{$value.productNumber}}</td>
                <td style='white-space: nowrap;'>{{$value.categoryName}}</td>
                <td style='white-space: nowrap;'>{{formatDateTime($value.createTime)}}</td>
            </tr>
		{{/each}}

   </script>
   
   <script type="text/html" id="tpl-order-print-data">

		{{each printLogs}}
            {{if $index == 0}}
                  <li class="active" pinterType="{{$value.pinterType}}" orderId="{{$value.orderId}}" ><a>{{convertOrderPinterType($value.pinterType)}}</a></li>
            {{else}} 
                  <li pinterType="{{$value.pinterType}}" orderId="{{$value.orderId}}"  ><a>{{convertOrderPinterType($value.pinterType)}}</a></li>
            {{/if}}
		{{/each}}
       
   </script>
   
   <script type="text/html" id="tpl-order-printInfo-detail-data">

		{{each list}}
           	<tr>
                <td>{{($index+1)}}</td>
                <td >{{convertOrderPinterType($value.pinterType)}}</td>
                <td >{{convertOrderPinterStatus($value.status)}}</td>
                <td style='white-space: nowrap;'>{{formatDateTime($value.createTime)}}</td>
                <td>
                   <button type="button" item='{{obj2Str($value)}}'  class="btn btn-info btn-xs reprint"><i class="glyphicon glyphicon-print"></i></button>
                </td>
            </tr>
		{{/each}}
   </script>
   
   
  <body>
        <input type="hidden" id="orderDel" value="${orderDel}" />
	<div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th i18n" data-properties="order-data-list" data-ptype="text" ></i>
				</h3>
			</div>
			<div class="panel-body">
				<form id="queryForm" class="form-horizontal" role="form" method="post" >
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
					     <label  class="col-sm-1 control-label i18n" data-properties="order-open-time" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						         <input type="text"  autocomplete="off"  id="openTime" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder" style="width:120%;">
            				     <input type="hidden" id = "startTime" name="startTime" class="form-control" />
            					 <input type="hidden" id = "endTime" name="endTime" class="form-control" />
						  </div>
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
							   <i class="glyphicon glyphicon glyphicon-repeat i18n" data-properties="btn-reset" data-ptype="text" ></i>
						    </button>
						    
						    <button id="refreshBtn" type="button" class="btn btn-success">
							   <i class="glyphicon glyphicon-refresh i18n" data-properties="btn-refresh" data-ptype="text" ></i>
						    </button>
						    
						    <button id="exportBtn" type="button" class="btn btn-info">
							   <i class="glyphicon glyphicon-export i18n" data-properties="btn-export" data-ptype="text" ></i>
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
									<th style="width: 7%;text-align: center;" class="i18n" data-properties="order-type" data-ptype="text"></th>
									<th style="width: 7%;text-align: center;" class="i18n" data-properties="order-adult" data-ptype="text"></th>
									<th style="width: 7%;text-align: center;" class="i18n" data-properties="order-child" data-ptype="text"></th>
									<th style="width: 7%;text-align: center;" class="i18n" data-properties="order-total-amount" data-ptype="text"></th>
									<th style="width: 10%;text-align: center;" class="i18n" data-properties="order-open-time" data-ptype="text"></th>
									<th style="width: 7%;text-align: center;" class="i18n" data-properties="order-status" data-ptype="text"></th>
									<th style="width:15%" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
								</tr>
							</thead>

							<tbody id="orderData">

							</tbody>

							<tfoot>
								<tr>
									<td colspan="11" align="center">
										<ul class="pagination"></ul>
										<span class="total"></span>
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
	<div class="modal fade" style="z-index: 2000;" id="orderDetailModal"
		tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-sm" style="width: 70%;" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="orderDetailTitle"></h4>
				</div>
				<div class="modal-body"
					style="padding-bottom: 0px; padding-top: 5px">
					<div class="container">
						<div class="row">
							<div class="left">
								<ul class="nav nav-pills nav-stacked">
									
								</ul>
							</div>

							<div class="right panel panel-default">
								<form id="orderForm" class="form-horizontal input-no-border" role="form">
									<div class="form-group">
										<label class="fl ml20 control-label i18n" data-properties="order-drinks-total-amount" data-ptype="text"></label>
										<div class="fl w20">
											<input autocomplete="off" type="text" style="color: green;" readonly="readonly" class="form-control " name="drinksTotalAmount">
										</div>
										<div class="fl w20">
											<input autocomplete="off" type="text" readonly="readonly" class="form-control" name="tableNum">
										</div>
										<label class="fl ml20 control-label i18n" data-properties="order-total-amount" data-ptype="text"></label>
										<div class="fl w20">
											<input autocomplete="off" type="text" style="color: green;" readonly="readonly" class="form-control" name="totalAmount" />
										</div>
									</div>
								</form>
								<div class="panel-body" style="padding: 3px;">
									<div class="table-responsive">
										<form id="queryOrderDetailListResult">
											<table class="table  table-bordered ">
												<thead>
													<tr>
														<th style="width: 5%; text-align: center;" class="i18n" data-properties="thead-serial-number" data-ptype="text"></th>
														<th style="width: 20%; text-align: center;" class="i18n" data-properties="product-name" data-ptype="text"></th>
														<th style="width: 8%; text-align: center;" class="i18n" data-properties="product-price" data-ptype="text"></th>
														<th style="width: 5%; text-align: center;" class="i18n" data-properties="product-number" data-ptype="text"></th>
														<th style="width: 6%; text-align: center;" class="i18n" data-properties="category-name" data-ptype="text"></th>
														<th style="width: 3%; text-align: center;" class="i18n" data-properties="order-detail-create-time" data-ptype="text"></th>
													</tr>
												</thead>

												<tbody>

												</tbody>

												<tfoot>
													<tr>
														<td colspan="6" align="center">
															<ul class="pagination"></ul>
															<span class="total"></span>
														</td>
													</tr>
												</tfoot>
											</table>
										</form>
									</div>
								</div>
								<div style="text-align: right;border-top: 1px solid #e5e5e5;">
								      <label class="fl ml20 control-label i18n" data-properties="order-open-time" data-ptype="text"></label> 
								      <div class="fl ml20">
											<span style="white-space: nowrap; color: red;" id="openTime"></span>
									  </div>
				                </div>
							</div>
						</div>

					</div>

				</div>
				<div class="modal-footer"  style="padding: 10px;text-align:center;">
				     <button type="button" class="btn btn-default i18n" data-properties="btn-close" data-ptype="text" data-dismiss="modal"></button>
				</div>
			</div>
		</div>
	</div>
	
	<%--订单打印详情模态框--%>
	<div class="modal fade" style="z-index: 2000;" id="orderPrintInfoModal"
		tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-sm" style="width: 70%;" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" ></h4>
				</div>
				<div class="modal-body"
					style="padding-bottom: 0px; padding-top: 5px">
					<div class="container">
						<div class="row">
							<div class="left">
								<ul class="nav nav-pills nav-stacked">
									
								</ul>
							</div>

							<div class="right panel panel-default">
								<form id="orderForm" class="form-horizontal input-no-border" role="form">
									<div class="form-group">
										<label class="fl ml20 control-label i18n" data-properties="order-drinks-total-amount" data-ptype="text"></label>
										<div class="fl w20">
											<input autocomplete="off" type="text" style="color: green;" readonly="readonly" class="form-control " name="drinksTotalAmount">
										</div>
										<div class="fl w20">
											<input autocomplete="off" type="text" readonly="readonly" class="form-control" name="tableNum">
										</div>
										<label class="fl ml20 control-label i18n" data-properties="order-total-amount" data-ptype="text"></label>
										<div class="fl w20">
											<input autocomplete="off" type="text" style="color: green;" readonly="readonly" class="form-control" name="totalAmount" />
										</div>
									</div>
								</form>
								<div class="panel-body" style="padding: 3px;">
									<div class="table-responsive">
										<form id="queryOrderPrintInfoDetailListResult">
											<table class="table  table-bordered ">
												<thead>
													<tr>
														<th style="width: 5%; text-align: center;" class="i18n" data-properties="thead-serial-number" data-ptype="text"></th>
														<th style="width: 20%; text-align: center;" class="i18n" data-properties="order-print-name" data-ptype="text"></th>
														<th style="width: 10%; text-align: center;" class="i18n" data-properties="order-print-status" data-ptype="text"></th>
														<th style="width: 20%; text-align: center;" class="i18n" data-properties="order-print-time" data-ptype="text"></th>
														<th style="width: 10%;" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
													</tr>
												</thead>

												<tbody>

												</tbody>

											</table>
										</form>
									</div>
								</div>
								<div style="text-align: right;border-top: 1px solid #e5e5e5;">
								      <label class="fl ml20 control-label i18n" data-properties="order-open-time" data-ptype="text"></label> 
								      <div class="fl ml20">
											<span style="white-space: nowrap; color: red;" id="openTime"></span>
									  </div>
				                </div>
							</div>
						</div>

					</div>

				</div>
				<div class="modal-footer"  style="padding: 10px;text-align:center;">
				     <button type="button" class="btn btn-default i18n" data-properties="btn-close" data-ptype="text" data-dismiss="modal"></button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
