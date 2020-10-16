<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<!-- <link rel="stylesheet" href="https://cdn.rawgit.com/InventPartners/Checkbox2Button/master/css/checkbox2button.css" /> 
<script src="https://cdn.rawgit.com/InventPartners/Checkbox2Button/master/js/checkbox2button.min.js"></script> -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/checkbox2button.css" />
<script src="${pageContext.request.contextPath }/resources/js/checkbox2button.min.js"></script>
<script type="text/javascript">
	var Dday;
	var deadLine = "${v_study.enddate}";
	var doughnut_chart = "${v_study.progress_rate}";
	var study_id = "${v_study.study_id}";
	var total_chap = "${v_study.total_chap}";
	var total_actual_chap = "${v_study.actual_chap}";
	var actual_chap = "${today_actual_chap}";
	var plan_chap = "${today_plan_chap}";
	var coverurl = "${v_study.coverurl}"
	var title = "${v_study.title}";

	console.log(total_chap);
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
	function chapPicker(){
		$("#select_chap").css("display", "block");
		var thisTarget = $(".enable_chap").first().offset();		
		$('html, body').animate({scrollTop : thisTarget.top-70}, 400);
	}//chapPicker
	//오늘 공부한 챕터 - 어제까지 actualtime == null인 구간

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
		if(dateDiff < 0)
			$('#owl-dday').text('D+'+ (-Dday));
		else 
			$('#owl-dday').text('D-'+ Dday);
		console.log(dateDiff);
		$('.thumbnail').css({'box-shadow':'12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4)','display':'block','margin':'auto'});
		//box-shadow:rgb(37, 54, 41) 5px 5px 10px;
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
			loop : false,
			autoplay : false,
			dots:false,
			margin : 5,
			merge : false,
			nav : false,
			responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
			}
		});//owl캐러셀
		$('.enable_chap').each(function(){
			$(this).css({'hover':'none'});
		});
		$('.disable_chap').each(function(){
		      $(this).css({'pointer-events':'none','cursor':'default'});
		      $(this).find('a').addClass('btn-checkbox-checked').addClass('already');
		      $(this).find('a').children().eq(0).addClass('glyphicon-check').removeClass('glyphicon-unchecked');
		});
		/**
		 *	페이지 입력 버튼 누르면 페이지 선택할 수 있는 alert가 나타난다.
		 */
	 $('#input_chap').click(function(){
		 chapPicker();//total 챕터를 swal에 출력함
		 $(this).css('display', 'none');
		 $('#enter_chap').css('display', 'block');
		 $('.disable_chap').parent().css('color','lightgray');
	});//chap btn
	
	/* $(".enable_chap").each(function(idx,ele){
		$(ele).change(function(e){
			if($(this).prop('checked') == true) {
				if(idx != 0) {
		
					if($(this).parent().prev().prev().find('input').prop('checked') == false) {
						swal('선택 오류', '연속적인 챕터만 입력할 수 있습니다.', 'error');
						$(this).prop("checked", false);
					} 
				}
			}//if
			else if($(this).prop('checked') == false) {
				console.log($(this).parent().next().next().find('input').prop('checked'));
				if($(this).parent().next().next().find('input').prop('checked') == true) {
					swal('선택 오류', '연속적인 챕터만 입력할 수 있습니다.', 'error');
					$(this).prop("checked", true);
				} else {
					console.log('checked false');
				}
			}//else
	    });//change
	});//each */
	  $(".enable_chap").each(function(){
		$(this).find('a').on('mouseenter', function(){
			var color = $(this).css('color');
			var bgcolor = $(this).css('background-color');
			
			$(this).css('background-color', bgcolor).css('color', color).css('font-weight', 'bold').css('border', '1px solid #c0cfb2');
	    });//mouseenter
	    $(this).find('a').on('click', function(){
	    	var chkSelect = $(this).attr('class');
	    	var checked = 'btn-checkbox-checked';
	    	if(chkSelect.search(checked) <= 0) {
				$(this).css('background-color', '#8ba989').css('color', 'white').css('font-weight', 'normal');
			}//if
			else{
				$(this).css('background-color', 'white').css('color', 'black').css('font-weight', 'normal');
			}
	    });
	    $(this).find('a').on('mouseout', function(){
			var chkSelect = $(this).attr('class');
	    	var checked = 'btn-checkbox-checked';
	    	if(chkSelect.search(checked) > 0) {
				$(this).css('background-color', '#8ba989').css('color', 'white').css('font-weight', 'normal');
			}//if
			else{
				$(this).css('background-color', 'white').css('color', 'black').css('font-weight', 'normal');
			}
	    });//mouseout
	});//each 
	
	$('#enter_chap').click(function(e){
		var cnt = 0;
		var params = new Array();
		$(".enable_chap input").each(function(idx,ele){
			if($(this).val() != '' && $(this).val() != null){
				cnt++;
				console.log($(this).val());
				params.push($(this).val());
			}
		});
		if(cnt <= 0){
			swal('경고', '선택된 챕터가 없습니다.\n 완료한 챕터를 선택해주세요.', 'warning');
			return false;
		} else{
			swal({
				  title: "확인",
				  text: "선택하신 챕터들을 완료 처리 하시겠습니까?",
				  icon: "info",
				  buttons: {
					cancel: "아니오", //취소버튼 false
				    confirm:{
				    	text:"예",
				    	value:true
				    }
				  },
			}).then((value) => {	//value가 true이면 내서재로 이동한다.
				
				if(value){
					$.ajax({
						url:'${pageContext.request.contextPath}/today/chap/process/${v_study.study_id}/',
						method:'get',
						data: 'chaps='+params,
						success:function(){
							location.href='${pageContext.request.contextPath}/today/chap/check/${v_study.study_id}';
						}//success
					});//ajax
				}//if
			});//swal
			return false;
		}
	});//enter_chap click
	 
	$('.progress1').css('background-color','#ecece9');
	$('.progress-bar1').each(function() {
		$(this).css('height','250px');
		  var min = $(this).attr('aria-valuemin');
		  var max = $(this).attr('aria-valuemax');
		  var now = $(this).attr('aria-valuenow');
		  if(now=='0') {now =1;}
		  //console.log(now);
		  /* var siz = (now-min)*100/(max-min); */
		  var siz = total_actual_chap / total_chap * 100;
		  
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
	font-size:1.1em;
	line-height: 35px;
	background-color: #c0cfb2;
	color:#555;
	font-weight:bold;
}
.bar-text{
	line-height: 35px;
	font-size: 1.1em;
	font-weight:bold;
	color:#555;	
}
#select_chap{
	display: none;
}
.disable_chap{
	color: #555;
}
#enter_chap{
	display: none;
}
.btn-checkbox-checked{
	background-color: #8ba989;
	color: white;
}
.already{
	background-color: #e4e6da;
	color: #c0cb2;
}
#select_chap a{
	width: 100%;
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
				<div class="progress-bar progress-bar1" role="progressbar" aria-valuenow="${v_study.actual_chap }"
					aria-valuemin="1" aria-valuemax="${v_study.total_chap }" >
					${v_study.actual_chap }챕터</div>
			</div>
			
			<!-- actual이랑 plan을 비교해서 큰거를 max값으로 둔다. actual이 클때는 배경색을 눈에띄게할것. -->
	<script type="text/javascript">
	$(function(){
		$('.progress2').css('background-color', '#ecece9');
		$('.progress-bar2').each(function() {
			  var min = $(this).attr('aria-valuemin');
			  var now;
			  var max; 
			  if(Number(actual_chap)>Number(plan_chap)){
				  now = $(this).attr('aria-valuenow', plan_chap);
				  max = $(this).attr('aria-valuemax', actual_chap);
				  $('.bar-text').text('+ '+(actual_chap - plan_chap)+'챕터');				 
			  		$('.progress2').css('background-color', '#ffc979');
					$(this).text('Plan:' + plan_chap);
			  }else if(Number(actual_chap) < Number(plan_chap)){
				  now = $(this).attr('aria-valuenow', actual_chap);
				  max = $(this).attr('aria-valuemax', plan_chap);
					$('.bar-text').text('- '+(plan_chap - actual_chap)+'챕터').css({'color':'#555','font-weight':'bold','font-size':'1.1em'});
					$(this).text(actual_chap + ' 챕터');
			  }else if(Number(actual_chap) == Number(plan_chap)){
				  now = $(this).attr('aria-valuenow', actual_chap);
				  max = $(this).attr('aria-valuemax', plan_chap);
				  	$('.bar-text').text('');
   				  	$(this).text(actual_chap+'챕터');
			  }
			  now = $(this).attr('aria-valuenow');
			  max = $(this).attr('aria-valuemax');
			 /*  var siz = (now-min)*100/(max-min); */
			  var siz = (plan_chap / actual_chap * 100);
			  $(this).css('width', siz+'%');
			});
	});
	</script>
	
			<div><span class="label label-default">Today</span></div>	
			<div class="progress progress2"><span class="bar-text">Actual ${actual_chap }챕터</span>
				<div class="progress-bar progress-bar2" role="progressbar" aria-valuenow=""
					aria-valuemin="1" aria-valuemax="" >
					</div>
			</div>
			
			<div id="select_chap">
				<c:forEach items="${listChap }" var="listChap">
					<div class="checkbox checkbox2button <c:if test='${listChap.actualtime eq null }'>enable_chap</c:if> <c:if test='${listChap.actualtime ne null}'>disable_chap</c:if>">
						<label><input type='checkbox' name='selectChap' value='${listChap.id}' />${listChap.toc}</label>
					</div>
				</c:forEach>
			</div>
			<button id="input_chap" class="btn btn-default btn-block">챕터 입력</button>
			<button id="enter_chap" class="btn btn-default btn-block">챕터 입력</button>
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
									<p><small>완료일</small></p>	
									<p><span class="caro-cnt" id="owl-dday"></span></p>	
									<p><small>&nbsp;</small></p>	
								</div><!-- D day -->
								<div class="owl-item">
									<p><small>오늘의 진도</small></p>	
									<p><span class="caro-cnt">${today_plan_chap }</span></p>	
									<p><small>챕터</small></p>	
								</div><!-- plan -->
								<div class="owl-item" id="owl-chapRate">
									<p><small>현황</small></p>	
									<p><span class="caro-cnt" >${v_study.actual_chap}/${v_study.plan_chap}</span></p>	
									<p><small>챕터</small></p>
								</div>
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