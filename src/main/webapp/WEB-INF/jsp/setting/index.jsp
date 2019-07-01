<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>

<script type="text/javascript">
var pageNum = 1;
var pageSize = 10;
$(function () {
	queryAreaList();
	bindAreaForm();
	bindSettingForm();
	getSettingInfo();
	
	$("#addAreaBtn").on('click',function(){
		   var data = {
        		id:0,
                name:"",
                pwd:""
        	}
        	$("#area_modal").autofill(data);
         	//弹出模态框
            $("#area_modal").modal({
                backdrop:"static"
            }).on('hidden.bs.modal', function() {
                $("#areaForm").data('bootstrapValidator').destroy();
                $('#areaForm').data('bootstrapValidator', null);
                bindAreaForm();
            });
	});
	
	$("#queryBtn").on('click',function(){
		queryAreaList()
	});
	
});


function getSettingInfo(){
	$.ajax({
        type : "GET",
        dataType : 'json',
        url  : "${APP_PATH}/setting/info",
        cache:false,
        contentType:"application/json",
        success : function(result) {
            if ( result.code == 100 ) {
                var settingInfo = result.extend.settingInfo;
                $("#settingForm").autofill(settingInfo);
                if(settingInfo){
                	$("#id").val(settingInfo.id);
                	$("#appPwd").val(settingInfo.appPwd);
                	$("#lunchNum").slider({
                		tooltip: 'always',
                		value:settingInfo.lunchNum
                	});
                	$("#dinnerNum").slider({
                		tooltip: 'always',
                		value:settingInfo.dinnerNum
                	});
                	$("#waitTime").slider({
                		tooltip: 'always',
                		value:settingInfo.waitTime
                	});
                }else{
                	$("#id").val(0);
                	$("#lunchNum").slider({
                		tooltip: 'always',
                		value:1
                	});
                	$("#dinnerNum").slider({
                		tooltip: 'always',
                		value:1
                	});
                	$("#waitTime").slider({
                		tooltip: 'always',
                		value:1
                	});
                }
                
            } else {
                layer.msg("加载数据失败", {time:2000, icon:5, shift:6}, function(){
                });
            }
        }
    });
}



function queryAreaList() {
	var loadingIndex = null;
	var params  = JSON.stringify({state:"0",pageNum:pageNum,pageSize:pageSize,name:$("#queryText").val()});
	$.ajax({
        type : "POST",
        dataType : 'json',
        url  : "${APP_PATH}/setting/queryAreaList",
        data:params,
        contentType:"application/json",
        beforeSend : function(){
            loadingIndex = layer.msg('处理中', {icon: 16});
        },
        success : function(result) {
            layer.close(loadingIndex);
            if ( result.code == 100 ) {
                var data = result.extend.data || [];
                $("#areaListForm tbody").html(template("tpl-data",data));
                $("#areaListForm tbody").on('click','.edit',function(){
                	var data = {
                		id:$(this).attr('id'),
                        name:$(this).attr('name'),
                        pwd:$(this).attr('pwd')
                	}
                	$("#areaForm").autofill(data);
                 	//弹出模态框
                    $("#area_modal").modal({
                        backdrop:"static"
                    }).on('hidden.bs.modal', function() {
                        $("#areaForm").data('bootstrapValidator').destroy();
                        $('#areaForm').data('bootstrapValidator', null);
                        bindAreaForm();
                    });;
                }).on('click','.del',function(){
                	var params = {state:"1",id:$(this).attr('id'),name:$(this).attr('name')};
                	delArea(params)
                });
                setPage(data.pageNum, data.total, queryAreaList)
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


function delArea(params){
	layer.confirm("删除【"+params.name+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
        // 删除单个角色
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/setting/area/save",
            dataType : 'json',
            data:JSON.stringify(params),
            contentType:"application/json",
            success : function(result) {
                if ( result.code==100 ) {
                    layer.msg(result.extend.msg, {time:2000, icon:6}, function(){});
                    queryAreaList();
                } else {
                    layer.msg(result.extend.msg, {time:2000, icon:5, shift:6}, function(){});
                }
            }
        });
        layer.close(cindex);

    }, function(cindex){
        layer.close(cindex);
    });
}

function bindAreaForm(){
	
	$('#areaForm').bootstrapValidator({
    	// 默认的提示消息
        message: 'This value is not valid',
        // 表单框里右侧的icon
        feedbackIcons: {
          　　　　　　　　valid: 'glyphicon glyphicon-ok',
          　　　　　　　　invalid: 'glyphicon glyphicon-remove',
          　　　　　　　　validating: 'glyphicon glyphicon-refresh'
        }
    }).on('success.form.bv', function(e) {//点击提交之后
        // 终止重复提交
        e.preventDefault();
        // 得到form表单对象
        var $form = $(e.target);
        // 获得bootstrap验证对象
        var bv = $form.data('bootstrapValidator');
        var params  = JSON.stringify($form.serializeJSON());
        $.ajax({
            type : "POST",
            dataType : 'json',
            url  : $form.attr('action'),
            data : params,
            contentType:"application/json",
            success : function(result) {
                if ( result.code==100 ) {
                	$("#area_modal").modal('hide');
                    layer.msg("保存成功:", {time:1500, icon:6}, function(){
                    	queryAreaList();
                    });
                } else {
                    layer.msg("保存失败："+result.msg, {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        });
    });
	
}

function bindSettingForm(){
	
	$('#settingForm').bootstrapValidator({
    	// 默认的提示消息
        message: 'This value is not valid',
        // 表单框里右侧的icon
        feedbackIcons: {
          　　　　　　　　valid: 'glyphicon glyphicon-ok',
          　　　　　　　　invalid: 'glyphicon glyphicon-remove',
          　　　　　　　　validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	adultPrice:{
                validators: {
                    notEmpty: {
                        message: '不能为空'
                    },
                    numeric:{
                    	message: '必须是数值'
                    },
                    regexp: {
                        regexp: /^\d+(\.\d{0,2})?$/,
                        message: '请输入大于0的正数'
                    }
                }
            },
        	childPrice: {
                validators: {
                    notEmpty: {
                        message: '不能为空'
                    },
                    numeric:{
                    	message: '必须是数值'
                    },
                    regexp: {
                        regexp: /^\d+(\.\d{0,2})?$/,
                        message: '请输入大于0的正数'
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
        var params  = JSON.stringify($form.serializeJSON());
        $.ajax({
            type : "POST",
            dataType : 'json',
            url  : $form.attr('action'),
            data : params,
            contentType:"application/json",
            success : function(result) {
                if ( result.code==100 ) {
                    layer.msg("保存成功:", {time:1500, icon:6}, function(){
                    	$("#settingForm").data('bootstrapValidator').destroy();
                        $('#settingForm').data('bootstrapValidator', null);
                        bindSettingForm();
                    });
                } else {
                    layer.msg("保存失败："+result.msg, {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        });
    });
	
}

</script>

<script type="text/html" id="tpl-data">

		{{each list}}
           	<tr>
                <td>{{((pageNum-1)*pageSize)+($index+1)}}</td>
                <td>{{$value.name}}</td>
                <td>{{$value.pwd}}</td>
                <td>
                   <button type="button" id="{{$value.id}}" name="{{$value.name}}" pwd="{{$value.pwd}}" class="btn btn-primary btn-xs edit"><i class=" glyphicon glyphicon-pencil"></i></button>
                   &nbsp;&nbsp;&nbsp;
                   <button type="button" id="{{$value.id}}" name="{{$value.name}}" pwd="{{$value.pwd}}" class="btn btn-danger btn-xs del"><i class=" glyphicon glyphicon-remove"></i></button>
                </td>
            </tr>
		{{/each}}

</script>
<body>
  <div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th"></i> 系统设置
				</h3>
		   </div>
		   <div class="panel-body" >
		        <form id="settingForm" class="form-horizontal" method="post" action="${APP_PATH}/setting/save" >
		            <input type="hidden" id="id" name="id" />
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label" >App 登录密码:</label> 
						<div class="col-sm-4">
					     	<input type="text"
							data-bv-notempty="true" data-bv-notempty-message="不能为空"
							class="form-control" id="appPwd" style="width: 100%;" name="appPwd" placeholder="请输入" autocomplete="off">
						</div>
					</div>
					<div class="form-group">
						<label for="adultPrice" class="col-sm-2 control-label" >每位成年人价格:</label> 
						<div class="col-sm-4">
							<div class="input-group">
						         <span class="input-group-addon">￥</span> 
					     		 <input type="text" class="form-control" id="adultPrice" style="width: 100%;" name="adultPrice" placeholder="请输入" autocomplete="off">
							</div>
						    
						</div>
					</div>
					<div class="form-group">
						<label for="childPrice" class="col-sm-2 control-label" >每位小孩价格:</label> 
						<div class="col-sm-4">
							<div class="input-group">
							    <span class="input-group-addon">￥</span>
					     		<input type="text" class="form-control" id="childPrice" style="width: 100%;" name="childPrice" placeholder="请输入" autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="lunchNum" class="col-sm-2 control-label">每轮午餐能点的数量:</label> 
						<div class="col-sm-4">
						    <input type="text" id="lunchNum" style="width: 100%" name="lunchNum"
						     data-slider-id='lunchNum' 
						     data-slider-min="1" 
						     data-slider-max="50" 
						     data-slider-step="1" 
						     data-slider-value="1"/>
						</div>
						
					</div>
					<div class="form-group">
						<label for="dinnerNum" class="col-sm-2 control-label">每轮晚餐能点的数量:</label> 
						<div class="col-sm-4">
						    <input type="text" id="dinnerNum"  name="dinnerNum" style="width: 100%;"
						     data-slider-id='dinnerNum' 
						     data-slider-min="1" 
						     data-slider-max="50" 
						     data-slider-step="1" 
						     data-slider-value="1"/>
						</div>
						
					</div>
					<div class="form-group">
						<label for="waitTime" class="col-sm-2 control-label">每轮需要等的时间:</label> 
						<div class="col-sm-4">
						    <input type="text" id="waitTime"  name="waitTime" style="width: 100%;"
						     data-slider-id='waitTime' 
						     data-slider-min="1" 
						     data-slider-max="50" 
						     data-slider-step="1" 
						     data-slider-value="1"/>
						</div>
					</div>
					
					<div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
						  <button type="submit" class="btn btn-success ">
							<i class="glyphicon glyphicon-film"></i>保存
						</button>
					   </div>
					</div>
					
				</form>
		   
		   </div>
		   
		 </div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th"></i> 区域设置
				</h3>
			</div>
			<div class="panel-body" >
					<form class="form-inline" role="form" style="float: left;">
						<div class="form-group has-feedback">
							<div class="input-group">
								<div class="input-group-addon">查询条件</div>
								<input id="queryText" autocomplete="off" class="form-control has-success"
									type="text" placeholder="请输入查询条件">
							</div>
						</div>
						<button id="queryBtn" type="button" class="btn btn-warning">
							<i class="glyphicon glyphicon-search"></i> 查询
						</button>
						
					</form>
					<button type="button" id="addAreaBtn" style="float: right;" class="btn btn-primary btn-xs">
						    <i class="glyphicon glyphicon-plus"></i> 新增
					</button>
					<br>
					<hr style="clear: both;">
					<div class="table-responsive">
						<form id="areaListForm">
							<table class="table  table-bordered ">
								<thead>
									<tr>
										<th style="width:1%;text-align: center;">序号</th>
										<th style="width:10% ;text-align: center;">名称</th>
										<th style="width:20% ;text-align: center;">password</th>
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
	
	
	<div id="area_modal" style="z-index: 2000;" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" style="width: 50%;">
            <form class="modal-content form-horizontal" id="areaForm" method="post" action="${APP_PATH}/setting/area/save">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body">
                        <input type="hidden" name="id" id="id">
                        <div class="form-group">
                            <label for="balance_update_input" class="col-sm-4 control-label">区域名称:</label>
                            <div class="col-sm-6">
                                <input type="text" data-bv-notempty="true" data-bv-notempty-message="不能为空" name="name" class="form-control" id="name" placeholder="请输入区域名称" autocomplete="off" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="balance_update_input" class="col-sm-4 control-label">password:</label>
                            <div class="col-sm-6">
                                 <input type="text" data-bv-notempty="true" data-bv-notempty-message="不能为空" name="pwd" class="form-control" id="pwd" placeholder="请输入password" autocomplete="off">
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