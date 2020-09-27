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
.side-line {
	border-left: 1px solid #e4e4e4;
	border-right: 1px solid #e4e4e4;
}

.search-form {
	margin-bottom: 15px;
}

.input-search { /* 검색form안의 div */
	height: 30px;
	border-radius: 25px;
	border-bottom: 1px solid #e4e4e4;
	box-shadow: #e4e4e4 0px 0px 5px;
	width: 100%;
}

#search { /* 검색 input */
	display: block;
	width: 100%;
	padding: 6px 12px;
	font-size: 14px;
	border: 0px;
	border-radius: 25px;
}

#search-btn { /* 검색버튼 */
	border: 0px;
	width: 90%;
	border-radius: 25px;
}

#search-btn:hover {
	background-color: white;
}

#input_group_btn {
	width: 30px;
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
				<span class="glyphicon glyphicon-book" aria-hidden="true"></span>
				북클럽
			</h3>
		</div>

		<div class="bottom-line col-xs-12 col-md-12"></div>
	</div>
	<div class="row">
		<!--************ search **********-->
		<div class="col-md-3">&nbsp;</div>
		<div class="col-xs-12 col-md-6">
			<form action="#" class="search-form form-inline">
				<div class="input-search input-group">
					<input type="text" class="" placeholder="게시판검색." name="search"
						id="search" /> <span class="input-group-btn" id="input_group_btn">
						<button type="submit" id="search-btn"
							class="btn btn-default btn-md">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</span>
				</div>
			</form>
		</div>
		<div class="col-md-3"></div>
		<div class="bottom-line col-xs-12 col-md-12"></div>

	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6">
			<!--**********post start**********-->
			<c:forEach begin="1" end="11">
				<div class="col-xs-12 col-md-6">
					<div class="thumbnail">
						<img
							src="https://bookthumb-phinf.pstatic.net/cover/158/734/15873485.jpg?type=m140&udate=20200822"
							alt="...">
						<div class="caption">
							<h3>책별 게시판 어떻게만들까</h3>
							<p>묻고 답하기</p>
						</div>
					</div>
				</div>

			</c:forEach>

			<!--**********post end**********-->
		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>