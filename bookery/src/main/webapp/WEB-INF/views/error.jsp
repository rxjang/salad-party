<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="template/head.jspf" %>
<style type="text/css">
	.error-info{
		text-align:center;
	}
	.error-img{
		width:220px;
		margin-top:100px;
	}	
	.forbg{
		background:url('${pageContext.request.contextPath}/resources/imgs/ripped-paper.png')center/cover;
	}
	h5{
		color:#787878;
	}
</style>
</head>
<body>
<%@ include file="template/menu.jspf" %>
<!--**********content start**********-->
<div class="row forbg">
	<div class="col-xs-2 col-md-2"></div>
	<div class="col-xs-8 col-md-8">
		<div class="error-info">
			<img class="error-img" src="${pageContext.request.contextPath }/resources/imgs/sad.png"/>
			<h3>비정상적인 접근 또는 존재하지 않는 페이지 입니다</h3>
			<h4>이전으로 돌아가거나 원하는 메뉴를 클릭해 페이지 이동을 부탁드립니다</h4>
			<h5>페이지에 관해 문의사항이 있다면 <a href="${pageContext.request.contextPath}/news/notice">1:1문의 게시판</a>을 이용해주시길 바랍니다</h5>
		</div>
		<div class="error-msg">
		</div>
	</div>
	<div class="col-xs-2 col-md-2"></div>
</div>
<!--**********content end**********-->
<%@ include file="template/footer.jspf" %>
</body>
</html>