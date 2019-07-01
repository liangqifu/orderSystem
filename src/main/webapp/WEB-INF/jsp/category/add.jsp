<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
        $(function () {
        	/**提交表单**/
            $("#insertBtn").click(function(){
                var categoryName =$("#name").val();
                if (categoryName ==""){
                    layer.msg("商品类型名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                    return;
    			}
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/category/doAdd",
                    data : { parentId:${category.parentId},name : categoryName },
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg("商品类型添加成功:"+result.extend.category.name, {time:1500, icon:6}, function(){
                            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/category/index"); 
                            });
                        } else {
                            layer.msg("商品类型添加失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });

            });
        	
            $("#goBackBtn").on('click',function(){
            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/category/index");
            });
            
            $("#resetBtn").click(function(){
                $("#categoryForm")[0].reset();
            });
        	
            
        });

        

        /**表单数据是否为空验证**/
        function checkFrom(){
            ///检查商品名称
			if($("#name").val()==""){
			    return "商品名称不能为空";
			}
            return "success";
		}
	</script>
<body>
	<div>
		<ol class="breadcrumb">
			<li><a href="${APP_PATH}/category/index">商品类别数据</a></li>
			<li class="active">新增</li>
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
				<form id="categoryForm" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="exampleInputPassword1">商品类别</label> <input type="text"
							class="form-control" id="name" name="name"
							placeholder="请输入商品类别名称">
					</div>
					<div style="display: block">
						<button id="insertBtn" type="button" class="btn btn-success">
							<i class="glyphicon glyphicon-plus"></i> 新增
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
