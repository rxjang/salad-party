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
	.font{
		font-family:나눔명조, Nanum Myeongjo;
		font-weight:bold;
		font-size:4em;
		color:#49654d;
	}
	.empty{
		height:200px;
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
		width:450px;
		border-radius:15px;
	}
	.find-ment{
		margin-top:40px;
		text-align:center;
	}
	.find-btn{
		background-color:#c0cfb2;
		font-size:1.3em;
		padding:10px 15px;
		border-radius:10px;
	}
	.find-btn:hover{
		background-color:#c0c8b2;
	}
	.mylib img{
		width:450px;
		border-radius:15px;
	}
	.mylib-info{
		margin:20px;
	}
	.mylib-info-img{
		width:40px;
	}
	@media (max-width:1000px) {
		.studying-image-box img{
			width:60%;
			margin-top:0px;
		}
		.find img{
			width:200px;
		}
	}
</style>
<script>
	$(function(){
		AOS.init();		
	});
</script>
</head>
<body>
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="nav">
			<a class="login-btn" href="${pageContext.request.contextPath }/account/login">로그인</a>
			<a class="join-btn" href="${pageContext.request.contextPath }/account/join">회원가입</a>
		</div>
	</div>
</div><!-- row -->
<div class="row">
	<div class="col-xs-12 col-md-4">
		<div class="main-ment" data-aos="fade-down" data-aos-duration="1500">
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
		<a class="find-btn" href="${pageContext.request.contextPath }/find">검색하러 가기</a>
	</div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
<div class="row">
	<div class="col-xs-1 col-md-1"></div>
	<div class="col-xs-11 col-md-6">
		<div class="font">
			내서재에서 목표설정을<br/> 할 수 있어요
		</div><!-- font -->
		<span class="">하루에 끝낼 양 혹은 완료하고 싶은 날짜를 지정하여 스터디 목표를 </span>
		<div>
			<div class="chap mylib-info">
				<img class="mylib-info-img" src="${pageContext.request.contextPath}/resources/imgs/main/chap.png"/>
				<span>챕터 중심 목표 설정</span><br/>
			</div><!-- chap -->
			<div class="page mylib-info">
				<img class="mylib-info-img" src="${pageContext.request.contextPath}/resources/imgs/main/page.png"/>
				<span>페이지 중심 목표 설정</span>
			</div>
		</div>
	</div>	
	<div class="col-xs-12 col-md-4">
		<div class="mylib" data-aos="fade-left" data-aos-duration="1500">
			<img src="${pageContext.request.contextPath}/resources/imgs/main/mylib.png"/>
		</div>
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row empty">&nbsp;</div>
</body>
</html>