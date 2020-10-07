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
/* 		height: 180px; */
	}
	#todayDiv1 img{
/* 		height: 170px; */
	}
	#todayDiv1>span{
		margin: 0;
		float: left;
	}
	#todayDiv1 h4{
/* 		line-height: 50px; */
		color: #888888;
	}
	#todayDiv1 h4 a{
		text-decoration: none;
/* 		line-height: 50px; */
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
					<c:if test="${fn:length(studymap) eq 0}">
						 기록할 스터디가 없습니다.
					</c:if>
					<c:if test="${fn:length(studymap) ne 0}">
						${fn:length(studymap)}개의 스터디
					</c:if>
				</h3>
				<div class="owl-carousel owl-theme">
					<c:forEach items="${studymap }" var="map">
						<c:set value="${map.key }" var="study_id"/>
						<c:set value="${map.value.v_study }" var="study"/>
						<c:set value="${map.value.v_calendar }" var="cals"/>
						<div class="item">
							<!-- 
							study_id: ${study_id }<br>
							제목: ${study.title }<br>
							시작일: ${study.startdate }<br>
							끝일: ${study.enddate }<br>
							-->
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
										<c:if test="${study.plan_chap-study.actual_chap eq 0}">
											<c:if test="${study.updatetime lt today}">
												<img src="${pageContext.request.contextPath }/resources/imgs/Smile-sleepy.png">
											</c:if>
											<c:if test="${study.updatetime eq today}">
												<img src="${pageContext.request.contextPath }/resources/imgs/Smile-blush.png">
											</c:if>
										</c:if>
										<c:if test="${study.plan_chap-study.actual_chap >= 0}">
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
										<c:if test="${study.plan_chap-study.actual_chap eq 0}">
											<c:if test="${study.updatetime lt today}">
												오늘엔 목표설정한 계획이 없어요 
											</c:if>
											<c:if test="${study.updatetime eq today}">
												축하합니다. 오늘의 목표를 모두 달성하셨습니다.
											</c:if>
										</c:if>
										<c:if test="${study.plan_chap-study.actual_chap >= 0}">
											${study.plan_chap-study.actual_chap } 챕터를 끝낼 계획이에요.
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
									완료: ${study.actual_page + study.actual_chap }<br>
									전체: ${study.total_pages + study.total_chap }<br>
								</div>
								<div class="col-md-3 col-xs-3">
									그래프 3 (어제밤 기준 일일 평균진도/남은 양)<br>
									총 날짜수: 	${study.total_days}<br>
									공부한날: ${study.actual_days_yesterday }일<br>
									계획했던 날 수: ${study.plan_days_yesterday }일<br>
									남은 날 수: ${study.remain_days }<br>
									<c:if test="${study.type eq 'chap'}">
										챕터-총 챕터수: 	${study.total_chap}<br>
										챕터-목표 챕터수: 	${study.plan_chap_yesterday}<br>
										챕터-실제 챕터수: 	${study.actual_chap_yesterday}<br>
										일일 평균 목표량:	${study.plan_chap div study.total_days}<br>
										어제까지 평균일일진도:${study.actual_chap_yesterday div study.plan_days_yesterday}<br>
										<c:if test="${study.remain_days > 0}">
											남은 기간동안 해야 하는 평균 일일 양:${(study.total_chap - study.actual_chap_yesterday) div (study.remain_days)}
										</c:if>
										<c:if test="${study.remain_days eq 0}">
											남은 기간동안 해야 하는 평균 일일 양:${(study.total_chap-study.actual_chap_yesterday)}
										</c:if>
									</c:if>
									<c:if test="${study.type eq 'page'}">
										페이지-총페이지수: 	${study.total_pages}<br>
										페이지-목표 페이지수:	${study.plan_page_yesterday}<br>
										페이지-실제 페이지수:	${study.actual_page_yesterday}<br>
										일일 평균 목표량:	${study.total_pages div study.total_days}<br>
										어제까지 평균 일일 진도:${study.actual_page_yesterday div study.plan_days_yesterday}<br>
										<c:if test="${study.remain_days > 0}">
											남은 기간동안 해야 하는 평균 일일 양:${(study.total_pages - study.actual_page_yesterday) div (study.remain_days)}
										</c:if>
										<c:if test="${study.remain_days eq 0}">
											남은 기간동안 해야 하는 평균 일일 양:${(study.total_pages-study.actual_page_yesterday)}
										</c:if>
									</c:if>
								</div>
							</div>
							<div id="todayDiv3" class="row">
								<div class="col-md-6 col-xs-6">
									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))<br>
									목록길이: ${fn:length(cals) }<br>
									<c:forEach items="${cals}" var="cal" varStatus="status">
										${cal.user_id} 
										${cal.sid_date} 
										${cal.type} 
										${cal.study_id} 
										${cal.date} 
										${cal.plan} 
										${cal.actual} 
										${cal.status}<br>
									</c:forEach>
								</div>
								<div class="col-md-6 col-xs-6">
									그래프 5 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))<br>
									목록길이: ${fn:length(cals) }<br>
									<c:forEach items="${cals}" var="cal" varStatus="status">
										${cal.user_id} 
										${cal.sid_date} 
										${cal.type} 
										${cal.study_id} 
										${cal.date} 
										${cal.plan} 
										${cal.actual} 
										${cal.status}<br>
									</c:forEach>
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
 				</div><!-- owl-carousel -->
			</div>		
		</div>			
	</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>