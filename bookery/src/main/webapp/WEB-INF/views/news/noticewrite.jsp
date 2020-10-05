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
	.reset{
		background-color:#e4e4e4;
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
var id=${user.id}//admin계정일시 공지사항 수정 위해
	$(function(){
		var ref = location.href;
		var temp=ref.substring(ref.lastIndexOf('/')+1);
		if(temp==1){
			$(".num").val(temp);
			$(".form").attr("action","./1");
			$(".menu-title").text("공지사항 작성");
		}else if(temp==2){
			$(".num").val(temp);
			$(".form").attr("action","./2");
			$(".menu-title").text("FAQ 작성");
		}else if(temp==3){
			$(".num").val(temp);
			$(".form").attr("action","./3");
			$(".menu-title").text("1:1문의 글 작성");
		}
		
		$(".submit").on("click",function(){
			var result = $(".content-main").val().replace(/(\n|\r\n)/g, '<br>');
			$(".content-main").val(result);			
		});
		
	});//ready
	
</script>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<!-- **********content start**********-->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 notice-submenu"><span class="menu-title"></span></div>
	<div class="col-md-2"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 center-content">
		<form method="POST"class="form">
		<div class="content-box">
			<input type="hidden" name="user_id" value="${user.id }"/>
			<input type="hidden" name="num" class="num"/>
			<input type="hidden" name="depth" value="0"/>
			<input type="text" class="content-title" name="title" placeholder="제목을 입력하세요"/>
			<textarea class="content-main" name="content" placeholder="문의할 내용을 작성하세요" rows="15"></textarea>
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
