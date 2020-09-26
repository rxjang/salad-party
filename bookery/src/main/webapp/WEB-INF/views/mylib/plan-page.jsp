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
var pages=${v_study.pages};
var startdate;
var enddate;
var plan_page;
var temp;

function get_date_str(date){
    var sYear = date.getFullYear();
    var sMonth = date.getMonth() + 1;
    var sDate = date.getDate();

    sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
    sDate  = sDate > 9 ? sDate : "0" + sDate;
    return sYear +"-"+ sMonth +"-"+ sDate;
}//날짜 형변환

$(function() {
$(".datepicker").datepicker({
	language: 'ko'
}); 
	$('.number-of-pages').hide();
	$('.page-enddate').hide();
	$('.result').hide();
	$('.page-choice').each(function(){
		$(this).on('click',function(){
			pagechoice = $(":input:radio[name=page-choice]:checked").val();
			if(pagechoice=='by-page'){
				$('.number-of-pages').show();
				$('.page-enddate').hide();
				$('.result').hide();
			}else if(pagechoice=='by-date'){
				$('.page-enddate').show();
				$('.number-of-pages').hide();
				$('.result').hide();
			}//if
		});//click
	});//each
	$('.page-btn').on('click',function(){
		startdate=$('.startdate').val();
		plan_page=$('.page').val();
		temp=Math.ceil(pages /plan_page); //숫자올림
		enddate=new Date(startdate);
		enddate=enddate.setDate(enddate.getDate()+temp-1);//끝나는 날짜 계산
		enddate=new Date(enddate);
		console.log(get_date_str(enddate));
		$('.start-date').val(startdate);
		$('.end-date').val(get_date_str(enddate));
		$('.study-day').val(temp);
		$('.plan-page').val(plan_page);
		$('.result').show();
	});//page-btn click
	$('.enddate-btn').on('click',function(){
		temp=$('.startdate1').val();
		$('.start-date').val(temp);
		startdate=new Date(temp);
		temp=$('.enddate').val();
		$('.end-date').val(temp);
		enddate=new Date(temp);
		temp=Math.ceil((enddate.getTime()-startdate.getTime())/(1000*3600*24))+1;
		$('.study-day').val(temp);
		plan_page=Math.ceil(pages/temp);
		$('.plan-page').val(plan_page);
		$('.result').show();
	});//enddate-btn click
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
					<h5>본 책은 총 <strong>${v_study.pages}</strong>페이지 입니다</h5>
				</div>
			</div><!-- .book-info end -->
			<div class="page-content">
				<input type="radio" id="by-page" name="page-choice" value="by-page" class="page-choice">
			 	<label for="by-page">공부할 양 지정</label>
				<input type="radio" id="by-date" name="page-choice" value="by-date" class="page-choice">
			 	<label for="by-date">끝나는 날 지정</label>
			 	
				<div class="number-of-pages">
					<label for="startdate">시작날짜</label><input type="date" name="startdate" class="startdate"/><br/>
					<label for="page">공부할 양</label><input type="text" name="page" class="page"/>
					<button class="btn btn-priamary page-btn">계산</button>
				</div>
				
				<div class="page-enddate">
					<label for="startdate">시작날짜</label><input type="date" name="startdate" class="startdate1"/><br/>
					<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="enddate"/>
					<button class="btn btn-priamary enddate-btn">계산</button>
				</div>
				<div class="result">
					<form method="post" action="${pageContext.request.contextPath }/mylib/plan/fin">
						<label for="startdate">시작날짜</label><input type="date" name="startdate" class="start-date" readonly/><br/>
						<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date" readonly/>
						<label for="studyday">총 공부일</label><input type="text" name="studyday" class="study-day" readonly/>
						<label for="planpage">공부할 양</label><input type="text" name="planpage" class="plan-page" readonly/>
						해당 데이터로 목표설정을 하시겠습니까?<button class="btn btn-priamary enddate-btn">확인</button>
					</form>
				</div>
			</div>
		</div><!-- .page-main-inner end -->
	</div><!-- .plan-page-main end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>