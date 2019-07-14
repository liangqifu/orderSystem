<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
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
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/fileinput.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/jquery/jquery.i18n.properties.js"></script>
    <script type="text/javascript" src="${APP_PATH}/script/language.js"></script>
    
  </head>

  <body>
  <%@include file="/WEB-INF/jsp/common/header.jsp"%>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<%@include file="/WEB-INF/jsp/common/menu.jsp"%>
        </div>
        <div >
          
          <iframe id="mainIframe" src="" style="height: 95%;" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"></iframe>
                 
        
        </div>
      </div>
    </div>
    
  </body>
</html>
