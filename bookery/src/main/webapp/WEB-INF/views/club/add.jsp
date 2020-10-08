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

#content{
	resize: none;
}
.btn-write{
	color:white;
	background-color:#8ba989; 
}
.form-btns{
	text-align: center;
}
.form-btns button{
	display: inline-block;
	margin: auto;
}
.jumbotron{
	background-color: white;
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
		<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8">
		<div class="jumbotron">
	
			<form class="form-horizontal" action="${pageContext.request.contextPath }/club/insert" method="post">
				<div class="form-group">
						<input type="text" class="form-control" id="inputPassword3" readonly="readonly"
							value="${book.title }">
				</div>

				<div class="form-group">
						<input type="text" class="form-control content-title" name="title" id="title"
							placeholder="제목을 입력하세요." required="required">
					</div>
				
				<div class="form-group">
						<textarea class="form-control content-main" required="required" rows="15" name="content" id="content" placeholder="내용을 입력하세요."></textarea>
				</div>
				
				<input type="hidden" name="book_bid" value="${book.bid }" />
				<input type="hidden" name="depth" value="0" />

				<div class="form-group form-btns">
						<button type="submit" class="btn btn-default btn-write">글쓰기</button>
						<button type="button" class="btn btn-default" onclick="history.back();">취소</button>
				</div>
			</form>

		</div>
			</div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>