<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	
	$(function() {
		
		var content = $('textarea').val().replace(/(<br\/>)/g, '');
		console.log(content);
		$('textarea').val(content);
	});//ready
</script>
<style type="text/css">

#content{
	resize: none;
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
			<form class="form-horizontal" action="${pageContext.request.contextPath }/club/update" method="post">
			<input type="hidden" name="_method" value="PUT"/>
				<div class="form-group">
					<label for="inputPassword3" class="col-sm-2 control-label">책</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="inputPassword3" readonly="readonly"
							value="${book.title }">
					</div>
				</div>

				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="title" id="title"
							value="${club.title }">
					</div>
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="6" name="content" id="content" >${club.content }</textarea>
					</div>
				</div>
				
				<input type="hidden" name="book_bid" value="${book.bid }" />
				<input type="hidden" name="depth" value="0" />
				<input type="hidden" name="id" value="${club.id }" />

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">수정하기</button>
					</div>
				</div>
			</form>

		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>