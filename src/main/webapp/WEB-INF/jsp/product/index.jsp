<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
<script type="text/javascript">
	var pageNum = 1;
	$(function() {
		$("#addProductBtn").click(function() {
	    	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/product/add");
		});
		/**分页查询**/
		queryListByPage();

		/**为查询按钮添加点击事件,判断内容是否为空，进行模糊查询**/
		$("#queryBtn").click(function() {
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
		
		
		
	});

	/***分页查询构建表格***/
	function queryListByPage() {
		var loadingIndex = null;
    	var params  = {pageNum:pageNum,name:$("#queryText").val()};
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
                    	$("#printerForm").autofill(data);
                    	if(data.status == "0"){
                            $("#statusSwitch").bootstrapSwitch('state',true,false);
                        }else{
                            $("#statusSwitch").bootstrapSwitch('state',false,true);
                        }
                     	//弹出模态框
                        $("#printer_modal").modal({
                            backdrop:"static"
                        }).on('hidden.bs.modal', function() {
                            $("#printerForm").data('bootstrapValidator').destroy();
                            $('#printerForm').data('bootstrapValidator', null);
                            $('#printerForm').clearForm(true);
                            bindPrinterForm();
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
	/**跳转到菜品修改页**/
	function goUpdatePage(id) {
		$('#mainIframe', parent.document).attr('src',"${APP_PATH}/product/edit?id=" + id)
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
                <td>{{$value.name}}</td>
                <td style="text-align: right;">{{$value.price}}</td>
                <td style="text-align: center;">{{convertProductStatus($value.status)}}</td>
                <td>
                  {{if $value.category }}
                      {{$value.category.name }}
                  {{/if}} 
               </td>
                <td>
                   <button type="button" item='{{obj2Str($value)}}'  class="btn btn-primary btn-xs edit"><i class=" glyphicon glyphicon-pencil"></i></button>
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
				<form class="form-inline" role="form" style="float: left;">
					<div class="form-group has-feedback">
						<div class="input-group">
							<div class="input-group-addon i18n" data-properties="query-criteria" data-ptype="text"></div>
							<input id="queryText" class="form-control has-success i18n" data-properties="pleaseEnter" data-ptype="pleaseEnter" type="text" placeholder="">
						</div>
					</div>
					<button id="queryBtn" type="button" class="btn btn-warning">
						<i class="glyphicon glyphicon-search i18n" data-properties="btn-search" data-ptype="text"></i> 
					</button>
				</form>
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
									<th style="width:30% ;text-align: center;" class="i18n" data-properties="product-name" data-ptype="text"></th>
									<th style="width:6% ;text-align: center;" class="i18n" data-properties="product-price" data-ptype="text"></th>
									<th style="width:5% ;text-align: center;" class="i18n" data-properties="product-status" data-ptype="text"></th>
									<th style="width:10% ;text-align: center;" class="i18n" data-properties="product-category" data-ptype="text"></th>
									<th style="width:10%" class="i18n" data-properties="thead-opt" data-ptype="text"></th>
								
								</tr>
							</thead>

							<tbody >

							</tbody>

							<tfoot>
								<tr>
									<td colspan="8" align="center">
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

</body>
</html>
