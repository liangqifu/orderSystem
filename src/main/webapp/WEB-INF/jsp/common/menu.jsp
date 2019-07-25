<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul style="padding-left:0px;" class="list-group">
	<c:forEach items="${rootPermission.children}" var="permission">
		
		<c:if test="${empty permission.children}">
			<li class="list-group-item tree-closed" url="${APP_PATH}${permission.url}" no="${permission.no}" >
				<a style="cursor: pointer;"><i style="cursor: pointer;" class="${permission.icon} i18n" data-properties="${permission.no}" data-ptype="text" ></i></a>
			</li>
		</c:if>
		
		<c:if test="${not empty permission.children}">
			<li class="list-group-item tree-closed" >
				<span><i style="cursor: pointer;" class="${permission.icon} i18n" data-properties="${permission.no}" data-ptype="text" ></i><span class="badge" style="float:right">${permission.children.size()}</span></span>
				<ul style="margin-top:10px;display: none;" class="nav nav-pills nav-stacked">
					<c:forEach items="${permission.children}" var="child" varStatus="status">
						<li url="${APP_PATH}${child.url}" no="${child.no}">
							<a  style="cursor: pointer;"><i style="cursor: pointer;" class="${child.icon} i18n" data-properties="${child.no}" data-ptype="text" ></i></a>
						</li>
					</c:forEach>
				</ul>
			</li>
		</c:if>
		
		
	</c:forEach>
	
</ul>

<div id="data_query_modal" style="z-index: 2000;" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" style="width: 48%;">
            <form class="modal-content form-horizontal" id="pwdEnterForm" method="post" action="${APP_PATH}/admin/checkPwd">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body">
						<div class="form-group">
							<label for="pwd" class="col-sm-3 control-label i18n" data-properties="pwdEnterForm-pwd" data-ptype="text" ></label> 
							<div class="col-sm-6">
							   <input autocomplete="off" type="password" class="form-control i18n" data-properties="pleaseEnter" data-ptype="placeholder" id="pwd" name="pwd"  placeholder="">
							</div>
						</div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary i18n"  data-properties="btn-confirm" data-ptype="text" id="save_btn"></button>
                    <button type="button" class="btn btn-default i18n"  data-properties="btn-cancel" data-ptype="text" data-dismiss="modal"></button>
                </div>
            </form>
        </div>
    </div>

<script type="text/javascript">
	  $(function () {
	     $(".list-group-item i").click(function(){
	    	 if($(this).parent().parent().find('ul')){
	    		 $(this).parent().parent().toggleClass("tree-closed");
	    		 if ($(this).parent().parent().hasClass("tree-closed") ) {
	    			  $(this).parent().parent().find('ul').hide();
		            } else {
		              $(this).parent().parent().find('ul').show();
		            }
	    	 }
	     });  
	     
	    
	     $(".list-group li").on("click",function(){
	    	 if($(this).parent().hasClass('nav')){
	    		 $(".list-group li").removeClass('active')
	    		 $(this).addClass('active')
	    	 }
	    	 
	    	 var url = $(this).attr('url');
	    	 var no = $(this).attr('no');
	    	 if(no == 'mean_101'){
	    		 $("#data_query_modal #pwdEnterForm").attr('url',url)
	    		 $("#data_query_modal").modal({
	                 backdrop:"static"
	             }).on('hidden.bs.modal', function() {
	                 $('#pwdEnterForm').clearForm(true);
	             });
	    		 
	    		 $('.modal-backdrop').css('z-index',0);
	    	 }else{
	    		 $("#mainIframe").attr('src',url); 
	    	 }
	    	 
	     })
	     $($(".list-group-item i")[0]).trigger("click")
	     $($(".list-group ul.nav li")[0]).trigger("click");
	     bindPwdEnterForm();
	     
	   });
	  
	  function bindPwdEnterForm(){
      	$('#pwdEnterForm').bootstrapValidator({
          	// 默认的提示消息
              message: 'This value is not valid',
              // 表单框里右侧的icon
              feedbackIcons: {
                　　　　　　　　valid: 'glyphicon glyphicon-ok',
                　　　　　　　　invalid: 'glyphicon glyphicon-remove',
                　　　　　　　　validating: 'glyphicon glyphicon-refresh'
              },
              fields: {
              	pwd: {
              		notEmpty: {
                        message: $.i18n.prop('notEmpty')
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
              // Use Ajax to submit form data 提交至form标签中的action，result自定义
              var params  = $form.serializeJSON();
              var url = $form.attr('url');
              debugger
              $.ajax({
                  type : "POST",
                  dataType : 'json',
                  url  : $form.attr('action'),
                  data : JSON.stringify(params),
                  contentType:"application/json",
                  success : function(result) {
                      if ( result.code==100 ) {
                      	$("#data_query_modal").modal('hide');
                      	$("#mainIframe").attr('src',url); 
                      } else if ( result.code==104 ) {
                    	  layer.msg($.i18n.prop('pwdEnterForm-pwd-error'), {time:2000, icon:5, shift:6}, function(){
                          });
                      }else if ( result.code==105 ) {
                    	  window.top.location.href = "${APP_PATH}/admin/login";
                      } else {
                          layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
                          });
                      }
                  }
              });
          });
      }
	</script>

