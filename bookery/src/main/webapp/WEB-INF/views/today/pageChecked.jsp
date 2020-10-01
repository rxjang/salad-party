<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>

<script type="text/javascript">
	var success = "${v_study.success_rate}";
	$(function() {
		//목표치
		if (success > 100) { //초과달성

			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/goodjob.png"/>';
			$('#result').append($(image));
			$('.caption h3').text('계획을 완벽하게 수행중인 당신!');
			$('.caption h4').text('혹시 ISTJ 성향이 아니신가요?!');
		} else if (success == 100) { //달성

			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/goodjob.png"/>';
			$('#result').append($(image));
			$('.caption h3').text('계획을 완벽하게 수행중인 당신!');
			$('.caption h4').text('혹시 ISTJ 성향이 아니신가요?!');
		} else if (success < 100) { //미달성

			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/crying.png"/>';
			$('#result').append($(image));
			$('.caption h3').text('우리 아직 갈길이 머네요...');
			$('.caption h4').text('내일은 더 열심히 달려보자구요!');
		}//if

		setTimeout(
				function() {
					location.href = "${pageContext.request.contextPath}/today/page/${v_study.study_id}"
				}, 3000);
	});//ready
</script>
<style type="text/css">
.jumbotron{
	background-color: white;
	text-align: center;
	font-size: 10em;
}
.caption h3,h4{
	text-shadow:#49654d 1px 1px 2px;
	color:#8ba989;
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
			</div><!-- jumbotron -->
			
		</div>
	</div><!-- row  -->
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>