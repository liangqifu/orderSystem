<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <meta id="i18n_pagename" content="message">
    <meta id="appPath" content="${APP_PATH}">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrapValidator.min.css">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-select.min.css">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-datepicker3.min.css">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap-datepicker3.standalone.min.css">
	<link rel="stylesheet" media="all" href="${APP_PATH}/bootstrap/css/fileinput.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/login.css">
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery.serializejson.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/fileinput.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/jquery/jquery.i18n.properties.js"></script>
    <script type="text/javascript" src="${APP_PATH}/script/language.js"></script>
    <script type="text/javascript" src="${APP_PATH}/layer/layer.js"></script>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #393C3D;border-bottom-color:#666868" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a href="${APP_PATH}/admin/login" class="navbar-brand i18n" style="font-size:32px;" data-properties="systemName" data-ptype="text"></a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
           <li style="margin-left:10px;padding-top:8px;margin-right: 25px">
                <select id="language_setting">
				    <option value="zh_CN">中文简体</option>
				    <option value="en_US">English</option>
				</select>
            </li> 
        </ul>
    </div>
      </div>
    </nav>

    <div class="container" style="padding-top: 110px">
      <form id="loginForm" action="${APP_PATH}/admin/doLogin" method="post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user i18n" data-properties="loginForm-title" data-ptype="text" ></i></h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control i18n" data-properties="loginForm-placeholder-account" data-ptype="placeholder" id="account" name="account" placeholder="" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control i18n" data-properties="loginForm-placeholder-password" data-ptype="placeholder" id="password" name="password" placeholder="" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
          <button type="submit" class="btn btn-lg btn-success btn-block i18n " data-properties="loginForm-btn-name" data-ptype="text" ></button>
      </form>
    </div>
    
    <script type="text/javascript">
    $(function () {
    	$('#loginForm').bootstrapValidator({
        	// 默认的提示消息
            message: 'This value is not valid',
            // 表单框里右侧的icon
            feedbackIcons: {
              　　　　　　　　valid: 'glyphicon glyphicon-ok',
              　　　　　　　　invalid: 'glyphicon glyphicon-remove',
              　　　　　　　　validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	account:{
                    validators: {
                        notEmpty: {
                            message: $.i18n.prop('loginForm-account-notempty')
                        }
                    }
                },
                password:{
                    validators: {
                        notEmpty: {
                            message: $.i18n.prop('loginForm-password-notempty')
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
            var loadingIndex = null;
            $.ajax({
                type : "POST",
                dataType : 'json',
                url  : $form.attr('action'),
                data : params,
                contentType:"application/json",
                beforeSend : function(){
            		loadingIndex = layer.msg('处理中', {icon: 16});
            	},
                success : function(result) {
                	layer.close(loadingIndex);
                    if ( result.code==100 ) {
                    	window.location.href = "${APP_PATH}/admin/main";
                    } else {
                    	layer.msg($.i18n.prop('loginForm-account-or-pwd-Invalid'), {time:2000, icon:5, shift:6}, function(){});
                    }
                }
            });
        });
    	
    });
    </script>
  </body>
</html>