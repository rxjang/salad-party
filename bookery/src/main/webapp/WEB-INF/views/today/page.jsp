<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	var Dday;
	var deadLine = "${v_study.enddate}";
	var doughnut_chart = "${v_study.progress_rate}";
	var study_id = "${v_study.study_id}";
	var total_pages = "${v_study.total_pages}";
	var actual_page = "${v_study.actual_page}";
	var plan_page = "${v_study.plan_page}";
	var plan_page_interval = "${plan_interval}"; //오늘 날짜의 actual_page 값이 필요함.
	var recent_actual_page="${recent_actual_page}";
	var today_actual_page="${today_actual_page}";
	var coverurl = "${v_study.coverurl}"
	var title = "${v_study.title}"
	var cnt = actual_page; //917
	//혹시 쓸까봐 일단 전부 선언해둠. 
	
	
	var page_data = new Array(); //pagePicker에 전달할 데이터목록. data를 배열로받음
	
	for (var i = 0; i <= total_pages-actual_page; i++){
		if(cnt=='0'){cnt = 1;}
		page_data[i]= cnt;
		cnt++;
	}//for
			
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
	function pagePicker(){
		$("#page_picker").picker({
				  data: page_data, //array type
				  lineHeight: 30,
				  selected: 0,
				},function (s) {
				  $('.output').html(s) //값 전달
				  $("#page_picker").data("value", s);
				})
	}//pagePicker
	//오늘 공부한 페이지 - 어제까지 actualpage / plan페이지 구간 = 오늘 퍼센트	
	function todayPage(page){ //페이지 입력 받아서 컨트롤러에 전달
		$.ajax({
			url:'${pageContext.request.contextPath}/today/page/check/${v_study.study_id}/'+page,
			method:'get',
			success:function(){
				location.href='${pageContext.request.contextPath}/today/page/check/${v_study.study_id}';
			}//success
		});//ajax
	}//today_page
	
	
	/**
	 * 	document Ready
	 */
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
		$('.thumbnail').css({'box-shadow':'rgb(135, 165, 134) 5px 5px 10px','display':'block','margin':'auto'});
		
		/**********************    캐러셀    **********************/
		var owlyear = deadLine.substring(0,4)+'년';
		var owlmonth = deadLine.substring(5,7)+'월';
		var owlday = deadLine.substring(8,10)+'일';
		$('#owl-year').text(owlyear);
		$('#owl-monthday').text(owlmonth+owlday);
		$('#chart-progress').text(doughnut_chart.substring(0,doughnut_chart.indexOf('.')+2)+'%');
		
		$('.caro-cnt').css({'font-size':'110%','font-weight':'500'});
		$('.owl-item').css('text-align','center');
		$('.owl-item small').css('color','#8f8f8f');
		
		$('.owl-stage-outer').owlCarousel({
			items:4,
			loop : true,
			autoplay : false,
			dots:false,
			margin : 5,
			merge : false,
			nav : false,
			responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
			}
		});//owl캐러셀

		/**
		 *	페이지 입력 버튼 누르면 페이지 선택할 수 있는 alert가 나타난다.
		 */
	$('#input_page').click(function(){
			swal({
				  text: "오늘 공부한 페이지를 입력해주세요",
				  buttons: {
					cancel: "취소", //취소버튼 false
				    confirm:{
				    	text:"입력",
				    	value:true
				    }
				  },
				  content:{
						element:"div",
						attributes:{
							id:"page_picker" //id값으로 pagePicker가 div를 인식함
						}
				  }
			}).then((value) => {	//swal 버튼을 누른 다음 수행된다.
				if(value){
			//		console.log(page_data[$('.output').text()]);//선택한 페이지
					var page_selected = page_data[$('.output').text()]
					todayPage(page_selected);//선택한 페이지를 DB에 보낸다.
				}//if
			});//swal
			pagePicker();//total 페이지를 swal에 출력함
	});//page btn
	
	
	
	
	
	/**
	 * ---------------------------------------
	 * This demo was created using amCharts 4.
	 * 
	 * For more information visit:
	 * https://www.amcharts.com/
	 * 
	 * Documentation is available at:
	 * https://www.amcharts.com/docs/v4/
	 * ---------------------------------------
	 */
	$('.progress1').css('background-color','#ecece9');
	$('.progress-bar1').each(function() {
		$(this).css('height','250px');
		  var min = $(this).attr('aria-valuemin');
		  var max = $(this).attr('aria-valuemax');
		  var now = $(this).attr('aria-valuenow');
		  if(now=='0') {now =1;}
		  //console.log(now);
		  var siz = (now-min)*100/(max-min);
		  
		  //93600 / 1199
		  $(this).css('width', siz+'%');
		  $(this).text(Math.floor(siz)+'%');
		});
	});//ready
	
</script>

<style type="text/css">
.media,.owl-item{
	text-align: center;
}
.output{
	display: none;
}
.progress{
	height: 35px;
	text-align: center;
}
.progress-bar{
	font-size:110%;
	line-height: 35px;
	background-color: #c0cfb2;
}
.bar-text{
	line-height: 35px;
	font-size: 12px;
	color:#fff;	
}

</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row"><br/></div>

	<div class="row">
		<div class="col-md-3"></div>
			<div id="book_thumbnail" class="col-xs-12 col-md-6">
				<a href="#">
					<img class="thumbnail" src="${v_study.coverurl }" alt="..."/>
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
					<h4 class="media-heading">${v_study.title }<br/> </h4>
						<p><small>${v_study.memo }</small></p>
				</div>
			</div>
			<div><span class="label label-default">Overall</span></div>	
			<div class="progress">
				<div class="progress-bar progress-bar1" role="progressbar" aria-valuenow="${v_study.actual_page }"
					aria-valuemin="1" aria-valuemax="${v_study.pages }" >
					${v_study.actual_page }p</div>
			</div>
			
			<!-- actual이랑 plan을 비교해서 큰거를 max값으로 둔다. actual이 클때는 배경색을 눈에띄게할것. -->
	<script type="text/javascript">
	$(function(){
		$('.progress2').css('background-color', '#ecece9');
		$('.progress-bar2').each(function() {
			  var min = $(this).attr('aria-valuemin');
			  var now;
			  var max; 
			  if(Number(actual_page)>Number(plan_page)){
				  now = $(this).attr('aria-valuenow',plan_page);
				  max = $(this).attr('aria-valuemax',actual_page);
				  $('.bar-text').text('+ '+(actual_page-plan_page)+'p');				 
			  		$('.progress2').css('background-color', '#ffabaa');
					$(this).text('Plan:'+plan_page+'p');
			  }else if(Number(actual_page)<Number(plan_page)){
				  now = $(this).attr('aria-valuenow',actual_page);
				  max = $(this).attr('aria-valuemax',plan_page);
					$('.bar-text').text('- '+(plan_page-actual_page)+'p').css('color','#ffabaa');
					$(this).text(actual_page+'p');
			  }else if(Number(actual_page)==Number(plan_page)){
				  now = $(this).attr('aria-valuenow',actual_page);
				  max = $(this).attr('aria-valuemax',plan_page);
				  	$('.bar-text').text('');
   				  	$(this).text(actual_page+'p');
			  }
			  now = $(this).attr('aria-valuenow');
			  max = $(this).attr('aria-valuemax');
			  var siz = (now-min)*100/(max-min);
			  $(this).css('width', siz+'%');
			});
	});
	</script>
	
			<div><span class="label label-default">Today</span></div>	
			<div class="progress progress2"><span class="bar-text">Actual ${v_study.actual_page }p</span>
				<div class="progress-bar progress-bar2" role="progressbar" aria-valuenow=""
					aria-valuemin="1" aria-valuemax="" >
					</div>
			</div>
			
			
			<button id="input_page" class="btn btn-default btn-block">페이지 입력</button>
				<div class="output"></div>

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
								<div class="owl-item">
									<p><small>오늘의 진도</small></p>	
									<p><span class="caro-cnt">${v_study.plan_page }</span></p>	
									<p><small>페이지</small></p>	
								</div><!-- plan -->
								<div class="owl-item" id="owl-pageRate">
									<p><small>현황</small></p>	
									<p><span class="caro-cnt" >${v_study.actual_page}/${v_study.pages}</span></p>	
									<p><small>페이지</small></p>
								</div><!--내가 공부한 페이지/총페이지 -->
								<!-- <div class="owl-item" id="owl-pageRate">
									<small id="chart-progress"></small>	
			 							<canvas id="chartjs-4" style="margin:auto;height:80px;width:80px;">
			 							</canvas> 
								</div>내가 공부한 페이지/총페이지 ${v_study.progress_rate}
								</div> -->
							</div>
						</div>
		
				</div>
			</div>
			<div class="col-md-3"></div>
			<!-- <div class="col-xs-12 col-md-12 bottom-line"></div> -->

	</div>


		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-xs-12 col-md-6">
				
				<!-- test -->
			</div>

			<div class="col-md-3"></div>

		</div>


	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>