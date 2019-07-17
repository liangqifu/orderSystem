
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE>
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
	<style type="text/css">
        *{margin: 0px; padding:0px; font-family:"微软雅黑";font-size:16px;}
        a {text-decoration: none; color: #1064A0;}
        h1,h2 {margin:0;font-weight:normal; font-family: "微软雅黑" ; }
        .errorpPage-box h1{font-size:44px; color:#0188DE; padding:20px 0px 10px;}
        .errorpPage-box h2{color:#0188DE; font-size:16px; padding:10px 0px 40px;}
        .errorpPage-box p{color:#666;}
        .errorpPage-box{width:910px; padding:20px 20px 40px; margin-top:80px;border-style:dashed;border-color:#e4e4e4;line-height:30px;margin-left:auto; margin-right:auto;}
        .errorpPage-operate .operateBtn{width:180px; height:28px; margin-left:0px; margin-top:10px; background:#009CFF; border-bottom:4px solid #0188DE; text-align:center;display:inline-block;font-size:14px; color:#fff; }
        .errorpPage-operate .operateBtn:hover{ background:#5BBFFF;}
    </style>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery.serializejson.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery.template.js"></script>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery.formautofill.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/jquery/jquery.formatDateTime.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/bootstrap/js/fileinput.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/jquery/jquery.i18n.properties.js"></script>
    <script type="text/javascript" src="${APP_PATH}/script/language.js"></script>
    
  </head>

<body>
<div class="errorpPage-box">
    <h1 class="i18n" data-properties="error-h1" data-ptype="text" ></h1>
    <p class="i18n" data-properties="error-p" data-ptype="text"></p>
    <div class="errorpPage-operate">
        <a href="javascript:window.location.reload()" class="operateBtn i18n" data-properties="error-try-ref" data-ptype="text" ></a>
        <a href="${APP_PATH}/admin/main" class="operateBtn i18n" data-properties="error-goback" data-ptype="text" ></a>
    </div>
</div>

</body>
</html>