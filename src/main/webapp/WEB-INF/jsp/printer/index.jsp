<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
<link rel="stylesheet" href="${APP_PATH}/css/main.css">
<link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
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
								<form id="categoryForm">
									<table class="table  table-bordered ">
										<thead>
											<tr>
												<th style="width: 5%;text-align: center;">序号</th>
												<th style="width:30% ;text-align: center;">打印机名称</th>
												<th style="width:20% ;text-align: center;">IP</th>
												<th style="width:10% ;text-align: center;">状态</th>
												<th style="width:10% ;text-align: center;">是否在线</th>
												<th style="width:15%">操作</th>
											</tr>
										</thead>
	
										<tbody id="data">
	
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
		</div>
	</div>
	<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
	<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
	<script type="text/javascript">
        var searchFlag = false;
        $(function () {
            
            /**分页查询**/
            pageQuery(1);

            /**为查询按钮添加点击事件,判断内容是否为空，进行模糊查询**/
            $("#queryBtn").click(function(){
                var queryText = $("#queryText").val();
                if ( queryText == "" ) {
                    searchFlag = false;
                } else {
                    searchFlag = true;
                }
                pageQuery(1);
            });
            $(document).on("click","#addBtn",function(){
            	goAddPage();
            });    
            
        });
        
        /***分页查询构建表格***/
        function pageQuery( pageno ) {
            var loadingIndex = null;
            var parentId = $("#queryBtn").attr("parentId");
            var jsonData = {"pageno" : pageno,"parentId":parentId};
            if ( searchFlag == true ) {
                jsonData.queryText = $("#queryText").val();
            }

            $.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/printer/pagedGetAll",
                data : jsonData,
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code==100 ) {
                        // 局部刷新页面数据
                        var tableContent = "";
                        var pageContent = "";
                        var pages =result.extend.pageInfo.pages;
                        var list=result.extend.pageInfo.list;
                        $.each(list, function(i, item){
                            tableContent += '<tr>';
                            tableContent += '  <td>'+item.rowNo+'</td>';
                            tableContent += '  <td>'+item.name+'</td>';
                            tableContent += '  <td>'+item.ip+'</td>';
                            tableContent += '  <td>'+item.status+'</td>';
                            tableContent += '  <td>'+item.onLine+'</td>';
                            tableContent += '  <td>';
                            tableContent += '     <button type="button" onclick="goUpdatePage('+item.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                            tableContent += '	  &nbsp;&nbsp;&nbsp;<button type="button" onclick="deleteById('+item.id+', \''+item.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                            tableContent += '  </td>';
                            tableContent += '</tr>';
                        });

                        if ( pageno > 1 ) {
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                        }

                        for ( var i = 1; i <= pages; i++ ) {
                            if ( i == pageno ) {
                                pageContent += '<li class="active"><a  href="#">'+i+'</a></li>';
                            } else {
                                pageContent += '<li ><a href="#" onclick="pageQuery('+i+')">'+i+'</a></li>';
                            }
                        }

                        if ( pageno < pages ) {
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                        }

                        $("#data").html(tableContent);
                        $(".pagination").html(pageContent);
                    } else {
                        layer.msg("查询失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }
        /**跳转到商品类别修改页**/
        function goUpdatePage(id,name) {
            window.location.href = "${APP_PATH}/printer/edit?id="+id;
        }
        function goAddPage() {
            window.location.href = "${APP_PATH}/printer/add";
        }
        
        /**删除单个商品类别信息**/
        function deleteById( id, name ) {
            if(!isHaveUse(id)){
                layer.confirm("删除打印机信息【"+name+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                    $.ajax({
                        type : "POST",
                        url  : "${APP_PATH}/printer/deleteOne",
                        data : { id : id },
                        success : function(result) {
                            if ( result.code==100 ) {
                                layer.msg("打印机信息删除成功", {time:1000, icon:6}, function(){
                                	pageQuery(1);
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
        }

        function isHaveUse(id) {
            var flag;
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/printer/isHaveUse",
                data : { id : id },
                async: false,
                success : function(result) {
                    if ( result.code ==100 ) {
                        layer.msg("改打印机正在使用中，不能删除", {time:1000, icon:7}, function(){});
                        flag =true;
                    }else {
                        flag=false;
                    }
                }
            });
            return flag;
        }
    </script>
</body>
</html>
