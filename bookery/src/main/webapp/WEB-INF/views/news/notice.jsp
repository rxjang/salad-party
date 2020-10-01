<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<style type="text/css">
	.best-books{
		margin-top: 20px;
		border: 1px solid #e4e4e4;
	}
	.notice{
		margin-top: 20px;
		border: 1px solid #e4e4e4;
	}
</style>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<%@ include file="../template/news-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-md-1">
	</div>
	<div class="col-xs-12 col-md-10 best-books">
		<h3>회원들이 </h3>
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    이번 주<span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
		    <li><a href="#">이번 주</a></li>
		    <li><a href="#">이번 달</a></li>
		    <li><a href="#">올해</a></li>
		  </ul>
		  가장 많이 읽은 책
	</div>
	<div class="col-md-1">
	</div>
</div>
<div class="row">
	<div class="col-md-1">
	</div>
	<div class="col-xs-12 col-md-10 notice">
		<h3>책거리 알림</h3>
	</div>
	<div class="col-md-1">
	</div>
</div>
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
