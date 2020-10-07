<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">

var studyingbooklist = '${studyingbooklist}';
	$(function() {
		//console.log(JSON.parse(studyingbooklist));
		aos();
		$('form').on('submit',function(){
			return false;
		});//submit
		
		$('#search').on('keyup',function(){
			var keyword = $(this).val();
			console.log(keyword);
			$('.thumb-box').hide();
			$('.thumb-box:contains("'+keyword+'")').show();
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
			
		/* 미완독 v_study list에서 book_bid만 배열에 저장 */
		var arr = [];
		var studyingbooks = JSON.parse(studyingbooklist).key;
		studyingbooks.forEach(function(ele){
			arr.push(ele.book_bid);
		});//forEach
		console.log(arr);
		
		/* 내책만보기 */
		$('#orderByMyBook').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');

			if($('#orderByABC').attr('class').includes('ok',0)){
				$('#orderByABC').addClass('not-ok').removeClass('ok');
				$('#orderByABC .glyphicon-ok').remove();
			}
			if($('#orderByCBA').attr('class').includes('ok',0)){
				$('#orderByCBA').addClass('not-ok').removeClass('ok');
				$('#orderByCBA .glyphicon-ok').remove();
			}
			
			if($(this).attr('class').includes('not-ok',0)){
				console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				
				var items = $('.thumb-box').get(); 
				$.each(items, function(idx, ele){
					if(arr.includes(Number($(ele).attr('id')))){
							console.log('same');
							$(ele).show();
					}else if(!arr.includes(Number($(ele).attr('id')))){
							$(ele).hide();
					}
				});
				aos();
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('glyphicon-ok').remove();
				location.reload();
			}//if
		});//click
		
		/* 가나다순 정렬하기 */
		$('#orderByABC').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			
			if($('#orderByMyBook').attr('class').includes('ok',0)){
				$('#orderByMyBook').addClass('not-ok').removeClass('ok');
				$('#orderByMyBook .glyphicon-ok').remove();
			}
			if($('#orderByCBA').attr('class').includes('ok',0)){
				$('#orderByCBA').addClass('not-ok').removeClass('ok');
				$('#orderByCBA .glyphicon-ok').remove();
			}
			
			
			if($(this).attr('class').includes('not-ok',0)){
				console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				
				var items = $('.thumb-box .book-title').get(); 
				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	
				$.each(items, function(idx, ele){
					$('.bookclub-contents').append($(ele).parent().parent().parent());
				});
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('glyphicon-ok').remove();
				location.reload();
			}//if
		});//click
		
		/* 역순 정렬하기 */
		$('#orderByCBA').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			
			if($('#orderByMyBook').attr('class').includes('ok',0)){
				$('#orderByMyBook').addClass('not-ok').removeClass('ok');
				$('#orderByMyBook .glyphicon-ok').remove();
			}
			
			if($('#orderByABC').attr('class').includes('ok',0)){
				$('#orderByABC').addClass('not-ok').removeClass('ok');
				$('#orderByABC .glyphicon-ok').remove();
			}
			
			
			if($(this).attr('class').includes('not-ok',0)){
				console.log('내책만보기');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');
				
				var items = $('.thumb-box .book-title').get(); 
				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	
				$.each(items, function(idx, ele){
					$('.bookclub-contents').prepend($(ele).parent().parent().parent());
				});
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('glyphicon-ok').remove();
				location.reload();
			}//if
		});//click
		setInterval(function() {
			var window_x = $(window).width();
			console.log(window_x);
			if(window_x < 666){
				$('#main-img').attr('src',"${pageContext.request.contextPath }/resources/imgs/bookclub-main-xs.png");				
			}else{
				$('#main-img').attr('src',"${pageContext.request.contextPath }/resources/imgs/bookclub-main.png");				
			}
		}, 500); 
		
		
	});//ready
</script>
<style type="text/css">
.side-line {
	border-left: 1px solid #e4e4e4;
	border-right: 1px solid #e4e4e4;
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
.thumb-box{
/* 	width:300px;
*/
	height: 350px; 
	margin-bottom:50px;
}
.thumbnail { /*   */
	text-align:center;
	border: 1px solid rgb(221, 221, 221);
	box-shadow: 0 2px 8px rgba(0,0,0,.1), 0 8px 20px rgba(0,0,0,.1);
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
.thumbnail a img{
	margin-top:10px;
	margin-bottom:10px;
	width:140px;
	height:190px;
	box-shadow:rgb(37, 54, 41) 5px 5px 10px;
}
.badge{
	background-color: #8ba989;
}
.additional-info a{
	color:#49654d;
}
.glyphicon-ok{
	color:#8ba989;
}
.order-btn>li a:hover{
	color:white;
	background-color: #253629;
}
.jumbotron{
	background-color: #ecece9;
	z-index:-1000;
	height: 140px;
	padding: 15px;
}
.jumbotron img{
	display: block;
	margin:auto;
	line-height:30px;
	size:auto;
}
@media (max-width:666px) {
	.jumbotron{
		padding: 7px;
	}
}

</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row">
		<div class="col-md-2">&nbsp;</div>
		<div class="col-md-8 col-xs-12">
		</div>
	</div>
	<div class="jumbotron">
		<img id = "main-img" alt="" src="">

	</div>
	<div class="row">
		<!--************ search **********-->
		<div class="col-md-3">&nbsp;</div>
		<div class="col-xs-12 col-md-6">
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
					<li><a id="orderByMyBook" class="not-ok" href="#">내책만보기</a></li>
					<li><a id="orderByStar" class="not-ok" href="#">평점(미구현)</a></li>
					<li><a id="orderByABC" class="not-ok" href="#">가나다</a></li>
					<li><a id="orderByCBA" class="not-ok" href="#">가나다역순</a></li>
			</ul>
		</div>
		<div class="col-md-3"></div>

		<div class="bottom-line col-xs-12 col-md-12"></div>

	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6 bookclub-contents">
			<!--**********post start**********-->
			<c:forEach items="${cntReaders }" var="bean" >
				<div id="${bean.book_bid}" class="col-xs-12 col-md-6 thumb-box" data-aos="fade-down">
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
							<p class="book-title">${bean.title }</p>
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