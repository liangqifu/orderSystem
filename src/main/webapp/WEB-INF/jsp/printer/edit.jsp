<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
        $(function () {
            
            $('#Form').bootstrapValidator({
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
                var params  = JSON.stringify($form.serializeJSON());
                debugger
                $.ajax({
                    type : "POST",
                    dataType : 'json',
                    url  : $form.attr('action'),
                    data : params,
                    contentType:"application/json",
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg("修改成功:"+result.extend.printer.name, {time:1500, icon:6}, function(){
                            	 window.location.href = "${APP_PATH}/printer/index";
                            });
                        } else {
                            layer.msg("修改失败："+result.msg, {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });
            });
            
            
            $("#goBackBtn").on('click',function(){
            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/printer/index");
            });
            $("#resetBtn").click(function(){
                $("#Form")[0].reset();
            });
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
            var status = '${printer.status}';
            if(status == "0"){
                $("#statusSwitch").bootstrapSwitch('state',true,false);
            }else{
                $("#statusSwitch").bootstrapSwitch('state',false,true);
            }
            
            
            
        
        });


	</script>
<body>

	<div>
		<ol class="breadcrumb">
			<li><a href="${APP_PATH}/admin/main">首页</a></li>
			<li><a href="${APP_PATH}/printer/index">打印机设置</a></li>
			<li class="active">修改</li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-heading">
				打印机详情
				<div style="float: right; cursor: pointer;" data-toggle="modal"
					data-target="#myModal">
					<i class="glyphicon glyphicon-question-sign"></i>
				</div>
			</div>
			<div class="panel-body">
				<form id="Form" class="form-horizontal" action="${APP_PATH}/printer/doEdit">
					<input type="hidden" name="id" value="${printer.id }" />
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">打印机名称:</label> 
						<div class="col-sm-4">
						   <input type="text"
							data-bv-notempty="true" data-bv-notempty-message="不能为空"
							class="form-control" id="name" name="name"
							value="${printer.name }" placeholder="请输入打印机名称">
						</div>
						
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="ip">IP:</label> 
						<div class="col-sm-4">
						  <input type="text"
							class="form-control"  id="ip" name="ip" value="${printer.ip }"
							placeholder="请输入打印机IP">
						</div>
						
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">开关:</label> 
						<div class="col-sm-4">
						  <input id="status" name="status" value="${printer.status}" type="hidden">
						  <input id="statusSwitch" type="checkbox" data-size="small">
						</div>
						
					</div>
					
					<div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
						  <button id="insertBtn" type="submit" class="btn btn-success">
								<i class="glyphicon glyphicon-plus"></i>保存
							</button>
							<button id="resetBtn" type="button" class="btn btn-danger">
								<i class="glyphicon glyphicon-refresh"></i> 重置
							</button>
							<button id="goBackBtn" type="button" class="btn btn-default">
								<i class="glyphicon glyphicon-share-alt"></i> 返回
							</button>
					   </div>
						
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		</div>
	  </div>
	</div> -->

</body>
</html>
