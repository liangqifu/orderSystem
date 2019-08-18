<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
	var pageNum = 1;
	var options={};
	$(function() {
		$("#queryForm .selectpicker").selectpicker({
            noneSelectedText : $.i18n.prop('bootstrap-select-noneSelectedText')
        });
		
		$("#resetBtn").click(function(){
            $("#queryForm")[0].reset();
            $("#queryForm #keyCid").selectpicker('val', '');
        });
		getCategoryList();
		$("#addProductBtn").click(function() {
			 bindPictureFileInput(options);
        	 $("#productForm").autofill({id:"0",status:'1',type:'2',state:'0'});
         	//弹出模态框
            $("#product_modal").modal({
                backdrop:"static"
            }).on('hidden.bs.modal', function() {
                $("#productForm").data('bootstrapValidator').destroy();
                $('#productForm').data('bootstrapValidator', null);
                $('#productForm').clearForm(true);
                bindProductForm();
            	bindPictureFileInput(options);
            });
		});
		/**分页查询**/
		queryListByPage();
		bindProductForm();
		/**为查询按钮添加点击事件,判断内容是否为空，进行模糊查询**/
		$("#queryBtn").click(function() {
			pageNum=1;
			queryListByPage();
		});
		
		/***为总单选按钮添加check 选择则全部选中**/
		$("#allSelBox").click(function() {
			var flg = this.checked;
			$("#queryListResult :checkbox").each(function() {
				this.checked = flg;
			});
		});

		/**为单个check_item添加点击事件**/
		$(document).on("click",".check_item",function() {
			//判断当前选择中的元素是否全选，如果是则选中总标签
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#allSelBox").prop("checked", flag);
		});
		
		createTree();
    	hideMenu();
    	$("body").bind("mousedown", 
             function(event){
                if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                    hideMenu();
                }
             }
        ); 
        $("#productForm #categoryName").bind("click",
              function(){
      	          showMenu();
              }
        );
		
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
    	 bindPictureFileInput(options);
		
	});

	/***分页查询构建表格***/
	function queryListByPage() {
		var loadingIndex = null;
		var params = $("#queryForm").serializeJSON();
    	params.pageNum=pageNum;
    	$.ajax({
            type : "POST",
            dataType : 'json',
            url  : "${APP_PATH}/product/queryListByPage",
            data:JSON.stringify(params),
            contentType:"application/json",
            beforeSend : function(){
                loadingIndex = layer.msg($.i18n.prop('layer-loading-msg'), {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.code == 100 ) {
                    var data = result.extend.data || [];
                    $("#queryListResult tbody").html(template("tpl-data",$.extend(data, {imgPath:result.extend.imgPath})));
                    $("#queryListResult tbody").on('click','.edit',function(){
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
                		bindPictureFileInput($.extend(true,{},options,previewData));
                		data.categoryName = data.category?data.category.name:"";
                		
                		
                		
                    	$("#productForm").autofill(data);
                    	
                		if(data.type1 == '1'){
                			$("#productForm #type1").prop("checked",true);
                		}else{
                			$("#productForm #type1").prop("checked",false);
                		}
                		
                		if(data.type2 == '1'){
                			$("#productForm #type2").prop("checked",true);
                		}else{
                			$("#productForm #type2").prop("checked",false);
                		}
                		
                     	//弹出模态框
                        $("#product_modal").modal({
                            backdrop:"static"
                        }).on('hidden.bs.modal', function() {
                            $("#productForm").data('bootstrapValidator').destroy();
                            $('#productForm').data('bootstrapValidator', null);
                            $('#productForm').clearForm(true);                            
                            bindProductForm();
                            bindPictureFileInput(options);
                        });;
                    }).on('click','.del',function(){
                    	var params = JSON.parse($(this).attr('item'));
                    	delProduct({id:params.id,name:params.name})
                    });
                    setPage(data.pageNum, data.total,data.pageSize, queryListByPage)
                } else {
                    layer.msg($.i18n.prop('layer-load-data-fail'), {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        });
		
	}
	function setPage(pageCurrent, total,pageSize, callback) {
    	
    	$("#queryListResult .pagination").html('');
    	$("#queryListResult .total").text($.format($.i18n.prop('query-result-total'),total));
    	if(total<1) return;
    	$("#queryListResult .pagination").bootstrapPaginator({
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
	
	/***批量删除菜品信息***/
	function deleteProducts() {
		var params = [];
    	$("#queryListResult .check_item:checked").each(function(i,e){
    		params.push($(e).val())
    	});
    	if ( params.length > 0 ) {
        	layer.confirm($.i18n.prop('layer-confirm-delete-choose-msg'), 
        			{icon: 3, 
        		    title:$.i18n.prop('layer-title'),
        		      btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')]
        	        }, 
        	function(cindex){
	                    $.ajax({
	                        type : "POST",
	                        dataType : 'json',
	                        url  : "${APP_PATH}/product/deleteBatch",
	                        data:JSON.stringify(params),
	                        contentType:"application/json",
	                        success : function(result) {
	                        	layer.close(cindex);
	                            if ( result.code == 100 ) {
	                                layer.msg($.i18n.prop('delete-success'), {time:1000, icon:6}, function(){
	                                	queryListByPage()
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
	/**删除单个菜品信息**/
	function delProduct(params) {
		params.state ='1';
    	layer.confirm($.format($.i18n.prop('layer-confirm-delete-msg'), params.name),  {
    		icon: 3, 
    		title:$.i18n.prop('layer-title'),
    		btn: [$.i18n.prop('layer-ok'),$.i18n.prop('layer-cancel')] 
    		}, function(cindex){
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/product/update",
                data : JSON.stringify(params),
                contentType:"application/json",
                success : function(result) {
                    if ( result.code==100 ) {
                        layer.msg($.i18n.prop('delete-success'), {time:1000, icon:6}, function(){
                        	queryListByPage();
                        });
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
	
	
	//显示树
    function showMenu() {
         var cityObj = $("#productForm #categoryName");
         var cityOffset = $("#productForm #categoryName").offset();
         $("#productForm #menuContent").css({ left: cityOffset.left-273 + "px", top: cityOffset.top + cityObj.outerHeight()-30	 + "px" }).slideDown("fast");
    }
           
     //隐藏树
    function hideMenu() {
         $("#productForm  #menuContent").fadeOut("fast");
    }
    
    function createTree() {
        var zTree; //用于保存创建的树节点
        var setting = { //设置
            check: {
                enable: false,
                dblClickExpand: false
            },
            view: {
                showLine: true, //显示辅助线
                dblClickExpand: false,
            },
            data:{
            	simpleData: {
    				enable: true,
    				idKey : "id",
    				pidKey : "pId"
    			}
            },
            callback: {
            	beforeClick:function (treeId, treeNode){
            		 var check = (treeNode && !treeNode.isParent);
            		 if (!check){
            			 layer.alert($.i18n.prop('layer-please-select-sub'), { 
         				    icon: 0,
         				    title:$.i18n.prop('layer-title'),
         					btn: [$.i18n.prop('layer-ok')],
         				    closeBtn: 0 
     				       },function(index){
     				    	  layer.close(index);
     				    	  $("#productForm #categoryName").val('');
                 		      $("#productForm #cid").val('');
     				       });
            		 } 
            		 return check;
            	},
                onClick: function(e, treeId, treeNode){
                	if (treeNode) {
                		$("#productForm #categoryName").val(treeNode.name);
                		$("#productForm #cid").val(treeNode.id);
                		hideMenu();
                	}
                    
                }
            },
            async : {
                enable : true,
                url : "${APP_PATH}/category/getTreeListAll",
                autoParam : [ "id" ],
            }
        };
        $.ajax({ //请求数据,创建树
        	url:"${APP_PATH}/category/getTreeListAll",
			type:"GET",
			dataType:"json",
			cache:false,
            success: function(data) {
                zTree = $.fn.zTree.init($("#treeDemo"), setting, data); //创建树
            },
            error: function(data) {
                
            }
        });
    }
    
    function bindPictureFileInput(options) {
    	 $("#pictureDIV").empty();
    	$('<input id="picture"  name="picture" type="file"  >').appendTo("#pictureDIV");
    	$("#picture").fileinput(options); 
    	$('#picture').on('filedeleted', function(event, key, jqXHR, data) {
    		$("#productForm #pic").val("")
        });
    }
    
    
    function bindProductForm (){
    	$('#productForm').bootstrapValidator({
        	// 默认的提示消息
            message: 'This value is not valid',
            // 表单框里右侧的icon
            feedbackIcons: {
              　　　　　　　　valid: 'glyphicon glyphicon-ok',
              　　　　　　　　invalid: 'glyphicon glyphicon-remove',
              　　　　　　　　validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	no: {
                    validators: {
                        notEmpty: {
                            message: $.i18n.prop('notEmpty')
                        }
                    }
                },
            	name: {
                    validators: {
                        notEmpty: {
                            message: $.i18n.prop('notEmpty')
                        }
                    }
                },
                price:{
                	validators: {
                		notEmpty: {
                            message: $.i18n.prop('notEmpty')
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
                categoryName:{
                	validators: {
                		notEmpty: {
                            message: $.i18n.prop('notEmpty')
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
            var params  = $form.serializeJSON();
            params.status = $form.find('input:radio[name="status"]:checked').val();
            
            if($('#productForm #type1').is(':checked')){
            	params.type1='1';
            }else{
            	params.type1='0';
            }
            if($('#productForm #type2').is(':checked')){
            	params.type2='1';
            }else{
            	params.type2='0';
            }
            
            $.ajaxFileUpload({
                url : $form.attr('action'), //用于文件上传的服务器端请求地址
                fileElementId : 'picture',
                type : 'POST',
                data:params,
                dataType : 'json',
                success : function(result) {
                	if ( result.code==100 ) {
                    	$("#product_modal").modal('hide');
                        layer.msg($.i18n.prop('save-success'), {time:1500, icon:6}, function(){
                        	queryListByPage()
                        });
                    }if ( result.code==103 ) {
                    	layer.msg($.i18n.prop('product-no-repeat'), {time:1500, icon:6}, function(){
                           
                    	});
                    }else {
                        layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        });
    }
    
    function getCategoryList() {
    	var params = {
    			state:"0",
    		};
    	$.ajax({
            type : "POST",
            dataType : 'json',
            url  : "${APP_PATH}/category/queryList",
            data:JSON.stringify(params),
            contentType:"application/json",
            success:function (result) {
            	 var data = result.extend.data || [];
           		 var options = [];
           	     options.push('<option value=""></option>') 
           		 for(var i=0;i<data.length;i++){
                    var item = data[i];
　　　　　　　　　　　　      options.push('<option value="'+item.id+'">'+item.name+'</option>') 
                 }
                 $("#queryForm #keyCid").html(options.join(' ')); 
      		     $("#queryForm #keyCid").selectpicker('refresh');
            }
        })
    }
</script>

<script type="text/html"  id="tpl-data">

		{{each list}}

           	<tr>
                <td>{{((pageNum-1)*pageSize)+($index+1)}}</td>
                <td style="text-align: center;"><input type="checkbox" name="productid" value="{{$value.id}}" class="check_item"></td>
                {{if $value.pic }}
                   <td><img src="{{imgPath}}{{$value.pic}}" class="img-rounded" style="width:80px;height:45px"/></td>
                {{else}} 
                  <td><img src="/img/upload.png" class="img-rounded" style="width:80px;height:45px"/></td>
                {{/if}}  
                <td>{{$value.no}}</td>              
                <td>{{$value.name}}</td>
                <td style="text-align: right;">{{$value.price}}</td>
                <td style="text-align: center;">{{convertProductStatus($value.status)}}</td>
                <td style="text-align: center;white-space: nowrap;">{{convertProductType($value.type1,$value.type2)}}</td>
                <td>
                  {{if $value.category }}
                      {{$value.category.name }}
                  {{/if}} 
               </td>
                <td>
                   <button type="button" imgPath="{{imgPath}}" item='{{obj2Str($value)}}'  class="btn btn-primary btn-xs edit"><i class=" glyphicon glyphicon-pencil"></i></button>
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
					<i class="glyphicon glyphicon-th i18n" data-properties="product-panel-title" data-ptype="text" ></i>
				</h3>
			</div>
			<div class="panel-body">
				<form id="queryForm" class="form-horizontal" role="form" >
					<div class="form-group">
					      <label for="order" class="col-sm-1 control-label i18n" data-properties="product-name" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <input autocomplete="off" type="text" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder"  name="name"  placeholder="">
						  </div>
						  <label for="status" class="col-sm-1 control-label i18n" data-properties="product-status" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <select  class="form-control" id="status" name="status" >
						         <option value="" class="i18n" data-properties="bootstrap-select-noneSelectedText" data-ptype="text"></option>
						         <option value="1" class="i18n" data-properties="product-status-1" data-ptype="text"></option>
						         <option value="0" class="i18n" data-properties="product-status-0" data-ptype="text"></option>
						      </select>
						  </div>
						  <label for="keyCid" class="col-sm-1 control-label i18n" data-properties="product-category" data-ptype="text" ></label> 
						  <div class="col-sm-2">
						      <select data-size="6" id="keyCid" name="keyCid" class="form-control selectpicker"></select>
						  </div>
					</div>
					
					<div style="float: right; margin-right: 30%">
					       <button id="queryBtn" type="button" class="btn btn-primary i18n" data-properties="btn-search" data-ptype="text"> 
					           <i class="glyphicon glyphicon-search"></i>
					        </button>
					        <button id="resetBtn" type="button" class="btn btn-default">
							   <i class="glyphicon glyphicon-refresh i18n" data-properties="btn-reset" data-ptype="text" ></i>
						    </button>
					</div>
					
				</form>
	
				
				<br>
				<hr style="clear: both;">
				<button type="button" class="btn btn-danger"
					onclick="deleteProducts()" style="float: right; margin-left: 10px;">
					<i class=" glyphicon glyphicon-remove i18n" data-properties="btn-delete" data-ptype="text" ></i>
				</button>
				<button id="addProductBtn" type="button"  class="btn btn-primary" style="float: right;">
					<i class="glyphicon glyphicon-plus i18n" data-properties="btn-add" data-ptype="text" ></i>
				</button>
				<br>
				<hr style="clear: both;">
				<div class="table-responsive">
					<form id="queryListResult">
						<table class="table table-bordered">
							<thead>
								<tr>
							        <th style="width: 4%;text-align: center;" class="i18n" data-properties="thead-serial-number" data-ptype="text"></th>
									<th style="width:3% ;text-align: center;" ><input type="checkbox" id="allSelBox"></th>
									<th style="width:10% ;text-align: center;" class="i18n" data-properties="product-pic" data-ptype="text"></th>
									<th style="width:8% ;text-align: center;" class="i18n" data-properties="product-no" data-ptype="text"></th>
									<th style="width:22% ;text-align: center;" class="i18n" data-properties="product-name" data-ptype="text"></th>
									<th style="width:6% ;text-align: center;" class="i18n" data-properties="product-price" data-ptype="text"></th>
									<th style="width:5% ;text-align: center;" class="i18n" data-properties="product-status" data-ptype="text"></th>
									<th style="width:5% ;text-align: center;" class="i18n" data-properties="product-type" data-ptype="text"></th>
									<th style="width:10% ;text-align: center;" class="i18n" data-properties="product-category" data-ptype="text"></th>
									<th style="width:10%" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
								
								</tr>
							</thead>

							<tbody >

							</tbody>

							<tfoot>
								<tr>
									<td colspan="10" align="center">
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

    <div id="product_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" style="width: 50%;">
            <form class="modal-content form-horizontal" id="productForm" method="post" action="${APP_PATH}/product/save">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body">
                        <input type="hidden" name="id" class="form-control" id="id">
                        <input type="hidden" name="pic" class="form-control" id="pic">
                        <div class="form-group">
                            <label for="no" class="col-sm-3 control-label i18n" data-properties="product-no" data-ptype="text" ></label>
                            <div class="col-sm-6">
                                <input type="text" autocomplete="off" data-bv-notempty="true" data-bv-notempty-message="" name="no" class="form-control i18n" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty" id="no" placeholder="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label i18n" data-properties="product-name" data-ptype="text" ></label>
                            <div class="col-sm-6">
                                <input type="text" autocomplete="off" data-bv-notempty="true" data-bv-notempty-message="" name="name" class="form-control i18n" data-properties="pleaseEnter/notempty" data-ptype="placeholder/notempty" id="name" placeholder="">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="price" class="col-sm-3 control-label i18n" data-properties="product-price" data-ptype="text" ></label>
                            <div class="col-sm-6">
                                <input type="text" autocomplete="off"  name="price" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder" id="price" placeholder="">
                            </div>
                        </div>
                        
                        <div class="form-group">
							<label for="status" class="col-sm-3 control-label i18n" data-properties="product-status" data-ptype="text" ></label> 
							<div class="col-sm-6">
							      <input type="radio" name="status" value="1" class="fl" id="status-1"  ><label for="status-1"  class="fl i18n" data-properties="product-status-1" data-ptype="text"></label>
								  <input type="radio" name="status" value="0" class="fl ml20" id="status-0" ><label for="status-0" class="fl i18n" data-properties="product-status-0" data-ptype="text"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="type" class="col-sm-3 control-label i18n" data-properties="product-type" data-ptype="text" ></label> 
							<div class="col-sm-6">
							      <div class="checkbox checkbox-primary fl">
								      <input id="type1" name="type1" class="styled" type="checkbox" checked>
										<label for="type1" class="i18n" data-properties="product-type-1" data-ptype="text" ></label>
								  </div>
								  <div class="checkbox checkbox-primary fl" style="margin-left: 10%">
								      <input id="type2" name="type2" class="styled" type="checkbox" checked>
										<label for="type2" class="i18n" data-properties="product-type-2" data-ptype="text" ></label>
								  </div>
							     <!--  <input type="radio" name="type" value="2" class="fl" id="type-2"  ><label for="type-2"  class="fl i18n" data-properties="product-type-2" data-ptype="text"></label>
								  <input type="radio" name="type" value="1" class="fl ml20" id="type-1" ><label for="type-1" class="fl i18n" data-properties="product-type-1" data-ptype="text"></label> -->
							</div>
						</div>
						
						<div class="form-group">
							<label for="cid" class="col-sm-3 control-label i18n" data-properties="category-name" data-ptype="text" ></label> 
							<div class="col-sm-6">
							       <input type="hidden" id="cid" name="cid" ></input>
                                   <input id="categoryName"  readonly="readonly"   name="categoryName" class="form-control i18n" data-properties="layer-please-select-sub" data-ptype="placeholder" type="text" placeholder="请选择分类"  />
	                         </div>
				     	</div>
                        
                        <div class="form-group">
							<label for="picture"  class="col-sm-3 control-label i18n" data-properties="upload-pic" data-ptype="text" ></label> 
							<div class="col-sm-8" id="pictureDIV">
				                <input id="picture"  name="picture" type="file" >
				            </div>
					    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary i18n" data-properties="btn-save" data-ptype="text" ></button>
                    <button type="button" class="btn btn-default i18n" data-properties="btn-close" data-ptype="text" data-dismiss="modal"></button>
                </div>
                <div id="menuContent" class="menuContent" style="displayx: none; position: absolute;z-index: 10000;width: 44%;height: 180px;  overflow-y: auto;background-color: #edf0f3;">
				      <ul id="treeDemo" class="ztree" style="margin-top: 0; width:100%;">
				      </ul>
				</div>
            </form>
        </div>
    </div>
</body>
</html>
