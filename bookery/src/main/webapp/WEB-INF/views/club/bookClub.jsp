<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	//미완독 미독 완독 책 리스트. JSON
	var studyingbooklist = '${studyingbooklist}';
	var nogoalbooklist = '${nogoalbooklist}';
	var finishedbooklist = '${finishedbooklist}';
	var full_badge_items;
	var show_class_name='thumb-box';
	$(function() {
		infinityScroll(show_class_name);
		//console.log(JSON.parse(studyingbooklist));
		//console.log(JSON.parse(nogoalbooklist));
		//console.log(JSON.parse(finishedbooklist));
		aos();
		$('form').on('submit',function(){
			return false;
		});//submit
		
		$('#search').on('keyup',function(){
			var keyword = $(this).val();
			console.log(keyword);
			$('.thumb-box').hide();
			$('.thumb-box:contains("'+keyword+'")').show();
			$('.not-found').hide();
			$(document).off('scroll'); //검색시 스크롤이벤트 삭제. 
			if(keyword == ''){//검색창 지우면 다시 무한 스크롤이벤트 생성
				$('.thumb-box').hide();
				infinityScroll(show_class_name);
			}
			aos();
		});//input change
		
		$('.thumbnail').each(function(){
			var aHref = $(this).find('a').attr('href');
			$(this).click(function(){
				location.href=aHref;
			});//thumbnail div click
		});// each
		
		
		/* 책제목 길이 조절 */		
		$('.book-title').each(function(){
			if($(this).text().length > 20){
				$(this).text($(this).text().substring(0,20)+' ...');			
			}
		});//each title
			
		/* v_study list에서 book_bid만 배열에 저장 */
		var studying_arr = [];
		var studyingbooks = JSON.parse(studyingbooklist).key;
		studyingbooks.forEach(function(ele){
			studying_arr.push(ele.book_bid);
		});//forEach
		var nogoal_arr = [];
		var nogoalbooks = JSON.parse(nogoalbooklist).key;
		nogoalbooks.forEach(function(ele){
			nogoal_arr.push(ele.book_bid);
		});//forEach
		var finished_arr = [];
		var finishedbooks = JSON.parse(finishedbooklist).key;
		finishedbooks.forEach(function(ele){
			finished_arr.push(ele.book_bid);
		});//forEach
	 
		
		var items_nogoal = $('.thumb-box').get(); 
		$.each(items_nogoal, function(idx, ele){
			if(nogoal_arr.includes(Number($(ele).attr('id')))){
				//	console.log('same');
					$(ele).addClass('nogoal');
			}else if(!studying_arr.includes(Number($(ele).attr('id')))){
			}
		});
		var items_studying = $('.thumb-box').get(); 
		$.each(items_studying, function(idx, ele){
			if(studying_arr.includes(Number($(ele).attr('id')))){
				//	console.log('same');
				$(ele).addClass('studying');
			}else if(!studying_arr.includes(Number($(ele).attr('id')))){
			}
		});
		var items_finished = $('.thumb-box').get(); 
		$.each(items_finished, function(idx, ele){
			if(finished_arr.includes(Number($(ele).attr('id')))){
				//	console.log('same');
				$(ele).addClass('finished');
			}else if(!studying_arr.includes(Number($(ele).attr('id')))){
			}
		});

		var orderby = 'thumb-box';
		
		/* 미완독 책만보기 */
		$('#orderByMyBook').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			orderby = 'studying';
			
			$('.order-btn a').not($(this)).each(function(){
				if($(this).attr('class').includes('ok',0)){
					$(this).addClass('not-ok').removeClass('ok');
					$(this).find('.glyphicon-ok').remove();
				}//if
			});//each
			
			if($(this).attr('class').includes('not-ok',0)){
				//console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				
				
				//$('.studying').show();
				$('.thumb-box').not('.studying').hide();
				infinityScroll('studying');
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('.glyphicon-ok').remove();
				$('.order-btn a').not($(this)).each(function(){
					if($(this).attr('class').includes('ok',0)){
						$(this).addClass('not-ok').removeClass('ok');
						$(this).find('.glyphicon-ok').remove();
					}//if
				});//each

				//full_badge_items = $('.thumb-box').get();
				//var items = full_badge_items;
			//	var items = $('.thumb-box .badge').get(); 
				/* items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	 */
			//	$.each(items, function(idx, ele){
			//		$('.bookclub-contents').prepend($(ele).parent().parent().parent().parent().parent().parent());
			//		$(ele).parent().parent().parent().parent().parent().parent().hide();
			//	});
				$('.thumb-box').hide();
				infinityScroll('thumb-box');
			}//if
		});//click
		
		/* 완독 책만보기 */
		$('#orderByFinished').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			orderby = 'finished';
			$('.order-btn a').not($(this)).each(function(){
				
				if($(this).attr('class').includes('ok',0)){
					$(this).addClass('not-ok').removeClass('ok');
					$(this).find('.glyphicon-ok').remove();
				}//if
			});//each
			
			if($(this).attr('class').includes('not-ok',0)){
				//console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				
				//$('.finished').show();
				$('.thumb-box').not('.finished').hide();
				$(document).off('scroll');
				infinityScroll('finished');
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('.glyphicon-ok').remove();
				$('.order-btn a').not($(this)).each(function(){
					if($(this).attr('class').includes('ok',0)){
						$(this).addClass('not-ok').removeClass('ok');
						$(this).find('.glyphicon-ok').remove();
					}//if
				});//each
				//full_badge_items = $('.thumb-box').get();
				//var items = $('.thumb-box .badge').get(); 
/* 				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	 */
				//$.each(items, function(idx, ele){
				//	$('.bookclub-contents').prepend($(ele).parent().parent().parent().parent().parent().parent());
				//	$(ele).parent().parent().parent().parent().parent().parent().hide();
				//});
				$('.thumb-box').hide();
				infinityScroll('thumb-box');
			}//if
		});//click
		
		/* 미독 책만보기 */
		$('#orderByNoGoal').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			orderby = 'nogoal';
			$('.order-btn a').not($(this)).each(function(){
				if($(this).attr('class').includes('ok',0)){
					$(this).addClass('not-ok').removeClass('ok');
					$(this).find('.glyphicon-ok').remove();
				}//if
			});//each
			
			if($(this).attr('class').includes('not-ok',0)){
			//	console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');				

				//$('.nogoal').show();
				$('.thumb-box').not('.nogoal').hide();
				infinityScroll('nogoal');
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('.glyphicon-ok').remove();
				$('.order-btn a').not($(this)).each(function(){
					if($(this).attr('class').includes('ok',0)){
						$(this).addClass('not-ok').removeClass('ok');
						$(this).find('.glyphicon-ok').remove();
					}//if
				});//each
				//full_badge_items = $('.thumb-box').get();
				//var items = $('.thumb-box').get(); 
/* 				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				}); */	
/* 				$.each(items, function(idx, ele){
					$('.bookclub-contents').prepend($(ele));
				}); */
				$('.thumb-box').hide();
				infinityScroll('thumb-box');
			}//if
		});//click
		
		
		
	
		/* 가나다순 정렬하기 */
		$('#orderByABC').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			var items_ABC = $('.thumb-box .book-title').get(); 
			items_ABC.sort(function(a,b){ 
				  var keyA = $(a).text();
				  var keyB = $(b).text();
				  if (keyB > keyA) return -1;
				  if (keyA > keyB) return 1;
				  return 0;
			});	
			
			if($('#orderByCBA').attr('class').includes('ok',0)){
				$('#orderByCBA').addClass('not-ok').removeClass('ok');
				$('#orderByCBA .glyphicon-ok').remove();
			} 
			if($(this).attr('class').includes('not-ok',0)){
				//console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				
				$.each(items_ABC, function(idx, ele){
				//	console.log('가나다');
					$('.bookclub-contents').append($(ele).parent().parent().parent());
					$(ele).parent().parent().parent().hide();
				});
			
				infinityScroll(orderby);
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('.glyphicon-ok').remove();
				

				location.reload();
			}//if
		});//click
		
		/* 역순 정렬하기 */
		$('#orderByCBA').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');

			var items_CBA = $('.thumb-box .book-title').get(); 
			items_CBA.sort(function(a,b){ 
				  var keyA = $(a).text();
				  var keyB = $(b).text();
				  if (keyB > keyA) return -1;
				  if (keyA > keyB) return 1;
				  return 0;
			});	
			
			if($('#orderByABC').attr('class').includes('ok',0)){
				$('#orderByABC').addClass('not-ok').removeClass('ok');
				$('#orderByABC .glyphicon-ok').remove();
			}
			if($(this).attr('class').includes('not-ok',0)){
				console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				$.each(items_CBA, function(idx, ele){
					$('.bookclub-contents').prepend($(ele).parent().parent().parent());
					$(ele).parent().parent().parent().hide();
				});
				
				infinityScroll(orderby);
			}else if($(this).attr('class').includes('ok',0)){
				//console.log('역순취소');
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('.glyphicon-ok').remove();
			
				
				location.reload();
			}//if
		});//click
		
		
		/* 스크롤바 다내리면 새로운 목록 로딩 */
		
	    /* 미독완독 미완독 가나다순 정렬 클릭시 검색결과없음 표시. */
	       $('.order-btn a').each(function(){
	    	   $(this).click(function(){
	    		   var length = 0;
	    		   var items = $('.thumb-box').get();
	    		   items.forEach(function(ele){
	    			  if($(ele).css('display') == 'block'){
	    				  length++;
	    			  } 
	    		   });
	    		   if(length == 0){
	    				$('.not-found').show();  
	    		   }else{
	    				$('.not-found').hide();  
	    		   }
	    	   });//click
	       });//each

	       /* tooltip */
    	   $('[data-toggle="tooltip"]').tooltip()
	});//ready
	
	
	function infinityScroll(className){
		
		$(document).off('scroll');//기존 스크롤 이벤트 삭제
		
 		$('.'+className+'').each(function(idx,ele){ //첫화면에 6개만 띄움
 			//console.log('check');
		    			if(idx >= 5 ){
		    				return false;
		    			}
				   $(ele).show();
				   aos();
   		}); 

		var cnt = 1;
		
		var sevent= $(document).on('scroll',function(){
			//console.log('스크롤');
	        var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
			//console.log(scrollT)
	        var scrollH = $('.thumb-box').height(); //스크롤바를 갖는 div의 높이
	        var contentH = $('.bookclub-contents').height(); //문서 전체 내용을 갖는 div의 높이
			//console.log(scrollH);
			//console.log(contentH);
	        if(scrollT + scrollH+1 >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
	          // $('.bookclub-contents').append($('<div class="col-xs-12 col-md-4 thumb-box" data-aos="fade-down"><p>APPEND</p></div>'));
	        $('.'+className+'').each(function(idx,ele){
		    			if(cnt*5 > (idx-1) ){
		    				$(this).show();
		    				  aos();
		    			}else if((idx-1) >(cnt+1)*5){
		    				return false;
		    			}
		    		}); 
	      //  console.log(cnt);
	        cnt++;
	        }
	    });//scoll 
	}
	
</script>
<style type="text/css">
 .thumb-box {
	display: none;
} 
.not-found {
	text-align: center;
	font-size: 1.5em;
	display: none;
}

.not-found {
	text-align: center;
	font-size: 1.5em;
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

.thumb-box {
	/* 	width:300px;
*/
	height: 350px;
	margin-bottom: 50px;
}

.thumbnail { /*   */
	text-align: center;
	border: 1px solid rgb(221, 221, 221);
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1), 0 8px 20px rgba(0, 0, 0, .1);
	border-radius: 16px;
	transition-duration: 600ms;
	display: block;
	margin: auto;
	margin-top: 3px;
}

.thumbnail:hover { /*  반짝 */
	transition-duration: 600ms;
	border: 1px solid rgb(139, 169, 137);
	box-shadow: rgb(192, 207, 178) 0px 0px 6px;
	cursor: pointer;
}

.thumbnail a img {
	margin-top: 10px;
	margin-bottom: 10px;
	width: 140px;
	height: 190px;
	box-shadow: rgb(37, 54, 41) 5px 5px 10px;
}

.badge {
	background-color: #8ba989;
}

.additional-info a {
	color: #49654d;
}

.glyphicon-ok {
	color: #8ba989;
}

.order-btn>li a:hover {
	color: white;
	background-color: #253629;
}
.gradient {
	background-image: url("${pageContext.request.contextPath }/resources/imgs/bookclub.jpg");
	margin-top:0px;
		background-size: cover;
	background-repeat: no-repeat;
	background-position: 30%;
	width: 100%;
/* 	background: rgb(237, 255, 245); background : radial-gradient( circle,
	rgba( 237, 255, 245, 1) 0%, rgba( 231, 249, 215, 1) 100%); */
	overflow: hidden;
	height: 300px;
/* 	background: radial-gradient(circle, rgba(237, 255, 245, 1) 0%,
		rgba(231, 249, 215, 1) 100%); */
}



.jumbotron div {
	height: 100%;
}

h2, h5 {
	color: #ecece9;
	text-align: center;
	font-size: 2em;
	margin-top: 30px;
	text-shadow: 1px 1px black;
}
.container-fluid .jumbotron {
	background-color: rgba(0, 0, 0, 0.3);
	padding-top: 30px;
	padding-bottom: 75px;
	border-radius: 0px;
}
@media ( max-width :7600px) {
	.gradient {height: 240px;}
	h2, h5 {
	font-size: 1.6em;
}
}
</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row">
	<div class="gradient bottom-line">
		<div class="jumbotron">
		<h5>함께하는 독서라이프<br/> 북클럽에서 함께 나누는 건 어때요?</h5>
		<h2><strong>무엇이든 궁금한 건 북클럽에 물어보세요!</strong></h2>
		</div>

	</div>
	</div>
	<div class="row">
		<!--************ search **********-->
		<div class="col-md-2">&nbsp;</div>
		<div class="col-xs-12 col-md-8">
			<form action="#" class="search-form form-inline">
				<div class="input-search input-group">
					<input type="text" class="" placeholder="책 제목을 입력해보세요." name="search"
						id="search" /> <span class="input-group-btn" id="input_group_btn">
						<button type="submit" id="search-btn"
							class="btn btn-default btn-md" disabled="disabled">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</span>
				</div>
			</form>
			<ul class="pager order-btn">
					<li><a id="orderByNoGoal" class="not-ok" href="#">미독</a></li>
					<li><a id="orderByMyBook" class="not-ok" href="#">미완독</a></li>
					<li><a id="orderByFinished" class="not-ok" href="#">완독</a></li>
					<li><a id="orderByABC" class="not-ok" href="#">가나다</a></li>
					<li><a id="orderByCBA" class="not-ok" href="#">가나다역순</a></li>
			</ul>
		</div>
		<div class="col-md-2"></div>

		<div class="bottom-line col-xs-12 col-md-12"></div>

	</div>
	<div class="row club-books">
		<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8 bookclub-contents">
		<div class="not-found">
			<strong>검색 결과가 없습니다. </strong>
		</div>
			<!--**********post start**********-->
			<c:forEach items="${cntReaders }" var="bean">
				<div id="${bean.book_bid}" class="col-xs-12 col-md-4 thumb-box" data-aos="fade-down">
					<div class="thumbnail">
						<a href="${pageContext.request.contextPath }/club/list/${bean.book_bid}"> 
							<c:choose>
								<c:when test="${'' ne bean.coverurl }">
									<img src="${bean.coverurl }" />
								</c:when>
								<c:when test="${'' eq bean.coverurl }">
									<img
										src="${pageContext.request.contextPath }/resources/imgs/no-image.png" />
								</c:when>
							</c:choose>
						</a>
						<div class="caption">
							<p class="book-title" title="${bean.title }"  data-toggle="tooltip" data-placement="bottom">${bean.title }</p>
							<ul class="pager additional-info">
								<li><a>함께 읽는 사람 <span class="badge">${bean.readers }명</span></a></li>

							</ul>

						</div>
					</div>
				</div>
			

			</c:forEach>

			<!--**********post end**********-->
		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>