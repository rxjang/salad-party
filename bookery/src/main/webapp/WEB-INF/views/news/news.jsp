<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<style type="text/css">
	.best-books{
		width:100%;
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
	.notice{
		margin-top: 20px;
		border: 1px solid #e4e4e4;
	}
</style>
<script>
$(function(){
	$('.book-title').each(function(){
		if($(this).text().length > 12){
			$(this).text($(this).text().substring(0,12)+' ...');			
		}
	});//book-title each
});//ready
</script>
</head>
<body>
<%@ include file="../template/menu.jspf"%>
<%@ include file="../template/news-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<p>케러셀자리</p>
</div><!-- row -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<h4>책거리 회원들이 많이 공부하는 책</h4>
		<ul class="best-books">
		<c:forEach items="${bestBooks }" var="bean"><!-- 많이 공부 중인 책 리스트 -->
		<li>
			<a href='${pageContext.request.contextPath }/find/book/${bean.bid}' class="anchor">
				<img class="book-image" alt="image loading fail" src="${bean.coverurl }"><br/>
				<span class="book-title">${bean.title }</span>
			</a>
		</li>
		</c:forEach>
		</ul>
	</div>
	<div class="col-md-1"></div>
</div><!-- row -->
<div class="row">
	<div class="col-md-1">
	</div>
	<div class="col-xs-12 col-md-10 notice">
		<h3>책거리 알림</h3>
	</div>
	<div class="col-md-1">
	</div>
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf"%>
</body>
</html>
