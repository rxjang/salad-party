<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<style type="text/css">
	.notice-submenu{
		font-size:1.3em;
		text-align:center;
		border-bottom: 1px solid #e4e4e4;
		margin-bottom:10px;
		padding:10px;
	}
	.on{
		color:#8ba898;
		font-weight:bold;
	}
	.off:hover{
		color:#8ba898;
		font-weight:bold;
		cursor: pointer;
	}
	.content-box{
		margin: 10px auto;
		border: 1px solid #e4e4e4;
		border-radius:5px;
	}
	.content-box:hover{
		border: 1px solid #C0CFB2;
		cursor: pointer;
	}
	.content-title{
		padding:5px 20px;
	}
	.glyphicon-menu-down{
		padding-top:10px;
		float:right;
	}
	.content-main{
		padding:5px 20px;
		padding-bottom:20px;
	}
	.info-ment{
		background-color:#ecece9;
		margin-bottom:10px;
	}
	.usernmae{
		font-weight:bold;
		color:#49654d;
	}
	.ask{
		float:right;
		color: black;
		margin:10px auto;
	}
	.notice-btn, .ask-btn{
		float:right;
		margin-left:5px;
		color:#787878;
	}
	.notice-btn:hover, .ask-btn:hover{
		color:#49654d;
		font-weight:bold;
		text-decoration:none;
	}
	.write-btn{
		float:none;
		position:relative;
		left:93%;
	}
	@media (max-width:1000px) {
		.content-main{
			font-size:1.2em;
		}
	}
</style>
<script>
var id=${user.id}//admin계정일시 공지사항 수정 위해
	$(function(){
		
	});//ready
	
</script>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<%@ include file="../template/news-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-4 col-md-2 notice-submenu"><span class="off">FAQ</span></div>
	<div class="col-xs-4 col-md-4 notice-submenu"><span class="on off">공지사항</span></div>
	<div class="col-xs-4 col-md-2 notice-submenu"><span class="off">1:1 문의</span></div>
	<div class="col-md-2"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 center-content">
		<div class="content-box">
			<div class="content-title">
				<h4 class="title">$title</h4>
			</div><!-- content-title -->
			<div class="content-main">
				content
			</div><!-- content-main -->
		</div><!-- content-box -->
	</div><!-- center-content -->
	<div class="col-md-2"></div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
