
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #393C3D;" role="navigation">
<div class="container-fluid">
    <div class="navbar-header">
        <div><a href="${APP_PATH}/admin/main" class="navbar-brand i18n" style="font-size:32px;" data-properties="systemName" data-ptype="text"></a></div>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
                <div class="btn-group">
                    <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                        <i class="glyphicon glyphicon-user"></i> ${loginAdmin.name} <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li class="personalSettings" style="cursor: pointer;" id=" ${loginAdmin.id}"><a style="cursor: pointer;"><i class="glyphicon glyphicon-cog i18n" data-properties="personal-settings" data-ptype="text" ></i></a></li>
                        <li class="divider"></li>
                        <li class="logout" style="cursor: pointer;" ><a style="cursor: pointer;" ><i class="glyphicon glyphicon-off i18n" data-properties="logout" data-ptype="text" ></i></a></li>
                    </ul>
                </div>
            </li>
           <li style="margin-left:10px;padding-top:8px;margin-right: 25px">
                <select id="language_setting">
				    <option value="zh_CN">Chinese</option>
				    <option value="de_DE">Deutsch</option>
				    <!-- <option value="en_US">English</option> -->
				</select>
            </li> 
        </ul>
    </div>
</div>
</nav>

<div id="personalSettings_modal" style="z-index: 3000;" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-sm" style="width: 30%;">
         <form class="modal-content form-horizontal" id="personalSettingsForm" method="post" action="${APP_PATH}/admin/update">
             <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                 <h4 class="modal-title" id="myModalLabel"></h4>
             </div>
             <div class="modal-body">
                     <input type="hidden" name="id" id="id">
                     <div class="form-group">
                         <label for="name" class="col-sm-4 control-label i18n" data-properties="personal-settingsForm-name" data-ptype="text"></label>
                         <div class="col-sm-6">
                             <input type="text"  name="name" class="form-control" id="name" autocomplete="off" >
                         </div>
                     </div>
                     <div class="form-group">
                         <label for="name" class="col-sm-4 control-label i18n" data-properties="personal-settingsForm-account" data-ptype="text"></label>
                         <div class="col-sm-6">
                             <input type="text"  name="account" class="form-control" id="account" autocomplete="off" >
                         </div>
                     </div>
                     
                     <div class="form-group">
                         <label for="name" class="col-sm-4 control-label i18n" data-properties="personal-settingsForm-new-pwd" data-ptype="text"></label>
                         <div class="col-sm-6">
                             <input type="password"  name="password" class="form-control" id="password" autocomplete="off" >
                         </div>
                     </div>
                     <div class="form-group">
                         <label for="name" class="col-sm-4 control-label i18n" data-properties="personal-settingsForm-check-pwd" data-ptype="text"></label>
                         <div class="col-sm-6">
                             <input type="password"  name="checkPwd" class="form-control" id="checkPwd" autocomplete="off" >
                         </div>
                     </div>
             </div>
             <div class="modal-footer">
                 <button type="submit" class="btn btn-primary i18n"  data-properties="btn-save" data-ptype="text" id="save_btn"></button>
                 <button type="button" class="btn btn-default i18n" data-properties="btn-close" data-ptype="text" data-dismiss="modal"></button>
             </div>
         </form>
     </div>
 </div>
    
 <script type="text/javascript">
     $(function () {
    	 bindPersonalSettingsForm();
    	 $("#navbar .dropdown-menu .personalSettings").on('click','',function(){
    		 showPersonalSettingsForm($(this).attr('id'))
    		 
    	 })
    	 $("#navbar .dropdown-menu .logout").on('click','',function(){
    		 window.top.location.href = "${APP_PATH}/admin/logout";
    		 
    	 })
     })
   
    function showPersonalSettingsForm(id){
    	 $.ajax({
             type : "GET",
             dataType : 'json',
             cache:false,
             url  : "${APP_PATH}/admin/"+id+"/info",
             success : function(result) {
                 if ( result.code==100 ) {
                	 var data = result.extend.data;
                	 delete data.password;
                	 data.password='';
                	 $("#personalSettingsForm").autofill(data);
                  	//弹出模态框
                     $("#personalSettings_modal").modal({
                         backdrop:"static"
                     }).on('hidden.bs.modal', function() {
                         $("#personalSettingsForm").data('bootstrapValidator').destroy();
                         $('#personalSettingsForm').data('bootstrapValidator', null);
                         $('#personalSettingsForm').clearForm(true);
                         bindPersonalSettingsForm();
                     });
                 } else {
                     layer.msg($.i18n.prop('save-fail'), {time:2000, icon:5, shift:6}, function(){
                     });
                 }
             }
         });
    }
    function bindPersonalSettingsForm(){
	   	$('#personalSettingsForm').bootstrapValidator({
	       	// 默认的提示消息
	           message: 'This value is not valid',
	           // 表单框里右侧的icon
	           feedbackIcons: {
	             　　　　　　　　valid: 'glyphicon glyphicon-ok',
	             　　　　　　　　invalid: 'glyphicon glyphicon-remove',
	             　　　　　　　　validating: 'glyphicon glyphicon-refresh'
	           },
	           fields: {
               	 name: {
                       validators: {
                           notEmpty: {
                               message: $.i18n.prop('notEmpty')
                           }
                       }
                   },
                   account: {
                	   validators: {
                           notEmpty: {
                               message: $.i18n.prop('notEmpty')
                           }
                       }
                   },
                   password: {
                	    validators: {
                	        identical: {
                	            field: 'checkPwd',
                	            message: $.i18n.prop('personal-settingsForm-check-pwd-Invalid')
                	        }
                	    }
                	},
                	checkPwd: {
                	    validators: {
                	        identical: {
                	            field: 'password',
                	            message: $.i18n.prop('personal-settingsForm-check-pwd-Invalid')
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
	           // Use Ajax to submit form data 提交至form标签中的action，result自定义
	           var params  = JSON.stringify($form.serializeJSON());
	           $.ajax({
	               type : "POST",
	               dataType : 'json',
	               url  : $form.attr('action'),
	               data : params,
	               contentType:"application/json",
	               success : function(result) {
	                   if ( result.code==100 ) {
	                	   $("#personalSettings_modal").modal('hide');
	                       layer.msg($.i18n.prop('save-success'), {time:1500, icon:6}, function(){
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