<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrapValidator.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<%@include file="/WEB-INF/jsp/common/header.jsp"%>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<%@include file="/WEB-INF/jsp/common/menu.jsp"%>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${APP_PATH}/admin/main">首页</a></li>
				  <li><a href="${APP_PATH}/printer/index">打印机设置</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">打印机详情<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form id="Form"  action="${APP_PATH}/printer/doAdd" >
					<div class="form-group">
						<label for="">打印机名称</label>
						<input type="text" data-bv-notempty="true" data-bv-notempty-message="不能为空"  class="form-control" id="name" name="name" placeholder="请输入打印机名称">
					</div>
					<div class="form-group">
						<label for="">IP</label>
						<input type="text" data-bv-notempty="true" data-bv-notempty-message="不能为空" class="form-control" id="ip" name="ip" placeholder="请输入打印机IP">
					</div>
					<div style="display:block">
						<button id="insertBtn" type="submit" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i>保存</button>
						<button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
					</div>
				</form>
			  </div>
			</div>
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
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/jquery/jquery.serializejson.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script src="${APP_PATH}/bootstrap/language/zh_CN.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
	<script type="text/javascript">
        $(function () {
            $(".list-group-item").click(function () {
                if ($(this).find("ul")) {
                    $(this).toggleClass("tree-closed");
                    if ($(this).hasClass("tree-closed")) {
                        $("ul", this).hide("fast");
                    } else {
                        $("ul", this).show("fast");
                    }
                }
            });
            
            $('#Form').bootstrapValidator({
            	// 默认的提示消息
                message: 'This value is not valid',
                // 表单框里右侧的icon
                feedbackIcons: {
                  　　　　　　　　valid: 'glyphicon glyphicon-ok',
                  　　　　　　　　invalid: 'glyphicon glyphicon-remove',
                  　　　　　　　　validating: 'glyphicon glyphicon-refresh'
                },
            }).on('success.form.bv', function(e) {//点击提交之后
                // 终止重复提交
                e.preventDefault();
                // 得到form表单对象
                var $form = $(e.target);
                // 获得bootstrap验证对象
                var bv = $form.data('bootstrapValidator');
                // Use Ajax to submit form data 提交至form标签中的action，result自定义
                $.ajax({
                    type : "POST",
                    dataType : 'json',
                    url  : $form.attr('action'),
                    data : $form.serializeJSON(),
                    contentType:"application/json",
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg("添加成功:"+result.extend.printer.name, {time:1500, icon:6}, function(){
                            	 window.location.href = "${APP_PATH}/printer/index";
                            });
                        } else {
                            layer.msg("添加失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });
            });
        });

        /**提交表单**/
        /* $("#insertBtn").click(function(){
            var name =$("#name").val();
            if (name ==""){
                layer.msg("打印机名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                return;
			}
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/printer/doAdd",
                data : { parentId:${category.parentId},name : categoryName },
                success : function(result) {
                    if ( result.code==100 ) {
                        layer.msg("商品类型添加成功:"+result.extend.category.name, {time:1500, icon:6}, function(){
                        	 window.location.href = "${APP_PATH}/category/index";
                        });
                    } else {
                        layer.msg("商品类型添加失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });

        }); */

	</script>
  </body>
</html>
