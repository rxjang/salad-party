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
		margin: 5px auto;
		padding-top:5px;
		font-weight:bold;
	}
	.content-box{
		margin: 10px auto;
		padding:5px 15px;
		border: 1px solid #e4e4e4;
	}
	.content-title{
		width:100%;
		font-size:1.2em;
		border:0px;
		padding:10px;
		margin-top:10px;
		border-bottom: 1px solid #e4e4e4;
	}
	.content-info{
		line-height:3em;
		border-bottom: 1px solid #e4e4e4;
	}
	.content-info strong,label{
		padding-left:10px;
	}
	.content-main{
		width:100%;
		resize: none;
		padding:10px;
		border:0px;
	}
	.btns{
		text-align:center;
	}
	.submit{
		color:white;
		background-color:#c0cfb2;
		border:1px solid #c0cfb2;
	}
	.submit:hover{
		color:white;
		border:1px solid #c0cfb2;
	}
	.reset:hover{
		border:1px solid #e4e4e4;
	}
	@media (max-width:1000px) {
		.content-main{
			font-size:1.2em;
		}
	}
</style>
<script>
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
	<div class="col-xs-12 col-md-8 notice-submenu"><span class="menu-title">1:1 문의 글 답변</span></div>
	<div class="col-md-2"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 center-content">
		<div class="content-box">
			<input type="hidden" name="num" value="${noticeOne.num}"/>
			<input type="hidden" name="depth" value="${noticeOne.depth}"/>
			<input type="text" class="content-title" name="title" value="${noticeOne.title}" readonly/>
			<p class="content-info">
				<strong>작성일</strong>&nbsp;${noticeOne.createtime }
			</p>
			<input type="text" class="content-main" name="content" value="${noticeOne.content}" readonly/>
		</div><!-- content-box -->
		<form method="POST" action="./${noticeOne.id}" class="form">
		<div class="content-box">
			<input type="hidden" name="user_id" value="${user.id }"/>
			<input type="hidden" name="num" value="3"/>
			<input type="hidden" name="depth" value="1"/>
			<input type="hidden" name="ref" value="${noticeOne.id}"/>
			<input type="hidden" class="content-title" name="title"/>
			<textarea class="content-main" name="content" placeholder="답변 내용을 작성하세요" rows="15"></textarea>
		</div><!-- content-box -->
		<div class="btns">
			<button type="submit" class="btn submit">작성</button>
			<button type="reset" class="btn reset">취소</button>
		</div>
		</form>
	</div><!-- center-content -->
	<div class="col-md-2"></div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
