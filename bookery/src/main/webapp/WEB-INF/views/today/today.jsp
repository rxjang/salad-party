<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
/* 캐러셀 */
	.full{
		padding:0;
	}
	.y-center{
		height:100%;
	}
	#today-main{
		width:100%;
		margin:0px;
		height:300px;
		overflow:hidden;
		padding:10px;
		marding:0;
		background-image: url("${pageContext.request.contextPath }/resources/imgs/today1.jpg");
		background-size: 100% 100%;
	}
	.owl-stage { /* 캐러셀 아래로 정렬 */
		margin-top:50px;
		padding-left: 12px;
		padding-right: 20px;
		align-items: baseline;
		display: inline-flex;
	}
	.main-ment{
		font-weight:900;
	}
	.imgs img{
		box-shadow: 2px 2px 6px #aaaaaa;
	}
	#smile img{
		width: 100%;
	}
	@media (max-width:1000px) {
		#today-main{
			height: 165px;
			padding: 5px;
		}
		.main-ment{
			font-size:small;
			margin:10px 0 5px 0;
		}
		.sub-ment{
			font-size:smaller;
		}
		.owl-stage { /* 캐러셀 아래로 정렬 */
			margin-top:10px;
		}
	}
		
/* 스터디의 오늘 할일 요약 */
	.perStudy{
		margin:20px 0; 
		padding:0;
		height: 100px;
		line-height: 100px;
	}
	.perStudy h4{
/* 		text-align:center; */
	}
	.perStudy a{
		margin-top: 20px;
	}
	.green,
	.yellow,
	.brown{
		font-size: 1.5em;
		text-align: center;
	}
	.green{
		background-color: #49654d;
		color: white;
	}
	.yellow{
		background-color: c0cfb2;
		color: #49654d;
	}
	.brown{
		background-color: rgb(197,174,132);
		color: white;
	}
	#today-chartlist{
		margin:0 auto;
	}
	#today-chartlist>div{
		border-top:1px solid #cccccc;
		border-bottom:1px solid #cccccc;
		
	}
	
	#chart-list{ /* ul */
		text-decoration: none;
		margin:0 auto;
		padding:0;
		width:80%;
		height:50px;
		overflow:hidden;
	}
	#chart-list li{
		display:inline-block;
		margin:0;
		padding:0;
		width: 20%;
		float:left;
		line-height:50px;
		text-align:center;
		border-left:1px solid #cccccc;
	}
	#chart-list li:last-child{
		border-right:1px solid #cccccc;
	}
	#chart-list li:hover{
/* 		background-color:#c0cfb2; */
/* 		border:1px solid #c0cfb2; */
		color:#c0cfb2;
		box-shadow: 0px 0px 3px 0.1px #c0cfb2;
	}
	
	#chart1{
		width: 100%;
		height: 600px;
	}
	.chart-inner{
		margin:0px auto;
		width:70%;
		height:300px;
	}
	
	
</style>

<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/plugins/timeline.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


<script type="text/javascript">
	var studyVo;//study_id당 V_StudyVo
	var calList;//study_id당 List<V_calendarVo>
	var amdata=[];//chart1에 사용할 data
	var start;
	var actual_perday;
	var list_date=new Array();
	var list_plan_perday=new Array();
	var list_actual_perday=new Array();
	var list_plan_accum=new Array();
	var list_actual_accum=new Array();
	var typeKor;

	// 책 목록 케러셀
	$(function() {
		$('.owl-carousel').owlCarousel({
			margin:20,
			responsiveClass:true,
			nav:false,
			autoPlay:true,
			responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
				480 : {
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

	$(function(){
		// 케러셀 아래부분 숨겼다가, 책 표지 클릭하면 해당하는 내용만 보이게 처리
		$(".perStudy").hide();
		$('.item').each(function(){
			$(this).click(function(){
				var study_id = $(this).find('input').val();//캐러셀에서 선택한 책의 study_id
				$('.perStudy').each(function(){
					var study_id2 = $(this).find('input').val();//캐러셀 하단 div에서 study_id 찾아 보이게 하기
					if(study_id==study_id2){
						$(this).show();
					}else{
						$(this).hide();
					}
				});
				// 클릭한 표지의 study_id을 service로 보내 data 받아오기
				$.ajax({
					url:'${pageContext.request.contextPath}/today/chart',
					type:'GET',
					data:'study_id='+study_id,
					success: function(data){
						console.log(data.code);//"OK" ajax 통신 성공 확인
						studyVo=data.study;
						if(studyVo.type=='chap'){typeKor="챕터"}else if(studyVo.type=='page'){typeKor="페이지"}
						calList=data.calList;
						console.log(studyVo.study_id);
						console.log(calList.length);
						amdata=[];
						list_date=[];
						list_plan_perday=[];
						list_actual_perday=[];
						list_plan_accum=[];
						list_actual_accum=[];
						calList.forEach(function(element,index){
								start = new Date(element.start).format('yyyy-MM-dd');
								actual_perday = element.actual_perday;
// 								console.log(start);
// 								console.log(actual_perday);
								amdata.push({startDate: start, dailyvalue: actual_perday});
// 								console.log(amdata);
								//Chart.js
								list_date.push(start);
// 								console.log(start)
								list_plan_perday.push(element.plan_perday);
// 								console.log(element.plan_perday)
								list_actual_perday.push(element.actual_perday);
								list_plan_accum.push(element.plan_accum);
								list_actual_accum.push(element.actual_accum);
						});
						console.log(list_actual_accum.length);
					}
				}); // ajax
				
			});// .item click
			
			$('#labelChartTimeline').click(function(){
				chartTimelineStart();
			});
			$('#labelChartPerDay').click(function(){
				chartPerDayStart();
			});
			$('#labelChartAccum').click(function(){
				chartAccumStart();
			});
			
		});// .item each
	});// doc ready
	
	// https://www.amcharts.com/demos/serpentine-stepline-chart/
	function chartTimelineStart(){
		am4core.ready(function() {
			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end
	
			var chart = am4core.create("chartTimeline", am4plugins_timeline.SerpentineChart);
			chart.levelCount = 3;
			
			chart.curveContainer.padding(50,20,50,20);
			chart.data = amdata;
	
			var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
			dateAxis.renderer.grid.template.location = 0;
	
			dateAxis.renderer.line.disabled = true;
			dateAxis.cursorTooltipEnabled = false;
			dateAxis.minZoomCount = 5;
	
			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.tooltip.disabled = true;
			valueAxis.renderer.innerRadius = -50;
			valueAxis.renderer.radius = 50;
			chart.seriesContainer.zIndex = -1;
	
			var series = chart.series.push(new am4plugins_timeline.CurveStepLineSeries());
			series.fillOpacity = 0.3;
			series.dataFields.dateX = "startDate";
			series.dataFields.valueY = "dailyvalue";
			series.tooltipText = "{valueY}";
			series.tooltip.pointerOrientation = "vertical";
			series.tooltip.background.fillOpacity = 0.7;
			series.fill = chart.colors.getIndex(3);
			series.strokeWidth = 2;
	
			chart.cursor = new am4plugins_timeline.CurveCursor();
			chart.cursor.xAxis = dateAxis;
			chart.cursor.yAxis = valueAxis;
			chart.cursor.lineY.disabled = true;
	
			chart.scrollbarX = new am4core.Scrollbar();
			chart.scrollbarX.width = am4core.percent(80);
			chart.scrollbarX.align = "center";
		}); // am4core.ready()
	} // chartTimelineStart
		
</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12 full">
		<div class="row" id="today-main">
			<div class="col-xs-3 col-md-3 ment">
				<c:if test="${fn:length(studyList) eq 0}">
					<h2 class="main-ment">기록할 책이 없습니다</h2>
					<h4 class="sub-ment"><a href="${pageContext.request.contextPath}/find">새 책을 검색하러 가볼까요?</a></h4>
				</c:if>
				<c:if test="${fn:length(studyList) ne 0}">
					<h2 class="main-ment">책 ${fn:length(studyList)}권을 보고 있어요</h2>
					<h4 class="sub-ment">책 표지를 선택해 주세요</h4>
				</c:if>
			</div>
			<div class="col-xs-9 col-md-9 y-center imgs">
				<div class="owl-carousel owl-theme y-center">
					<c:forEach items="${studyList }" var="list">
						<div class="item">
							<img class="media-object" src="${list.coverurl }" alt="책 이미지">
							<input type="hidden" value="${list.study_id }" />
						</div>
					</c:forEach>
				</div><!-- owl end -->
			</div>
		</div><!-- today-main -->	
		<div class="row" id="today-body">
			<c:forEach items="${studyList }" var="study">
				<div class="col-md-8 col-md-offset-2 col-xs-12 perStudy">
					<input type="hidden" value="${study.study_id }" />
					<div class="row">
						<c:set var="today" value="<%=new java.util.Date()%>"/>
						<c:if test="${study.type eq 'chap'}">
							<c:if test="${study.plan_chap lt study.actual_chap}">
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<h2 class="main-ment">우와! 정말 대단해요!</h2>
									<h4 class="sub-ment">오늘의 목표를 초과 달성하셨어요!</h4>
								</div>
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 기록 추가 입력하기</a>
								</div>
							</c:if>
							<c:if test="${study.plan_chap eq study.actual_chap}">
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<h2 class="main-ment">축하합니다!</h2>
									<h4 class="sub-ment">오늘의 목표를 모두 달성했어요!</h4>
								</div>
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 기록 추가 입력하기</a>
								</div>
							</c:if>
							<c:if test="${study.plan_chap gt study.actual_chap}">
								<div class="col-md-5 col-xs-10 col-xs-offset-1">
									<h2 class="main-ment">열심히 노력하는 당신!</h2>
									<h4 class="sub-ment">목표 달성까지 ${study.plan_chap-study.actual_chap } 챕터 남았어요!</h4>
								</div>
								<div class="col-md-5 col-xs-10 col-xs-offset-1">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 공부 입력하러 가기</a>
								</div>
							</c:if>
						</c:if>
						<c:if test="${study.type eq 'page'}">
							<c:if test="${study.plan_page lt study.actual_page}">
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<h2 class="main-ment">우와! 정말 대단해요!</h2>
									<h4 class="sub-ment">오늘의 목표를 초과 달성하셨어요!</h4>
								</div>
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 기록 추가 입력하기</a>
								</div>
							</c:if>
							<c:if test="${study.plan_page eq study.actual_page}">
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<h2 class="main-ment">축하합니다!</h2>
									<h4 class="sub-ment">오늘의 목표를 모두 달성했어요!</h4>
								</div>
								<div class="col-md-6 col-xs-10 col-xs-offset-1">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 기록 추가 입력하기</a>
								</div>
							</c:if>
							<c:if test="${study.plan_page gt study.actual_page}">
								<div class="col-md-5 col-xs-10 col-xs-offset-1">
									<h2 class="main-ment">열심히 노력하는 당신!</h2>
									<h4 class="sub-ment">목표 달성까지 ${study.plan_page-study.actual_page } 페이지 남았어요!</h4>
								</div>
								<div class="col-md-5 col-xs-10 col-xs-offset-1">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 공부 입력하러 가기</a>
								</div>
							</c:if>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div><!-- today-body -->
		<div class="row" id="today-chart">
			<div class="col-md-12 col-xs-12">
				<ul id="chart-list">
					<li id="labelChartTimeline">타임라인 보기</li>
					<li>완료율 보기</li>
					<li>평균 공부양으로 보기</li>
					<li id="labelChartPerDay">일일 공부양 보기</li>
					<li id="labelChartAccum">누적 공부양 보기</li>
				</ul>
			</div>
			<div  id="today-chart" class="col-md-8 col-md-offset-2 col-xs-12">
				<div id="charts" class="chart-inner">
					<div id="chartTimeline"></div><!-- timeline -->
					<canvas id="chartPerDay"></canvas>
					<canvas id="chartAccum"></canvas>
				</div>
			</div>
		</div><!-- today-charts -->	
	</div>
</div>
<!-- 							study_id: ${study_id }<br> -->
<!-- 							제목: ${study.title }<br> -->
<!-- 							시작일: ${study.startdate }<br> -->
<!-- 							끝일: ${study.enddate }<br> -->
<!-- 							-->
<!-- 							</div>todayDiv1 -->
<!-- 							<div id="todayDiv2" class="row"> -->
<!-- 								<div class="col-md-3 col-xs-3"> -->
<%-- 									<c:if test="${study.success_rate gt 100}"> --%>
<!-- 										<div class="green">목표를<br>초과달성했어요</div> -->
<%-- 									</c:if> --%>
<%-- 									<c:if test="${study.success_rate eq 100}"> --%>
<!-- 										<div class="yellow">목표를<br>달성했어요</div> -->
<%-- 									</c:if> --%>
<%-- 									<c:if test="${study.success_rate lt 100}"> --%>
<!-- 										<div class="brown">조금 더<br>분발하세요</div> -->
<%-- 									</c:if> --%>
<!-- 								</div> -->
<!-- 								<div class="col-md-3 col-xs-3"> -->
<!-- 									그래프 1 (지렁이그래프)<br> -->
<%-- 									시작일: ${study.startdate }<br> --%>
<%-- 									오늘: <fmt:formatDate value="${today }" pattern="yyyy-MM-dd" /><br> --%>
<%-- 									완료일: ${study.enddate } --%>
<!-- 								</div> -->
<!-- 								<div class="col-md-3 col-xs-3"> -->
<!-- 									그래프 2 (반달 대시보드 그래프)<br> -->
<%-- 									완료율: ${study.progress_rate }<br> --%>
<%-- 									완료: ${study.actual_page + study.actual_chap }<br> --%>
<%-- 									전체: ${study.total_pages + study.total_chap }<br> --%>
<!-- 								</div> -->
<!-- 								<div class="col-md-3 col-xs-3"> -->
<!-- 									그래프 3 (어제밤 기준 일일 평균진도/남은 양)<br> -->
<%-- 									총 날짜수: 	${study.total_days}<br> --%>
<%-- 									공부한날: ${study.actual_days_yesterday }일<br> --%>
<%-- 									계획했던 날 수: ${study.plan_days_yesterday }일<br> --%>
<%-- 									남은 날 수: ${study.remain_days }<br> --%>
<%-- 									<c:if test="${study.type eq 'chap'}"> --%>
<%-- 										챕터-총 챕터수: 	${study.total_chap}<br> --%>
<%-- 										챕터-목표 챕터수: 	${study.plan_chap_yesterday}<br> --%>
<%-- 										챕터-실제 챕터수: 	${study.actual_chap_yesterday}<br> --%>
<%-- 										일일 평균 목표량:	${study.plan_chap div study.total_days}<br> --%>
<%-- 										어제까지 평균일일진도:${study.actual_chap_yesterday div study.plan_days_yesterday}<br> --%>
<%-- 										<c:if test="${study.remain_days > 0}"> --%>
<%-- 											남은 기간동안 해야 하는 평균 일일 양:${(study.total_chap - study.actual_chap_yesterday) div (study.remain_days)} --%>
<%-- 										</c:if> --%>
<%-- 										<c:if test="${study.remain_days eq 0}"> --%>
<%-- 											남은 기간동안 해야 하는 평균 일일 양:${(study.total_chap-study.actual_chap_yesterday)} --%>
<%-- 										</c:if> --%>
<%-- 									</c:if> --%>
<%-- 									<c:if test="${study.type eq 'page'}"> --%>
<%-- 										페이지-총페이지수: 	${study.total_pages}<br> --%>
<%-- 										페이지-목표 페이지수:	${study.plan_page_yesterday}<br> --%>
<%-- 										페이지-실제 페이지수:	${study.actual_page_yesterday}<br> --%>
<%-- 										일일 평균 목표량:	${study.total_pages div study.total_days}<br> --%>
<%-- 										어제까지 평균 일일 진도:${study.actual_page_yesterday div study.plan_days_yesterday}<br> --%>
<%-- 										<c:if test="${study.remain_days > 0}"> --%>
<%-- 											남은 기간동안 해야 하는 평균 일일 양:${(study.total_pages - study.actual_page_yesterday) div (study.remain_days)} --%>
<%-- 										</c:if> --%>
<%-- 										<c:if test="${study.remain_days eq 0}"> --%>
<%-- 											남은 기간동안 해야 하는 평균 일일 양:${(study.total_pages-study.actual_page_yesterday)} --%>
<%-- 										</c:if> --%>
<%-- 									</c:if> --%>
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div id="chart12" class="row"> -->
<!-- 								<div id="chart1" class="col-md-6 col-xs-6"> -->
									
<!-- 								</div> -->
<!-- 								<div id="chart2" class="col-md-6 col-xs-6"> -->
									
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div id="todayDiv3" class="row"> -->
<!-- 								<div class="col-md-6 col-xs-6"> -->
<!-- 									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))<br> -->
<%-- 									목록길이: ${fn:length(cals) }<br> --%>
<%-- 									<c:forEach items="${cals}" var="cal" varStatus="status"> --%>
<%-- 										${cal.user_id}  --%>
<%-- 										${cal.sid_date}  --%>
<%-- 										${cal.type}  --%>
<%-- 										${cal.study_id}  --%>
<%-- 										${cal.start}  --%>
<%-- 										${cal.plan_accum}  --%>
<%-- 										${cal.actual_accum}  --%>
<%-- 										${cal.status}<br> --%>
<%-- 									</c:forEach> --%>
<!-- 								</div> -->
<!-- 								<div class="col-md-6 col-xs-6"> -->
<!-- 									그래프 5 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))<br> -->
<%-- 									목록길이: ${fn:length(cals) }<br> --%>
<%-- 									<c:forEach items="${cals}" var="cal" varStatus="status"> --%>
<%-- 										${cal.user_id}  --%>
<%-- 										${cal.sid_date}  --%>
<%-- 										${cal.type}  --%>
<%-- 										${cal.study_id}  --%>
<%-- 										${cal.start}  --%>
<%-- 										${cal.plan_perday}  --%>
<%-- 										${cal.actual_perday}  --%>
<%-- 										${cal.status}<br> --%>
<%-- 									</c:forEach> --%>

<script type="text/javascript">

	//일일 차트 Chart.js
	function chartPerDayStart(){
		var ctx_perday=document.getElementById('chartPerDay');
		console.log(list_date);
		
		var config_perday={
			type: 'line',
			data: {
				labels:list_date,
				datasets: [{
					label: '계획한 양',
					backgroundColor: '#e4e6da',
					borderColor: '#e4e6da',
					fill: false,
					data: list_plan_perday
				}, {
					label: '실제 공부한 양',
					backgroundColor: '#8ba989',
					borderColor: '#8ba989',
					fill: true,
					data: list_actual_perday
				}]
			},
			options: {
				maintainAspectRatio: false,
				title: {
					text: 'Chart.js Time Scale'
				},
				scales: {
					yAxes: [{
						scaleLabel: {
							display: true,
							labelString: typeKor
						}
					}]
				},
			}
		};
		var chartPerDay = new Chart(ctx_perday, config_perday);
	}
	
	// 누적 차트 Chart.js
	function chartAccumStart(){
		var ctx_accum=document.getElementById('chartAccum');
		var config_accum = {
			type: 'line',
			data: {
				labels:list_date,
				datasets: [{
					label: '계획한 양',
					backgroundColor: '#e4e6da',
					borderColor: '#e4e6da',
					fill: false,
					data: list_plan_accum,
				}, {
					label: '실제 공부한 양',
					backgroundColor: '#8ba989',
					borderColor: '#8ba989',
					fill: true,
					data: list_actual_accum,
				}]
			},
			options: {
				maintainAspectRatio: false,
				title: {
					text: 'Chart.js Time Scale'
				},
				scales: {
					yAxes: [{
						scaleLabel: {
							display: true,
							labelString: typeKor
						}
					}]
				},
			}
		};
		var chartAccum = new Chart(ctx_accum, config_accum);
	}
</script>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>