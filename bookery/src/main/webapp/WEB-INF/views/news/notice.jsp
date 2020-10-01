<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<style type="text/css">
	img{
		width:1.5em;
	}
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
	.onetoone{
		color:#787878;
	}
	.onetoone:hover{
		color:#49654d;
		font-weight:bold;
		text-decoration:none;
	}
	@media (max-width:1000px) {
		.content-main{
			font-size:1.2em;
		}
	}
</style>
<script>
	$(function(){
	 	$(".content-main").hide();
		$(".2-box").hide();
		$(".3-box").hide();
		$(".1-box").show();
		
		$(".off").each(function(){
			$(this).on('click',function(){
				$(".on").addClass("off");
				$(".on").removeClass("on");
				$(this).addClass("on");
				$(this).removeClass("off");
				
				if($(".on").text()=="공지사항"){
					$(".2-box").hide();
					$(".3-box").hide();
					$(".1-box").show();
				}else if($(".on").text()=="FAQ"){
					$(".1-box").hide();
					$(".3-box").hide();
					$(".2-box").show();
				}else if($(".on").text()=="1:1 문의"){
					$(".1-box").hide();
					$(".2-box").hide();
					$(".3-box").show();
				}
			});//click
		});//off
		
		$(".content-box").each(function(){
			var clickTimes = 0;
			$(this).on('click',function(){
				clickTimes++;
				if((clickTimes%2)==0){
					$(this).children('.content-main').hide();
				}else{
					$(this).children('.content-main').show();
				}
			});//click
		});//content-box
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
		<div class="3-box info-ment">
			<div class="content-title">
				<h4><span class="usernmae">${user.nickname }</span>님 <br/>무엇을 도와 드릴까요?<img src="${pageContext.request.contextPath}/resources/imgs/Smile-blush.png" alt="?"></h4>
				<a href="#" class="onetoone"> 1:1 문의 하기</a>
			</div>
			<div class="content-main 3-box">
				남겨주신 문의는 담당자 확인 후 빠른 시일 내에 답변 드리겠습니다.<br/>
				북커리를 이용해주셔서 감사합니다.
			</div>
		</div>
		<c:forEach items="${noticeList }" var="bean">
		<div class="content-box ${bean.num }-box">
			<div class="content-title">
				<h4 class="title">${bean.title }</h4>
				<p class="1-box 3-box">${bean.createtime }</p>
			</div><!-- content-title -->
			<div class="content-main">
				${bean.content }
			</div><!-- content-main -->
		</div><!-- content-box -->
		</c:forEach>
		<div class="ask 2-box">
			<em>그래도 해결이 안되시나요?</em> <a href="#" class="onetoone"> 1:1 문의 하기</a>
		</div>
	</div><!-- center-content -->
	<div class="col-md-2"></div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
