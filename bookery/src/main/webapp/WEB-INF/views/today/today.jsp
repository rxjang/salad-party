<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
/* 캐러셀 */
	.y-center{
		height:100%;
	}
	#today-main{
/* 		margin-top:100px; */
		height:300px;
		overflow:hidden;
		padding:10px;
		background-image: url("${pageContext.request.contextPath }/resources/imgs/today1.jpg");
		background-size: 100% 100%;
	}
	.owl-stage { /* 캐러셀 아래로 정렬 */
		margin-top:50px;
		padding-left: 12px;
		padding-right: 20px;
		padding-bottom: 5px;
		align-items: baseline;
		display: inline-flex;
		cursor:pointer;
	}
	.main-ment{
		margin-top:40px;
		font-weight:900;
	}
	.media-object{
		box-shadow: 2px 2px 6px #aaaaaa;
		padding: 10px;
	}
	.selected{
		border: 5px solid #e4e6da;
		padding: 5px;
	}
	
	@media (max-width:1000px) {
		#today-main{
			height: 190px;
			padding: 0px;
		}
		.ment{
			padding:10px;
		}
		.main-ment{
			font-size:medium;
			margin:10px 0 5px 0;
		}
		.sub-ment{
			font-size:small;
		}
		.owl-stage { /* 캐러셀 아래로 정렬 */
			margin-top:25px;
		}
		.media-object{
			padding: 8px;
		}
		.selected{
			border: 4px solid #e4e6da;
			padding: 4px;
		}
		.chart-desc{
		height:50px;
		padding:20px;
	}
	}
		
/* 스터디 요약 */
	.perStudy{
		margin:20px 0; 
		padding:0;
	}
	.perStudy .row{
		margin:20px 0; 
	}
	#summary{
		padding:0;
	}
	.dates{
		background-color:#f7f7f7;
		border-radius:15px;
		display:flex;
		width:100%;
		margin-left:0px;
		margin-top:20px;
		margin-bottom:20px;
	}
	.date{
		text-align:center;
		margin:5px auto;
		padding:0.5em;
		width:25%;
		display: flex;
		flex-direction: column;
		font-size:0.9em;
		border-left:1px solid white;
	}
	.date:first-child {
		border-left:0px;
	}
	.date-data{
		font-size:1.2em;
		font-weight:bold;
		color:#505050;
	}
	.btn{
/* 		margin:30px 0; */
		border-radius:15px;
		cursor: pointer;
		color:#8ba989;
		border: 1px solid #e4e6da;
	}
	.btn:hover{
/* 		color:white; */
		color:#8ba989;
		font-weight:bold;
		background-color:#e4e6da;
		border: 1px solid #e4e6da;
	}
	
/* 	차트 목록 */
	#chartList{
		margin:0 auto;
/* 		padding:0; */
		width:100%;
		height:50px;
/* 		overflow:hidden; */
/* 		border-radius: 15px; */
	}
	#chartList a{
		display:inline-block;
		margin:0;
		padding:0;
		width: 20%;
		float:left;
		line-height:50px;
		text-align:center;
		cursor: pointer;
/* 		color:#8ba989; */
/* 		border: 1px solid #8ba989; */
		border-radius:0;
	}
	#chartList a:first-child{
		border-top-left-radius:15px;
		border-bottom-left-radius:15px;
	}
	#chartList a:last-child{
		border-top-right-radius:15px;
		border-bottom-right-radius:15px;
	}
	#chartList a:hover{
/* 		color:white; */
/* 		font-weight:bold; */
/* 		background-color:#c0cfb2; */
	}
	.sticky {
		position: -webkit-sticky; /* Safari */
		position: sticky;
		top: 0;
/* 		background-color: green; */
/* 		border: 2px solid #4CAF50; */
	}
	
/* 	차트 설명 */
	.chart-desc{
		height:500px;
	}
	.chart-desc h2{
		color:49654d;
		margin-bottom:15px;
	}
	.chartOuter{
		width:90%;
		height:400px;
		margin:0px auto;
	}
	.col-xs-12{
		padding:0 20px;
	}
	
</style>

<script type="text/javascript">
	var studyVo;// study_id당 V_StudyVo
	var calList;// study_id당 List<V_calendarVo>
	var amdata=[];// chart1에 사용할 data
	var chart;
	var start;
	var actual_perday;

	var list_date=new Array();
	var list_plan_perday=new Array();
	var list_actual_perday=new Array();
	var list_plan_accum=new Array();
	var list_actual_accum=new Array();

	var typeKor;// "챕터","페이지"
	var total;// 총챕터수 or 총페이지수
	var progress;// progress_rate
	var arrPlan=[];// [[x값,y값],[],[],[]]
	var arrActual=[];// [[x값,y값],[],[],[]]
	var daysPlan;//어제까지의 날짜 수
	
	var _canvas;//canvas 요소

	// 책 목록 케러셀
	$(function() {
		$('.owl-carousel').owlCarousel({
			margin:20,
			responsiveClass:true,
			nav:false,
			autoPlay:true,
			responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
				300 : {items:2},
				600 : {items:5},
				1200 : {items:7}
			}
		});
	});
	
	// 책 목록에서 책 이미리 클릭할 때의 이벤트
	function item_click(){
		$('.item').find('img').removeClass("selected");
		$(this).find('img').addClass("selected");// 캐러셀에서 선택한 책에 액자 효과 주기
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
				if(studyVo.type=='chap'){
					typeKor="챕터";
					total=studyVo.total_chap;
				}else if(studyVo.type=='page'){
					typeKor="페이지";
					total=studyVo.total_pages;
				}
				progress=studyVo.progress_rate;
				calList=data.calList;

				amdata=[];
				list_date=[];
				list_plan_perday=[];
				list_actual_perday=[];
				list_plan_accum=[];
				list_actual_accum=[];

				calList.forEach(function(element,index){
					//amchart
					start = new Date(element.start).format('yyyy-MM-dd');
					actual_perday = element.actual_perday;
					amdata.push({startDate: start, dailyvalue: actual_perday});
					//Chart.js
					list_date.push(start);
					list_plan_perday.push(element.plan_perday);
					list_actual_perday.push(element.actual_perday);
					list_plan_accum.push(element.plan_accum);
					list_actual_accum.push(element.actual_accum);
				});

				//highcgart
				var days=studyVo.total_days; //총 날짜 수
				daysPlan=studyVo.plan_days_yesterday; //어제까지 계획한 날짜 수
				var daysActual=studyVo.actual_days_yesterday; //어제까지 공부한 날짜 수
				var daysRemain=studyVo.remain_days; // 오늘 포함 남은 날 수
				console.log(daysRemain);
				console.log(typeof daysRemain);
				arrPlan=[];
				arrActual=[];
				var y_plan;
				var y_actual;
				for(var i=0; i<days; i++){
					temp_plan=[];
					temp_actual=[];
					if(studyVo.type=='chap'){
						if(i<daysPlan){
							y_plan=studyVo.plan_chap / studyVo.total_days;
							temp_plan.push(i+1,y_plan);
							arrPlan.push(temp_plan);
							y_actual=studyVo.actual_chap_yesterday / studyVo.plan_days_yesterday;
							temp_actual.push(i+1,y_actual);
							arrActual.push(temp_actual);
						}else if(i>=daysPlan && daysRemain>0){
							y_plan=studyVo.plan_chap / studyVo.total_days;
							temp_plan.push(i+1,y_plan);
							arrPlan.push(temp_plan);
							y_actual=(studyVo.total_chap - studyVo.actual_chap_yesterday) / studyVo.remain_days;
							console.log(y_actual);
							temp_actual.push(i+1,y_actual);
							arrActual.push(temp_actual);
						}else if(i>=daysPlan && daysRemain==0){	
							y_plan=studyVo.plan_chap / studyVo.total_days;
							temp_plan.push(i+1,y_plan);
							arrPlan.push(temp_plan);
							y_actual=studyVo.total_chap - studyVo.actual_chap_yesterday;
							console.log(y_actual);
							temp_actual.push(i+1,y_actual);
							arrActual.push(temp_actual);
						}
					}else if(studyVo.type=='page'){
						if(i<daysPlan){
							y_plan=studyVo.plan_page / studyVo.total_days;
							temp_plan.push(i+1,y_plan);
							arrPlan.push(temp_plan);
							y_actual=studyVo.actual_page_yesterday / studyVo.plan_days_yesterday;
							temp_actual.push(i+1,y_actual);
							arrActual.push(temp_actual);
						}else if(i>=daysPlan && daysRemain>0){
							y_plan=studyVo.plan_page / studyVo.total_days;
							temp_plan.push(i+1,y_plan);
							arrPlan.push(temp_plan);
							y_actual=(studyVo.total_pages - studyVo.actual_page_yesterday) / studyVo.remain_days;
							temp_actual.push(i+1,y_actual);
							arrActual.push(temp_actual);
						}else if(i>=daysPlan && daysRemain==0){	
							y_plan=studyVo.plan_page / studyVo.total_days;
							temp_plan.push(i+1,y_plan);
							arrPlan.push(temp_plan);
							y_actual=studyVo.total_pages - studyVo.actual_page_yesterday;
							temp_actual.push(i+1,y_actual);
							arrActual.push(temp_actual);
						}
					}
				} //for
			} //success: function(data)
		}); // ajax
		chartStart();
	}//item_click()

	$(function(){//doc ready
		$(".perStudy").hide();// 케러셀 아래부분 숨기고, 책 표지 클릭하면 해당하는 내용만 보이게 처리
		setTimeout(function(){
			$('.item').eq(0).click();
		}, 500);
		setTimeout(function(){
			$('.item').eq(0).click();
		}, 600);
		$('.item').each(function(){
			$(this).click(item_click);
		});
	});// doc ready

	function chartStart(){//ajax로 데이터 불러온 1초 후에 차트들 실행함
		setTimeout(function(){
			chartTimelineStart();
			chartGaugeStart();
			chartAvgStart();
			chartPerDayStart();
			chartAccumStart();
		},1000)
	}
	
	// https://www.amcharts.com/demos/serpentine-stepline-chart/
	function chartTimelineStart(){
		am4core.ready(function() {
			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end
	
			chart = am4core.create("chartTimeline", am4plugins_timeline.SerpentineChart);
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

	} // chartTimelineStart()
	
	// https://www.amcharts.com/demos/gauge-with-gradient-fill/
	function chartGaugeStart(){
		am4core.ready(function() {
			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			// create chartG
			var chartG = am4core.create("chartGauge", am4charts.GaugeChart);
			chartG.innerRadius = -15;

			var axis = chartG.xAxes.push(new am4charts.ValueAxis());
			axis.min = 0;
			axis.max = total;
			axis.strictMinMax = true;

			var colorSet = new am4core.ColorSet();

			var gradient = new am4core.LinearGradient();
			gradient.stops.push({color:am4core.color("#e4e6da")})
			gradient.stops.push({color:am4core.color("#c0cfb2")})
			gradient.stops.push({color:am4core.color("#8ba989")})
			gradient.stops.push({color:am4core.color("#49654d")})

			axis.renderer.line.stroke = gradient;
			axis.renderer.line.strokeWidth = 15;
			axis.renderer.line.strokeOpacity = 1;

			axis.renderer.grid.template.disabled = true;

			var hand = chartG.hands.push(new am4charts.ClockHand());
			hand.radius = am4core.percent(95);
			hand.showValue(progress);
		});// am4core.ready()
	}// chartGaugeStart()
	
	// Highchart 
	// https://www.highcharts.com/docs/stock/depth-chart
	function chartAvgStart(){
		Highcharts.chart('chartAvg', {
				chart: {
					type: 'area',
					zoomType: 'xy'
				},
				title: {
					text: '일일 평균 독서/공부량'
				},
				xAxis: {
					minPadding: 0,
					maxPadding: 0,
					plotLines: [{
						color: '#888',
						value: daysPlan+0.5,
						width: 1,
						label: {
							text: '오늘',
							rotation: 0
						}
					}],
					title: {
						text: '날짜'
					}
				},
				yAxis: [{
					lineWidth: 1,
					gridLineWidth: 1,
					title: typeKor,
					tickWidth: 1,
					tickLength: 5,
					tickPosition: 'inside',
					labels: {
						align: 'left',
						x: 8
					}
				}, {
					opposite: true,
					linkedTo: 0,
					lineWidth: 1,
					gridLineWidth: 0,
					title: typeKor,
					tickWidth: 1,
					tickLength: 5,
					tickPosition: 'inside',
					labels: {
						align: 'right',
						x: -8
					}
				}],
				legend: {
					enabled: false
				},
				plotOptions: {
					area: {
						fillOpacity: 0.2,
						lineWidth: 1,
						step: 'center'
					}
				},
				tooltip: {
					headerFormat: '<span style="font-size=10px;">날짜수: {point.key}</span><br/>',
					valueDecimals: 2
				},
				series: [{
					name: '목표',
					data: arrPlan,
					color: '#03a7a8'
				}, {
					name: '실행',
					data: arrActual,
					color: '#fc5857'
				}]
		});
	} // chartAvgStart()
	
</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start**********-->
<div class="row" id="today-main">
	<div class="col-xs-5 col-md-3 ment">
		<c:if test="${fn:length(studyList) eq 0}">
			<h2 class="main-ment">기록할 책이 없습니다</h2>
			<h4 class="sub-ment"><a href="${pageContext.request.contextPath}/find">새 책을 검색하러 가볼까요?</a></h4>
		</c:if>
		<c:if test="${fn:length(studyList) ne 0}">
			<h2 class="main-ment">책 ${fn:length(studyList)}권을 보고 있어요</h2>
			<h4 class="sub-ment">책 표지를 선택해 주세요</h4>
		</c:if>
	</div>
	<div class="col-xs-7 col-md-9 y-center imgs">
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
	<div class="col-md-12 col-xs-12">
		<div class="row">
			<div class="col-md-2"></div>
			<c:forEach items="${studyList }" var="study">
				<div class="col-md-8 col-xs-12 perStudy">
					<input type="hidden" value="${study.study_id }" />
					<div class="row">
						<c:set var="today" value="<%=new java.util.Date()%>"/>
						<c:if test="${study.type eq 'chap'}">
							<c:if test="${study.plan_chap lt study.actual_chap}">
								<h2 class="main-ment">우와! 정말 대단해요!</h2>
								<h4 class="sub-ment">오늘의 목표를 초과 달성하셨어요!</h4>
							</c:if>
							<c:if test="${study.plan_chap eq study.actual_chap}">
								<h2 class="main-ment">축하합니다!</h2>
								<h4 class="sub-ment">오늘의 목표를 모두 달성했어요!</h4>
							</c:if>
							<c:if test="${study.plan_chap gt study.actual_chap}">
								<h2 class="main-ment">열심히 노력하는 당신!</h2>
								<h4 class="sub-ment">오늘의 목표 달성까지 ${study.plan_chap-study.actual_chap } 챕터 남았어요!</h4>
							</c:if>
						</c:if>
						<c:if test="${study.type eq 'page'}">
							<c:if test="${study.plan_page lt study.actual_page}">
								<h2 class="main-ment">우와! 정말 대단해요!</h2>
								<h4 class="sub-ment">오늘의 목표를 초과 달성하셨어요!</h4>
							</c:if>
							<c:if test="${study.plan_page eq study.actual_page}">
								<h2 class="main-ment">축하합니다!</h2>
								<h4 class="sub-ment">오늘의 목표를 모두 달성했어요!</h4>
							</c:if>
							<c:if test="${study.plan_page gt study.actual_page}">
								<h2 class="main-ment">열심히 노력하는 당신!</h2>
								<h4 class="sub-ment">오늘의 목표 달성까지 ${study.plan_page-study.actual_page } 페이지 남았어요!</h4>
							</c:if>
						</c:if>
					</div>
					<div class="row">
						<div class="col-md-12 col-xs-12" id="summary" >
							<div class="dates">
								<div class="date">
									시작일<br/>
									<span class="date-data">${study.startdate}</span>
								</div>
								<div class="date">
									목표일<br/>
									<span class="date-data">${study.enddate}</span>
								</div>
								<div class="date">
									남은날짜<br/>
									<span class="date-data">${study.remain_days}</span>
								</div>
								<div class="date">
									전체<br/>
									<span class="date-data">${study.total_pages + study.total_chap } ${study.type }</span>
								</div>
								<div class="date">
									완료<br/>
									<span class="date-data">${study.actual_page + study.actual_chap } ${study.type }</span>
								</div>
							</div><!-- dates -->
						</div>
					</div>
					<div class="row">
						<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
						type="button" class="btn btn-default btn-lg btn-block">오늘의 공부 입력하러 가기</a>
					</div>
					<div class="row">
						<h2 class="main-ment">다양한 차트를 통해 진행중인 스터디의 현황을 볼 수 있어요</h2>
						<h4 class="sub-ment">차트 목록에서 원하는 기록 타입을 선택하세요. 차트들은 어젯밤 12시까지의 기록을 기준으로 그려집니다.</h4>
						<div id="chartList" class="sticky">
							<a href="#chart1" type="button" class="btn btn-default btn-lg">타임라인</a>
							<a href="#chart2" type="button" class="btn btn-default btn-lg">진행률</a>
							<a href="#chart3" type="button" class="btn btn-default btn-lg">일일 평균</a>
							<a href="#chart4" type="button" class="btn btn-default btn-lg">일일 기록</a>
							<a href="#chart5" type="button" class="btn btn-default btn-lg">누적 기록</a>
						</div>
					</div>
				</div><!-- col-md-8 col-xs-12 perStudy -->
		</div>
	</c:forEach>
		<div class="row" id="chart1">
			<div class="col-md-3 col-md-offset-2 col-xs-12 chart-desc">
				<h2 class="main-ment">타임라인 차트</h2>
				<h4 class="sub-ment">스터디를 시작한 날부터 마치는 날까지 하루하루 기록한 챕터 또는 페이지의 양을 시간 순으로 볼 수 있어요.<br><br>
				더 자세히 보고 싶다면 차트 위에 가로로 있는 바를 움직여 보세요. 최소 5일까지 자세히 볼 수 있어요.<br><br>
				차트 위를 움직여 보세요. 각 날짜의 값도 볼 수 있어요. </h4>
			</div>
			<div class="col-md-5 col-xs-12">
				<div class="row chartOuter" id="chartTimelineOuter">
					<div id="chartTimeline" class="chart-inner"></div>
				</div>
			</div>
		</div>
		<div class="row" id="chart2">
			<div class="col-md-3 col-md-offset-2 col-xs-12 chart-desc">
				<h2 class="main-ment">진행률 게이지</h2>
				<h4 class="sub-ment">전체 중 완료한 양을 볼 수 있어요.<br><br>
				숫자는 챕터 또는 페이지 수, 바늘은 현재 완료한 위치를 나타냅니다.</h4>
			</div>
			<div class="col-md-5 col-xs-12">
				<div class="row chartOuter" id="chartGaugeOuter">
					<div id="chartGauge" class="chart-inner"></div>
				</div>
			</div>
		</div>
		<div class="row" id="chart3">
			<div class="col-md-3 col-md-offset-2 col-xs-12 chart-desc">
				<h2 class="main-ment">일일평균 차트</h2>
				<h4 class="sub-ment">목표로 설정한 하루 평균 스터디양과, 실제로 기록한 하루 평균 스터디양을 비교해 보세요.<br><br>
				어제까지의 기록을 기준으로, 목표 완료일까지 스터디를 마치기 위해 필요한, 이후의 일일 스터디양이 계산됩니다.<br><br>
				차트 위를 움직여 보세요. 각 날짜의 상세한 값도 볼 수 있어요.</h4>
			</div>
			<div class="col-md-5 col-xs-12">
				<div class="row chartOuter" id="chartAvgOuter">
					<div id="chartAvg" class="chart-inner"></div>
				</div>
			</div>
		</div>
		<div class="row" id="chart4">
			<div class="col-md-3 col-md-offset-2 col-xs-12 chart-desc">
				<h2 class="main-ment">일일 기록</h2>
				<h4 class="sub-ment">스터디를 시작한 날부터 마치는 날까지 하루하루 기록한 챕터 또는 페이지의 양을 목표량과 비교해서 볼 수 있어요.<br><br>
				차트 위를 움직여 보세요. 각 날짜의 상세한 값도 볼 수 있어요.<br><br>
				연한 색은 목표한 양, 진한 색은 완료한 양을 나타냅니다.</h4>
			</div>
			<div class="col-md-5 col-xs-12">
				<div class="row chartOuter" id="chartPerDayOuter">
					<canvas id="chartPerDay" class="chart-inner"></canvas>
				</div>
			</div>
		</div>
		<div class="row" id="chart5">
			<div class="col-md-3 col-md-offset-2 col-xs-12 chart-desc">
				<h2 class="main-ment">누적 기록</h2>
				<h4 class="sub-ment">스터디를 시작한 날부터 마치는 날까지 기록한 챕터 또는 페이지의 누적량을 목표량과 비교해서 볼 수 있어요.<br><br>
				차트 위를 움직여 보세요. 각 날짜의 상세한 값도 볼 수 있어요.<br><br>
				연한 색은 목표한 양, 진한 색 영역은 완료한 양을 나타냅니다.</h4>
			</div>
			<div class="col-md-5 col-xs-12">
				<div class="row chartOuter" id="chartAccumOuter">
					<canvas id="chartAccum" class="chart-inner" width="500" height="300"></canvas>
				</div>
			</div>
		</div>
</div><!-- .row.today-body -->
<!--**********content end**********-->

<script type="text/javascript">
	//일일 차트 Chart.js
	//요소 상태별 샐깔 달리 줄 수 있는지 시험
	function chartPerDayStart(){
		var ctx_perday=document.getElementById('chartPerDay');
		console.log(list_date);
		
		var config_perday={
			type: 'bar',
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
<%@ include file="../template/footer.jspf" %>
</body>
</html>