<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<!--  
rss	-	디버그를 쉽게 하고 RSS 리더기만으로 이용할 수 있게 하기 위해 만든 RSS 포맷의 컨테이너이며 그 외의 특별한 의미는 없다.
channel	-	검색 결과를 포함하는 컨테이너이다. 이 안에 있는 title, link, description 등의 항목은 참고용으로 무시해도 무방하다.
lastBuildDate	datetime	검색 결과를 생성한 시간이다.
total	integer	검색 결과 문서의 총 개수를 의미한다.
start	integer	검색 결과 문서 중, 문서의 시작점을 의미한다.
display	integer	검색된 검색 결과의 개수이다.
item/items	-	XML 포멧에서는 item 태그로, JSON 포멧에서는 items 속성으로 표현된다. 개별 검색 결과이며 title, link, description을 포함한다.
title	string	검색 결과 문서의 제목을 나타낸다. 제목에서 검색어와 일치하는 부분은 태그로 감싸져 있다.
link	string	검색 결과 문서의 하이퍼텍스트 link를 나타낸다.
image	string	썸네일 이미지의 URL이다. 이미지가 있는 경우만 나타납난다.
author	string	저자 정보이다.
price	integer	정가 정보이다. 절판도서 등으로 가격이 없으면 나타나지 않는다.
discount	integer	할인 가격 정보이다. 절판도서 등으로 가격이 없으면 나타나지 않는다.
publisher	string	출판사 정보이다.
isbn	integer	ISBN 넘버이다.
description	string	검색 결과 문서의 내용을 요약한 패시지 정보이다. 문서 전체의 내용은 link를 따라가면 읽을 수 있다. 패시지에서 검색어와 일치하는 부분은 태그로 감싸져 있다.
pubdate	datetime	출간일 정보이다.
-->
<script type="text/javascript">
	var result;
	var startResult = 1;
	var scrollMove_cnt;
	var owlItems;
	var selectOpt_val = '제목';
	
	function bookDetail(){
		/***********	책 이미지 눌렀을 때 bid를 이용해 서버에서 해당 책정보 받아오기	**********/
		$('.bid').each(function(){
			$(this).on('click',function(event){
				//event.preventDefault();
				//console.log($(this).prop('href'));
				$('#moreResult').hide();//더 보기 버튼 비활성화
				$('#moveTop').hide();//탑 버튼 비활성화
				var idxBid=$(this).prop('href').indexOf('bid');
				//console.log('book_id = '+$(this).prop('href').substring(idxBid+4));
				var bid = $(this).prop('href').substring(idxBid+4);
				location.href="${pageContext.request.contextPath }/find/book/"+bid;
				//검색된 눌렀을 때 책 상세보기 페이지로 이동
 			return false;//a tag 이동방지
			});
		});//each 검색된 책 bid로 상세정보 받아오기
		
	}//bookDetail function
	

	function bookSearch(start,findOpt) {
		
		if($('#search').val().trim()==''){ 
			swal("검색 실패", "검색어를 입력해주세요.", "error");
			$('#cntOfTotal').text('책 제목을 입력하세요.');
			$('#moreResult').hide();//더 보기 버튼 비활성화
			$('#moveTop').hide();//탑 버튼 비활성화
			return;
		}else{
			//$('#moreResult').show();//더 보기 버튼 활성화
			//$('#moveTop').show();//탑 버튼 비활성화
		}
		$.ajax('${pageContext.request.contextPath }/find/result', {
			method : 'GET',
			data : 'search=' + $('#search').val()+'&start='+start+'&select='+findOpt,
			dataType : 'xml',
			contentType:'application/xml;charset=utf-8',
			success : function(data) {
				result = $(data).find('item');
				
				$('#cntOfTotal').text($(data).find('total').text()+'건의 책이 검색되었습니다.');
				if($(data).find('total').text()==0||$(data).find('total').text()<=10){ 
					$('#moreResult').hide();//더 보기 버튼 비활성화
					$('#moveTop').hide();//탑 버튼 비활성화
				}else{
					$('#moreResult').show();//더 보기 버튼 활성화
				}
				/************	검색된 책들 화면에 불러오기	*************/
				result.each(function(i,ele){
					var content = '';
					var idxBid=$(ele).find('link').text().indexOf('bid');
				//	console.log(result[i].link.substring(idxBid+4));
					var bid = $(ele).find('link').text().substring(idxBid+4);
					scrollMove_cnt++;//div에 id를 매겨 검색결과 더보기 할때마다 스크롤 위치 정해주기 위한 변수
					/* 
     				data-aos="fade-down"
     				data-aos="zoom-out-down"
    				data-aos="flip-down"
    				data-aos="flip-up"
					*/
					content += '<div id="scrollMove'+scrollMove_cnt+'" class="media" data-aos="fade-up"><div class="media-left media-middle">'
					content += '<a class="bid"  href="' + $(ele).find('link').text() + '">'  
					content += '<img class="media-object" src="' + $(ele).find('image').text() + '" onerror="this.src=\'${pageContext.request.contextPath}/resources/imgs/no-image.png\'" alt="loading fail">'    
					content += '</a></div>'   
					content += '<div class="media-body">' 
					content += '<h4 class="media-heading">' +$(ele).find('title').text() + '</h4>' 
					content += '<p>' + $(ele).find('author').text()  + '</p>';
					content += '<p>' + $(ele).find('publisher').text()  + '</p>';
					content += '<p>' + $(ele).find('description').text()  + '</p>';
					content += '</div>'  
					content += '</div><br/>'
					$('#result').append(content);
					$('<a href="#scrollMove'+(start-1)+'"/>').wrap($('#aMove')).get(0).click();
				});
				/***********	책 이미지 눌렀을 때 bid를 이용해 서버에서 해당 책정보 받아오기	**********/
				 bookDetail(); //비동기 웹 크롤링
				//$('#moreResult').show();//더 보기 버튼 활성화
				$('#moveTop').show();//탑 버튼
				
			},//success
			error:function(){
				swal("검색 실패", "검색어를 바르게 입력해주세요.", "error");
			}//error
		});//ajax
	}//booksearch function
	
	/*********************** Document Ready ***********************/
	$(function() {
		$('#moreResult').on('click',function(){ //더보기 버튼, 검색결과 10개씩 더 불러온다.
			startResult+=10;
			selectOpt_val = $('#selectOpt').text().trim();//검색 옵션값(제목 저자 출판사)
			bookSearch(startResult, selectOpt_val);
		});//moreResult 버튼 클릭
	/*********************** 탑 버튼, 문서 제일 위로 이동 ***********************/
		$('#moveTop').on('click',function(){ 
			$(document).scrollTop(0);
		});//탑 버튼 클릭
		
			
	/*********************** 검색 form 전송  ***********************/
		$('.search-form').submit(function() { 
			$('#owl_div,.top10').hide();
			$('#result').html('');
			$('#result').append($('<div class="align-right"><a href="#"><em>+책 직접 입력하기</em></a></div>'));
			selectOpt_val = $('#selectOpt').text().trim();//검색 옵션값(제목 저자 출판사)
			startResult=1; //검색결과들 중 읽어올 문서의 순서. ex:start=2 라면 10개 검색됐으면 2번째부터 출력
			scrollMove_cnt=0; //더보기 눌렀을 때 스크롤 이동시키기 위한 id값,검색버튼 누를때마다 초기화.
			bookSearch(startResult,selectOpt_val);
			return false;
		});//submit
		
		
		if (!window.Cypress) {//aos 적용.
	        const scrollCounter = document.querySelector('.js-scroll-counter');
	        AOS.init({
	          mirror: true
	        });
	      }//if

	/*********************** 더보기, 내서재담기 버튼 숨기기 ***********************/
		$('#moreResult,#moveTop').hide();
	      
	 
	/**********************    캐러셀    **********************/
		$('.owl-carousel').owlCarousel({
			margin:20,
	    	responsiveClass:true,
			nav : false,
			autoplay:true,
			dots:false,
			responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
				480 : {
					items:3
				},
				800 : {
					items:5
				},
				1200 : {
					items:7
				}
			}
		});//owl캐러셀
		$('.owl-stage-outer').after('<img class=\"wood\" src=\"${pageContext.request.contextPath}/resources/imgs/shelf.png\">');
		/* 검색 옵션 제목,저자,출판사 */
		$('#opt-tit').click(function(){
			$('#selectOpt').html($(this).text()+'<span class="caret"/>');
			$('#search').prop('placeholder',$(this).text()+'을 입력하세요.');
			selectOpt_val = $(this).text();
		});		
		$('#opt-auth').click(function(){
			$('#selectOpt').html($(this).text()+'<span class="caret"/>');
			$('#search').prop('placeholder',$(this).text()+'을 입력하세요.');
			selectOpt_val = $(this).text();
		});		
		$('#opt-pub').click(function(){
			$('#selectOpt').html($(this).text()+'<span class="caret"/>');
			$('#search').prop('placeholder',$(this).text()+'을 입력하세요.');
			selectOpt_val = $(this).text();
		});		
		$('#opt-all').click(function(){
			$('#selectOpt').html($(this).text()+'<span class="caret"/>');
			$('#search').prop('placeholder',$(this).text()+'을 입력하세요.');
			selectOpt_val = $(this).text();
		});		
		
		
		
		
	/* 캐러셀 책제목 길이 조절 */		
	$('.owl-title').each(function(){
		if($(this).text().length > 20){
			$(this).text($(this).text().substring(0,20)+' ...');			
		}
	});//each title
	
	$('.top10').click(function(){
		location.href='${pageContext.request.contextPath}/news';
	});//click

	/* 메달 반응형 */
	setInterval(function() {
		var window_x = $(window).width();
		console.log(window_x);
		if(window_x < 666){
			$('.medal').hide();
		}else{
			$('.medal').show();
		}
	}, 500); 
	
	
	});//ready
	
</script>
<style type="text/css">
.align-right {
	text-align: right;
}

.no-image {
	display: none;
}

.search-form {
	margin-bottom: 15px;
}

.input-search { /* 검색form안의 div */
	height: 30px;
	border-radius: 25px;
	border-bottom: 1px solid #e4e4e4;
	box-shadow: rgb(192, 207, 178) 0px 0px 3px;
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

.dropdown-menu {
	left: 30px;
	margin-top: 5px;
}

#selectOpt {
	border-radius: 25px;
	border: 0px;
	box-shadow: rgb(192, 207, 178) 0px 0px 3px;
	float: right;
}

.media-object {
	width: 120px;
}

.jumbotron {
	background-color: white;
	padding: 0px;
	padding-right: 0px;
	padding-left: 0px;
}

.owl-carousel {
	
}

.owl-item {
	
}

.owl-stage { /* 캐러셀 아래로 정렬 */
	padding-left: 12px;
	padding-right: 20px;
	align-items: baseline;
	display: inline-flex;
}

.media-object {
	
}

.owl-item img {
	box-shadow: 2px 2px 6px rgba(0, 0, 0, .1), 0 0 2px rgba(0, 0, 0, .2);
}

.bid img {
	margin: 5px 5px 5px 5px;
	box-sizing: border-box;
	box-shadow: 2px 2px 6px rgba(0, 0, 0, .1), 0 0 2px rgba(0, 0, 0, .2);
}

.wood {
	width: 107%;
	height: 5em;
	position: relative;
	right: 3.5%;
	bottom: 6px;
}

.top10 {
	cursor: pointer;
	font-size: 120%;
	font-weight: 600;
	color: rgb(37, 54, 41);
/* 	border: 1px solid #ecece9; */
	/* background-color: #ecece9; */
	height: 120px;
}

.top10 small {
	font-size: 90%;
	font-weight: normal;
	color: #445243;
}

.top10 .panel-body {
	padding: 30px;
}

.medal {
	float: right;
	position: relative;
	bottom: 45px;
}
.panel{
	border: 0px;
	-webkit-box-shadow: 0 0px 0px rgba(0,0,0,.05);
	box-shadow: 0 0px 0px rgba(0,0,0,.05);
}
.panel-bg-img{
	height:120px;
	border-radius:6px;
	background-image: url("${pageContext.request.contextPath }/resources/imgs/yellow-book2.png");
	background-size: contain;
	background-repeat: no-repeat;
	background-color: #f8f5f8;
	text-align: center;
}
@media ( min-width :900px) {
	.btn-group {
		width: 100px;
	}
}

@media ( max-width :800px) {
	.dropdown-menu {
		left: 0px;
	}
	.panel-bg-img{
	background-size: cover;
	}
}
<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
</style>

</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
	<!-- **********content start**********--> 
			<div class="row"></div>	
	
			<div class="row">
				<div class="col-md-2">&nbsp;</div>
				<div class="col-md-8 col-xs-12">
				<br/>
				</div>
				
			</div>

			<div class="row">	<!--************ search **********-->
			
			<div class="col-md-2">&nbsp;</div>
			<div class="col-xs-2 col-md-1">
			 <div class="btn-group" role="group">
				 <button type="button" id="selectOpt" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				      전체
				      <span class="caret"></span>
				    </button>
				    <ul class="dropdown-menu">
				      <li><a id="opt-all" href="#">전체</a></li>
				      <li><a id="opt-tit" href="#">제목</a></li>
				      <li><a id="opt-auth" href="#">저자</a></li>
				      <li><a id="opt-pub" href="#">출판사</a></li>
				    </ul>
			</div>
			</div>
			<div class="col-xs-10 col-md-6">
					<form action="#" class="search-form form-inline">
						<div class="input-search input-group">
							<input type="text" class="" placeholder="제목을 입력하세요." name="search" id="search"/>
							<span class="input-group-btn" id="input_group_btn">
								<button type="submit" id="search-btn" class="btn btn-default btn-md">
									<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
								</button>
							</span>
						</div>
					</form>
					<h4><small id="cntOfTotal"></small></h4>
			</div>
			<div class="col-md-3"></div>
			</div>
	
		
	<div class="row">
		<div class="panel panel-default top10">
			<div class="panel-body panel-bg-img">
				지금 많이 공부하는 책 TOP10<br/><small>북커리회원들이 많이 공부하는 책을 살펴보세요</small>
			<%-- <img class="medal" style="width:64px;height:84px;" src="${pageContext.request.contextPath }/resources/imgs/award/bronze_madal.png">
			<img class="medal" style="width:64px;height:84px;" src="${pageContext.request.contextPath }/resources/imgs/award/silver_madal.png">
			<img class="medal" style="width:64px;height:84px;" src="${pageContext.request.contextPath }/resources/imgs/award/gold_madal.png"> --%>
		<%-- 	<img class="medal" style="height:84px;" src="${pageContext.request.contextPath }/resources/imgs/yellow_book.jpg"/> --%>
			</div>
		
		</div>
	</div>
	
	<div class="jumbotron">
		<div id="chartdiv"></div>	
	</div>
	<!-- ************** OWL carousel ************  -->
	<div class="row" id="owl_div">
		<div class="col-xs-1 col-md-1"></div>
		<div class="col-xs-10 col-md-10"   id="owl">
				<div class="owl-carousel owl-theme">
						<c:forEach items="${most_list }" var="bean"><!-- 많이 공부 중인 책 리스트 -->
						<div class="item"><a href='${pageContext.request.contextPath }/find/book/${bean.bid}'>
						<img class="media-object" alt="image loading fail" src="${bean.coverurl }">
						</a></div>
						</c:forEach>
				</div>

		</div>
		<div class="col-md-1"></div>
		<div class="bottom-line col-xs-12 col-md-12"></div>
	</div><!-- /캐러셀 -->

	<div class="row">
				<!-- <input type="file" name="camara" id="camera" accept="image/*" capture="camera"/> -->
			<br/>
			<div class="col-md-2"></div>
			<div class="col-xs-12 col-md-8" id="result"></div>
			<div class="col-md-2"></div>
		</div>
		
		<div class="row">
			<div class="col-md-2">&nbsp;</div>
			<div class="col-xs-12 col-md-10">
			<button id="moreResult" class="btn btn-default"> 더 보기 </button>
			<button id="moveTop" class="btn btn-default"> Top </button>
			</div>
			<span id="aMove"></span>
		<div class="col-md-12 col-xs-12">&nbsp;
		<img class="no-image" alt="" src="${pageContext.request.contextPath}/resources/imgs/no-image.png">
		</div>
		</div>


<!-- Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/plugins/wordCloud.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<!-- Chart code -->
<script>
var words = '${wordCloud}';
am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

var chart = am4core.create("chartdiv", am4plugins_wordCloud.WordCloud);
var series = chart.series.push(new am4plugins_wordCloud.WordCloudSeries());

series.accuracy = 2;
series.step = 15;
series.rotationThreshold = 0.7;
series.maxCount = 100;
series.minWordLength = 2;
series.labels.template.margin(4,4,4,4);
series.maxFontSize = am4core.percent(20);


//console.log('words ',words);
//series.text = "Though yet of Hamlet our dear brother's death The memory be green, and that it us befitted To bear our hearts in grief and our whole kingdom To be contracted in one brow of woe, Yet so far hath discretion fought with nature That we with wisest sorrow think on him, Together with remembrance of ourselves. Therefore our sometime sister, now our queen, The imperial jointress to this warlike state, Have we, as 'twere with a defeated joy,-- With an auspicious and a dropping eye, With mirth in funeral and with dirge in marriage, In equal scale weighing delight and dole,-- Taken to wife: nor have we herein barr'd Your better wisdoms, which have freely gone With this affair along. For all, our thanks. Now follows, that you know, young Fortinbras, Holding a weak supposal of our worth, Or thinking by our late dear brother's death Our state to be disjoint and out of frame, Colleagued with the dream of his advantage, He hath not fail'd to pester us with message, Importing the surrender of those lands Lost by his father, with all bonds of law, To our most valiant brother. So much for him. Now for ourself and for this time of meeting: Thus much the business is: we have here writ To Norway, uncle of young Fortinbras,-- Who, impotent and bed-rid, scarcely hears Of this his nephew's purpose,--to suppress His further gait herein; in that the levies, The lists and full proportions, are all made Out of his subject: and we here dispatch You, good Cornelius, and you, Voltimand, For bearers of this greeting to old Norway; Giving to you no further personal power To business with the king, more than the scope Of these delated articles allow. Farewell, and let your haste commend your duty. Tis sweet and commendable in your nature, Hamlet,To give these mourning duties to your father: But, you must know, your father lost a father; That father lost, lost his, and the survivor bound In filial obligation for some term To do obsequious sorrow: but to persever In obstinate condolement is a course Of impious stubbornness; 'tis unmanly grief; It shows a will most incorrect to heaven, A heart unfortified, a mind impatient, An understanding simple and unschool'd: For what we know must be and is as common As any the most vulgar thing to sense, Why should we in our peevish opposition Take it to heart? Fie! 'tis a fault to heaven, A fault against the dead, a fault to nature, To reason most absurd: whose common theme Is death of fathers, and who still hath cried, From the first corse till he that died to-day, 'This must be so.' We pray you, throw to earth This unprevailing woe, and think of us As of a father: for let the world take note, You are the most immediate to our throne; And with no less nobility of love Than that which dearest father bears his son, Do I impart toward you. For your intent In going back to school in Wittenberg, It is most retrograde to our desire: And we beseech you, bend you to remain Here, in the cheer and comfort of our eye, Our chiefest courtier, cousin, and our son."; 
series.text = words; 

series.colors = new am4core.ColorSet();
series.colors.passOptions = {}; // makes it loop

//series.labelsContainer.rotation = 45;
series.angles = [0,-90];
series.fontWeight = "600"

setInterval(function () {
  series.dataItems.getIndex(Math.round(Math.random() * (series.dataItems.length - 1))).setValue("value", Math.round(Math.random() * 10));
 }, 10000)

}); // end am4core.ready()
</script>

<!-- HTML -->

	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
