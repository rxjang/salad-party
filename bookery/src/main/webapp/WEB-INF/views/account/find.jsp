<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Bookery</title>
	<%@ include file="../template/head.jspf" %>
	<style type="text/css">
	.find{
		display: flex;
		margin: 0px auto;
		width: 300px;
		height:100%;
		text-align: center;
		overflow: hidden;
		margin-top: 50px;
	}
	h1{
		font-size: 30px;
		margin-bottom: 20px;
	}
	.defaultFind{
		width: 240px;
		height: 50px;
		border: none;
		background: linear-gradient(to right, rgb(19, 78, 94), rgb(113, 178, 128));
		color: rgb(193, 207, 178);
		font-size: 16px;
		border-radius: 50px;
		margin-top: 5px;
	}
	.defaultFind:hover{
		border: solid 1px #e4e4e4;
		color: white;
	}
	#findpw{
		margin-top: 20px;
	}
	</style>
	</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start********** -->.
<div class="find">
	<div class="col-xs-12 col-md-12">
			<!-- <h1><img src="" alt="Bookery" class="logo"></h1> -->
			<h1>아이디 비밀번호 찾기</h1>
			<button type="button" class="btn btn-default defaultFind" id="findid" onclick="location.href='${pageContext.request.contextPath}/account/findid'">가입한 이메일 찾기</button>
			<button type="button" class="btn btn-default defaultFind" id="findpw" onclick="location.href='${pageContext.request.contextPath}/account/findpw'">비밀번호 찾기</button>
	</div>
</div>
<!-- **********content end********** --> 
<%@ include file="../template/footer.jspf" %>
</body>
</html>