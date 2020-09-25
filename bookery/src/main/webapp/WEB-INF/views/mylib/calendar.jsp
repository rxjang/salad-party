<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********--> 
<div class="row">
	<div class="col-xs-12 col-md-12">
	<h2>스터디캘린더</h2>
	<div>
		<div>
			<h3>${v_study.nickname }님</h3>
			calendar api
		</div>
	</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
