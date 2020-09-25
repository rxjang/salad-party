<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script> <!-- Air datepicker js -->
<script src="${pageContext.request.contextPath }/resources/js/i18n/datepicker.ko.js"></script>
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
var pagechoice;
var content;
$(function() {
$(".datepicker").datepicker({
	language: 'ko'
}); 
	$('.page-choice').each(function(){
		$(this).on('click',function(){
			pagechoice = $(":input:radio[name=page-choice]:checked").val();
			console.log(pagechoice);
			if(pagechoice=='by-page'){
				content='<label for="startdate">시작날짜</label><input type="date" name="startdate"/><br/>';
				content +='<label for="page">공부할 양</label><input type="text" name="page"/>';
				$('.number-of-pages').append(content);
				$('.page-enddate').children().remove()
			}else if(pagechoice=='by-date'){
				content='<label for="startdate">시작날짜</label><input type="date" name="startdate"/><br/>';
				content +='<label for="enddate">끝나는 날짜</label><input type="date" name="enddate"/><br/>';
				$('.page-enddate').append(content);
				$('.number-of-pages').children().remove()
			}//if
		});//click
	});//each
	
});//ready
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
					<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
				</div>
				<div class="book-info-detail">
					<h4>${v_study.title}</h4>
					<h5>본 책은 총 <strong>${v_study.total_pages}</strong>페이지 입니다</h5>
				</div>
			</div><!-- .book-info end -->
			<div class="page-content">
				<input type="radio" id="by-page" name="page-choice" value="by-page" class="page-choice">
			 	<label for="by-page">공부할 양 지정</label>
				<input type="radio" id="by-date" name="page-choice" value="by-date" class="page-choice">
			 	<label for="by-date">끝나는 날 지정</label>
			 	
				<div class="number-of-pages">
				
				</div>
				
				<div class="page-enddate">
				</div>
				
			</div>
		</div><!-- .page-main-inner end -->
	</div><!-- .plan-page-main end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>