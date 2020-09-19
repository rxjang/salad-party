<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>

<script type="text/javascript">
$(function() {
/**********************    캐러셀    **********************/
	$('.owl-stage-outer').owlCarousel({
		items:1,
		loop : true,
		autoplay : false,
		margin : 10,
		merge : false,
		nav : true,
		responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
		}
	});//owl캐러셀
});
</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
	<!-- **********content start**********--> 
<div class="row">
			<div class="col-md-1">&nbsp;</div>
		<div class="col-xs-12 col-md-10"   id="owl">
			<div class="owl-carousel owl-themeowl-loading owl-loaded">
				<div class="owl-stage-outer" >
					<div class="owl-stage owl-refresh" >
							<div class="owl-item">
							<h2>오늘의 기록1111111111111111111</h2>
								<div>
								${nickname }님은 ${activestudy }가지 공부를 진행중입니다. 
								</div>
								<div>
								${book.imgurl }
								</div>
								
								<div>
								오늘활동 요약 (컬러코딩된 이모티콘) 옆으로 설명
								- 오늘 목표를 모두 달성했어요 (Green)
								- 2챕터 (또는 30페이지)를 끝낼 계획이에요 (wine??)
								- 계획이 없어요 (gray)
								</div>
								
								<div> 이 전체를 좌우로 케러셀 할 수 있나? 아님 버튼으로라도 다른 study로 이동할 수 있게
									<h3>오늘까지의 여정</h3>
									한마디 :
										계획보다 더 열심히 하고 있어요(green)
										목표를 달성했어요(yellow)
										조금 더 분발해야 해요(brown)
								
									<div>
									그래프 1 (지렁이그래프)
									시작~오늘~끝~D-Day 
									</div>
									<div>
									그래프 2 (반달 대시보드 그래프)
									- 완료율%=오늘까지총페이지 or 총챕터/전체
									</div>
									<div>
									그래프 3 (오늘 기준 일일 평균진도/남은 양)
									- 오늘까지 평균 일일 진도 | 남은 기간동안 해야 하는 평균 일일 양
									</div>
									<div>
									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))
									</div>
									<div>
									그래프 4 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))
									</div>
								</div>	
								
								<div>
									<h3></h3>
								</div>
								
								
								
								
								<div>
								화면 하단 고정 버튼 : 
								입력전이면 : 오늘의 공부 입력하러 가기
								입력했으면 : 버튼 불활성화
								입력할 목표가 없으면 : ??? 
								</div>
								
						
						
						</div>
					
							<div class="owl-item">
							<h2>오늘의 기록2222222222222222222222</h2>
								<div>
								${nickname }님은 ${activestudy }가지 공부를 진행중입니다. 
								</div>
								<div>
								${book.imgurl }
								</div>
								
								<div>
								오늘활동 요약 (컬러코딩된 이모티콘) 옆으로 설명
								- 오늘 목표를 모두 달성했어요 (Green)
								- 2챕터 (또는 30페이지)를 끝낼 계획이에요 (wine??)
								- 계획이 없어요 (gray)
								</div>
								
								<div> 이 전체를 좌우로 케러셀 할 수 있나? 아님 버튼으로라도 다른 study로 이동할 수 있게
									<h3>오늘까지의 여정</h3>
									한마디 :
										계획보다 더 열심히 하고 있어요(green)
										목표를 달성했어요(yellow)
										조금 더 분발해야 해요(brown)
								
									<div>
									그래프 1 (지렁이그래프)
									시작~오늘~끝~D-Day 
									</div>
									<div>
									그래프 2 (반달 대시보드 그래프)
									- 완료율%=오늘까지총페이지 or 총챕터/전체
									</div>
									<div>
									그래프 3 (오늘 기준 일일 평균진도/남은 양)
									- 오늘까지 평균 일일 진도 | 남은 기간동안 해야 하는 평균 일일 양
									</div>
									<div>
									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))
									</div>
									<div>
									그래프 4 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))
									</div>
								</div>	
								
								<div>
									<h3></h3>
								</div>
								
								
								
								
								<div>
								화면 하단 고정 버튼 : 
								입력전이면 : 오늘의 공부 입력하러 가기
								입력했으면 : 버튼 불활성화
								입력할 목표가 없으면 : ??? 
								</div>
								
						
						
						</div>
					
							<div class="owl-item">
							<h2>오늘의 기록3333333333333</h2>
								<div>
								${nickname }님은 ${activestudy }가지 공부를 진행중입니다. 
								</div>
								<div>
								${book.imgurl }
								</div>
								
								<div>
								오늘활동 요약 (컬러코딩된 이모티콘) 옆으로 설명
								- 오늘 목표를 모두 달성했어요 (Green)
								- 2챕터 (또는 30페이지)를 끝낼 계획이에요 (wine??)
								- 계획이 없어요 (gray)
								</div>
								
								<div> 이 전체를 좌우로 케러셀 할 수 있나? 아님 버튼으로라도 다른 study로 이동할 수 있게
									<h3>오늘까지의 여정</h3>
									한마디 :
										계획보다 더 열심히 하고 있어요(green)
										목표를 달성했어요(yellow)
										조금 더 분발해야 해요(brown)
								
									<div>
									그래프 1 (지렁이그래프)
									시작~오늘~끝~D-Day 
									</div>
									<div>
									그래프 2 (반달 대시보드 그래프)
									- 완료율%=오늘까지총페이지 or 총챕터/전체
									</div>
									<div>
									그래프 3 (오늘 기준 일일 평균진도/남은 양)
									- 오늘까지 평균 일일 진도 | 남은 기간동안 해야 하는 평균 일일 양
									</div>
									<div>
									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))
									</div>
									<div>
									그래프 4 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))
									</div>
								</div>	
								
								<div>
									<h3></h3>
								</div>
								
								
								
								
								<div>
								화면 하단 고정 버튼 : 
								입력전이면 : 오늘의 공부 입력하러 가기
								입력했으면 : 버튼 불활성화
								입력할 목표가 없으면 : ??? 
								</div>
								
						
						
						</div>
					<c:forEach items="${v_study }" var="bean">
			
						<div class="owl-item">
							<h2>오늘의 기록</h2>
								<div>
								${nickname }님은 ${activestudy }가지 공부를 진행중입니다. 
								</div>
								<div>
								${book.imgurl }
								</div>
								
								<div>
								오늘활동 요약 (컬러코딩된 이모티콘) 옆으로 설명
								- 오늘 목표를 모두 달성했어요 (Green)
								- 2챕터 (또는 30페이지)를 끝낼 계획이에요 (wine??)
								- 계획이 없어요 (gray)
								</div>
								
								<div> 이 전체를 좌우로 케러셀 할 수 있나? 아님 버튼으로라도 다른 study로 이동할 수 있게
									<h3>오늘까지의 여정</h3>
									한마디 :
										계획보다 더 열심히 하고 있어요(green)
										목표를 달성했어요(yellow)
										조금 더 분발해야 해요(brown)
								
									<div>
									그래프 1 (지렁이그래프)
									시작~오늘~끝~D-Day 
									</div>
									<div>
									그래프 2 (반달 대시보드 그래프)
									- 완료율%=오늘까지총페이지 or 총챕터/전체
									</div>
									<div>
									그래프 3 (오늘 기준 일일 평균진도/남은 양)
									- 오늘까지 평균 일일 진도 | 남은 기간동안 해야 하는 평균 일일 양
									</div>
									<div>
									그래프 4 (전체 기간동안 누적 actual(green,yellow,brown)/plan(gray))
									</div>
									<div>
									그래프 4 (전체 기간동안 일일 actual(green,yellow,brown)/plan(gray))
									</div>
								</div>	
								
								<div>
									<h3></h3>
								</div>
								
								
								
								
								<div>
								화면 하단 고정 버튼 : 
								입력전이면 : 오늘의 공부 입력하러 가기
								입력했으면 : 버튼 불활성화
								입력할 목표가 없으면 : ??? 
								</div>
								
						
						
						</div>
					</div>		
					
					</c:forEach>
				</div>
			</div>

		</div>
		<div class="col-md-1">&nbsp;</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
