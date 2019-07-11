<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
        var pageNum = 1;
        var pageSize = 10;
        var options={};
    	
        $(function () {
        	debugger
        	var language = localStorage.currentLang;
        	if(!language || language == ''){
        		language = "zh_CN";
        	}
        	options = {
        			language: language,
            		dropZoneTitle:$.i18n.prop('fileinput-dropZoneTitle'),
            		dropZoneClickTitle:$.i18n.prop('fileinput-dropZoneClickTitle'),
            		uploadUrl: '#',
            		allowedFileExtensions: ['jpg','jpeg','gif','png'],
            		showUpload: false,
            		showRemove: false,
            		showPreview: true,
            		showCaption:false,
            		showBrowse:false,
            		hideThumbnailContent:false,
            		dropZoneEnabled: true,
            		browseOnZoneClick:true,
            		autoReplace:true,
            		maxFileSize: 1024,
            		minFileCount: 1,
            		maxFileCount: 1,
            		allowedPreviewTypes: ['image'],
                    fileActionSettings:{
                    	showRemove:true,
                    	showUpload:false,   
                    	showDrag:false,
                    	showZoom:false
                    },
                    msgFilesTooMany: $.i18n.prop('fileinput-msgFilesTooMany'),
                    overwriteInitial:false,
        	};
        	$(".selectpicker").selectpicker({
                noneSelectedText : $.i18n.prop('bootstrap-select-noneSelectedText')
            });
        	loadPinterdata({status:"0",state:"0"});
            loadCategoryTree();
            bindCategoryForm();
            bindPictureFileInput(options);
            /**为查询按钮添加点击事件,判断内容是否为空，进行模糊查询**/
            $("#queryBtn").click(function(){
            	pageQuery();
            });

            /***为总单选按钮添加check 选择则全部选中**/
            $("#allSelBox").click(function(){
                var flg = this.checked;
                $("#categoryData :checkbox").each(function(){
                    this.checked = flg;
                });
            });

            /**为单个check_item添加点击事件**/
            $(document).on("click",".check_item",function(){
                //判断当前选择中的元素是否全选，如果是则选中总标签
                var flag = $(".check_item:checked").length==$(".check_item").length;
                $("#allSelBox").prop("checked",flag);
            }).on("click","#addBtn",function(){
            	
            	goAddPage();
            });
            
            
        });
        var selectedNode = null;
        var setting = {
        		check: {
        			enable: false,
        			dblClickExpand: false
        		},callback: {
        			onClick: function(e,treeId, treeNode) {
                        $("#queryBtn").attr("parentId",treeNode.id);
                        selectedNode = treeNode;
                        pageQuery();
                    }
        		},
                data:{
                	simpleData: {
        				enable: true,
        				idKey : "id",
        				pidKey : "pId"
        			}
                },
                async : {
                    enable : true,
                    url : "${APP_PATH}/category/getTreeListAll",
                    autoParam : [ "id" ],
                }
        };
        var treeObj = null;
        function loadCategoryTree(){
        	$.ajax({
		            url:"${APP_PATH}/category/getTreeListAll",
					type:"GET",
					dataType:"json",
					success:function(data, textStatus){	
						treeObj =$.fn.zTree.init($("#categoryTree"), setting, data);
						if(!selectedNode){
							var selectedNodes = treeObj.getSelectedNodes();
							selectedNode = treeObj.getNodeByParam('id', "0");
						}
	                    treeObj.selectNode(selectedNode);
	                    treeObj.setting.callback.onClick(null, treeObj.setting.treeId, selectedNode);//调用事件 
						
					},
					error:function(){
						
					}
       		});
        }

        /***分页查询构建表格***/
        function pageQuery() {
        	var loadingIndex = null;
        	var params = {
        			state:"0",
        			pageNum:pageNum,
        			pageSize:pageSize,
        			name:$("#queryText").val(),
        			parentId:$("#queryBtn").attr("parentId")
        		};
        	
        	$.ajax({
                type : "POST",
                dataType : 'json',
                url  : "${APP_PATH}/category/queryListByPage",
                data:JSON.stringify(params),
                contentType:"application/json",
                beforeSend : function(){
                    loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.code == 100 ) {
                        var data = result.extend.data || [];
                        $("#categoryListForm tbody").html(template("tpl-data",$.extend(data, {imgPath:result.extend.imgPath})));
                        $("#categoryListForm tbody").on('click','.edit',function(){
                        	var data = JSON.parse($(this).attr('item'));
                        	var imgPath = $(this).attr('imgPath');
                        	var previewData = {};
                        	if(data.pic){
                        		previewData ={
                        				initialPreviewFileType: 'image',
                        	            initialPreviewAsData:true,
                        	            initialPreview:[
                        	            	imgPath+data.pic
                        	            ],
                        	            initialPreviewConfig:[
                        	            	{type: "image", caption: data.pic,url:"${APP_PATH}/category/deletePic",key: 1}
                        	            ]
                        		}
                        	}
                        	$("#picture").fileinput('clear').fileinput('destroy').fileinput('destroy').fileinput('destroy');
                    		bindPictureFileInput($.extend(true,{},options,previewData));
                        	$("#category_modal").autofill(data);
                      		$("#category_modal #printid").selectpicker('val', data.printid);
                         	//弹出模态框
                            $("#category_modal").modal({
                                backdrop:"static"
                            }).on('hidden.bs.modal', function() {
                                $("#categoryForm").data('bootstrapValidator').destroy();
                                $('#categoryForm').data('bootstrapValidator', null);
                                $("#picture").fileinput('clear').fileinput('destroy').fileinput('destroy').fileinput('destroy');
                            	bindCategoryForm();
                            	bindPictureFileInput(options);
                            });;
                        }).on('click','.del',function(){
                        	var params = JSON.parse($(this).attr('item'));
                        	delCategory(params)
                        });
                        setPage(data.pageNum,data.total, pageQuery)
                    } else {
                        layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
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
                onPageClicked: function (event,originalEvent,type,page) {
                    pageNum = page
                    callback && callback()
                }
            })
        }
        
       
        
       
        function goAddPage() {
        	$("#picture").fileinput('clear').fileinput('clear').fileinput('destroy').fileinput('destroy');
    		bindPictureFileInput(options);
        	var parentId = $("#queryBtn").attr("parentId");
        	 $("#category_modal").autofill({id:"0",parentId:parentId,name:"",printid:"",state:'0'});
        	 $("#category_modal #printid").selectpicker('val', "");
         	//弹出模态框
            $("#category_modal").modal({
                backdrop:"static"
            });
        }
        /***批量删除菜品类别信息***/
        function deleteUsers() {
        	var params = [];
        	$("#categoryListForm .check_item:checked").each(function(i,e){
        		params.push($(e).val())
        	});
            var checkedlength = $(".check_item:checked").length;
            if ( params.length > 0 ) {
            	layer.confirm($.i18n.prop('layer-confirm-delete-choose-msg'), 
            			{icon: 3, 
            		    title:$.i18n.prop('layer-title'),
            		      btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')]
            	        }, 
            	function(cindex){
		                    // 删除已选择的菜品类别信息
		                    $.ajax({
		                        type : "POST",
		                        dataType : 'json',
		                        url  : "${APP_PATH}/category/deleteBatch",
		                        data:JSON.stringify(params),
		                        contentType:"application/json",
		                        success : function(result) {
		                        	layer.close(cindex);
		                            if ( result.code == 100 ) {
		                                layer.msg($.i18n.prop('delete-success'), {time:1000, icon:6}, function(){
		                                	loadCategoryTree()
		                                });
		                            } else {
		                                layer.msg($.i18n.prop('delete-fail'), {time:2000, icon:5, shift:6}, function(){});
		                            }
		                        }
		                    });
                    
                }, function(cindex){
                    layer.close(cindex);
                });
                
            } else{
            	layer.msg($.i18n.prop('layer-choose-delete-msg'), {time:2000, icon:5, shift:6}, function(){});
            }
            
        }
        /**删除单个菜品类别信息**/
        function delCategory(params) {
        	layer.confirm($.format($.i18n.prop('layer-confirm-delete-msg'), params.name),  
        	  { icon: 3,
        		title:$.i18n.prop('layer-title'),
        		btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')]
        	   }, function(cindex){
                var param = [];
                param.push(params.id);
        		$.ajax({
                    type : "POST",
                    dataType : 'json',
                    url  : "${APP_PATH}/category/deleteBatch",
                    data:JSON.stringify(param),
                    contentType:"application/json",
                    success : function(result) {
                    	layer.close(cindex);
                        if (result.code==100 ) {
                            layer.msg($.i18n.prop('delete-success'), {time:1000, icon:6}, function(){
                            	loadCategoryTree()
                            });
                        } else {
                            layer.msg($.i18n.prop('delete-fail'), {time:2000, icon:5, shift:6}, function(){});
                        }
                    }
                });
                
            }, function(cindex){
                layer.close(cindex);
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
                         $("#category_modal #printid").html(options.join(' ')); 
                		 $("#category_modal #printid").selectpicker('refresh');
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
        
        function bindCategoryForm(){
        	$('#categoryForm').bootstrapValidator({
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
                // Use Ajax to submit form data 提交至form标签中的action，result自定义
                var params  = $form.serializeJSON();
                $.ajaxFileUpload({
                    url : $form.attr('action'), //用于文件上传的服务器端请求地址
                    fileElementId : 'picture',
                    type : 'POST',
                    data:params,
                    dataType : 'json',
                    success : function(result) {
                    	if ( result.code==100 ) {
                        	$("#category_modal").modal('hide');
                            layer.msg($.i18n.prop('save-success'), {time:1500, icon:6}, function(){
                            	loadCategoryTree()
                            });
                        } else {
                            layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });
                
            });
        	
        	
        }
        
        function bindPictureFileInput(options) {
        	$("#pictureDIV").empty();
        	$('<input id="picture"  name="picture" type="file"  >').appendTo("#pictureDIV");
        	$("#picture").fileinput(options);
        }
        
    </script>
    
    <script type="text/html" id="tpl-data">
		{{each list}}
           	<tr>
                <td>{{((pageNum-1)*pageSize)+($index+1)}}</td>
                <td><input type="checkbox" value="{{$value.id}}" class="check_item"></td>
                {{if $value.pic }}
                   <td><img src="{{imgPath}}{{$value.pic}}" class="img-rounded" style="width:80px;height:45px"/></td>
                {{else}} 
                  <td><img src="/img/upload.png" class="img-rounded" style="width:80px;height:45px"/></td>
                {{/if}}
                <td>{{$value.name}}</td>
                <td>
                  {{if $value.printer }}
                      {{$value.printer.name}}
                  {{/if}}
                </td>
                <td>
                  {{if $value.printer }}
                      {{$value.printer.ip}}
                  {{/if}}
                 </td>
                <td>
                   <button type="button" imgPath="{{imgPath}}" item='{{obj2Str($value)}}' class="btn btn-primary btn-xs edit"><i class=" glyphicon glyphicon-pencil"></i></button>
                   &nbsp;&nbsp;&nbsp;
                   <button type="button" item='{{obj2Str($value)}}' class="btn btn-danger btn-xs del"><i class=" glyphicon glyphicon-remove"></i></button>
                </td>
            </tr>
		{{/each}}

   </script>
<body>

	<div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th i18n" data-properties="category-panel-title" data-ptype="text" ></i> 
				</h3>
			</div>
			<div>
				<div class="panel panel-default" style="float: left; width: 20%;">
					<ul id="categoryTree"  class="ztree"></ul>
				</div>
				<div class="panel-body" style="float: right; width: 80%;">
					<form class="form-inline" role="form"  style="float: left;">
						<div class="form-group has-feedback">
							<div class="input-group">
								<div class="input-group-addon i18n" data-properties="query-criteria" data-ptype="text"></div>
								<input id="queryText" class="form-control has-success i18n" data-properties="pleaseEnter" data-ptype="placeholder" type="text" placeholder="">
							</div>
						</div>
						<button id="queryBtn" parentId="0" type="button" class="btn btn-warning">
							<i class="glyphicon glyphicon-search i18n" data-properties="btn-search" data-ptype="text" >查询</i>
						</button>
					</form>
					<button type="button" class="btn btn-danger"
						onclick="deleteUsers()" style="float: right; margin-left: 10px;">
						<i class=" glyphicon glyphicon-remove i18n" data-properties="btn-delete" data-ptype="text"></i>
					</button>
					<button type="button" id="addBtn" class="btn btn-primary" style="float: right;">
						<i class="glyphicon glyphicon-plus i18n" data-properties="btn-add" data-ptype="text"></i>
					</button>
					<br>
					<hr style="clear: both;">
					<div class="table-responsive">
						<form id="categoryListForm">
							<table class="table  table-bordered ">
								<thead>
									<tr>
										<th style="width: 5%;" class="i18n" data-properties="thead-serial-number" data-ptype="text" ></th>
										<th style="width: 5%;"><input type="checkbox" id="allSelBox"></th>
										<th style="width: 10%; text-align: center;" class="i18n" data-properties="category-pic" data-ptype="text" ></th>
										<th style="width: 10%; text-align: center;" class="i18n" data-properties="category-name" data-ptype="text" ></th>
										<th style="width: 14%; text-align: center;" class="i18n" data-properties="category-printer" data-ptype="text" ></th>
										<th style="width: 14%; text-align: center;" class="i18n" data-properties="thead-category-printer-ip" data-ptype="text" ></th>
										<th style="width: 18%" class="i18n" data-properties="thead-opt" data-ptype="text" >操作</th>
									</tr>
								</thead>

								<tbody id="categoryData">

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

    <div id="category_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" style="width: 50%;">
            <form class="modal-content form-horizontal" id="categoryForm" method="post" action="${APP_PATH}/category/save">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body">
                        <input type="hidden" name="id" class="form-control" id="category_id">
                        <input type="hidden" name="state" class="form-control" id="state">
                        <input type="hidden" name="parentId" class="form-control" id="parentId">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label i18n" data-properties="category-name" data-ptype="text" ></label>
                            <div class="col-sm-6">
                                <input type="text" autocomplete="off" data-bv-notempty="true" data-bv-notempty-message="" name="name" class="form-control i18n" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty" id="name" placeholder="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="printid" class="col-sm-3 control-label i18n" data-properties="category-printer" data-ptype="text" ></label>
                            <div class="col-sm-6">
                                <select data-size="6" id="printid" name="printid" class="form-control selectpicker"></select>
                            </div>
                        </div>
                        <div class="form-group">
							<label for="picture"  class="col-sm-3 control-label i18n" data-properties="upload-pic" data-ptype="text" >上传图片:</label> 
							<div class="col-sm-8" id="pictureDIV">
				                <input id="picture"  name="picture" type="file"  >
				            </div>
					    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary i18n" data-properties="btn-save" data-ptype="text" id="category_save_btn"></button>
                    <button type="button" class="btn btn-default i18n" data-properties="btn-close" data-ptype="text" data-dismiss="modal"></button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
