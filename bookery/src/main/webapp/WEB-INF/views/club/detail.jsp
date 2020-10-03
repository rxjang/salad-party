<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
var date = "${club.updatetime}";


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
/* 오늘 날짜면 시간으로 변환  */
	function todayToTime(date){
		var today = getRecentDate();
		var update =date.substring(0,10);
		var updatetime;
		if(today == update){
			updatetime = new Date(date).format('a/p hh:mm');
		}else{
			updatetime = new Date(date).format('yyyy-MM-dd');
		}
	return updatetime;
	}


	$(function() {
		console.log(date);
		console.log(new Date().format('HH:mm:ss'));
		console.log(new Date('${club.updatetime}').format('HH:mm:ss'));
		$('.updatetime').text(todayToTime(date));
		
		
	});//ready
</script>
<style type="text/css">

.jumbotron{
	background-color: white;
}
.div-btn{
	margin-bottom:20px;
}
</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row">
		<div class="col-md-2">&nbsp;</div>
		<div class="col-md-8 col-xs-12">
			<h3>
				<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
				북클럽
			</h3>
			<br /><small>같은 책을 읽는 사람들과 소통할 수 있어요!</small>
		</div>

		<div class="bottom-line col-xs-12 col-md-12"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6 side-line">

			<div class="jumbotron">


				<div class="panel panel-default pannel-post">
					<div class="panel-body">
						<span class="lead">${club.title }</span>
					</div>
					<div class="panel-body">
						<span class="user_id">${club.user_id }</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="updatetime"></span>
					</div>
					<div class="bottom-line"></div>
					<div class="panel-body post-content">${club.content}</div>
				</div>
				
				<div class="div-btn">
				<button class="btn btn-default">댓글달기</button>
				<button class="btn btn-default">수정</button>
				<button class="btn btn-default">삭제</button>
				</div>
				
				
				<div class="panel panel-default pannel-reply">
					<div class="panel-body">reply</div>
					<div class="panel-body">contnt</div>
				</div>
				<div class="panel panel-default pannel-reply">
					<div class="panel-body">reply</div>
					<div class="panel-body">contnt</div>
				</div>
				<div class="panel panel-default pannel-reply">
					<div class="panel-body">reply</div>
					<div class="panel-body">contnt</div>
				</div>



			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>