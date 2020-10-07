<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	#planDiv1{
		border-radius: 5px;
		border: 1px solid #dddddd;
		padding: 5px 5px 0px 5px;
		background-color: rgb(246,246,246);
		margin: 10px;
	}
	#planDiv1 img{
/* 		height: 50px; */
/* 		line-height: 50px; */
	}
	#planDiv1 h4{
		line-height: 50px;
		color: #888888;
	}
	#planDiv1 h4 a{
		text-decoration: none;
/* 		line-height: 50px; */
		color: #888888;
	}
	#planDiv2{
		width:100%;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		border: 1px solid #dddddd;
		background-color: rgb(246,246,246);
		margin: 10px 10px 0px 10px;
		display: block;
	}
	#planDiv2 h4,#planDiv3 h4{
		margin-top: 20px;
	}
	#planDiv2 img{
		border-top-left-radius: 5px;
		width: 40%;
		overflow:hidden;
		display: block;
/* 		height: 200px; */
		line-height: 150px;
	}
	@media (max-width:800px) {
		height: 100px;
	}
	#planDiv3{
		width:100%;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
		border: 1px solid #dddddd;
		background-color: rgb(246,246,246);
		margin: 0 10px 10px 10px;
		display: block;
	}
	#planDiv3 img{
		border-bottom-left-radius: 5px;
		width: 40%;
/* 		height: 200px; */
		line-height: 150px;
	}
	#planDiv2:hover,#planDiv3:hover{
		background-color: #c0cfb2;
	}
	#link{
		text-decoration: none;
		color: #555555;
		text-align: center;
	}
	
</style>

 <script>
 $(function(){
	console.log("${v_study.study_id}"); 
 });
 </script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 col-xs-12">
				<h3>
					<span class="glyphicon glyphicon-fire" aria-hidden="true"></span>
					목표설정 방식을 선택해 주세요
				</h3>
			</div>
			<div class="col-md-8 col-md-offset-2 col-xs-12">
				<div id="planDiv1" class="row">
					<div class="col-md-2 col-xs-5">
						<a href="${pageContext.request.contextPath }/find/book/${v_study.book_bid }">
							<img class="media-object img-rounded" src="${v_study.coverurl}" alt="book cover">
						</a>
					</div>
					<div class="col-md-3 col-xs-8">
						<a href="${pageContext.request.contextPath }/find/book/${v_study.book_bid }">
							${v_study.title}
						</a>
					</div>
<!-- 				<div id="planDiv1"> -->
<!-- 					<div class="media"> -->
<!-- 						<div class="media-left"> -->
<%-- 							<a href="${pageContext.request.contextPath }/find/book/${v_study.book_bid }"> --%>
<%-- 								<img class="media-object img-rounded" src="${v_study.coverurl}" alt="book cover"> --%>
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 						<div class="media-body"> -->
<!-- 							<h4 class="media-heading"> -->
<%-- 								<a href="${pageContext.request.contextPath }/find/book/${v_study.book_bid }"> --%>
<%-- 									${v_study.title} --%>
<!-- 								</a> -->
<!-- 							</h4> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 col-xs-12">
						<a id="link" href="${pageContext.request.contextPath }/mylib/plan/chap/${v_study.study_id }">
							<div id="planDiv2">
								<div class="media">
									<div class="media-left">
										<img class="media-object" src="${pageContext.request.contextPath }/resources/imgs/chap.jpg" alt="chapter">
									</div>
									<div class="media-body">
										<h4 class="media-heading">하루에 한 챕터 이상을 완료할 수 있다면?<br><br>챕터 중심으로 목표설정하기</h4>
										<br>
										<p>선택한 도서의 전체 챕터를 살펴보고<br>
										필요하다면 원하는 대로 챕터를 추가하거나 삭제합니다.<br>
										<br>
										하루에 끝낼 챕터의 양 또는 완료하고 싶은 날짜를 정하여<br>
										스터디 목표를 설정합니다.
										</p>
									</div>
								</div>
							</div>
						</a>
						<a id="link" href="${pageContext.request.contextPath }/mylib/plan/page/${v_study.study_id }">
							<div id="planDiv3">
								<div class="media">
									<div class="media-left">
										<img class="media-object" src="${pageContext.request.contextPath }/resources/imgs/page.jpg" alt="page">
									</div>
									<div class="media-body">
										<h4 class="media-heading">한 챕터를 끝내는데 여러날이 걸린다면?<br><br>페이지 중심으로 목표설정하기</h4>
										<br>
										<p>선택한 도서의 전체 페이지를 살펴보고<br>
										하루에 끝낼 페이지수 또는 완료하고 싶은 날짜를 정하여<br>
										스터디 목표를 설정합니다.
									</div>
								</div>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>