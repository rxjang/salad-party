<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script> <!-- Air datepicker js -->
<script src="${pageContext.request.contextPath }/resources/js/i18n/datepicker.ko.js"></script>
<Script type="text/javascript">

</Script>
<style type="text/css">
	.jumbotron{
		background-color:white;
		width:80%;
		margin:0 auto;
		padding:10px;
		border:1px solid #e4e4e4;
	}
	.plan-page-title{
		text-align:center;
		margin-bottom:1em;
	}
	.page-main{
		display:inline-flex;
		width:100%;
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:5em;
	}
	.page-content{
		margin-left:3em;
	}
	.page-content h4{
		margin-top:0px;
	}
 	@media (max-width:800px) {
 		.jumbotron{width:90%; text-align:center;}
		.book-image{margin-bottom:2em;}
		.page-main{display:block;}
		.page-content{
			width:100%;
			margin:0 auto;
			font-size:1.3em;
		}
	}
</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="jumbotron">
		<h3 class="plan-page-title">책 상세보기</h3>
		<div class="page-main">
			<div class="book-image-box">
				<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
			</div><!-- book-image-box -->
			<div class="page-content">
				<div class="book-info-detail">
					<h4><strong>${v_study.title}</strong></h4>
					<h5>본 책은 총 <strong>${v_study.pages}</strong>페이지 입니다</h5>
					메모:${v_study.memo}<br/>
					서재에 책을 담은 날짜:${v_study.createtime}<br/>
					공부 시작일: ${v_study.startdate}<br/>
					완료 예정일: ${v_study.enddate}<br/>
					
				</div><!-- book-info-detail -->
			</div><!-- page content -->
		</div><!-- .page-main end -->
	</div><!-- jumbotron end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
