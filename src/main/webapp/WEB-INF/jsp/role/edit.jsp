<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
        $(function () {
        	$("#resetBtn").click(function(){
                $("#roleForm")[0].reset();
            });
        	
        	$("#goBackBtn").click(function() {
    			$('#mainIframe', parent.document).attr('src',"${APP_PATH}/role/index")
    		});

            /**校验用户账户的唯一性**/
            $("#name").change(function () {
                var name = this.value;
                $.ajax({
                    url:"${APP_PATH}/role/uniqueName",
                    type:"POST",
                    data:{"name":name},
                    success:function (result) {
                        if(100 == result.code){
                            show_validate_msg("#name","success","可用");
                            $("#updateFormBtn").attr("ajax-va","success");
                            return true;
                        }else {
                            show_validate_msg("#name","error",result.extend.va_msg);
                            $("#updateFormBtn").attr("ajax-va","error");
                        }
                    }
                })
            });
            
            $("#updateFormBtn").click(function () {
                if("error" == $(this).attr("ajax-va")){
                    return false;
                }
                var roleName =$("#name").val();
                if (roleName ==""){
                    layer.msg("商品类型名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                    return;
                }
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/role/doEdit",
                    data : {id:${role.id},name:roleName},
                    beforeSend : function(){
                        loadingIndex = layer.msg('处理中', {icon: 16});
                    },
                    success : function(result) {
                        console.log(result);
                        layer.close(loadingIndex);
                        if (result.code==100 ) {
                            layer.msg("角色信息修改成功", {time:1000, icon:6}, function(){
                            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/role/index")
    						});
                        } else {
                            layer.msg("角色信息修改失败", {time:2000, icon:5, shift:6}, function(){});
                        }
                    }
                });
            });
        });
        
        /**显示校验结果的提示信息**/
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }
        
	</script>
<body>

	<div>
		<ol class="breadcrumb">
			<li><a href="${APP_PATH}/role/index">角色数据</a></li>
			<li class="active">修改</li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-heading">
				表单数据
				<div style="float: right; cursor: pointer;" data-toggle="modal"
					data-target="#myModal"></div>
			</div>
			<div class="panel-body">
				<form id="roleForm">
					<div class="form-group">
						<label>角色</label> <input type="text" class="form-control"
							id="name" name="name" value="${role.name}" placeholder="请输入角色名称">
						<span class="help-block"></span>
					</div>
					<div style="display: block">
						<button id="updateFormBtn" type="button" class="btn btn-success">
							<i class="glyphicon glyphicon-pencil"></i> 修改
						</button>
						<button id="resetBtn" type="button" class="btn btn-danger">
							<i class="glyphicon glyphicon-refresh"></i> 重置
						</button>
						<button id="goBackBtn" type="button" class="btn btn-default">
							<i class="glyphicon glyphicon-share-alt"></i> 返回
						</button>
					</div>
				</form>

			</div>
		</div>
	</div>

</body>
</html>
