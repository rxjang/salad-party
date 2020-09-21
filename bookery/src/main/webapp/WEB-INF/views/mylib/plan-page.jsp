<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	.plan-page-main>h3{
		position:relative;
		left:40%;
	}
	.planbypage::before {
	    content: '';
	    display: block;
	    width: 100%;
	    height: 16px;
	    position: absolute;
	    left: 3px;
	    bottom: 1px;
	    background: #D5E7B8;
    }
    .planbypage>span{
    	position:relative;
    }
	.page-main-inner{
		max-width:800px;
		margin:0 auto;
		border:1px solid #A7D489;
	}
	.book-info{
		float:left;
	}
	.planbypage{
	    display: inline-block;
    	position: relative;
	}
    .page-content{
    	float:left;
    }
</style>
<Script type="text/javascript">
</Script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12 plan-page-main">
			<h3 class="planbypage"><span>목표설정 by PAGE</span></h3>
		<div class="page-main-inner">
			<div class="book-info">
				<div class="book-image-box">
					<img class="book-image" src="#" alt="책 이미지">
				</div>
				<div class="book-info-detail">
					<h4>book title</h4>
					<h5>본 책은 총 <strong>456</strong>페이지 입니다</h5>
				</div>
			</div><!-- .book-info end -->
			<div class="page-content">
				<div class="number-of-pages">
					하루에 공부 해야할 양 설정
				</div>
				<div class="page-enddate">
					끝나는 날짜로 하루에 공부해야할 양 지정
				</div>
			</div>
		</div><!-- .page-main-inner end -->
	</div><!-- .plan-page-main end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>