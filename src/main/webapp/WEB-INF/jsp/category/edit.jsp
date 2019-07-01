<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
        $(function () {
        	
        	$("#resetBtn").click(function(){
                $("#categoryForm")[0].reset();
            });
        	 $("#goBackBtn").on('click',function(){
             	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/category/index");
             });

            $("#updateFormBtn").click(function () {
                var categoryName =$("#name").val();
                if (categoryName ==""){
                    layer.msg("商品类型名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                    return;
                }
                
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/category/doEdit",
                    data : {id:${category.id},parentId:${category.parentId},name:categoryName},
                    beforeSend : function(){
                        loadingIndex = layer.msg('处理中', {icon: 16});
                    },
                    success : function(result) {
                        layer.close(loadingIndex);
                        if ( result.code==100 ) {
                            layer.msg("商品类别信息修改成功", {time:1000, icon:6}, function(){
                                $('#mainIframe', parent.document).attr('src',"${APP_PATH}/category/index");
    						});
                        } else {
                            layer.msg("商品类别信息修改失败", {time:2000, icon:5, shift:6}, function(){});
                        }
                    }
                });
            });
        });
        
	</script>
<body>

	<div>
		<ol class="breadcrumb">
			<li><a href="${APP_PATH}/category/index">商品类别数据</a></li>
			<li class="active">修改</li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-heading">
				类别详情
				<div style="float: right; cursor: pointer;" data-toggle="modal"
					data-target="#myModal">
					<i class="glyphicon glyphicon-question-sign"></i>
				</div>
			</div>
			<div class="panel-body">
				<form id="categoryForm">
					<div class="form-group">
						<label>商品类别</label> <input type="text" class="form-control"
							id="name" name="name" value="${category.name}"
							placeholder="请输入商品名称">
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
