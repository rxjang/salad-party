<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	#todayDiv1{
		border-radius: 5px;
		border: 1px solid #dddddd;
		padding: 5px 5px 0px 5px;
		background-color: rgb(246,246,246);
		margin: 10px;
	}
	#todayDiv1 img{
		height: 50px;
		line-height: 50px;
	}
	#todayDiv1 h4{
		line-height: 50px;
		color: #888888;
	}
	#todayDiv1 h4 a{
		text-decoration: none;
		line-height: 50px;
		color: #888888;
	}
	#todaybtn{
	}
</style>
<script type="text/javascript">
// 	$('#todaybtn').
// 		입력전이면 : 오늘의 공부 입력하러 가기
// 		입력했으면 : 버튼 불활성화
// 		입력할 목표가 없으면 : ???
</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 col-xs-12">
				<h3>
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					오늘의 기록
				</h3>
				${user.nickname }님은 ${fn:length(studies)}개의 스터디를 진행중입니다.
			</div>
			<div class="col-md-8 col-md-offset-2 col-xs-12">
				<c:forEach items="${studies }" var="study">
					<div class="item">
						<div id="todayDiv1">
							<div class="media">
								<div class="media-left">
									<a href="${pageContext.request.contextPath }/find/book/${study.book_bid }">
										<img class="media-object img-rounded" src="${study.coverurl}" alt="book cover">
									</a>
								</div>
								<div class="media-body">
									<h4 class="media-heading">
										<a href="${pageContext.request.contextPath }/find/book/${study.book_bid }">
											${study.title}
										</a>
									</h4>
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					
	<!-- 			<div> -->
	<!-- 			오늘활동 요약 (컬러코딩된 이모티콘) 옆으로 설명 -->
	<!-- 			- 오늘 목표를 모두 달성했어요 (Green) -->
	<!-- 			- 2챕터 (또는 30페이지)를 끝낼 계획이에요 (wine??) -->
	<!-- 			- 계획이 없어요 (gray) -->
	<!-- 			</div> -->
				
	<!-- 			<div> 이 전체를 좌우로 케러셀 할 수 있나? 아님 버튼으로라도 다른 study로 이동할 수 있게 -->
	<!-- 				한마디 : -->
	<!-- 					계획보다 더 열심히 하고 있어요(green) -->
	<!-- 					목표를 달성했어요(yellow) -->
	<!-- 					조금 더 분발해야 해요(brown) -->
				
	<!-- 				<div> -->
	<!-- 				그래프 1 (지렁이그래프) -->
	<!-- 				시작~오늘~끝~D-Day  -->
	<!-- 				</div> -->
	<!-- 				<div> -->
	<!-- 				그래프 2 (반달 대시보드 그래프) -->
	<!-- 				- 완료율%=오늘까지총페이지 or 총챕터/전체 -->
	<!-- 				</div> -->
	<!-- 				<div> -->
	<!-- 				그래프 3 (오늘 기준 일일 평균진도/남은 양) -->
	<!-- 				- 오늘까지 평균 일일 진도 | 남은 기간동안 해야 하는 평균 일일 양 -->
	<!-- 				</div> -->
	<!-- 				<div> -->
	<!-- 				그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray)) -->
	<!-- 				</div> -->
	<!-- 				<div> -->
	<!-- 				그래프 4 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray)) -->
	<!-- 				</div> -->
	<!-- 			</div>	 -->
					
					
					<div id="todaybtn" class="row">
						<div class="col-md-8 col-md-offset-2 col-xs-12">
							<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
							type="button" class="btn btn-default btn-lg btn-block">오늘의 공부 입력하러 가기</a>
						</div>
					</div>
				</c:forEach>	
			</div>
		</div>			
	</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
