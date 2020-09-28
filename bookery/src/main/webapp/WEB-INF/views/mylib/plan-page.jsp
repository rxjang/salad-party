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
 	$('.by-page').hide();
	$('.by-date').hide();
 	$('.page-result').hide();
	$('.date-result').hide();
	$('.page-choice').on('click',function(){
			$('.by-page').show();
			$('.by-date').hide();
		 	$('.date-result').hide();
	});//click
	$('.page-date').on('click',function(){
		$('.by-date').show();
		$('.by-page').hide();
		$('.page-result').hide();
	});//click
		
	$('.page-btn').on('click',function(){
		$('.page-btn:hover').css('border','0px solid');
		startdate=$('.startdate').val();
		$('.start-date').val(startdate);
		plan_page=$('.page').val();
		$('.plan-page').val(plan_page);
		temp=Math.ceil(pages /plan_page); //숫자올림
		$('.study-day').val(temp);
		enddate=new Date(startdate);
		enddate=enddate.setDate(enddate.getDate()+temp-1);//끝나는 날짜 계산
		enddate=new Date(enddate);
		$('.end-date').val(get_date_str(enddate));
		if(startdate==""||plan_page==""){
			swal({
				  title: "값이 비었습니다",
				  text: "시작 날짜와 공부할 양이 제대로 입력되었는지 확인해 주세요",
				  icon: "error",
				  button: "확인",
			});			
		}else if(startdate<get_date_str(new Date())){
			swal({
				  title: "시작 날짜 입력 오류",
				  text: "시작 날짜는 오늘이나 오늘 이후의 날짜로 입력해 주세요",
				  icon: "error",
				  button: "확인",
				});
		}else if(plan_page>pages){
			swal({
				  title: "페이지 입력 오류",
				  text: "공부할 양은 총 페이지수보다 많을 수 없습니다",
				  icon: "error",
				  button: "확인",
				});
		}else{
			$('.page-result').show();
		}
	});//page-btn click
	$('.enddate-btn').on('click',function(){
		temp=$('.startdate1').val();
		$('.start-date1').val(temp);
		startdate=new Date(temp);
		temp=$('.enddate').val();
		$('.end-date1').val(temp);
		enddate=new Date(temp);
		temp=Math.ceil((enddate.getTime()-startdate.getTime())/(1000*3600*24))+1;
		$('.study-day1').val(temp);
		plan_page=Math.ceil(pages/temp);
		$('.plan-page1').val(plan_page);
		if($('.startdate1').val()==""||$('.enddate').val()==""){
			swal({
				  title: "값이 비었습니다",
				  text: "시작 날짜와 마칠 날짜가 제대로 입력되었는지 확인해 주세요",
				  icon: "error",
				  button: "확인",
			});			
		}else if($('.startdate1').val()<get_date_str(new Date())){
			swal({
				  title: "시작 날짜 입력 오류",
				  text: "시작 날짜는 오늘이나 오늘 이후의 날짜로 입력해 주세요",
				  icon: "error",
				  button: "확인",
			});
		}else if($('.startdate1').val()>$('.enddate').val()){
			swal({
				  title: "날짜 입력 오류",
				  text: "마칠 날짜는 시작 날짜 이후여야 합니다",
				  icon: "error",
				  button: "확인",
			});
		}else{
		 	$('.date-result').show();
		}
	});//enddate-btn click
});//ready
</Script>
<style type="text/css">
	label{
	 width:20%;
	}
	input{
		width:150px;
		border: 1px solid #e4e4e4;
		margin:0.3em auto;
	}
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
		width:700px;
	}
	.page-content h4{
		margin-top:0px;
	}
	.choice{
		cursor:pointer;
		line-height:40px;
		border: 1px solid #e4e4e4;
		padding:0.5em 1.5em;
		font-size:1.2em;
		border-radius:10px;
		margin:20px auto;
	}
	.choice:hover{
		color:#8ba989;
		border: 1px solid #8ba989;g
	}
	.gray{
		color:#999999;
		font-size:0.9em;
	}
	.by{
		padding-left:10px;
	}
	.calc{
		margin-left:30px;
		background-color:#8ba989;
		color:white;
		line-height:15px;
	}
	.calc:hover{
		background-color:white;
		border:1px solid #8ba989;
		color:#8ba989;
	}
	.assert{
		background-color:white;
		line-height:15px;
		padding:0px 5px;
		margin-bottom:5px;
		font-size:1.2em;
	}
	.assert:hover{
		border:1px solid white;
		color: #49654d;
	} 
	.result{
		border-top:1px solid #e4e4e4;
		padding-top:1em;
		margin-top:1em;
	}
	.comment{
		vertical-align:middle;
		text-align:center;
		margin-top:10px;
	}
	.submenu-main{
	    margin-bottom:120px;
	}
 	@media (max-width:800px) {
 		.jumbotron{width:90%; text-align:center;}
		.book-image{margin-bottom:2em;}
		.page-main{display:block;}
	}
</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="jumbotron">
		<h3 class="plan-page-title">목표설정 by PAGE</h3>
		<div class="page-main">
			<div class="book-image-box">
				<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
			</div><!-- book-image-box -->
			<div class="page-content">
				<div class="book-info-detail">
					<h4><strong>${v_study.title}</strong></h4>
					<h5>본 책은 총 <strong>${v_study.pages}</strong>페이지 입니다</h5>
				</div><!-- book-info-detail -->
				<div class="page-page">
					<div class="choice page-choice">
						 <span class="glyphicon glyphicon-duplicate" aria-hidden="true"></span> 하루에 공부할 양을 기준으로<br/>
						 <span class="gray">시작 날짜와 공부할 페이지 양을 입력하시면 끝나는 날짜가 계산됩니다</span>
					</div><!-- choice -->
					<div class="by-page by">
						<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="startdate"/><br/>
						<label for="page">공부할 양</label><input type="text" name="page" class="page"/>
						<button class="btn btn-priamary page-btn calc">계산</button>
						<div class="page-result result">
							<form method="post" action="${pageContext.request.contextPath }/mylib/plan/page/fin">
								<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="start-date" readonly/><br/>
								<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date" readonly/><br/>
								<label for="studyday">총 공부일</label><input type="text" name="studyDay" class="study-day" readonly/><br/>
								<label for="planpage">공부할 양</label><input type="text" name="planPage" class="plan-page" readonly/><br/>
								<label for="memo">메모</label><input type="textarea" name="memo" class="memo"/>
								<input type="hidden" name="id" value="${v_study.study_id}" readonly/>
								<input type="hidden" name="type" value="page" readonly/><br/>
								<div class="comment">
									<button class="btn enddate-btn assert">해당 정보로 목표설정을 하시겠습니까?
									<span class="glyphicon glyphicon-ok"></span>
									</button>
								</div>
							</form>
						</div><!-- page-result -->
					</div><!-- by-page -->
				</div><!-- page-page -->
				<div class="page-date">
					<div class="choice page-choice">
						 <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> 공부를 마칠 날짜를 기준으로<br/>
						 <span class="gray">시작 날짜와 마칠 날짜를 입력해주시면 하루에 공부해야 할 페이지이 계산됩니다</span>
					</div><!-- choice -->
					<div class="by-date by">
						<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="startdate1"/><br/>
						<label for="enddate">마칠 날짜</label><input type="date" name="enddate" class="enddate"/>
						<button class="btn btn-priamary enddate-btn calc">계산</button>
						<div class="date-result result">
							<form method="post" action="${pageContext.request.contextPath }/mylib/plan/page/fin">
								<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="start-date1" readonly/><br/>
								<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date1" readonly/><br/>
								<label for="studyday">총 공부일</label><input type="text" name="studyDay" class="study-day1" readonly/><br/>
								<label for="planpage">공부할 양</label><input type="text" name="planPage" class="plan-page1" readonly/>
								<label for="memo">메모</label><input type="textarea" name="memo" class="memo"/>
								<input type="hidden" name="id" value="${v_study.study_id}" readonly/>
								<input type="hidden" name="type" value="page" readonly/><br/>
								<div class="comment">
									<button class="btn enddate-btn assert">해당 정보로 목표설정을 하시겠습니까?
									<span class="glyphicon glyphicon-ok"></span>
									</button>
								</div>
							</form>
						</div><!-- date-result -->
					</div><!-- by-date -->
				</div><!-- page-date -->
			</div><!-- page content -->
		</div><!-- .page-main end -->
	</div><!-- jumbotron end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>