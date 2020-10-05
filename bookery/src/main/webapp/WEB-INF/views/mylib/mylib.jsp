<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<Script type="text/javascript">
$(function() {
	$('.owl-carousel').each(function(){
		$(this).owlCarousel({
	   		margin:20,
	    	nav:true,
	    	responsiveClass:true,
	    	responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
				250 : {
					items:3
				},
				800 : {
					items:5
				},
				1200 : {
					items:7
				}
			}
		});
	});
	$('.owl-stage-outer').after('<img class=\"wood\" src=\"${pageContext.request.contextPath}/resources/imgs/shelf.png\">');
});
</Script>
<style type="text/css">
	a{
		color:black;
	}
	a:hover{
		color:black;
		text-decoration:none;
	}
	h6{
		color:#8c8c8c;
	}
	#mylib-account{
		width:90%;
		height:280px;
		background:url('${pageContext.request.contextPath}/resources/imgs/library.jpeg')center/cover;
		margin:0 auto;
		color:white;
		padding:20px 30px;
		position: -webkit-sticky; 
		position:sticky;
		top:66px;
	}
	.jumbotron a{color:white}
	.jumbotron a:hover{text-decoration:none; color:#ECEBC9}
	.forbg{
		padding:10px 20px;
		background-color: rgba(000, 000, 000, .4);
	}
	#table{
		width:70%;
		border-bottom: 1px rgba(255, 255, 255, .8) solid;
	}
	.table{
		width:55%;
		margin-top:30px;
		color:white;
	}
	.table>tbody>tr>td{
		opacity: 0.8;
	}
	.table>tbody>tr>td, .table>tbody>tr>th{
		border-top:0px;
		padding:5px 0px;
	}
	.mylib-info-ment{
		margin-top:10px;
	}
	.mylib-info-ment span{opacity: 0.8;}
	.mylib-main{
		width:90%;
		margin:0 auto;
		border-radius:10px;
		background-color:white;
		position: -webkit-sticky; 
		position:sticky;
		top:0;
	}
	.mylib-main-inner{padding-top:15px; padding-left:30px;}
	.sub-title{position:relative;}
	.owl-theme{
		padding-bottom:20px;
		margin-bottom:20px;
		border-bottom:1px solid #e4e4e4;
	}
	.owl-stage{	/* 캐러셀 아래로 정렬 */
		padding-left:5px;
		align-items: baseline;
		display: inline-flex;
	}
	.media-object{
		box-shadow: 2px 2px 6px rgba(0,0,0,.1), 0 0 2px rgba(0,0,0,.2);
	}
	.counting{
		font-size:0.8em;
		color:#8c8c8c;
	}
	.submenu-main{
	    margin-bottom:120px;
	}
	.wood{
		width:100%;
		height:5em;
	}
	@media (max-width:1000px) {
		#mylib-account{
			width:100%;
			height:250px;
			padding:15px;
		}
		#table{
			width:90%;
		}
		.table{
			width:85%;
		}
		.mylib-main{
			width:100%;
			padding:20px;
			padding-left:20px;
		}
		.mylib-main-inner{padding-left:10px;}
		#mylib-account h3, .table, .table>tbody>tr>td{font-weight:bold}
		.mylib-info-ment{font-weight:bold; text-shadow: 3px 3px 3px #000000; font-size:1.1em;}
	}
</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="jumbotron" id="mylib-account">
		<div class="forbg">
			<h3>${user.nickname }님의 서재</h3>
			<div id="table">
				<table class="table">
					<tr>
						<td>미독&nbsp;&nbsp;</td>
						<td>미완독</td>
						<td>완독</td>
					</tr>
					<tr>
						<th>${countnogoalbook }</th>
						<th>${countstudyingbook }</th>
						<th>${countfinishedbook }</th>
					</tr>
				</table>
			</div><!-- #table end -->
			<div class="mylib-info-ment">
				<a href="${pageContext.request.contextPath }/find">
					서재에 책을 추가하러 가볼까요?<br/><span>책 검색하러 가기</span>			
				</a>
			</div><!-- .mylib-info-ment end -->
		</div>
		</div><!-- .jumbotron end -->
		<div class="junbotron mylib-main">
			<div class="mylib-main-inner">
			<h3 class="sub-title">미독 <span class="counting">${countnogoalbook }권</span></h3>
			<span class="glyphicon glyphicon-remove" style="color:#CAAD7E"></span>&nbsp;아직 목표 설정을 하지 않았어요
			<h6>책을 클릭하여 공부를 시작해 보세요</h6>	
			<div class="owl-carousel owl-theme">
				<c:forEach items="${nogoalbooklist }" var="bean1">
				    <div class="item">
				    	<a href="${pageContext.request.contextPath }/mylib/plan/${bean1.study_id }"><img class="media-object" src="${bean1.coverurl }" alt="책 이미지"></a>
				    </div>
				</c:forEach>
			</div><!-- owl end -->
			<h3 class="sub-title three">미완독 <span class="counting">${countstudyingbook }권</span></h3>
			<span class="glyphicon glyphicon-minus" style="color:#C4DEA4"></span>&nbsp;현재 공부 중인 책들이예요
			<h6>책을 클릭하여 오늘의 진도를 입력해 보아요</h6>	
			<div class="owl-carousel owl-theme">
				<c:forEach items="${studyingbooklist }" var="bean2">
				    <div class="item">
				    	<a href="${pageContext.request.contextPath }/mylib/${bean2.study_id }"><img class="media-object" src="${bean2.coverurl }" alt="책 이미지"></a>
				    </div>
				</c:forEach>
			</div><!-- owl end -->
			<h3 class="sub-title">완독 <span class="counting">${countfinishedbook }권</span></h3>
			<span class="glyphicon glyphicon-ok" style="color:#A7D489"></span>&nbsp;완료한 책
			<h6>책을 클릭하면 과거의 기록을 볼 수 있어요</h6>	
			<div class="owl-carousel owl-theme">
				<c:forEach items="${finishedbooklist }" var="bean3">
				    <div class="item">
				    	<a href="${pageContext.request.contextPath }/mylib/${bean3.study_id }"><img class="media-object" src="${bean3.coverurl }" alt="책 이미지">
				    	</a>
				    </div>
				</c:forEach>
			</div><!-- owl end -->
			</div>
		</div><!-- mylib-main -->	
	</div>
</div><!-- .row end -->
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
