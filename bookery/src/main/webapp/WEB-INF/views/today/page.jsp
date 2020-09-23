<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	//오늘 날짜 yyyy-mm-dd
	function getRecentDate(){
	    var dt = new Date();
	    var recentYear = dt.getFullYear();
	    var recentMonth = dt.getMonth() + 1;
	    var recentDay = dt.getDate();
	 
	    if(recentMonth < 10) recentMonth = "0" + recentMonth;
	    if(recentDay < 10) recentDay = "0" + recentDay;
	    return recentYear + "-" + recentMonth + "-" + recentDay;
	}
	var Dday;
	var deadLine = "${v_study.dday}";
	$(function() {
		//D day 구하기
		var currentTime = getRecentDate();
		var start = new Date(currentTime);
		var end = new Date(deadLine);
		var dateDiff = Math.ceil((end.getTime() - start.getTime())
				/ (1000 * 3600 * 24));
		Dday = dateDiff;
		$('#owl-dday').text('D-'+Dday);
		console.log(dateDiff);


		$('#book_thumbnail img').css({'box-shadow':'rgb(135, 165, 134) 5px 5px 10px','display':'block','margin':'auto'});
		
		/**********************    캐러셀    **********************/
		var owlyear = deadLine.substring(0,4)+'년';
		var owlmonth = deadLine.substring(5,7)+'월';
		var owlday = deadLine.substring(8,10)+'일';
		$('#owl-year').text(owlyear);
		$('#owl-monthday').text(owlmonth+owlday);
		
		$('.caro-cnt').css({'font-size':'110%','font-weight':'500'});
		$('.owl-item').css('text-align','center');
		$('.owl-item small').css('color','#8f8f8f');
		
		$('.owl-stage-outer').owlCarousel({
			items:4,
			loop : true,
			autoplay : true,
			margin : 10,
			merge : false,
			nav : false,
			responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
			}
		});//owl캐러셀
		
	});//ready
</script>

<style type="text/css">
.media{
	text-align: center;
}

</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row"><br /></div>
	
	<!-- 
				오늘의 진도 >> 공부중인 책클릭 >> 오늘 공부한 페이지 입력할 수 있는 form
				책 정보
				공부상황: 진행률(그래프 or 차트 or 프로그래스바). 디데이 계산 . 남은 페이지수. 
				 -->
<%-- 
	<div class="row">
		<div class="col-md-3">&nbsp;</div>
		<div class="col-xs-12 col-md-4">
<!--
'2', NULL, '14466324', '시나공 정보처리기사 실기 C와 JAVA의 기,산업기사 포함,2019', '3', 
'2020-09-19 00:18:31', NULL, '2020-09-01', '2020-10-01',
 '2020-10-17', NULL, 'page', NULL, NULL, NULL, 
 '30', '21', '1200', '840', '680', NULL, NULL, 
 '56.6667', '80.9524', '56.6667', '80.9524'

  -->
			<div class="media">
				<div class="media-left">
					<a href="#"> <img class="media-object"
						src="https://bookthumb-phinf.pstatic.net/cover/163/114/16311458.jpg?type=m140&udate=20200701"
						alt="...">
					</a>
				</div>
				<div class="media-body">
					<h4 class="media-heading">${v_study.title } </h4>
					<p>book_bid ${v_study.book_bid } </p>
					<p>study_id ${v_study.study_id } </p>
					<h4>Begin ${v_study.createtime }</h4>
					<h4>DeadLine ${v_study.dday }</h4>
					<h4>dday D-<span id="dday"></span> </h4>
					<p>total_days ${v_study.total_days } </p>
					<p>total_pages ${v_study.total_pages } </p>
					<p>plan_page ${v_study.plan_page } </p>
					<p>actual_page ${v_study.actual_page } </p>
				</div>
			</div>
			
			<div class="list-group">
				<a href="#" class="list-group-item"> ${v_study.title } </a>
				<a href="#" class="list-group-item">success_rate ${v_study.success_rate }</a>
				<a href="#" class="list-group-item">progress_rate ${v_study.progress_rate }</a>
			</div>

		</div>
		<div class="col-md-3">
		</div>
		<div class="col-md-2">&nbsp;</div>

	</div>
	
	 --%>
	<div class="row">
		<div class="col-md-3"></div>
			<div id="book_thumbnail" class="col-xs-12 col-md-6">
				<a href="#">
					<img class="thumbnail" src="${book.coverurl }" alt="..."/>
				</a>			
			</div>
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-12"><br/><br/></div>
	</div>
	
	<div class="row">
		<div class="col-md-3"></div>
		<div id="book_detail" class="col-xs-12 col-md-6">
			<div class="media">
				<div class="media-body">
					<h4 class="media-heading">${book.title }<br/> <small>${v_study.memo } </small></h4>
					<%-- 	<p><small>저자&nbsp;</small>${book.writer }</p>
						<p><small>원제</small>${book.titleoriginal}</p> --%>
				
					<c:choose>
					<c:when test="${null ne book.writer && '' ne book.writer}">
							<p><small>저자&nbsp;</small>${book.writer }</p>
					</c:when>
					<c:when test="${book.titleoriginal  ne null} && ${book.titleoriginal  ne ''}">
							<p><small>원제&nbsp;</small>${book.titleoriginal}</p>
					</c:when>
					</c:choose>
								
				</div>
			</div>

		</div>
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-12 bottom-line"></div>
	</div>
	
	<div class="row">
		<div class="col-md-3"></div>
			<div id="book_carousel" class="col-xs-12 col-md-6">
	
				<div class="owl-carousel owl-theme owl-loaded">
					<div class="owl-stage-outer">
						<div class="owl-stage">
							<div class="owl-item" id="owl-deadLine">
								<p><small>목표일</small></p>	
								<p><span class="caro-cnt" id="owl-year"></span></p>	
								<p id="owl-monthday"></p>	
							</div><!-- deadLine -->
							<div class="owl-item">
								<p><small>디데이</small></p>	
								<p><span class="caro-cnt" id="owl-dday"></span></p>	
								<p><small>&nbsp;</small></p>	
							</div><!-- D day -->
							<div class="owl-item" id="owl-progress">
								<p><small>진도</small></p>	
								<p><span class="caro-cnt" id="owl-dday">${v_study.progress_rate }%</span></p>	
								<p><small>&nbsp;</small></p>
							</div><!-- 진행률 -->
							<div class="owl-item" id="owl-pageRate">
								<p><small>페이지</small></p>	
								<p><span class="caro-cnt" id="owl-dday">${v_study.actual_page}/${v_study.total_pages}</span></p>	
								<p><small>&nbsp;</small></p>
							</div><!--내가 공부한 페이지/총페이지 -->
						</div>
					</div>
				</div>

		</div>
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-12 bottom-line"></div>
	</div>
	
	
	<div class="row">
		<div class="col-md-3"></div>
			<div id="page_check" class="col-xs-12 col-md-6">
				<!-- form 페이지 입력 하기-->
		<p class="lead">${v_study.actual_page }페이지까지 읽었습니다.</p>
		<p class="lead">오늘의 목표&nbsp;<strong>${v_study.plan_page }</strong>페이지</p>
				<button class="btn btn-default">페이지 입력</button>
		</div>
		<div class="col-md-3"></div>
	</div>
	
	
	
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>

</body>
</html>
