<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
var date = "${club.updatetime }";



	$(function() {
		console.log(date);
		console.log(new Date().format('HH:mm:ss'));
		console.log(new Date('${club.updatetime}').format('HH:mm:ss'));
		
		
		
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
						<span class="user_id">${club.user_id }</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span
							class="updatetime">${club.updatetime }</span>
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