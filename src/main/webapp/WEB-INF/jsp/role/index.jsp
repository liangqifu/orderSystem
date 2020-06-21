<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
            var likeflg = false;
            $(function () {
			   
			    
			    pageQuery(1);
			    
			    $("#queryBtn").click(function(){
			    	var queryText = $("#queryText").val();
			    	if ( queryText == "" ) {
			    		likeflg = false;
			    	} else {
			    		likeflg = true;
			    	}
			    	
			    	pageQuery(1);
			    });
			    
			    $("#allSelBox").click(function(){
			    	var flg = this.checked;
			    	$("#roleData :checkbox").each(function(){
			    		this.checked = flg;
			    	});
			    });
			    
			    $("#addBtn").on('click',function(){
			    	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/role/add")
			    });
            });
            
            // 分页查询
            function pageQuery( pageno ) {
            	var loadingIndex = null;
            	
            	var jsonData = {"pageno" : pageno, "pagesize" : 10};
            	if ( likeflg == true ) {
            		jsonData.queryText = $("#queryText").val();
            	}
            	
            	$.ajax({
					url : "${APP_PATH}/role/pageQuery",
					type : 'POST',
					async : false,
					datatype : 'json',
					data : JSON.stringify(jsonData),
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
                            var roles=result.extend.pageInfo.list;
            				$.each(roles, function(i, role){
            	                tableContent += '<tr>';
	          	                tableContent += '  <td>'+(i+1)+'</td>';
	          					tableContent += '  <td><input type="checkbox" name="roleId" value="'+role.id+'" class="check_item"></td>';
	          	                tableContent += '  <td>'+role.name+'</td>';
	          	                tableContent += '  <td>';
	          					tableContent += '      <button type="button" onclick="goAssignPage('+role.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
	          					tableContent += '      <button type="button" onclick="goUpdatePage('+role.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
	          					tableContent += '	  <button type="button" onclick="deleteRole('+role.id+', \''+role.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
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

            				$("#roleData").html(tableContent);
            				$(".pagination").html(pageContent);
            			} else {
                            layer.msg("角色信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                            	
                            });
            			}
            		}
            	});
            }
            
            function goAssignPage(id) {
            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/role/assign?id="+id);
            }
            function goUpdatePage(id) {
            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/role/edit?id="+id);
            }
            /***批量删除角色***/
            function deleteRoles() {
                var checkedlength = $(".check_item:checked").length;
                if ( checkedlength == 0 ) {
                    layer.msg("请选择需要删除的角色", {time:2000, icon:5, shift:6}, function(){});
                } else {
                    layer.confirm("确认删除已选择的角色, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                        // 删除已选择的角色
                        $.ajax({
                            type : "POST",
                            url  : "${APP_PATH}/role/deletes",
                            data : $("#roleForm").serialize(),
                            success : function(result) {
                                if ( result.code ==100 ) {
                                    layer.msg("角色删除成功", {time:2000, icon:6}, function(){});
                                    pageQuery(1);
                                } else {
                                    layer.msg("角色删除失败", {time:2000, icon:5, shift:6}, function(){});
                                }
                            }
                        });

                        layer.close(cindex);
                    }, function(cindex){
                        layer.close(cindex);
                    });
                }
            }
            function deleteRole( id, name ) {
                layer.confirm("删除角色【"+name+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                    // 删除单个角色
                    $.ajax({
                        type : "POST",
                        url  : "${APP_PATH}/role/deletes",
                        data : "roleId="+id,
                        success : function(result) {
                            if ( result.code==100 ) {
                                layer.msg("角色删除成功", {time:2000, icon:6}, function(){});
                                pageQuery(1);
                            } else {
                                layer.msg("角色删除失败", {time:2000, icon:5, shift:6}, function(){});
                            }
                        }
                    });
                    layer.close(cindex);
                }, function(cindex){
                    layer.close(cindex);
                });
            }
        </script>
<body>

	<div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th"></i>角色数据
				</h3>
			</div>
			<div class="panel-body">
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
				<button type="button" class="btn btn-danger" onclick="deleteRoles()"
					style="float: right; margin-left: 10px;">
					<i class=" glyphicon glyphicon-remove"></i> 删除
				</button>
				<button type="button" id="addBtn" class="btn btn-primary" style="float: right;" >
					<i class="glyphicon glyphicon-plus"></i> 新增
				</button>
				<br>
				<hr style="clear: both;">
				<div class="table-responsive">
					<form id="roleForm">
						<table class="table  table-bordered">
							<thead>
								<tr>
									<th width="30">#</th>
									<th width="30"><input type="checkbox" id="allSelBox"></th>
									<th>名称</th>
									<th width="100">操作</th>
								</tr>
							</thead>

							<tbody id="roleData">

							</tbody>

							<tfoot>
								<tr>
									<td colspan="6" align="center">
										<ul class="pagination">

										</ul>
									</td>
								</tr>

							</tfoot>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

	
</body>
</html>
