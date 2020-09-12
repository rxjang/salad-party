<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
	<title>Bookery</title>
<style>
 	#menu{
 		height:66px;
		line-height:40px;
		border-bottom: 1px solid #e4e4e4;
		font-size: 1.3em;
	}
	#menu a{color:black;}
	#menu a:hover{
		text-decoration: none;
		background-color: rgba(255, 0, 0, 0.0);/*기존 부트스트랩 색깔 투명하게 설정*/
	}
	#menu ul{padding:4px 0px;}
	.nav li{float:left;}
	.real-menu{padding:0px;} 
	.menu-setting{padding-left:80px;}/*좌측 적당한 공간 띄움*/
	.pull-right{padding:23px 80px;}
	.jung{color:white;}/*#처음에 안보이게*/
	.dropdown-toggle:active, .open .dropdown-toggle {
        background:white !important; 
        color:#000 !important;
		text-decoration: none;
    }
	
	@media (max-width:1000px) {
		#menu{
			height:50px;
			border-bottom:0px;
		}
		.menu-setting{padding:0px 25px;}
		.pull-right{padding:23px 25px;}
		.real-menu{
			position:absolute;
			bottom:0;
			font-size:0.7em;
			border-top:1px solid #e4e4e4;
			height:60px;
		}
	}
</style>
<script type="text/javascript">
var mql = window.matchMedia("screen and (max-width: 1000px)");

mql.addListener(function(e) {
    if(e.matches) {
    	mobile();
    } else {
    	pc();
    }
});//넓이 변경시 이벤트 발생

$(function(){
	  $('.add-jung').mouseenter(function(){
	    $(this).children().css('color','black');
		$(this).css('font-weight','bold');
	  });
	  $('.add-jung').mouseleave(function(){
	    $(this).children().css('color','white');
	    $(this).css('font-weight','normal').css('background-color','none');
	  });
	  $(".nav li").click( function() { 
          $(this).css("background-color", "rgba(255, 0, 0, 0.0)");
        });
		
		if (mql.matches) {
		    mobile();
		} else {
			pc()
		}//최조 접속 상태로 판단
	});
function mobile(){
	$('.real-menu').addClass('col-xs-12');
	$('.nav').css('text-align','center').css('position','realtive');
	$('.nav li').css('float','none').css('display','inline-block').css('margin','auto');
	$('.jung').text('');
}
function pc(){
	$('.real-menu').removeClass('col-xs-12');
	$('.nav').css('text-algin','none');
	$('.nav li').css('float','left').css('display','inline');
	$('.jung').text('#');
}

</script>
</head>
<body>
<div class="container-fluid">
	<div id="menu" class="row">
	<!-- 로고 위치 -->
		<div class="col-xs-6 col-md-2 menu-setting">
			<h3><a href="#">Bookery</a></h3>
		</div>
	<!--메인 메뉴 위치 -->
		<div class="col-md-8 real-menu">
		<ul class="nav">
			<li><a href="#" class="add-jung"><span class="jung"></span>오늘의 기록</a></li>
			<li><a href="#" class="add-jung"><span class="jung"></span>내서재</a></li>
			<li><a href="#" class="add-jung"><span class="jung"></span>북클럽</a></li>
			<li><a href="#" class="add-jung"><span class="jung"></span>검색</a></li>
			<li><a href="#" class="add-jung"><span class="jung"></span>책거리 뉴스</a></li>
		</ul>
		</div>
	<!-- 설정 메뉴 위치 -->
		<div class="col-xs-6 col-md-2 side">
		 <a class="dropdown-toggle pull-right" data-toggle="dropdown" href="#" role="button" aria-expanded="false">
	         <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
	     </a>
	     <ul class="dropdown-menu" role="menu">
	       <li><a href="#">내 정보</a></li>
	       <li role="separator" class="divider"></li>
	       <li><a href="#">로그아웃</a></li>
	       </ul>
		</div>
	</div><!-- #menu end -->
	<div class="row">
	<!-- **********content start**********-->  
	<!--**********content end**********-->  
	</div>
</div><!-- #container-fluid end -->
</body>
</html>
