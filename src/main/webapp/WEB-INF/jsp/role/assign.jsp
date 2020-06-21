<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>

<script type="text/javascript">
	$(function() {

		var setting = {
			check : {
				enable : true,
				chkboxType :{ "Y" : "s", "N" : "s" }
			},
			async : {
				enable : true,
				url : "${APP_PATH}/permission/loadAssignData?roleid=${param.id}",
				autoParam : [ "id", "name=n", "level=lv" ]
			},
			view : {
				selectedMulti : false,
				addDiyDom : function(treeId, treeNode) {
					var icoObj = $("#" + treeNode.tId + "_ico"); 
					if (treeNode.icon) {
						icoObj.removeClass("button ico_docu ico_open")
								.addClass(treeNode.icon).css("background", "");
					}

				}
			}
		};

		$.fn.zTree.init($("#permissionTree"), setting);
		
		$("#goBackBtn").on('click',function(){
			$('#mainIframe', parent.document).attr('src',"${APP_PATH}/role/index")
		});
	});
	function doAssign() {
		var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
		var nodes = treeObj.getCheckedNodes(true);
		if (nodes.length == 0) {
			layer.msg("请选择需要分配的许可信息", {
				time : 2000,
				icon : 5,
				shift : 6
			}, function() {

			});
		} else {
			var d = "roleId=${param.id}";
			var permissionIds = [];
			$.each(nodes, function(i, node) {
				permissionIds.push( node.id);
			});
			$.ajax({
				url : "${APP_PATH}/role/doAssign",
				data : d,
				type : 'POST',
				async : false,
				datatype : 'json',
				data : JSON.stringify({
					"roleId" : ${param.id},
					"permissionIds":permissionIds
				}),
				contentType:"application/json",
				success : function(result) {
					if (result) {
						layer.msg("分配许可信息成功", {
							time : 2000,
							icon : 6
						}, function() {

						});
					} else {
						layer.msg("分配许可信息失败", {
							time : 2000,
							icon : 5,
							shift : 6
						}, function() {

						});
					}
				}
			});
		}
	}
</script>

<body>
	<div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th"></i>【${role.name}】许可数据
				</h3>
			</div>
			<div class="panel-body">
				<button class="btn btn-success" onclick="doAssign()">分配许可</button>
				<ul id="permissionTree" class="ztree"></ul>
				
				<div style="display: block">
						<button id="goBackBtn" type="button" class="btn btn-default">
							<i class="glyphicon glyphicon-share-alt"></i> 返回
						</button>
					</div>
			</div>
		</div>
	</div>
</body>
</html>
