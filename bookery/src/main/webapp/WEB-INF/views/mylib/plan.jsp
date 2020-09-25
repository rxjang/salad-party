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
	<h2>목표설정</h2>
	<div>
		<div>
		  <h3>${v_study.nickname }님</h3>
			<img class="meta-object" src="${v_study.coverurl }" />
			
			${v_study.study_id}<br>
			${v_study.title}의 스터디를 시작하려 하시네요.<br>
			<h4>본격적인 목표설정에 앞서 어떤 방식으로 목표설정을원하는지 선택해 주세요.</h4>
		</div>
			
		<div class="row">
		  <div class="col-md-2"></div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail">
		      <img src="${pageContext.request.contextPath }/resources/imgs/chap.jpg" alt="chapter">
		      <div class="caption">
		        <h3>챕터 중심</h3>
		        <p>하루에 끝내길 원하는 챕터의 수를 중심으로 목표를 수립하는 방식</p>
		        <form method="post" action="${pageContext.request.contextPath }/mylib/plan/edit/${v_study.study_id}">
		        	<input type="hidden" name="_method" value="put" />
			        <button type="submit" class="btn btn-primary btn-block">챕터 중심으로 목표설정하러가기</button>
					<!-- 여기서 update안하기로 함. put 안해도 될 듯 -->
		        </form>
		      </div>
		    </div>
		  </div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail">
		      <img src="${pageContext.request.contextPath }/resources/imgs/page.jpg" alt="page">
		      <div class="caption">
		        <h3>페이지 중심</h3>
		        <p>하루에 끝내길 원하는 페이지 수를 중심으로 목표를 수립하는 방식</p>
		        <form method="post" action="${pageContext.request.contextPath }/mylib/plan/page/${v_study.study_id}">
		        	<input type="hidden" name="_method" value="put" />
			        <button type="submit" class="btn btn-primary btn-block">페이지 중심으로 목표설정하러가기</button>
		        </form>
		      </div>
		    </div>
		  </div>
		  <div class="col-md-2"></div>
		</div>
	
	</div>
	
	</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
