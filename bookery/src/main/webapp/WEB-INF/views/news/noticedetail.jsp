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
	.submit,.edit{
		color:white;
		background-color:#c0cfb2;
		border:1px solid #c0cfb2;
	}
	.submit:hover,.edit:hover{
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
var num=${noticeOne.num}
	
	$(function(){
		//글 분류 번호에 따라 제목 설정
		if(num==1){
			$(".menu-title").text("공지사항 상세보기");
		}else if(num==2){
			$(".menu-title").text("FAQ 상세보기");
		}else if(num==3){
			$(".menu-title").text("1:1 문의 글 상세보기");
		}
		
		//수정버튼 활성화
		$(".submit").on("click",function(){
			if($(".submit").val()=="수정"){
				$(".submit").val("입력");
				$(".reset").val("취소");
				$(".content-title").prop("readonly",false);
				$(".content-main").prop("readonly",false);
			}else if($(".submit").val()=="입력"){
				var form=$(".form");
				form.submit();
			}
		});//submit
		//삭제버튼 활성화
		$(".reset").on("click",function(){
			if($(".reset").val()=="삭제"){
				var form=$(".form");
				$(".restful").val("delete");
				form.submit();
				
			}else if($(".reset").val()=="취소"){
			}
		});
	});//ready
</script>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<%@ include file="../template/news-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 notice-submenu"><span class="menu-title"></span></div>
	<div class="col-md-2"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 center-content">
		<form method="POST" action="./${noticeOne.id}" class="form">
		<input type="hidden" name="_method" value="put" class="restful">
		<div class="content-box">
			<input type="hidden" name="num" value="${noticeOne.num}"/>
			<input type="hidden" name="depth" value="${noticeOne.depth}"/>
			<input type="text" class="content-title" name="title" value="${noticeOne.title}" readonly/>
			<textarea class="content-main" name="content" rows="15" readonly>${noticeOne.content}</textarea>
		</div><!-- content-box -->
		<div class="btns">
			<input type="button" class="btn submit" value="수정">
			<input type="button" class="btn reset" value="삭제">
		</div>
		</form>
	</div><!-- center-content -->
	<div class="col-md-2"></div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>