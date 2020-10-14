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
	#todayChartList{
		margin:0 auto;
	}
	#todayChartList>div{
		border-top:1px solid #cccccc;
		border-bottom:1px solid #cccccc;
		
	}
	
	#chartList{ /* ul */
		text-decoration: none;
		margin:0 auto;
		padding:0;
		width:80%;
		height:50px;
		overflow:hidden;
	}
	#chartList li{
		display:inline-block;
		margin:0;
		padding:0;
		width: 20%;
		float:left;
		line-height:50px;
		text-align:center;
		border-left:1px solid #cccccc;
	}
	#chartList li:last-child{
		border-right:1px solid #cccccc;
	}
	#chartList li:hover{
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
	var today=new Date().format('yyyy-MM-dd');
	
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
		$('#todayChartList').hide();
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
						var daysPlan=studyVo.plan_days_yesterday; //어제까지 계획한 날짜 수
						var daysActual=studyVo.actual_days_yesterday; //어제까지 공부한 날짜 수
						var daysRemain=studyVo.remain_days; // 오늘 포함 남은 날 수
						console.log(daysRemain);
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
									y_actual=(studyVo.total_chap - studyVo.actual_chap_yesterday) / daysRemain;
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
									y_actual=(studyVo.total_page - studyVo.actual_page_yesterday) / daysRemain;
									temp_actual.push(i+1,y_actual);
									arrActual.push(temp_actual);
								}else if(i>=daysPlan && daysRemain==0){	
									y_plan=studyVo.plan_page / studyVo.total_days;
									temp_plan.push(i+1,y_plan);
									arrPlan.push(temp_plan);
									y_actual=studyVo.total_page - studyVo.actual_page_yesterday;
									temp_actual.push(i+1,y_actual);
									arrActual.push(temp_actual);
								}
							}
						} //for
					} //success: function(data)
				}); // ajax
				$('#todayChartList').show();
			});// .item click

			$('#labelChartTimeline').click(function(){
				chartTimelineStart();
				$('#charts').children().hide();
				$('#chartTimeline').show();
			});
			$('#labelChartGauge').click(function(){
				chartGaugeStart();
				$('#charts').children().hide();
				$('#chartGauge').show();
			});
			$('#labelChartAvg').click(function(){
				chartAvgStart();
				$('#charts').children().hide();
				$('#chartAvg').show();
			});
			$('#labelChartPerDay').click(function(){
				chartPerDayStart();
				$('#charts').children().hide();
				$('#chartPerDay').show();
			});
			$('#labelChartAccum').click(function(){
				chartAccumStart();
				$('#charts').children().hide();
				$('#chartAccum').show();
			});
		});// .item each
	});// doc ready
	
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
// 			gradient.stops.push({color:am4core.color("#253629")})

			axis.renderer.line.stroke = gradient;
			axis.renderer.line.strokeWidth = 15;
			axis.renderer.line.strokeOpacity = 1;

			axis.renderer.grid.template.disabled = true;

			var hand = chartG.hands.push(new am4charts.ClockHand());
			hand.radius = am4core.percent(95);
			hand.showValue(progress);
// 			setInterval(function() {
// 				hand.showValue(Math.random() * 100, 1000, am4core.ease.cubicOut);
// 			}, 2000);
		});// am4core.ready()
	}// chartGaugeStart()
	
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
						value: today,
						width: 1,
						label: {
							text: '오늘',
							rotation: 90
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
									<h4 class="sub-ment">오늘의 목표 달성까지 ${study.plan_chap-study.actual_chap } 챕터 남았어요!</h4>
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
									<h4 class="sub-ment">오늘의 목표 달성까지 ${study.plan_page-study.actual_page } 페이지 남았어요!</h4>
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
		<div class="row" id="todayChartList">
			<div class="col-md-12 col-xs-12">
				<ul id="chartList">
					<li id="labelChartTimeline">타임라인</li>
					<li id="labelChartGauge">진행률</li>
					<li id="labelChartAvg">일일 평균</li>
					<li id="labelChartPerDay">일일 기록</li>
					<li id="labelChartAccum">누적 기록</li>
				</ul>
			</div>
		</div><!-- todayChartList -->
		<div class="row" id="todayCharts">
			<div class="col-md-8 col-md-offset-2 col-xs-12">
				<div id="charts" class="chart-inner">
					<div id="chartCommon">
						study_id: ${study_id }<br>
						제목: ${study.title }<br>
						시작일: ${study.startdate }<br>
						끝일: ${study.enddate }<br>
						완료: ${study.actual_page + study.actual_chap }<br>
						전체: ${study.total_pages + study.total_chap }<br>
					
					</div>
					<div id="chartTimeline"></div>
					<div id="chartGauge"></div>
					<div id="chartAvg"></div>
					<canvas id="chartPerDay"></canvas>
					<canvas id="chartAccum"></canvas>
				</div>
			</div>
		</div><!-- todayCharts -->
	</div>
</div>
<!--**********content end**********-->

<script type="text/javascript">

	//일일 차트 Chart.js
	//요소 상태별 샐깔 달리 줄 수 있는지 시험
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
<%@ include file="../template/footer.jspf" %>
</body>
</html>