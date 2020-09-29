<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	#todayDiv1,#todayDiv2,#todayDiv3{
		border-radius: 5px;
		border: 1px solid #dddddd;
		padding: 5px 5px 0px 5px;
		background-color: rgb(246,246,246);
		margin: 10px;
		height: 180px;
	}
	#todayDiv1 img{
 		height: 170px;
	}
	#todayDiv1>span{
		margin: 0;
		float: left;
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
	.green,
	.yellow,
	.brown{
		font-size: 1.5em;
		text-align: center;
	}
	.green{
		background-color: #49654d;
		color: white;
	}
	.yellow{
		background-color: c0cfb2;
		color: #49654d;
	}
	.brown{
		background-color: rgb(197,174,132);
		color: white;
	}
</style>
<script type="text/javascript">
// 	$('#todaybtn').
// 		입력전이면 : 오늘의 공부 입력하러 가기
// 		입력했으면 : 버튼 불활성화
// 		입력할 목표가 없으면 : ???
	$(function(){
		$('.owl-carousel').owlCarousel({
			items: 1,
			loop:true,
			margin:10,
			nav:false,
			responsive:{
			}
		})
	});
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
					오늘의 기록 : 
					<c:if test="${fn:length(studies) eq 0}">
						 기록할 스터디가 없습니다.
					</c:if>
					<c:if test="${fn:length(studies) ne 0}">
						${fn:length(studies)}개의 스터디
					</c:if>
				</h3>
				<div class="owl-carousel owl-theme">
					<c:forEach items="${studies }" var="study">
						<div class="item">
							<div id="todayDiv1" class="row">
								<div class="col-md-3 col-xs-3">
									<img class="img-rounded" src="${study.coverurl}" alt="book cover">
								</div>
								<div class="col-md-3 col-xs-3">
									${study.memo}
								</div>
								<div class="col-md-3 col-xs-3">
									<c:set var="today" value="<%=new java.util.Date()%>"/>
									<c:if test="${study.type eq 'chap'}">
										<c:if test="${study.plan_cnt-study.actual_cnt eq 0}">
											<c:if test="${study.updatetime lt today}">
												<img src="${pageContext.request.contextPath }/resources/imgs/Smile-sleepy.png">
											</c:if>
											<c:if test="${study.updatetime eq today}">
												<img src="${pageContext.request.contextPath }/resources/imgs/Smile-blush.png">
											</c:if>
										</c:if>
										<c:if test="${study.plan_cnt-study.actual_cnt >= 0}">
											<img src="${pageContext.request.contextPath }/resources/imgs/Smile-sweat.png">
										</c:if>
									</c:if>
									<c:if test="${study.type eq 'page'}">
										<c:if test="${study.plan_page-study.actual_page eq 0}">
											<c:if test="${study.updatetime lt today}">
												<img src="${pageContext.request.contextPath }/resources/imgs/Smile-sleepy.png">
											</c:if>
											<c:if test="${study.updatetime eq today}">
												<img src="${pageContext.request.contextPath }/resources/imgs/Smile-blush.png">
											</c:if>
										</c:if>
										<c:if test="${study.plan_page-study.actual_page >= 0}">
											<img src="${pageContext.request.contextPath }/resources/imgs/Smile-sweat.png">
										</c:if>
									</c:if>
								</div>
								<div class="col-md-3 col-xs-3">
									<c:if test="${study.type eq 'chap'}">
										<c:if test="${study.plan_cnt-study.actual_cnt eq 0}">
											<c:if test="${study.updatetime lt today}">
												오늘엔 목표설정한 계획이 없어요 
											</c:if>
											<c:if test="${study.updatetime eq today}">
												축하합니다. 오늘의 목표를 모두 달성하셨습니다.
											</c:if>
										</c:if>
										<c:if test="${study.plan_cnt-study.actual_cnt >= 0}">
											${study.plan_cnt-study.actual_cnt } 챕터를 끝낼 계획이에요.
										</c:if>
									</c:if>
									<c:if test="${study.type eq 'page'}">
										<c:if test="${study.plan_page-study.actual_page eq 0}">
											<c:if test="${study.updatetime lt today}">
												오늘엔 목표설정한 계획이 없어요 
											</c:if>
											<c:if test="${study.updatetime eq today}">
												축하합니다. 오늘의 목표를 모두 달성하셨습니다.
											</c:if>
										</c:if>
										<c:if test="${study.plan_page-study.actual_page >= 0}">
											${study.plan_page-study.actual_page } 페이지를 끝낼 계획이에요.
										</c:if>
									</c:if>
								</div>
							</div><!-- todayDiv1 -->
							<div id="todayDiv2" class="row">
								<div class="col-md-3 col-xs-3">
									<c:if test="${study.success_rate gt 100}">
										<div class="green">목표를<br>초과달성했어요</div>
									</c:if>
									<c:if test="${study.success_rate eq 100}">
										<div class="yellow">목표를<br>달성했어요</div>
									</c:if>
									<c:if test="${study.success_rate lt 100}">
										<div class="brown">조금 더<br>분발하세요</div>
									</c:if>
								</div>
								<div class="col-md-3 col-xs-3">
									그래프 1 (지렁이그래프)<br>
									시작일: ${study.startdate }<br>
									오늘: <fmt:formatDate value="${today }" pattern="yyyy-MM-dd" /><br>
									완료일: ${study.enddate }
								</div>
								<div class="col-md-3 col-xs-3">
									그래프 2 (반달 대시보드 그래프)<br>
									완료율: ${study.progress_rate }<br>
									완료: ${study.actual_page + study.actual_cnt }<br>
									전체: ${study.total_pages + study.total_cnt }
								</div>
								<div class="col-md-3 col-xs-3">
									그래프 3 (오늘 기준 일일 평균진도/남은 양)<br>
									<c:if test="${study.type eq 'chap'}">
										챕터-총챕터수: 		${study.plan_cnt}<br>
										챕터-총 날짜수: 	${study.chap_total_days}<br>
										챕터-실제 챕터수: 	${study.actual_cnt}<br>
										챕터-실제 날짜수: 	${study.chap_actual_days}<br>
										일일 평균 목표량:	${study.plan_cnt div study.chap_total_days}<br>
										오늘까지 평균일일진도:${study.actual_cnt div study.chap_actual_days}<br>
										남은 기간동안 해야 하는 평균 일일 양:${((study.plan_cnt div study.chap_total_days)
										 - (study.actual_cnt div study.chap_actual_days))
										 div (study.chap_total_days - study.chap_actual_days)}
										 계산식 재검토 필요
									</c:if>
									<c:if test="${study.type eq 'page'}">
										페이지-총페이지수: 	${study.total_pages}<br>
										페이지-총 날짜수: 	${study.page_total_days}<br>
										페이지-실제 페이지수:	${study.actual_page}<br>
										페이지-실 날짜수: 	${study.page_actual_days}<br>
										일일 평균 목표량:	${study.total_pages div study.page_total_days}<br>
										오늘까지 평균 일일 진도:${study.actual_page div study.page_actual_days}<br>
										남은 기간동안 해야 하는 평균 일일 양:${((study.pages div study.page_total_days)
										 - (study.actual_page div study.page_actual_days))
										 div (study.page_total_days - study.page_actual_days)}
										 계산식 재검토 필요
									</c:if>
								</div>
							</div>
							<div id="todayDiv3" class="row">
								<div class="col-md-6 col-xs-6">
									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))
								</div>
								<div class="col-md-6 col-xs-6">
									그래프 4 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))
								</div>
							
							</div>
							<div id="todaybtn" class="row">
								<div class="col-md-8 col-md-offset-2 col-xs-12">
									<a href="${pageContext.request.contextPath }/today/${study.type }/${study.study_id }"
									type="button" class="btn btn-default btn-lg btn-block">오늘의 공부 입력하러 가기</a>
								</div>
							</div>
						</div><!-- item -->
					</c:forEach>
				</div>
			</div>		
		</div>			
	</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
