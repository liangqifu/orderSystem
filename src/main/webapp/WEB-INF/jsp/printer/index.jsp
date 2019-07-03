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
        	var params  = {state:"0",pageNum:pageNum,pageSize:pageSize,name:$("#queryText").val()};
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/printer/queryListByPage",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
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
                                bindPrinterForm();
                            });;
                        }).on('click','.del',function(){
                        	var params = JSON.parse($(this).attr('item'));
                        	delPrinter(params)
                        });
                        setPage(data.pageNum, data.total, queryListByPage)
                    } else {
                        layer.msg("加载数据失败", {time:2000, icon:5, shift:6}, function(){
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
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "末页";
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
                bindPrinterForm();
            });
        }
        
        function delPrinter(params) {
        	params.state ='1';
        	layer.confirm("删除打印机信息【"+params.name+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/printer/update",
                    data : JSON.stringify(params),
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg("打印机信息删除成功", {time:1000, icon:6}, function(){
                            	queryListByPage();
                            });
                        } else {
                            layer.msg("打印机信息删除失败", {time:2000, icon:5, shift:6}, function(){});
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
                        message: 'ip地址格式不正确',
                        validators: {
                            notEmpty: {
                                message: 'ip地址不能为空'
                            },
                            regexp: {
                                regexp: /^(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.(?:25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$/,
                                message: '请输入正确的IP'
                            }
                        }
                    },
                    port: {
                        message: '端口号格式不正确',
                        validators: {
                            notEmpty: {
                                message: '端口号不能为空'
                            },
                            regexp: {
                                regexp: /^([0-9]|[1-9]\d{1,3}|[1-5]\d{4}|6[0-4]\d{4}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])$/,
                                message: '请输入正确的端口号'
                            }
                        }
                    }
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
                            layer.msg("修改成功:"+result.extend.printer.name, {time:1500, icon:6}, function(){
                            	queryListByPage();
                            });
                        } else {
                            layer.msg("修改失败："+result.msg, {time:2000, icon:5, shift:6}, function(){
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
                <td>{{$value.port}}</td>
                {{if $value.status == '0'}}
                  <td style="color: green">ON</td>
                {{else}} 
                  <td style="color: red" >OFF</td>
                {{/if}}
                <td>{{$value.onLine}}</td>
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
					<i class="glyphicon glyphicon-th"></i> 打印机配置
				</h3>
			</div>
			<div class="panel-body" >
					<form class="form-inline" role="form" style="float: left;">
						<div class="form-group has-feedback">
							<div class="input-group">
								<div class="input-group-addon">查询条件</div>
								<input id="queryText" class="form-control has-success"
									type="text" placeholder="请输入查询条件">
							</div>
						</div>
						<button id="queryBtn" type="button" class="btn btn-warning">
							<i class="glyphicon glyphicon-search"></i> 查询
						</button>
					</form>
					<button type="button" id="addBtn" class="btn btn-primary"
						style="float: right;">
						<i class="glyphicon glyphicon-plus"></i> 新增
					</button>
					<br>
					<hr style="clear: both;">
					<div class="table-responsive">
						<form id="queryListResult">
							<table class="table  table-bordered ">
								<thead>
									<tr>
										<th style="width: 5%;text-align: center;">序号</th>
										<th style="width:20% ;text-align: center;">打印机名称</th>
										<th style="width:20% ;text-align: center;">IP</th>
										<th style="width:8% ;text-align: center;">port</th>
										<th style="width:10% ;text-align: center;">状态</th>
										<th style="width:10% ;text-align: center;">是否在线</th>
										<th style="width:15%">操作</th>
									</tr>
								</thead>

								<tbody >

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
							<label for="name" class="col-sm-3 control-label">打印机名称:</label> 
							<div class="col-sm-6">
							   <input autocomplete="off" type="text" data-bv-notempty="true" data-bv-notempty-message="不能为空"
								class="form-control" id="name" name="name"  placeholder="请输入打印机名称">
							</div>
							
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="ip">IP:</label> 
							<div class="col-sm-6">
							  <input autocomplete="off" type="text" class="form-control"  id="ip" name="ip"  placeholder="请输入打印机IP">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="port">port:</label> 
							<div class="col-sm-6">
							  <input autocomplete="off" type="text" class="form-control"  id="port" name="port"  placeholder="请输入打印机端口号">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">开关:</label> 
							<div class="col-sm-6">
							  <input id="status" name="status" type="hidden">
							  <input id="statusSwitch" type="checkbox" data-size="small">
							</div>
						</div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="save_btn">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
