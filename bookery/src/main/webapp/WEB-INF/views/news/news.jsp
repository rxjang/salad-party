<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<style type="text/css">
	em{
		color:#787878;
	}
	em:hover{
		color:#49654d;
		font-weight:bold;
		text-decoration:none;
	}
	.row{
		padding:10px 0px 20px 0px; 
	}
	.best-books{
		width:100%;
	}
	.title{
		font-weight:bold;
	}
	.best-books li{
		width:20%;
		float:left;
		list-style:none;
		margin-bottom:10px;
	}
	.book-image{
		box-shadow: 2px 2px 6px rgba(0,0,0,.1), 0 0 2px rgba(0,0,0,.2);
	}
	/********************************realtime-content-css*******************************/
	.item{
	    box-shadow: 0 2px 8px rgba(0,0,0,.1), 0 8px 20px rgba(0,0,0,.1);
	    border-radius: 16px;
	    overflow: hidden;
	    margin-left: 10px;
	    height:350px;
	    color:white;
	    margin-bottom:20px;
	}
	.item-inner{
		height:100%;
		background-color:rgba(0,0,0,0.5);
	}
	.item-content{
		padding:15px;
		height:47%;
	}
	.realtime-book-info{
		padding:15px;
		height:33%;
	}
	.realtime-book-info a{
		color:white;
	}
	.owl-carousel .owl-item .book-image-content{
   		display: inline;
    	width: 20%;
	}
	.realtime-book-title{
		width:70%;
		margin:0px;
		display:inline-block;
	}
	.user-info{
		padding:15px;
		position:relative;
		height:20%;
		background-color:white;
	}
	/********************************ad-css*******************************/
	.ad{
		height:200px;
		background-color:#e4e6da;
	}
	/********************************notice-css*******************************/
	.notice{
		margin-bottom:20px;
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
	.glyphicon-menu-down{
		padding-top:10px;
		float:right;
	}
	.more-btn{
		float:right;
		margin-left:5px;
	}
	@media (max-width:900px) {
		.best-books li{
			width:45%;
		}
	}
</style>
<script>
var i=0;
$(function(){
	$(".content-main").hide();
	
	$('.book-title').each(function(){
		if($(this).text().length > 12){
			$(this).text($(this).text().substring(0,12)+' ...');			
		}
	});//book-title each
	$('.writer').each(function(){
		if($(this).text().length > 15){
			$(this).text($(this).text().substring(0,15)+' ...');			
		}
	});//writer each
	$('.real-time-content').each(function(){
		if($(this).text().length > 100){
			$(this).text($(this).text().substring(0,100)+' ...');			
		}
	});//real-time-content each
	
	//글내용 열고 닫기는 횟수 기준으로
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
	
	$(".title").each(function(){
		$(this).children(".depth-1").text("[공지]");
	});
	
	$(".item").each(function(){
		i++;
		$(this).css("background","url(\"${pageContext.request.contextPath}/resources/imgs/news/real-time"+i+".JPG\")center/cover");
	});
	
	$('.owl-carousel').owlCarousel({
	    loop:true,
	    autoplay : true,
		center: true,
	   	margin:20,
	    nav:false,
	    dots:false,
	    responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
			300 : {
				items:2
			},
			1200 : {
				items:4
			}
		}
	});//owl-carousel
});//ready
</script>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<!-- **********content start**********-->
<div class="row">
	<p>케러셀자리</p>
</div><!-- row -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<h4 class="title">책거리 회원들이 많이 공부하는 책</h4>
		<ul class="best-books">
		<c:forEach items="${bestBooks }" var="best"><!-- 많이 공부 중인 책 리스트 -->
		<li>
			<a href='${pageContext.request.contextPath }/find/book/${best.bid}'>
				<img class="book-image" alt="image loading fail" src="${best.coverurl }"><br/>
				<span class="book-title">${best.title }</span>
			</a>
		</li>
		</c:forEach>
		</ul>
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<h4 class="title">실시간 게시글</h4>
		<div class="owl-carousel owl-theme">
			<c:forEach items="${contentList }" var="contents">
				<div class="item">
					<div class="item-inner">
						<div class="item-content">
							<h4 class="title">${contents.title}</h4>
							<p class="real-time-content">${contents.content}</p>
						</div><!-- item-content -->
						<div class="realtime-book-info">
							<img class="book-image-content" src="${contents.coverurl }" alt="책 이미지"/>
							<a href="${pageContext.request.contextPath }/find/book/${contents.book_bid }" class="realtime-book-title">
								<b class="book-title">&nbsp;${contents.book_title }</b><br/>
								<small class="writer">&nbsp;${contents.writer }</small>
							</a>
						</div><!-- realtime-book-info -->
						<div class="user-info">
							<a href="${pageContext.request.contextPath }/club/detail/${contents.id}">
								<strong>작성자</strong>&nbsp;${contents.nickname}<br/><em>게시글로 이동</em>
							</a>
						</div>
					</div><!-- item-inner -->
				</div><!-- item -->
			</c:forEach>
		</div><!-- owl end -->
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<h4 class="title">북커리 랭킹</h4>
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row">
	<div class="col-xs-12 col-md-12 ad">
	</div>
</div><!-- row -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10 notice">
	<h4 class="title">
		<a href="${pageContext.request.contextPath }/news/notice">
		<span class="glyphicon glyphicon-bullhorn"></span>&nbsp;책거리 알림</a>
	</h4>
	<c:forEach items="${noticeList }" var="bean">
		<div class="content-box">
			<div class="content-title">
				<span class="glyphicon glyphicon-menu-down"></span>
				<h4 class="title"><span class="depth-${bean.depth }"></span>${bean.title }</h4>
				<p>${bean.createtime }</p>
			</div><!-- content-title -->
			<div class="content-main">
				${bean.content }
			</div><!-- content-main -->
		</div><!-- content-box -->
		</c:forEach>
		<a class="more-btn" href="${pageContext.request.contextPath }/news/notice"><em>공지사항 더보기</em></a>
	</div><!-- notice -->
	<div class="col-md-1"></div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
