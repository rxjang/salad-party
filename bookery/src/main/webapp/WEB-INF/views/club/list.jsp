<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	$(function() {
		var url_here = window.location.href;
	//	http://localhost:8085/bookery/club/list/16687560
		var bid = url_here.substring(url_here.lastIndexOf('/')+1);
		$('#add').attr('href','${pageContext.request.contextPath }/club/add/'+bid);
		
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

			<a href="#" id="add"class="btn btn-default" role="button">글쓰기</a>
			<table class="table">
				<tr>
					<th>id</th>
					<th>title</th>
					<th>updatetime</th>
					<th>user_id</th>
				</tr>
				<tbody>
					<c:forEach items="${list }" var="bean">
						<tr>
							<td>${bean.id }</td>
							<td><a href="${pageContext.request.contextPath }/club/detail/${bean.id}">${bean.title }</a></td>
							<td>${bean.updatetime }</td>
							<td>${bean.user_id }</td>
						</tr>

					</c:forEach>

				</tbody>
			</table>
		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>