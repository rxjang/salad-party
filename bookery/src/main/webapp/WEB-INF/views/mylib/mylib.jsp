<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	#mylib-info{
		width:90%;
		height:280px;
		background:url('${pageContext.request.contextPath}/resources/imgs/library.jpeg')center/cover;
		margin:0 auto;
		color:white;
	}
	.jumbotron{
		padding:30px 60px;
	}
	.jumbotron a{color:white}
	.jumbotron a:hover{text-decoration:none; color:#ECEBC9}
	.table{
		margin-top:30px;
		font-size:1.3em;
		color:white;
		width:40%
	}
	.table>tbody>tr>td{opacity: 0.8;}
	.table>tbody>tr>td, .table>tbody>tr>th{
		border-top:0px;
		padding:5px 0px;
	}
	#table{border-bottom: 1px rgba(255, 255, 255, .5) solid}
	.mylib-info-ment{margin-top:10px;text-shadow: 2px 2px 2px gray;}
	.mylib-info-ment span{opacity: 0.8;}
	#mylib-contents{width:90%; margin:0 auto;}
	
	
	@media (max-width:1000px) {
		#mylib-info{width:100%; height:250px;}
	}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********--> 
<div class="row">
	<div class="col-xs-12 col-md-12 mylib-main">
		<div class="jumbotron" id="mylib-info">
			<h3>김셀파님의 서재</h3>
			<div id="table">
			<table class="table">
				<tr>
					<td>미독</td>
					<td>미완독</td>
					<td>완독</td>
				</tr>
				<tr>
					<th>0</th>
					<th>0</th>
					<th>0</th>
				</tr>
			</table>
			</div>
			<div class="mylib-info-ment">
				<a href="${pageContext.request.contextPath }/find">
				서재에 책을 추가하러 가볼까요?<br/>
				<span>책 검색하러 가기</span>			
				</a>
			</div><!-- .mylib-info-ment end -->
		</div><!-- .jumbotron end -->
		<div id="mylib-contents">
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		1<br/>
		</div>
	</div>
</div><!-- .row end -->
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
