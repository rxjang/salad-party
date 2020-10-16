<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>

<script type="text/javascript">
	var success = "${v_study.success_rate}";

	var over=[['쾌속 질주 중이시네요.','내일도 이기세로 힘내요!⌒(*＾-゜)v','010-happy'],['미친집중력!!!','오늘 폭풍공부하셨네요.d=(￣▽￣*)b','034-laugh'],
				['무슨소리 안들리세요?','머리에 지식쌓이는 소리φ(゜▽゜*)♪.','024-in love']]
	var archive=[['계획을 완벽하게 수행중인 당신!','혹시 ISTJ 성향이 아니신가요?!','028-wink'],['열공하는 멋진 당신!','북커리가 응원합니다.','015-smile']
				,['보람찬 하루~','목표를 달성하셨어요!','048-tongue']]
	var under=[['우리아직 갈길이 머네요...','내일은 더 열심히 달려보자구요!','026-sad'],['오늘 이대로 끝낼건가요?','내일로 미루실껀가요（；´д｀）ゞ','039-ill']
				,['시작이 반이에요!','목표는 채우고 주무실거죠?!','035-shock']]
	
	var generateRandom = function (min, max) {
		  var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
		  return ranNum;
		}
	
	
	$(function() {
		//목표치
		
		var index = generateRandom(0,2);
		
		if (success > 100) { //초과달성
			$('.caption h3').text(over[index][0]);
			$('.caption h4').text(over[index][1]);
			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/emoji/'+over[index][2]+'.png"/>';
			$('#result').prepend($(image));
		} else if (success == 100) { //달성
			$('.caption h3').text(archive[index][0]);
			$('.caption h4').text(archive[index][1]);
			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/emoji/'+archive[index][2]+'.png"/>';
			$('#result').prepend($(image));
		} else if (success < 100) { //미달성
			$('.caption h3').text(under[index][0]);
			$('.caption h4').text(under[index][1]);
			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/emoji/'+under[index][2]+'.png"/>';
			$('#result').prepend($(image));
		}//if

		setTimeout(
				function() {
					location.href = "${pageContext.request.contextPath}/today/page/${v_study.study_id}"
				}, 3000);
 

	var cnt = 2;
		setInterval(function() {
			if (cnt < 0){
				$('.time-Sec').text(0);
			}else{
				$('.time-Sec').text(cnt);
			}
			cnt--;
		}, 1000);

	});//ready
</script>
<style type="text/css">

.jumbotron{
	background-color: white;
	text-align: center;
}
.thumbnail{
	border: 0px;
}
.caption h3,h4{
	font-size: 1.6em;
/* 	text-shadow:#49654d 1px 1px 2px; */
	color:#253629;
}
.caption h3{
	font-weight:800;
	font-size: 1.8em;
}
#result img{
	margin-top:30px;
	margin-bottom:30px;
	width:60%;
}
</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6">

			<div class="jumbotron">
				<div id="result" class="thumbnail">
					
					<div class="caption">
						<h3></h3>
						<h4></h4>
						
					</div>
				</div>
				<em class="info"><span class="time-Sec">3</span>초 후 이전 페이지로 이동합니다...</em>
			</div><!-- jumbotron -->
			
		</div>
	</div><!-- row  -->
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>