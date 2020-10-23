<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<style type="text/css">
	
	.news-row{
		padding-bottom:35px;
	}
	.title{
		font-weight:bold;
	}
	/********************************carousel-css*******************************/
	.news-carousel .item{
		width:100%;
		margin:0px;
		height:300px;
		overflow: hidden;
	}
	.item1{
		background: rgb(228,230,218);
		background: linear-gradient(90deg, rgba(228,230,218,1) 0%, rgba(199,255,255,1) 100%);
	}
	.item2{
		background: rgb(199,255,255);
		background: linear-gradient(90deg, rgba(199,255,255,1) 0%, rgba(227,255,219,1) 100%);
	}
	.item3{
		background: rgb(227,255,219);
		background: linear-gradient(90deg, rgba(227,255,219,1) 0%, rgba(254,255,191,1) 100%);
	}
	.item4{
		background: rgb(254,255,191);
		background: linear-gradient(90deg, rgba(254,255,191,1) 0%, rgba(173,211,255,1) 100%);
	}
	.item5{
		background: rgb(173,211,255);
		background: linear-gradient(90deg, rgba(173,211,255,1) 0%, rgba(228,230,218,1) 100%);
	}
	.news-main{
		height:100%;
	}
	.car-ment{
		position:relative;
		margin-top:8%;
	}
	.main-ment{
		font-weight:900;
	}
	.owl-carousel .owl-item .item-image{
		width:28%;
		display:inline;
		position:absolute;
		top:20%;
		left:60%;
	}
	.owl-carousel .owl-item .phone{
		width:25%;
		top:10%;
	}
	.owl-carousel .owl-item .group{
		width:40%;
	}
	/********************************bestbooks-css*******************************/
	.best-books{
		width:100%;
		text-align:center;
	}
	.book-list{
		width:18%;
		float:left;
		list-style:none;
		margin:10px;
		height:230px;
	}
	.list-image{
		padding:10px;
		width:100%;
	    border-radius: 10px;
	    margin-bottom:5px;
		height:220px;
		border:1px solid #e4e4e4;
	}
	.book-image{
		box-shadow: 2px 2px 6px rgba(0,0,0,.1), 0 0 2px rgba(0,0,0,.2);
	}
	.glyphicon-info-sign{
		float:right;
		color:#b4b4b4;
	}
	/********************************realtime-content-css*******************************/
	.real-time-item{
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
	/********************************rank-css*******************************/
	.rank-inner{
		text-align:center;
	}
	.rank1,.rank2{
		width:45%;
		display:inline-block;
		text-align:left;
		margin:0 2em;
	}
	.rank-image{
		width:1.5em;
	}
	.rank-content{
		line-height:4em;
		border-top:1px solid #e4e4e4;	
	}
	.rank-num,.rank-num2{
		padding: 0 1.5em;
		color:#828282;
		font-size:1.3em;
	}
	.rank-who{
		padding: 0 3em;
	}
	.rank-what{
		float:right;
		padding-right:4em;
	}
	/********************************ad-css*******************************/
	.ad-book{
		text-align:center;
		height:280px;
	}
	.ad-complicated-image{
		position:relative;
		height:55%;
		z-index:3;
	}
	.bg{
		background-color:#e4e6da;
		position: absolute;
	    bottom: 0;
	    left: 0;
	    width: 100%;
	    height: 220px;
	}
	.box{
		width: 0;
	    height: 0;
	    border-top: 60px solid #fff;
	    border-right: 100vw solid transparent;
	}
	.box2{
		width: 0;
	    height: 0;
	    border-bottom: 60px solid #fff;
	    border-left: 100vw solid transparent;
	    margin-top: 100px;
	}
	.comment-title{
		position:relative;
		z-index:3;
		font-size:1.4em;
		margin-bottom:0px;
	}
	.comment{
		position:relative;
		z-index:3;
	}
	.ad{
		text-align:center;
		height:150px;
		background-color:#e4e6da;
	}
	.ad-image{
		margin-top:20px;
		height:70%;
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
	.cut-15{
		font-weight:bold;
	}
	@media (max-width:900px) {
		.book-list{
			width:45%;
		}
		.item-content{
			height:45%;
			font-size:1.2em;
		}
		.realtime-book-info{
			font-size:1.2em;
			height:35%;
			padding-top:0px;
			padding-bottom:20px;
		}
		.rank1,.rank2{
			width:90%;
			margin-bottom:1.5em;
		}	
	}
	@media (max-width:990px) {
		.car-ment{
			margin-left:30px
		}
	}
	@media (max-width:550px) {
		/********************************carousel-css*******************************/
		.news-carousel .item{
			margin:0px;
			height:250px;
		}
		.car-ment h2{
			font-size:1.8em;
		}
		.car-ment h4{
			font-size:1.2em;
		}
		.owl-carousel .owl-item .item-image{
			width:45%;
			top:38%;
			left:40%;
		}
		.owl-carousel .owl-item .phone,.owl-carousel .owl-item .write{
			width:35%;
			top:40%;
		}
		
		.owl-carousel .owl-item .group{
			width:50%;
		} 
	/********************************bestbooks-css*******************************/
		.book-list{
			width:40%;
			height:200px;
		}
		.book-image{
			width:80%;
		}
		.list-image{
			height:190px;
		}
	}
</style>
<script>
var i=0;

$(function(){
	$(".content-main").hide();
	$('[data-toggle="tooltip"]').tooltip()
	
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
	
	$(".real-time-item").each(function(){
		i++;
		$(this).css("background","url(\"${pageContext.request.contextPath}/resources/imgs/news/real-time"+i+".JPG\")center/cover");
		if(i>10){
			i=1;
		}
	});
	i=0;
	$(".rank-num").each(function(){
		i++;
		$(this).text(i);
	});
	i=0;
	$(".rank-num2").each(function(){
		i++;
		$(this).text(i);
	});
	$('.news-carousel').owlCarousel({
	    loop:true,
	    autoplay : true,
	    autoplayTimeout:7000,
	    smartSpeed:700,
	    dots:false,
	    nav:true,
	    responsive:{
	        0:{
	            items:1
	        }
	    }
	})
	$('.real-time-carousel').owlCarousel({
	    loop:true,
	    autoplay : true,
		center: true,
	   	margin:20,
	    nav:false,
	    dots:false,
	    responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
			300 : {
				items:1
			},
			600 : {
				items:2
			},
			1200 : {
				items:4
			}
		}
	});//real-time-carousel
});//ready
</script>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<!-- **********content start**********-->
<div class="row news-row">
	<div class="owl-carousel owl-theme news-carousel">
		<div class="item item1">
			<div class="col-md-2"></div>
			<a href="${pageContext.request.contextPath }/today">
			<div class="col-xs-12 col-md-8 news-main">
				<div class="car-ment">
					<h2 class="main-ment">오늘의 기록, 잘하고 계신가요?</h2>
					<h4 class="sub-ment">그래프로 한눈에 보는 목표치,<br/>오늘의 기록에서 확인 할 수 있습니다</h4>
				</div>
				<img class="item-image write" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/record.png"><br/>
			</div>
			</a>
			<div class="col-md-2"></div>
		</div><!-- item -->
		<div class="item item2">
			<div class="col-md-2"></div>
			<a href="${pageContext.request.contextPath }/club">
			<div class="col-xs-12 col-md-8 news-main">
				<div class="car-ment">
					<h2 class="main-ment">스터디는 북커리 회원들과 함께!</h2>
					<h4 class="sub-ment">책에 관한 이야기를 나누어 보아요</h4>
				</div>
				<img class="item-image group" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/group.png"><br/>
			</div>
			</a>
			<div class="col-md-2"></div>
		</div><!-- item -->
		<div class="item item3">
			<div class="col-md-2"></div>
			<a href="${pageContext.request.contextPath }/find">
			<div class="col-xs-12 col-md-8 news-main">
				<div class="car-ment">
					<h2 class="main-ment">막막하던 수험서 공부,</h2>
					<h4 class="sub-ment">북커리가 도와드리겠습니다<br/>내서재에 책을 추가하러 가요!</h4>
				</div>
				<img class="item-image" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/toby.png"><br/>
			</div>
			</a>
			<div class="col-md-2"></div>
		</div><!-- item -->
		<div class="item item4">
			<div class="col-md-2"></div>
			<a href="${pageContext.request.contextPath }/news/notice/detail/2">
			<div class="col-xs-12 col-md-8 news-main">
				<div class="car-ment">
					<h2 class="main-ment">북커리 오픈 이벤트</h2>
					<h4 class="sub-ment">북커리 오픈 기념 푸짐한 선물을<br/>회원분들께 제공합니다</h4>
				</div>
				<img class="item-image" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/present.png"><br/>
			</div>
			</a>
			<div class="col-md-2"></div>
		</div><!-- item -->
		<div class="item item5">
		<div class="col-md-2"></div>
			<a href="${pageContext.request.contextPath }">
			<div class="col-xs-12 col-md-8 news-main">
				<div class="car-ment">
					<h2 class="main-ment">북커리 사용법이 궁금하다면,</h2>
					<h4 class="sub-ment">어렵지 않아요!<br/>남녀노소 사용하기 쉽게 알려드립니다</h4>
				</div>
				<img class="item-image phone" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/phone.png"><br/>
			</div>
			</a>
			<div class="col-md-2"></div>
		</div><!-- item -->
	</div>
</div><!-- row -->
<div class="row news-row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<h4 class="title">책거리 회원들이 많이 공부하는 책</h4>
		<ul class="best-books">
		<c:forEach items="${bestBooks }" var="best"><!-- 많이 공부 중인 책 리스트 -->
		<li class="book-list">
			<a href="${pageContext.request.contextPath }/find/book/${best.bid}">
				<div class="list-image" data-toggle="tooltip" data-placement="bottom" title="${best.title }">
					<img class="book-image" alt="image loading fail" src="${best.coverurl }"><br/>
				</div>
				<span class="book-title title cut-12">${best.title }</span><span class="glyphicon glyphicon-info-sign"></span>
			</a>
		</li>
		</c:forEach>
		</ul>
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row news-row">
	<div class="col-xs-12 col-md-12 ad-book">
		<a href="${pageContext.request.contextPath }/find/book/16415934">
			<img class="ad-complicated-image" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/complicated.png"><br/>
			<p class="comment-title"><strong>IT시대! 얼마나 준비되셨나요?</strong></p>
			<p class="comment">꼭 필요한 IT지식을 비전공자도<br/> 이해할 수 있도록 쉽게 알려드립니다</p>
			<div class="bg">
				<div class="box"></div>
				<div class="box2"></div>
			</div>
		</a>
	</div>
</div><!-- row -->
<div class="row news-row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<h4 class="title">실시간 게시글</h4>
		<div class="owl-carousel owl-theme real-time-carousel">
			<c:forEach items="${contentList }" var="contents">
				<div class="item real-time-item">
					<div class="item-inner">
						<div class="item-content">
							<h4 class="title">${contents.title}</h4>
							<p class="real-time-content cut-100">${contents.content}</p>
						</div><!-- item-content -->
						<div class="realtime-book-info">
							<img class="book-image-content" src="${contents.coverurl }" alt="책 이미지"/>
							<a href="${pageContext.request.contextPath }/find/book/${contents.book_bid }" class="realtime-book-title">
								<b class="book-title cut-15">&nbsp;${contents.book_title }</b><br/>
								<small class="writer cut-15">&nbsp;${contents.writer }</small>
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
<div class="row news-row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10 rank">
		<h4 class="title">북커리 랭킹</h4>
		<div class="rank-inner">
			<div class="rank1">
				<h4><img class="rank-image" src="${pageContext.request.contextPath}/resources/imgs/news/open-book.png"/>&nbsp;북커리 완독왕</h4>
				<c:forEach items="${bestUserList }" var="bestUser">
				<div class="rank-content">
					<span class="rank-num"></span>
					<span class="rank-who"><b>${bestUser.nickname }</b></span>
					<span class="rank-what"><img class="rank-image" src="${pageContext.request.contextPath}/resources/imgs/news/book.png"/>
					&nbsp;${bestUser.pages }</span>
				</div>
				</c:forEach>
			</div><!-- rank1 -->
			<div class="rank2">
				<h4><img class="rank-image" src="${pageContext.request.contextPath}/resources/imgs/news/content.png"/>&nbsp;북커리 인기글</h4>
				<c:forEach items="${popularContents }" var="popular">
				<div class="rank-content">
					<span class="rank-num2"></span>
					<a href="${pageContext.request.contextPath}/club/detail/${popular.id}"><span class="rank-who cut-20"><b>${popular.title }</b></span></a>
					<span class="rank-what"><img class="rank-image" src="${pageContext.request.contextPath}/resources/imgs/news/thumb-up.png"/>
					&nbsp;${popular.num }</span>
				</div>
				</c:forEach>
			</div><!-- rank2 -->
		</div>
	</div><!-- rank -->
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row news-row">
	<div class="col-xs-12 col-md-12 ad">
		<a href="${pageContext.request.contextPath }/today">
			<img class="ad-image" alt="image loading fail" src="${pageContext.request.contextPath}/resources/imgs/news/ad-record.png"><br/>
		</a>
	</div>
</div><!-- row -->
<div class="row news-row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10 notice">
	<h4 class="title">
		<a href="${pageContext.request.contextPath }/news/notice">
		<span class="glyphicon glyphicon-bullhorn"></span>&nbsp;북커리 알림</a>
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
