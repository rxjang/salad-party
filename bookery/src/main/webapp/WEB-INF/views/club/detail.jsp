<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	$(function() {
	});//ready
</script>
<style type="text/css">
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


				<table class="table">

					<tr>
						<th>제목</th>
						<th>${club.title }</th>
					</tr>

					<tr>
						<td>작성자</td>
						<td>${club.user_id }</td>
					</tr>
					<tr>
						<td>작성시간</td>
						<td>${club.updatetime }</td>
					</tr>

					<tr>
						<td>내용</td>
						<td>${club.content}</td>
					</tr>

				</table>


			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>