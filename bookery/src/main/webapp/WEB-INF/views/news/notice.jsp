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
	.content-title,.qna-title{
		padding:5px 20px;
	}
	.qna-title,.for-line{
		border-bottom:1px solid #e4e4e4;
	}
	.title,.content-inner{
		font-weight:bold;
	}
	.for-line{
		margin:1em auto;
	}
	.glyphicon-menu-down,.asktime{
		padding-top:10px;
		float:right;
	}
	.ref{
		padding-top:10px;
		float:right;
		margin-right:10px;
	}
	.content-main,.info-ment-main{
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
	.admin-btn, .ask-btn,.answer-btn{
		float:right;
		margin-left:5px;
		color:#787878;
	}
	.admin-btn:hover, .ask-btn:hover,.answer-btn:hover{
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
		.write-btn{
			left:90%;
		}
	}
</style>
<script>
var id=${user.id}//admin계정일시 공지사항 수정 위해

$(function(){
	//기본적으로 글 내용은 숨기고 글 제목 클릭시 내용 보이게 함
	//1-box:공지사항 2-box:FAQ 3-box:1:1 문의
	$(".content-main").hide();
	$(".2-box").hide();
	$(".3-box").hide();
	$(".1-box").show();
	admin();
		
	//공지 안내
	$(".title").each(function(){
		$(this).children(".depth-1").text("[공지]");
	});
		
	$(".off").each(function(){//처음에 off로 서브메뉴 세팅하고 클릭시 on 클래스 생성, off클래스 remove형식으로 내용 보여줌
		$(this).on('click',function(){
			$(".on").addClass("off");
			$(".on").removeClass("on");
			$(this).addClass("on");
			$(this).removeClass("off");
			
			if($(".on").text()=="공지사항"){
				$(".2-box").hide();
				$(".3-box").hide();
				$(".1-box").show();
				admin();
			}else if($(".on").text()=="FAQ"){
				$(".1-box").hide();
				$(".3-box").hide();
				$(".2-box").show();
				admin();
			}else if($(".on").text()=="1:1 문의"){
				$(".1-box").hide();
				$(".2-box").hide();
				$(".3-box").show();
				if($(".login").val()==""){
					swal({
					    title: "1:1문의는 로그인 후 사용 가능합니다",
					    text: "버튼을 누르면 로그인 페이지로 이동합니다",
					    icon:"info",
					    type: "success"
					}).then(function() {
					    window.location = "${pageContext.request.contextPath }/account/login";
					});
				}
				/******************본인이 쓴 문의 글 만 볼 수 있게함(관리자는 모든 문의글)***********************/
				$(".qna1").each(function(){
					var temp=$(this).children("input").val();
					if(temp==id||id==1){
						$(this).show();
					}else{
						$(this).hide();
					}
				});//each
				$(".qna2").each(function(){
					var temp=$(this).children("input").val();
					if(temp==id||id==1){
						$(this).show();
					}else{
						$(this).hide();
					}
				});//each
			}//if
		});//click
	});//off
		
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
		
	//time formating
	$(".createtime").each(function(){
		var createtime=$(this).text();
		$(this).text(new Date(createtime).format('yyyy-MM-dd a/p hh:mm'));
	});//createtime
	$(".answertime").each(function(){
		var answertime=$(this).text();
		$(this).text(new Date(answertime).format('yyyy-MM-dd a/p hh:mm'));
	});//answertime
});//ready

	/***********************글 번호 분류 후 작성 페이지 이동 함수**************************/
	function moveFunction(){
		var title=$(".on").text();
		if(title=="공지사항"){
			location.href="${pageContext.request.contextPath }/news/notice/write/1";
		}else if(title=="FAQ"){
			location.href="${pageContext.request.contextPath }/news/notice/write/2";
		}
	}
	
	/**************************관리자 계정일 때 글쓰기/상세보기 버튼 보이게**************************/
	function admin(){
		if(id==1){
			$(".3-box").children(".admin-btn").remove(); 
			$(".info-ment").remove();
			$(".admin-btn").show();
		}else{
			$(".admin-btn").hide();
			$(".answer-btn").hide();
		}
	}
	
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
		<a class="write-btn admin-btn 1-box 2-box" href="javascript:moveFunction();">글쓰기</a>
		<div class="3-box info-ment">
			<div class="content-title">
				<h4><span class="usernmae">${user.nickname }</span>님 <br/>무엇을 도와 드릴까요?<img src="${pageContext.request.contextPath}/resources/imgs/Smile-blush.png" alt="?"></h4>
			</div><!-- content-title -->
			<div class="info-ment-main">
				남겨주신 문의는 담당자 확인 후 빠른 시일 내에 답변 드리겠습니다.<br/>
				북커리를 이용해주셔서 감사합니다.
				<a href="${pageContext.request.contextPath }/news/notice/write/3" class="ask-btn"> 1:1 문의 하기</a>
			</div><!-- content-main -->
		</div><!-- info-ment -->
		<c:forEach items="${noticeList }" var="bean">
		<div class="content-box ${bean.num }-box">
			<div class="content-title">
				<span class="glyphicon glyphicon-menu-down"></span>
				<h4 class="title"><span class="depth-${bean.depth }"></span>${bean.title }</h4>
				<p class="1-box">${bean.createtime }</p>
			</div><!-- content-title -->
			<div class="content-main">
				${bean.content }
				<a class="admin-btn" href="${pageContext.request.contextPath }/news/notice/detail/${bean.id}">상세보기</a>
			</div><!-- content-main -->
		</div><!-- n-box -->
		</c:forEach>
		
		<c:forEach items="${noticeOneToOne }" var="bean2">
		<div class="content-box ${bean2.num }-box qna1">
			<input type="hidden" value="${bean2.user_id}" class="writer"/>
			<div class="content-title">
				<span class="glyphicon glyphicon-menu-down"></span><span class="ref">답변 전</span>
				<h4 class="title">${bean2.title }</h4>
				<p>${bean2.createtime }&nbsp;</p>
			</div><!-- content-title -->
			<div class="content-main">
				${bean2.content }
				<a class="answer-btn ${bean2.ref }-btn" href="${pageContext.request.contextPath }/news/notice/answer/${bean2.id}">답변하기</a>
			</div><!-- content-main -->
		</div><!-- n-box -->
		</c:forEach>
		
		<c:forEach items="${noticeQnA }" var="bean3">
		<div class="content-box 3-box qna2">
			<input type="hidden" class="writer" value="${bean3.user_id}">
			<div class="qna-title">
				<span class="glyphicon glyphicon-menu-down"></span><span class="ref">답변 완료</span>
				<h4 class="title">${bean3.title }</h4>
				<p>답변 시각 <span class="answertime">${bean3.answertime }</span>&nbsp;</p>
			</div><!-- content-title -->
			<div class="content-main">
				<p class="asktime">문의 시각 <span class="createtime">${bean3.createtime }</span></p>
				<h5 class="content-inner">문의 내용</h5>
				${bean3.content }<br/>
				<div class="for-line"></div>
				<h5 class="content-inner">답변 내용</h5>${bean3.answer }
			</div><!-- content-main -->
		</div><!-- n-box -->
		</c:forEach>
		<div class="ask 2-box">
			<em>그래도 해결이 안되시나요?</em><a href="${pageContext.request.contextPath }/news/notice/write/3" class="ask-btn"> 1:1 문의 하기</a>
			<input type="hidden" value="${user.id }" class="login"/>
		</div>
	</div><!-- center-content -->
	<div class="col-md-2"></div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
