<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	var doughnut_chart = "${v_study.progress_rate}";
	var study_id = "${v_study.study_id}";
	var total_pages = "${v_study.total_pages}";
	var actual_page = "${v_study.actual_page}";
	var plan_page = "${v_study.plan_page}";

	var page_data = new Array(); //pagePicker에 전달할 데이터목록. data를 배열로받음
	var cnt = actual_page; //917
	for (var i = 0; i <= total_pages-actual_page; i++){
		page_data[i]= cnt;
		cnt++;
	}//for
			
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
		
	function todayPage(page){ //페이지 입력 받아서 컨트롤러에 전달
		location.href='${pageContext.request.contextPath}/today/page/check/${book.bid}';
		$.ajax({
			url:'${pageContext.request.contextPath}/today/page/check/${v_study.study_id}/'+page,
			method:'get',
			success:function(data){
				console.log('success');
			}//success
		});//ajax
	}//today_page
	
	/**
	 * document Ready
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


		$('#book_thumbnail img').css({'box-shadow':'rgb(135, 165, 134) 5px 5px 10px','display':'block','margin':'auto'});
		
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
		
		
		/* 
		$(this).addClass("class_name");
		$(this).removeClass("class_name");
		
		*/
/* 		$('#page_form').on('submit',function(){
			var success_icon =$('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span> ');
			//$('#page_form input').insertAfter(success_icon);
			success_icon.insertAfter($('#page_form input'));
			$('#page_form div').addClass('has-success');
			location.reload();
			$.ajax({
				type:'get',
				url:'${pageContext.request.contextPath}/today/page/check/${v_study.study_id}',
				data:'page='+$('#inputSuccess4').val()+'&date='+currentTime,
				success:function(data){
					
					location.href='${pageContext.request.contextPath}/today/page/check?bid=${book.bid}';
						console.log('${pageContext.request.contextPath}/today/page/check?bid=${book.bid}');
				},
				error:function(){
					swal('error');
				}
				//페이지를 받아서 checkpage 테이블에 입력한다.
				//study_id필요. update checkpage set actualpage = {입력값} where study_id =  {v_study_id.study_id} 
				//and date = {오늘날짜} and deleted = 0
				//success >> 결과화면 보여주기.
			});//ajax
			
			
			return false;	//submit 방지
		});//submit */
		
		
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
	
	});//ready

</script>

<style type="text/css">
.media,.owl-item{
	text-align: center;
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
							<div class="owl-item" id="owl-pageRate">
								<p><small>페이지</small></p>	
								<p><span class="caro-cnt" >${v_study.actual_page}/${v_study.total_pages}</span></p>	
								<p><small>&nbsp;</small></p>
							</div><!--내가 공부한 페이지/총페이지 -->
							<div class="owl-item" id="owl-pageRate">
								<small id="chart-progress"></small>	
		 							<canvas id="chartjs-4" style="margin:auto;height:80px;width:80px;">
		 							</canvas> 
							</div><!--내가 공부한 페이지/총페이지 ${v_study.progress_rate} -->
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
		<p class="lead">${v_study.actual_page }페이지까지 읽었습니다.</p>
		<p class="lead">${v_study.success_rate }%</p>
		<p class="lead">오늘의 목표&nbsp;<strong>${v_study.plan_page }</strong>페이지</p>
<%-- 
		<form action="#" id="page_form" class="form-inline">
			<div class="form-group has-feedback input-group">
			<!--  <label class="control-label" for="inputSuccess4">페이지</label> -->
			  <span class="input-group-addon">page</span>
				<input type="text" class="form-control" id="inputSuccess4" 
				placeholder="${v_study.actual_page } / ${v_study.plan_page }" aria-describedby="inputSuccess4Status"> 
				<!-- 	<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"> -->
					<span id="inputSuccess4Status" class="sr-only">(success)</span>
				
			
			</div>
		</form>
 --%>
		</div>
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-12">

		<button id="input_page" class="btn btn-default">페이지 입력</button>


			<div class="output"></div><!-- test -->
		</div>
			
	</div>
	

	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>

	<script type="text/javascript">
					new Chart(document.getElementById("chartjs-4"), {
						type : "doughnut",
						data : {
							//"labels" : [ "읽은 페이지", "남은 페이지" ],
							datasets : [ {
							//"label" : "My First Dataset",
							data : [ ${v_study.actual_page }, (${v_study.total_pages }-${v_study.actual_page}) ],
								"backgroundColor" : [ "rgb(73, 101, 77)","rgb(192, 207, 178)" ]
							} ]//dataset
						},//data
					options: {
							maintainAspectRatio: false,
							responsive: false,
							tooltips: {
				                   enabled: false
							 },
							scales: {
								
								yAxes: [{
									ticks:{
										fontSize : 0
									},
									gridLines:{  display:false
										//drawOnChartArea: false,
										//lineWidth: 0
									}
								}],
								xAxes:[{
									ticks:{
										fontSize : 0
									},
									gridLines:{  display:false
										//drawOnChartArea: false,
										//lineWidth: 0
										}
								}]
							}
					}//option
					});//chart js
				
					
			</script>
</body>
</html>
