<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<Script type="text/javascript">
$(function() {
	$('.owl-carousel').owlCarousel({
	    margin:30,
	    nav:true,
	    autoWidth:true,
	    responsiveClass:true,
	    responsive:{
	    	0:{
	   	     items:1,
	        },
	        600:{
  	         items:3,
	       	},
	       	1000:{
	          items:5,
	        }
	    }
	})
});
</Script>
<style type="text/css">
	#mylib{
		width:90%;
		height:280px;
		background:url('${pageContext.request.contextPath}/resources/imgs/library.jpeg')center/cover;
		margin:0 auto;
		color:white;
		padding:30px 60px;
	}
	.jumbotron a{color:white}
	.jumbotron a:hover{text-decoration:none; color:#ECEBC9}
	.table{
		margin-top:30px;
		font-size:1.3em;
		color:white;
		width:40%;
	}
	.table>tbody>tr>td{opacity: 0.8;}
	.table>tbody>tr>td, .table>tbody>tr>th{
		border-top:0px;
		padding:5px 0px;
	}
	#table{border-bottom: 1px rgba(255, 255, 255, .5) solid}
	.mylib-info-ment{margin-top:10px;text-shadow: 2px 2px 2px gray;}
	.mylib-info-ment span{opacity: 0.8;}
	#mylib-contents{width:90%; margin:0 auto;}
	
	@media (max-width:1000px) {
		#mylib{width:100%; height:250px; padding:20px; padding-left:30px;}
		#mylib h3, .table, .table>tbody>tr>td{font-weight:bold}
		.mylib-info-ment{font-weight:bold; text-shadow: 3px 3px 3px #000000; font-size:1.1em;}
	}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="jumbotron" id="mylib">
			<h3>김셀파님의 서재</h3>
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
			</div>
			<div class="mylib-info-ment">
				<a href="${pageContext.request.contextPath }/find">
				서재에 책을 추가하러 가볼까요?<br/>
				<span>책 검색하러 가기</span>			
				</a>
			</div><!-- .mylib-info-ment end -->
		</div><!-- .jumbotron end -->
		<div id="mylib-contents">
			<span class="glyphicon glyphicon-remove" style="color:#CAAD7E"></span>&nbsp;아직 목표 설정을 하지 않았어요
			<h6>책을 클릭하여 공부를 시작해 보세요</h6>	
			<div class="owl-carousel owl-theme">
				<c:forEach items="${nogoalbooklist }" var="bean1">
				    <div class="item">
				    	<img class="media-object" src="${bean1.coverurl }" alt="책 이미지">
				    </div>	
				</c:forEach>
			</div>
			<span class="glyphicon glyphicon-minus" style="color:#C4DEA4"></span>&nbsp;현재 공부 중인 책들이예요
			<h6>책을 클릭하여 오늘의 진도를 입력해 보아요</h6>	
			<div class="owl-carousel owl-theme">
				<c:forEach items="${studyingbooklist }" var="bean2">
				    <div class="item"><img class="media-object" src="${bean2.coverurl }" alt="책 이미지"></div>
				</c:forEach>
			</div>
			<span class="glyphicon glyphicon-ok" style="color:#A7D489"></span>&nbsp;완료한 책
			<h6>책을 클릭하면 과거의 기록을 볼 수 있어요</h6>	
			<div class="owl-carousel owl-theme">
				<c:forEach items="${finishedbooklist }" var="bean3">
				    <div class="item"><img class="media-object" src="${bean3.coverurl }" alt="책 이미지"></div>
				</c:forEach>
			</div>
		</div>			
	</div>
</div><!-- .row end -->
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
