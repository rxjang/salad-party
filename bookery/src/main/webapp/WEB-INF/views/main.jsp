<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookery</title>
<%@ include file="template/head.jspf"%>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/nanummyeongjo.css);
	body{
		background-color:#e4e6da;
	}
	video{
		width:80%;
	}
	.font{
		font-family:나눔명조, Nanum Myeongjo;
		font-weight:bold;
		font-size:4em;
		color:#49654d;
	}
	.font-sub{
		font-family:나눔명조, Nanum Myeongjo;
		color:#253629;
		font-weight:bold;
		font-size:1.3em;
		margin:10px;
	}
	.sub-ment{
		font-weight:bold;
	}
	.empty{
		height:250px;
	}
	.btn{
		background-color:#c0cfb2;
		font-size:1.3em;
		padding:10px 15px;
		border-radius:10px;
	}
	.btn:hover{
		background-color:#c0c8b2;
	}
	.nav{
		margin:10px;
		padding:10px;
	}
	.login-btn{
		position: fixed;
	    top: 30px;
	    right: 135px;
	    width: 67px;
	    height: 29px;
	    line-height: 29px;
	    text-align:center;
	    transition: 0.5s;
	    z-index: 100;
	    cursor: pointer;
	    border:1px solid #8ba989;
	    border-radius:15px;
		background-color:#e4e6da;
	    color:#8ba989;
	}
	.login-btn:hover{
	    color:#8ba989;
		font-weight:bold;
	}
	.join-btn{
	    position: fixed;
	    top: 30px;
	    right: 30px;
	    width: 95px;
	    height: 29px;
	    line-height: 29px;
	    text-align:center;
	    background-repeat: no-repeat;
	    opacity: 1;
	    transition: 0.5s;
	    z-index: 100;
	    cursor: pointer;
	    border-radius:15px;
	    background-color:#8ba989;
	    color:#e4e6da;
	}
	.join-btn:hover{
	    color:#e4e6da;
		font-weight:bold;		
	}
	.main-ment img{
		margin:60px;
		width:360px;
	}
	.studying-image-box{
		display:inline;
		margin:0px;
	}
	.studying-image-box img{
		width:60%;
		margin-top:290px;
	}
	.find img{
		width:100%;
	}
	.find-ment{
		margin-top:40px;
		text-align:center;
	}
	.mylib img{
		width:100%;
	}
	.mylib-info{
		margin:30px;
		margin-left:10px;
		display:inline-block;
	}
	.mylib-info-img{
		width:40px;
	}
	.mylib-info-ment{
		padding-top:10px;
	}
	.video-box{
		position:relative;
		text-align:center;
	}
	.news-img{
		width:100%;
		position:absolute;
		top:-10%;
		left:0%;
	}
	.news-ment{
		font-family:나눔명조, Nanum Myeongjo;
		text-align:center;
		margin-top:1em;
		font-weight:bold;
		font-size:2em;
		color:#49654d;
	}
	.club-img-outter{
		position:relative;
	}
	.club-img{
		width:300px;
		box-shadow: 2px 2px 6px rgba(0,0,0,.1), 0 0 2px rgba(0,0,0,.2);
	}
	.club-move{
		position: absolute;
		left:200px;
	}
	.club-btn{
		margin-top:80px;
		margin-left:200px;
	}
	.books-title{
		margin-left:2em;
		font-size:3em;
	}
	.book-list{
		width:10%;
		float:left;
		list-style:none;
		margin:5px;
		height:200px;
		position:relative;
		z-index:2;
	}
	.book-image{
		box-shadow: 2px 2px 6px rgba(0,0,0,.1), 0 0 2px rgba(0,0,0,.2);
	}
	.book-image:hover{
		box-shadow: 2px 2px 6px rgba(0,0,0,.5), 0 0 2px rgba(0,0,0,.7);
	}
	.end{
		margin:100px auto;
		text-align:center;
	}
	.news-btn{
		margin-top:20px;
	}
	@media (max-width:1000px) {
		.empty{
			height:150px;
		}
		.font{
			font-size:2.5em;
		}
		.studying-image-box img{
			width:60%;
			margin-top:0px;
		}
		.club-img{
			width:50%;
			margin-bottom:2em;
		}
		.club-move{
			left:40%;		
		}
		.club-btn{
			margin:10px 0;
			text-align:center;
		}
		.news-ment{
			font-size:1.5em;
		}
	}
</style>
<script>
	$(function(){
		AOS.init();	
		
		$('.book-list').each(function(){
			$(this).mouseenter(function(){
				$(this).css('z-index','10');
			});
			$(this).mouseleave(function(){
				$(this).css('z-index','2');
			});
		});
	});
</script>
</head>
<body>
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="nav">
			<c:if test="${user eq null}">
				<a class="login-btn" href="${pageContext.request.contextPath }/account/login">로그인</a>
				<a class="join-btn" href="${pageContext.request.contextPath }/account/join">회원가입</a>
			</c:if>
			<c:if test="${user ne null}">
				<a class="login-btn" href="${pageContext.request.contextPath }/mylib">내서재</a>
				<a class="join-btn" href="${pageContext.request.contextPath }/account/logout">로그아웃</a>
			</c:if>
		</div>
	</div>
</div><!-- row -->
<div class="row">
	<div class="col-xs-12 col-md-4">
		<div class="main-ment" data-aos="fade-down" data-aos-duration="2000">
			<img src="${pageContext.request.contextPath}/resources/imgs/main/main-ment.png"/>
		</div>
	</div>
	<div class="col-xs-4 col-md-3"></div>
	<div class="col-xs-8 col-md-5">
		<div class="studying-image-box">
			<img src="${pageContext.request.contextPath}/resources/imgs/main/studying.png"/>
		</div>
	</div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
<div class="row">
	<div class="col-xs-1 col-md-1"></div>
	<div class="col-xs-11 col-md-4">
		<div class="find" data-aos="fade-right" data-aos-duration="1500">
			<img src="${pageContext.request.contextPath}/resources/imgs/main/find.PNG"/>
		</div>
	</div>
	<div class="col-xs-12 col-md-7 find-ment">
		<span class="font">공부하고 있는 책을<br/> 북커리 검색에서 찾아보아요<br/></span><br/>
		<a class="btn" href="${pageContext.request.contextPath }/find">검색하러 가기</a>
	</div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
<div class="row">

</div>
<div class="row">
	<div class="col-xs-1 col-md-1"></div>
	<div class="col-xs-11 col-md-6">
		<div class="font">
			내서재에서 목표설정을<br/> 할 수 있어요
		</div><!-- font -->
		<div class="font-sub">
			하루에 끝낼 양 혹은 완료하고 싶은 날짜를<br/> 지정하여 스터디 목표를 세워 보아요
		</div>
		<div>
			<div class="chap mylib-info">
				<img class="mylib-info-img" src="${pageContext.request.contextPath}/resources/imgs/main/chap.png"/>
				<div class="mylib-info-ment">
					<span>챕터를 기준으로 공부하고 싶다면,</span><br/>
					<span class="sub-ment">챕터 중심 목표 설정</span>
				</div><!-- mylib-info-ment -->
			</div><!-- chap -->
			<div class="page mylib-info">
				<img class="mylib-info-img" src="${pageContext.request.contextPath}/resources/imgs/main/page.png"/>
				<div class="mylib-info-ment">
					<span>매일 일정 양을 공부하고 싶다면,</span><br/>
					<span class="sub-ment">페이지 중심 목표 설정</span>
				</div><!-- mylib-info-ment -->
			</div>
		</div>
	</div>	
	<div class="col-xs-12 col-md-4">
		<div class="mylib" data-aos="fade-left" data-aos-duration="1500">
			<img src="${pageContext.request.contextPath}/resources/imgs/main/mylib.png"/>
		</div><!-- mylib -->
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-8 col-xs-12">
		<div class="video-box">
  			<video muted autoplay loop>
    			<source src="${pageContext.request.contextPath}/resources/imgs/main/main-news.mp4" type="video/mp4">
			</video>
			<img class="news-img" src="${pageContext.request.contextPath}/resources/imgs/main/macbook.png"/>
		</div><!-- video-box -->
		<div class="news-ment">
			<span data-aos="fade-down" data-aos-duration="500">
				북커리 뉴스에서 북커리의 최신소식을 만날 수 있어요
			</span>
		</div>	
	</div>
	<div class="col-md-2"></div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
<div class="row">
	<div class="col-xs-1 col-md-1"></div>
	<div class="col-xs-11 col-md-5">
		<div class="club-img-outter">
			<img class="club-img" src="${pageContext.request.contextPath}/resources/imgs/main/bookclub.jpg"/>
			<img class="club-img club-move" data-aos="fade-right" data-aos-duration="1500" src="${pageContext.request.contextPath}/resources/imgs/main/club-detail.jpg"/>
		</div>
	</div>
	<div class="col-xs-1 col-md-6"></div>
	<div class="col-xs-11 col-md-6">
		<div class="font">
			스터디는 북커리<br/>회원들과 함께해요
		</div>
		<div class="font-sub">
			공부하다 궁금한 문제가 생기면 북커리 클럽에서 회원들과 질문하고 답할 수 있어요
		</div>
		<div class="club-btn">
			<a class="btn" href="${pageContext.request.contextPath }/club">북클럽 바로가기</a>
		</div>
	</div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
<div class="row">
	<div class="col-md-12">
		<div class="font books-title">
			북커리 회원들이 공부하는 책
		</div>
		<ul>
			<c:forEach items="${list }" var="bean">
			<li class="book-list" data-aos="fade-up" data-aos-duration="3000">
				<a href="${pageContext.request.contextPath }/find/book/${bean.bid}">
					<img class="book-image" src="${bean.coverurl }" alt="책 이미지">
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>
<div class="row end">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8" data-aos="zoom-out">
		<div class="font-sub">
			이제 북커리의 대략적인 기능을 다 알아보았습니다
		</div>
		<div class="font">
			북커리를 시작하러 가볼까요?
		</div>
		<div class="news-btn">
			<a class="btn" href="${pageContext.request.contextPath }/news">북커리 바로가기</a>
		</div>
	</div>
	<div class="col-md-2"></div>
</div>
</body>
</html>