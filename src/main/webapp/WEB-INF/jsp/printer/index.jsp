<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
        var pageNum = 1;
        var pageSize = 10;
        $(function () {
        	bindPrinterForm();
        	bindSwitch();
            queryListByPage();
            $(document).on("click","#addBtn",function(){
            	goAddPage();
            }).on("click","#queryBtn",function(){
            	queryListByPage();
            });    
        });
        
        function queryListByPage( ) {
        	var loadingIndex = null;
        	var params  = {state:"0",pageNum:pageNum,name:$("#queryText").val()};
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/printer/queryListByPage",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                        
                        $("#queryListResult tbody").html(template("tpl-data",data));
                        $("#queryListResult tbody").on('click','.edit',function(){
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
                                $('#printerForm').clearForm(true);
                                bindPrinterForm();
                            });
                        }).on('click','.del',function(){
                        	var params = JSON.parse($(this).attr('item'));
                        	delPrinter(params)
                        });
                        setPage(data.pageNum, data.total,data.pageSize, queryListByPage)
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        	
        }
        
        function setPage(pageCurrent, total,pageSize, callback) {
        	
        	$("#queryListResult .pagination").html('');
        	$("#queryListResult .total").text($.format($.i18n.prop('query-result-total'),total));
        	if(total<1) return;
        	$("#queryListResult .pagination").bootstrapPaginator({
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
       
        function goAddPage() {
        	$("#printerForm").clearForm();
            	//弹出模态框
            $("#printer_modal").modal({
                backdrop:"static"
            }).on('hidden.bs.modal', function() {
                $("#printerForm").data('bootstrapValidator').destroy();
                $('#printerForm').data('bootstrapValidator', null);
                $('#printerForm').clearForm(true);
                bindPrinterForm();
            });
        }
        
        function delPrinter(params) {
        	params.state ='1';
        	layer.confirm($.format($.i18n.prop('layer-confirm-delete-msg'), params.name),  {
        		icon: 3, 
        		title:$.i18n.prop('layer-title'),
        		btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')] 
        		}, function(cindex){
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/printer/update",
                    datatype : 'json',
                    data : JSON.stringify(params),
                    contentType:"application/json",
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg($.i18n.prop('delete-success'), {time:1000, icon:6}, function(){
                            	queryListByPage();
                            });
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

        
        function bindPrinterForm(){
        	$('#printerForm').bootstrapValidator({
            	// 默认的提示消息
                message: 'This value is not valid',
                // 表单框里右侧的icon
                feedbackIcons: {
                  　　　　　　　　valid: 'glyphicon glyphicon-ok',
                  　　　　　　　　invalid: 'glyphicon glyphicon-remove',
                  　　　　　　　　validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                	ip: {
                        message: $.i18n.prop('ip-Invalid'),
                        validators: {
                            notEmpty: {
                                message: $.i18n.prop('notEmpty')
                            },
                            regexp: {
                                regexp: /^(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$/,
                                message:$.i18n.prop('enter-ip')
                            }
                        }
                    }/* ,
                    port: {
                        message: $.i18n.prop('port-Invalid'),
                        validators: {
                            notEmpty: {
                                message:$.i18n.prop('notEmpty')
                            },
                            regexp: {
                                regexp: /^([0-9]|[1-9]\d{1,3}|[1-5]\d{4}|6[0-4]\d{4}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])$/,
                                message: $.i18n.prop('enter-port')
                            }
                        }
                    } */
                }
            }).on('success.form.bv', function(e) {//点击提交之后
                // 终止重复提交
                e.preventDefault();
                // 得到form表单对象
                var $form = $(e.target);
                // 获得bootstrap验证对象
                var bv = $form.data('bootstrapValidator');
                // Use Ajax to submit form data 提交至form标签中的action，result自定义
                var params  = $form.serializeJSON();
                $.ajax({
                    type : "POST",
                    dataType : 'json',
                    url  : $form.attr('action'),
                    data : JSON.stringify(params),
                    contentType:"application/json",
                    success : function(result) {
                        if ( result.code==100 ) {
                        	$("#printer_modal").modal('hide');
                            layer.msg( $.i18n.prop('save-success'), {time:1500, icon:6}, function(){
                            	queryListByPage();
                            });
                        } else {
                            layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });
            });
        }
        
        function bindSwitch(){
        	$('#statusSwitch').bootstrapSwitch({  
                onColor:"success",  
                offColor:"info", 
                onText:$.i18n.prop('printerForm-status-0'),
                offText:$.i18n.prop('printerForm-status-1'),
                size:"small",  
                  onSwitchChange:function(event,state){  
                    if(state==true){  
                    	$("[name='status']").val("0")  
                    }else{  
                    	$("[name='status']").val("1") 
                    }  
                  }  
           
            })
        }
        
        
        
    </script>
    
    <script type="text/html" id="tpl-data">

		{{each list}}

           	<tr>
                <td>{{((pageNum-1)*pageSize)+($index+1)}}</td>
                <td>{{$value.name}}</td>
                <td>{{$value.ip}}</td>
                
                {{if $value.status == '0'}}
                  <td style="color: green">{{convertPrinterStatus($value.status)}}</td>
                {{else}} 
                  <td style="color: red" >{{convertPrinterStatus($value.status)}}</td>
                {{/if}}
                <td>{{convertPrinterOnLine($value.onLine)}}</td>
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
					<i class="glyphicon glyphicon-th i18n" data-properties="printer-setting-title" data-ptype="text"></i>
				</h3>
			</div>
			<div class="panel-body" >
					<form class="form-inline" role="form" style="float: left;">
						<div class="form-group has-feedback">
							<div class="input-group">
								<div class="input-group-addon i18n" data-properties="query-criteria" data-ptype="text" ></div>
								<input id="queryText" class="form-control has-success i18n" data-properties="pleaseEnter" data-ptype="pleaseEnter" type="text" placeholder="">
							</div>
						</div>
						<button id="queryBtn" type="button" class="btn btn-warning">
							<i class="glyphicon glyphicon-search i18n" data-properties="btn-search" data-ptype="text"></i>
						</button>
					</form>
					<button type="button" id="addBtn" class="btn btn-primary"
						style="float: right;">
						<i class="glyphicon glyphicon-plus i18n" data-properties="btn-add" data-ptype="text" ></i>
					</button>
					<br>
					<hr style="clear: both;">
					<div class="table-responsive">
						<form id="queryListResult">
							<table class="table  table-bordered ">
								<thead>
									<tr>
										<th style="width: 5%;text-align: center;" class="i18n" data-properties="thead-serial-number" data-ptype="text"></th>
										<th style="width:20% ;text-align: center;" class="i18n" data-properties="printerForm-name" data-ptype="text"></th>
										<th style="width:20% ;text-align: center;" class="i18n" data-properties="printerForm-ip" data-ptype="text"></th>
										<!-- <th style="width:8% ;text-align: center;" class="i18n" data-properties="printerForm-port" data-ptype="text"></th> -->
										<th style="width:10% ;text-align: center;" class="i18n" data-properties="printerForm-status" data-ptype="text"></th>
										<th style="width:10% ;text-align: center;" class="i18n" data-properties="printerForm-onLine" data-ptype="text"></th>
										<th style="width:15%" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
									</tr>
								</thead>

								<tbody >

								</tbody>

								<tfoot>
									<tr>
										<td colspan="7" align="center">
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
	<div id="printer_modal" style="z-index: 2000;" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" style="width: 48%;">
            <form class="modal-content form-horizontal" id="printerForm" method="post" action="${APP_PATH}/printer/save">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body">
                        <input type="hidden" name="id" id="id" />
                        <input type="hidden" name="state" id="state" />
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label i18n" data-properties="printerForm-name" data-ptype="text" ></label> 
							<div class="col-sm-6">
							   <input autocomplete="off" type="text" data-bv-notempty="true" data-bv-notempty-message=""
								class="form-control i18n" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty" id="name" name="name"  placeholder="">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label i18n" data-properties="printerForm-ip" data-ptype="text" for="ip"></label> 
							<div class="col-sm-6">
							  <input autocomplete="off" type="text" class="form-control i18n"  data-properties="pleaseEnter" data-ptype="placeholder" id="ip" name="ip"  placeholder="">
							</div>
						</div>
						<!-- <div class="form-group">
							<label class="col-sm-3 control-label i18n" data-properties="printerForm-port" data-ptype="text" for="port"></label> 
							<div class="col-sm-6">
							  <input autocomplete="off" type="text" class="form-control i18n"  data-properties="pleaseEnter" data-ptype="placeholder" id="port" name="port"  placeholder="">
							</div>
						</div> -->
						<div class="form-group">
							<label class="col-sm-3 control-label i18n" data-properties="printerForm-status" data-ptype="text" ></label> 
							<div class="col-sm-6">
							  <input id="status" name="status" type="hidden">
							  <input id="statusSwitch" type="checkbox" data-size="small">
							</div>
						</div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary i18n"  data-properties="btn-save" data-ptype="text" id="save_btn">保存</button>
                    <button type="button" class="btn btn-default i18n"  data-properties="btn-close" data-ptype="text" data-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
