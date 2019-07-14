<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>

<script type="text/javascript">
var pageNum = 1;
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
                $('#areaForm').clearForm(true);
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
                $("#settingForm #servicePrinterId").selectpicker({
                    noneSelectedText : $.i18n.prop('bootstrap-select-noneSelectedText')   
                });
                loadPinterdata({status:"0",state:"0"});
                if(settingInfo){
                	if(settingInfo.servicePrinterId){
                		$("#settingForm #servicePrinterId").selectpicker('val', settingInfo.servicePrinterId);
                	}
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
                layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                });
            }
        }
    });
}



function queryAreaList() {
	var loadingIndex = null;
	var params  = JSON.stringify({state:"0",pageNum:pageNum,name:$("#queryText").val()});
	$.ajax({
        type : "POST",
        dataType : 'json',
        url  : "${APP_PATH}/setting/queryAreaList",
        data:params,
        contentType:"application/json",
        beforeSend : function(){
            loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
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
                        $('#areaForm').clearForm(true);
                        bindAreaForm();
                    });
                }).on('click','.del',function(){
                	var params = {state:"1",id:$(this).attr('id'),name:$(this).attr('name')};
                	delArea(params)
                });
                setPage(data.pageNum, data.total, data.pageSize,queryAreaList)
            } else {
                layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                });
            }
        }
    });
}

function setPage(pageCurrent, total,pageSize, callback) {
	$("#areaListForm .pagination").html('');
	$("#areaListForm .total").text($.format($.i18n.prop('query-result-total'),total));
	if(total<1) return;
	$("#areaListForm .pagination").bootstrapPaginator({
        //设置版本号
        bootstrapMajorVersion: 3,
        // 显示第几页
        currentPage: pageCurrent,
        numberOfPages: 5,
        // 总页数
        total: total,
        pageSize:pageSize,
        size:"mini",
        alignment:"center",
        itemTexts: function (type, page, current) {//设置显示的样式，默认是箭头
            switch (type) {
                case "first":
                    return $.i18n.prop('bootstrap-paginator-first');
                case "prev":
                    return $.i18n.prop('bootstrap-paginator-prev');
                case "next":
                    return $.i18n.prop('bootstrap-paginator-next');
                case "last":
                    return $.i18n.prop('bootstrap-paginator-last');
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
	layer.confirm($.format($.i18n.prop('layer-confirm-delete-msg'), params.name),  {
		icon: 3, 
		title:$.i18n.prop('layer-title'),
		btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')] 
		}, function(cindex){
        // 删除单个角色
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/setting/area/save",
            dataType : 'json',
            data:JSON.stringify(params),
            contentType:"application/json",
            success : function(result) {
                if ( result.code==100 ) {
                    layer.msg($.i18n.prop('delete-success'), {time:2000, icon:6}, function(){});
                    queryAreaList();
                } else {
                    layer.msg($.i18n.prop('delete-fail'), {time:2000, icon:5, shift:6}, function(){});
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
                    layer.msg($.i18n.prop('save-success'), {time:1500, icon:6}, function(){
                    	queryAreaList();
                    });
                } else {
                    layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        });
    });
	
}

function loadPinterdata(params){
    $.ajax({
         url : "${APP_PATH}/printer/getList",  
         type : 'POST',
         async : false,
         datatype : 'json',
         data : JSON.stringify(params),
         contentType:"application/json",
         success : function(result) {
        	 
        	 if ( result.code==100 ) {
        		 var data = result.extend.data || [];
        		 var options = [];
        		 for(var i=0;i<data.length;i++){
                     var item = data[i];
　　　　　　　　　       　options.push('<option value="'+item.id+'">'+item.name+'</option>') 
                 }
                 $("#settingForm #servicePrinterId").html(options.join(' ')); 
        		 $("#settingForm #servicePrinterId").selectpicker('refresh');
             } else {
                 layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                 });
             }
         },
         error : function() {
        	 layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
             });
         }
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
        	adultLunchPrice:{
                validators: {
                    notEmpty: {
                        message: $.i18n.prop('notempty')
                    },
                    numeric:{
                    	message: $.i18n.prop('numeric')
                    },
                    regexp: {
                        regexp: /^\d+(\.\d{0,2})?$/,
                        message: $.i18n.prop('number-greater-than-0')
                    }
                }
            },
            adultDinnerPrice:{
                validators: {
                    notEmpty: {
                        message: $.i18n.prop('notempty')
                    },
                    numeric:{
                    	message: $.i18n.prop('numeric')
                    },
                    regexp: {
                        regexp: /^\d+(\.\d{0,2})?$/,
                        message: $.i18n.prop('number-greater-than-0')
                    }
                }
            },
        	childLunchPrice: {
                validators: {
                    notEmpty: {
                        message: $.i18n.prop('notempty')
                    },
                    numeric:{
                    	message: $.i18n.prop('numeric')
                    },
                    regexp: {
                        regexp: /^\d+(\.\d{0,2})?$/,
                        message: $.i18n.prop('number-greater-than-0')
                    }
                }
            },
            childDinnerPrice: {
                validators: {
                    notEmpty: {
                        message: $.i18n.prop('notempty')
                    },
                    numeric:{
                    	message: $.i18n.prop('numeric')
                    },
                    regexp: {
                        regexp: /^\d+(\.\d{0,2})?$/,
                        message: $.i18n.prop('number-greater-than-0')
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
                    layer.msg($.i18n.prop('save-success'), {time:1500, icon:6}, function(){
                    	$("#settingForm").data('bootstrapValidator').destroy();
                        $('#settingForm').data('bootstrapValidator', null);
                        bindSettingForm();
                    });
                } else {
                    layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
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
					<i class="glyphicon glyphicon-th i18n" data-properties="setting-panel-title" data-ptype="text" ></i> 
				</h3>
		   </div>
		   <div class="panel-body" >
		        <form id="settingForm" class="form-horizontal" method="post" action="${APP_PATH}/setting/save" >
		            <input type="hidden" id="id" name="id" />
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label i18n" data-properties="settingForm-appPwd" data-ptype="text" ></label> 
						<div class="col-sm-4">
					     	<input type="text"
							data-bv-notempty="true" data-bv-notempty-message=""
							class="form-control i18n" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty" id="appPwd" style="width: 100%;" name="appPwd" placeholder="" autocomplete="off">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label i18n" data-properties="settingForm-ctlAppPwd" data-ptype="text"></label> 
						<div class="col-sm-4">
					     	<input type="text"
							data-bv-notempty="true" data-bv-notempty-message=""
							class="form-control i18n" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty"  id="ctlAppPwd" style="width: 100%;" name="ctlAppPwd" placeholder="" autocomplete="off">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label i18n" data-properties="settingForm-adultLunchPrice" data-ptype="text"></label> 
						<div class="col-sm-4">
							<div class="input-group">
						         <span class="input-group-addon i18n" data-properties="settingForm-lunchPrice-span" data-ptype="text"></span> 
					     		 <input type="text" class="form-control i18n"  data-properties="pleaseEnter" data-ptype="placeholder" id="adultLunchPrice" style="width: 100%;" name="adultLunchPrice" placeholder="" autocomplete="off">
							</div>
							<div class="input-group">
						         <span class="input-group-addon i18n" data-properties="settingForm-dinnerPrice-span" data-ptype="text"></span> 
					     		 <input type="text" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder" id="adultDinnerPrice" style="width: 100%;" name="adultDinnerPrice" placeholder="" autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label i18n" data-properties="settingForm-childLunchPrice" data-ptype="text" ></label> 
						<div class="col-sm-4">
							<div class="input-group">
							    <span class="input-group-addon i18n" data-properties="settingForm-lunchPrice-span" data-ptype="text"></span>
					     		<input type="text" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder" id="childLunchPrice" style="width: 100%;" name="childLunchPrice" placeholder="" autocomplete="off">
							</div>
							<div class="input-group">
							    <span class="input-group-addon i18n" data-properties="settingForm-dinnerPrice-span" data-ptype="text"></span>
					     		<input type="text" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder" id="childDinnerPrice" style="width: 100%;" name="childDinnerPrice" placeholder="" autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="lunchNum" class="col-sm-2 control-label i18n" data-properties="settingForm-lunchNum" data-ptype="text"></label> 
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
						<label for="dinnerNum" class="col-sm-2 control-label i18n" data-properties="settingForm-dinnerNum" data-ptype="text" ></label> 
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
						<label for="waitTime" class="col-sm-2 control-label i18n" data-properties="settingForm-waitTime" data-ptype="text" ></label> 
						<div class="col-sm-4">
						    <input type="text" id="waitTime"  name="waitTime" style="width: 100%;"
						     data-slider-id='waitTime' 
						     data-slider-min="1" 
						     data-slider-max="50" 
						     data-slider-step="1" 
						     data-slider-value="1"/>
						</div>
					</div>
					
					<!-- <div class="form-group">
                            <label for="servicePrinterId" class="col-sm-2 control-label">服务台打印机:</label>
                            <div class="col-sm-4">
                                <select data-size="6" id="servicePrinterId" name="servicePrinterId" class="form-control selectpicker"></select>
                            </div>
                     </div> -->
					
					<div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
						  <button type="submit" class="btn btn-success ">
							<i class="glyphicon glyphicon-film i18n" data-properties="btn-save" data-ptype="text"></i>
						  </button>
					   </div>
					</div>
					
				</form>
		   
		   </div>
		   
		 </div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th i18n"  data-properties="area-setting-title" data-ptype="text"></i> 
				</h3>
			</div>
			<div class="panel-body" >
					<form class="form-inline" role="form" style="float: left;">
						<div class="form-group has-feedback">
							<div class="input-group">
								<div class="input-group-addon i18n" data-properties="query-criteria" data-ptype="text" ></div>
								<input id="queryText" autocomplete="off" class="form-control has-success i18n" data-properties="pleaseEnter" data-ptype="placeholder" type="text" placeholder="">
							</div>
						</div>
						<button id="queryBtn" type="button" class="btn btn-warning">
							<i class="glyphicon glyphicon-search i18n" data-properties="btn-search" data-ptype="text"></i> 
						</button>
						
					</form>
					<button type="button" id="addAreaBtn" style="float: right;" class="btn btn-primary btn-xs">
						    <i class="glyphicon glyphicon-plus i18n" data-properties="btn-add" data-ptype="text" ></i>
					</button>
					<br>
					<hr style="clear: both;">
					<div class="table-responsive">
						<form id="areaListForm">
							<table class="table  table-bordered ">
								<thead>
									<tr>
										<th style="width:1%;text-align: center;" class="i18n" data-properties="thead-serial-number" data-ptype="text"></th>
										<th style="width:10% ;text-align: center;" class="i18n" data-properties="thead-name" data-ptype="text"></th>
										<!-- <th style="width:20% ;text-align: center;">password</th> -->
										<th style="width:15%" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
									</tr>
								</thead>

								<tbody id="data">

								</tbody>

								<tfoot>
									<tr>
										<td colspan="3" align="center">
											<ul class="pagination"></ul>
											<span class="total"></span>
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
                            <label for="name" class="col-sm-4 control-label i18n" data-properties="areaForm-name" data-ptype="text"></label>
                            <div class="col-sm-6">
                                <input type="text" data-bv-notempty="true" data-bv-notempty-message="" name="name" class="form-control" id="name" placeholder="" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty" autocomplete="off" >
                            </div>
                        </div>
                        <!-- <div class="form-group">
                            <label for="pwd" class="col-sm-4 control-label">password:</label>
                            <div class="col-sm-6">
                                 <input type="text" data-bv-notempty="true" data-bv-notempty-message="不能为空" name="pwd" class="form-control" id="pwd" placeholder="请输入password" autocomplete="off">
                            </div>
                        </div> -->
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary i18n"  data-properties="btn-save" data-ptype="text" id="save_btn"></button>
                    <button type="button" class="btn btn-default i18n" data-properties="btn-close" data-ptype="text" data-dismiss="modal"></button>
                </div>
            </form>
        </div>
    </div>
	
</body>

</html>