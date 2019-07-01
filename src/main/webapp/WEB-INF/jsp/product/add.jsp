<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
  <%@include file="/WEB-INF/jsp/common/htmlBase.jsp"%>
  <script type="text/javascript">
        $(function () {
        	$(".selectpicker").selectpicker({
                noneSelectedText : '请选择'    //默认显示内容
            });
            getTypes();
            bindKeyEvent($("#price"));
            /**提交表单**/
            $("#insertBtn").click(function(){
                var checkResult =checkFrom();
                if (checkResult!="success"){
                    layer.msg(checkResult, {time:2000, icon:5, shift:6}, function(){
                    });
                    return;
    			}
                var datajson=$('#productForm').serializeObject();

                $.ajaxFileUpload({
                    url : '${APP_PATH}/product/doAdd', //用于文件上传的服务器端请求地址
                    fileElementId : 'pic',
                    type : 'POST',
                    data:datajson,
                    dataType : 'json',
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg("菜品添加成功", {time:1000, icon:6}, function(){
                            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/product/index")
                            });
                        } else {
                            layer.msg("菜品添加失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });

            });
            
            $("#goBackBtn").click(function(){
            	$('#mainIframe', parent.document).attr('src',"${APP_PATH}/product/index")
            });
            
            $("#resetBtn").click(function(){
                $("#productForm")[0].reset();
            });
        });

        
        /**获取产品类别信息,并表单构建**/
        function getTypes() {
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
	           		 for(var i=0;i<data.length;i++){
	                    var item = data[i];
	　　　　　　　　　　　　      options.push('<option value="'+item.id+'">'+item.name+'</option>') 
	                 }
                     $("#productForm #cid").html(options.join(' ')); 
          		     $("#productForm #cid").selectpicker('refresh');
                }
            })
        }
        /**限制只能金额输入**/
        function bindKeyEvent(obj){
            obj.keyup(function () {    
                var reg = $(this).val().match(/\d+\.?\d{0,2}/);
                var txt = '';          
                if (reg != null) {              
                    txt = reg[0];
                }          
                $(this).val(txt); 
            }).change(function () {
                $(this).keypress();    
                var v = $(this).val();   
                if (/\.$/.test(v)){        
                    $(this).val(v.substr(0, v.length - 1));  
				}    
            }); 
        }

        /**选择图片，马上预览**/
        //var image = '';
        function onupload(file) {
            if(!file.files || !file.files[0]){
                return;
            }
            //判断文件格式
            var picInfo = $("#pic").val();
            if(picInfo.length>0 && picInfo != '') {
                var lodt = picInfo.lastIndexOf(".");
                var ext = picInfo.substring(lodt + 1).toUpperCase();
                if (ext != "PNG" && ext != "GIF"&&  ext != "JPG" && ext != "JPEG"){
                    layer.msg("图片格式不正确", {time:2000, icon:5, shift:6}, function(){
                    });
                    //jquery清空file域
                    var filePic =$("#pic");
                    filePic.after(filePic.clone().val(""));
                    filePic.remove();
                    return ;
				}
            }
            //读取文件过程方法
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('Img').src = e.target.result;
            };
            reader.readAsDataURL(file.files[0]);
        }
        /**将表单数据序列化为json对象**/
        $.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
        /**表单数据是否为空验证**/
        function checkFrom(){
            ///检查菜品名称
			if($("#name").val()==""){
			    return "菜品名称不能为空";
			}
			//检查菜品价格
			if($("#price").val()==""){
			    return "菜品价格不能为空";
			}
            if($("#inventory").val()==""){
                return "菜品库存不能为空";
            }
            var status =$('input:radio[name="status"]:checked').val();
            if(status!=1 && status!=0){
                return "请选择菜品状态";
            }
            var type =$("#type_select option:selected").val();
            if(type==""){
                return "请选择菜品类别";
            }
            var picInfo = $("#pic").val();
            if(picInfo.length==0 || picInfo == ''){
                //return "请上传图片"
                return "success";
            }
            return "success";
		}
	</script>
<body>
	<div>
		<ol class="breadcrumb">
			<li><a href="${APP_PATH}/product/index">菜品列表</a></li>
			<li class="active">新增</li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-heading">
				菜品详情
				<div style="float: right; cursor: pointer;" data-toggle="modal"
					data-target="#myModal">
					<i class="glyphicon glyphicon-question-sign"></i>
				</div>
			</div>
			<div class="panel-body">
				<form id="productForm" class="form-horizontal" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="name" class="col-sm-1 control-label">菜品名称:</label> 
						<div class="col-sm-4">
						    <input type="text" autocomplete="off" class="form-control" id="name" name="name" placeholder="请输入菜品名称">
						</div>
					</div>
					<div class="form-group">
						<label for="price" class="col-sm-1 control-label">菜品价格:</label>
						<div class="col-sm-4">
						    <div class="input-group">
								<span class="input-group-addon">￥</span> 
								<input  autocomplete="off" type="text" class="form-control" id="price" name="price" placeholder="请输入菜品价格">
							</div>
						</div>
						<p class="help-block label label-warning">请输入合法的数据, 格式为：25.60</p>
					</div>
					<div class="form-group">
						<label for="inventory" class="col-sm-1 control-label">菜品库存:</label>
						<div class="col-sm-4">
						    <input  autocomplete="off" type="number" class="form-control" id="inventory" name="inventory"
							placeholder="请输入菜品库存"
							onkeyup="this.value=this.value.replace(/[^\d]/g,'')"
							onpaste="return false">
						</div>
						
					</div>
					<div class="form-group">
						<label for="status" class="col-sm-1 control-label">菜品状态:</label> 
						<div class="col-sm-4">
							<label><input type="radio" name="status" value="1">上架</label> 
							<label><input type="radio" name="status" value="0">下架</label>
						</div>
					</div>
					<div class="form-group">
						<label for="cid" class="col-sm-1 control-label" >菜品类别:</label> 
						<div class="col-sm-4">
                               <select data-size="6" id="cid" name="cid" class="form-control selectpicker"></select>
                         </div>
					</div>
					<div class="form-group">
						<label for="pic"  class="col-sm-1 control-label">上传图片:</label> 
						<div class="col-sm-4">
						   <input id="pic"
							name="pic" onchange="onupload(this)" type="file"
							accept="image/png, image/jpeg, image/gif, image/jpg"
							class="btn-info"> <img style="padding-top: 2px;" id="Img"
							width="376" height="213" src="${basePath}/img/upload.png">
						</div>
						
						<div>
							<p class="help-block label label-warning">仅支持png gif jpg gif
								jpeg格式</p>
						</div>
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
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
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
				<!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
			</div>
		</div>
	</div>

</body>
</html>
