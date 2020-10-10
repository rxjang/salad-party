<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	var start = 0;

	//오늘 날짜 yyyy-mm-dd
	function getRecentDate(){
	    var dt = new Date();
	    var recentYear = dt.getFullYear();
	    var recentMonth = dt.getMonth() + 1;
	    var recentDay = dt.getDate();
	 	
	    if(recentMonth < 10) recentMonth = "0" + recentMonth;
	    if(recentDay < 10) recentDay = "0" + recentDay;
	    return recentYear + "-" + recentMonth + "-" + recentDay;
	}
	/* 오늘 날짜면 시간으로 변환  */
	function todayToTime(date){
		var today = getRecentDate();
		var update =date.substring(0,10);
		var updatetime;
		if(today == update){
			updatetime = new Date(date).format('a/p hh:mm');
		}else{
			updatetime = new Date(date).format('yyyy-MM-dd');
		}
		return updatetime;
	}
	
	$(function() {
		aos();
		console.log(new Date().format('HH:mm:ss'));
		var url_here = window.location.href;
		//	http://localhost:8085/bookery/club/list/16687560
		//var bid = url_here.substring(url_here.lastIndexOf('/') + 1,url_here.indexOf('?'));
		var url_search;
		if(url_here.includes('search',0)){
			url_search = url_here.substring(url_here.indexOf('search=')+7);
		}else{
				url_search = '';
		}
		
		
		/* 글쓰기 */
		$('#add').attr('href',
				'${pageContext.request.contextPath }/club/add/${book.bid}');

		
		
		/* 게시글 박스 클릭 시 Detail로 이동 */
		$('.pannel-post').each(function(idx,ele){
			var aHref = $(this).children().eq(0).find('a').attr('href');
			$(this).on('click',function(){
				location.href=aHref;
			})//click 
		});//each
			
		/* 제일 위로 */
		$('.btn-top').click(function(){
			$(document).scrollTop(0);			
		});//top버튼 클릭
		
		/* 검색결과가 10개미만이면 더보기 버튼 숨김 */
		var cnt_posts=0;
		$('.pannel-post').each(function(){
			cnt_posts++;
		});//each
		if(cnt_posts<9 && cnt_posts>0){
			$('.more-posts').hide();
		}else if(cnt_posts == 0){   //게시물이 1건도 없을 때 기본으로 공지사항 1개 생성.
			$('.more-posts').hide();
			var post = '';
				post += '<div class="panel panel-default pannel-post">'
				post += '<div class="panel-body"><span class="lead">책과 관련된 주제로 자유롭게 토론하세요.</span></div>'
				post += '<div class="panel-body"><span class="user_id"> bookery </span>';
				post += '&nbsp;|&nbsp;<span class="wrote-day">공지사항</span></div>';
				post += '</div><br/>';
				$('.div-post').append(post);
		}	
		
		/* 더보기 */
		$('.more-posts').click(function(){
			start = start+10;
			console.log('start',start);
			var param = 'book_bid=${book.bid}&start='+start+'&search='+url_search;
			console.log(param);
			$.ajax('${pageContext.request.contextPath}/club/list/more',{
				type:'get',
				data:param,
				dataType:'json',
				success:function(data){
					var result =data.key;
					console.log(data);
					console.log(result.length);
					if(result.length<10){
						$('.more-posts').hide();
					}
					/* 더보기 누를 때 마다 검색결과를 현재결과 아래 append한다. */
					var posts='';
					for(var i = 0 ; i < result.length; i++){
						//console.log('result = ',result[i].id);
						posts += '<div class="panel panel-default pannel-post" data-aos="fade-up">'
						posts += '<div class="panel-body"><a href="${pageContext.request.contextPath }/club/detail/'+result[i].id+'"><span class="lead">'+result[i].title+'</span></a></div>'
						posts += '<div class="panel-body"><span class="user_id">'+result[i].nickname+'</span>';
						posts += '&nbsp;|&nbsp;<span class="wrote-day">'+todayToTime(result[i].updatetime)+'</span>';
						posts += '&nbsp;|&nbsp;<span class="cnt-reply"> 댓글&nbsp;'+result[i].reply+'개</span>&nbsp;|&nbsp;<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;<span class="cnt-recommend">'+result[i].num+'</span>';                                                     
						posts += '</div></div>';
					}
						$('.div-post').append(posts);
						aos();
						$('.pannel-post').each(function(idx,ele){
							var aHref = $(this).children().eq(0).find('a').attr('href');
							$(this).on('click',function(){
								location.href=aHref;
							})//click 
						});//each
				},//success
				error:function(){
					swal('error');
				}
			});//ajax
		});//더보기 클릭
		
		/* 리스트 날짜 오늘이면 시간으로 바꾸기 */
		$('.update-day').each(function(){
			//console.log($(this).text());
		//	console.log(new Date($(this).text()).toLocaleString("ko-KR", {timeZone: "Asia/Seoul"}));
			$(this).text(todayToTime($(this).text()));
		});
		
		
		/* 추천순 정렬 */
		$('#orderByRecommend').click(function(){
			
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			
			if($('#orderByReply').attr('class').includes('ok',0)){
				$('#orderByReply').addClass('not-ok').removeClass('ok');
				$('#orderByReply .glyphicon-ok').remove();
			}
			
			if($(this).attr('class').includes('not-ok',0)){
				console.log('추천순정렬');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');

				var items = $('.pannel-post .cnt-recommend').get(); 
				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	
				$.each(items, function(idx, ele){
					$('.div-post').prepend($(ele).parent().parent());
				});
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('glyphicon-ok').remove();
				location.reload();
			}
		});//click
		
		/* 댓글순 정렬 */
		$('#orderByReply').click(function(){
			var okIcon = $('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>');
			
			if($('#orderByRecommend').attr('class').includes('ok',0)){
				$('#orderByRecommend').addClass('not-ok').removeClass('ok');
				$('#orderByRecommend .glyphicon-ok').remove();
			}
			
			if($(this).attr('class').includes('not-ok',0)){
				console.log('댓글순정렬');
				$(this).append(okIcon);
				$(this).addClass('ok').removeClass('not-ok');

				var items = $('.pannel-post .cnt-reply').get(); 
				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	
				$.each(items, function(idx, ele){
					$('.div-post').prepend($(ele).parent().parent());
				});
			}else if($(this).attr('class').includes('ok',0)){
				$(this).addClass('not-ok').removeClass('ok');
				$(this).find('glyphicon-ok').remove();
				location.reload();
			}
		});//click
		
		
	});//ready
	
</script>
<style type="text/css">

#add{
	background-color:#c0cfb2;
	color:white;
	float: right;
}

.pannel-post { /*   */
	border: 1px solid rgb(221, 221, 221);
	box-shadow: 0 2px 8px rgba(0,0,0,.1), 0 8px 20px rgba(0,0,0,.1);
	border-radius: 16px;
	transition-duration: 600ms;
	display: block;
	margin: auto;
	margin-top: 3px;
	margin-bottom:30px;
}
.pannel-post:hover { /*  반짝 */
	transition-duration: 600ms;
	border: 1px solid rgb(139, 169, 137);
	box-shadow: rgb(192, 207, 178) 0px 0px 6px;
	cursor: pointer;
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


.glyphicon-ok{
	color:#8ba989;
}
.order-btn>li a:hover{
	color:white;
	background-color: #253629;
}
.media-body{
	vertical-align: middle;
}
.media-object{
	margin:5px 5px 5px 5px;
	width:4em;
	box-shadow: 0 1px 5px rgba(0,0,0,.1), 0 2px 5px rgba(0,0,0,.1);
}
</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row">
		<div class="col-md-2">&nbsp;</div>
		<div class="col-md-8 col-xs-12">
			<br />
			<div class="media">
				<div class="media-left media-middle">
					<a href="${pageContext.request.contextPath }/find/book/${book.bid}"> <img class="media-object" src="${book.coverurl }" alt="...">
					</a>
				</div>
				<div class="media-body">
					<h4 class="media-heading">${book.title }</h4>
					<small>${listSize }건의 게시물이 있습니다.</small>
				</div>
			</div>
		</div>

		<div class="bottom-line col-xs-12 col-md-12"></div>
	</div>

	<div class="row">

		<div class="col-md-3"></div>
	

<div class="col-md-3"></div>
	</div>

	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6 div-search">
		<%-- 	<form class="form-inline" action="${pageContext.request.contextPath }/club/list/${book.bid }" method="get">
				<div class="form-group">
					<input type="text" class="form-control" id="search"	name="search" placeholder="제목을 입력하세요."/>
					<button type="submit" class="btn btn-default">검색</button>
				</div>
			</form> --%>
			<form action="${pageContext.request.contextPath }/club/list/${book.bid }" method="get" class="search-form form-inline">
				<div class="input-search input-group">
					<input type="text" class="" placeholder="책 제목을 입력해보세요." name="search"
						id="search" /> <span class="input-group-btn" id="input_group_btn">
						<button type="submit" id="search-btn"
							class="btn btn-default btn-md">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</span>
				</div>
			</form>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8">
		
				<ul class="pager order-btn">
					<li><a id="orderByRecommend" class="not-ok" href="#">추천순</a></li>
					<li><a id="orderByReply" class="not-ok" href="#">댓글순</a></li>
					<li><a href="#" id="add" class="btn btn-default" role="button">글쓰기</a></li>
				</ul>
		
		</div>
	</div>
	
	<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8  div-post">
	
		<c:forEach items="${list }" var="bean" begin="0" end="9">
				<div class="panel panel-default pannel-post" data-aos="fade-up">
					<div class="panel-body"><a href="${pageContext.request.contextPath }/club/detail/${bean.id}"><span class="lead">${bean.title }</span></a></div>
					<div class="panel-body"><span class="user_id">${bean.nickname }</span> &nbsp;|&nbsp;<span class="update-day">${bean.updatetime }</span>
					&nbsp;|&nbsp;<span class="cnt-reply"> 댓글&nbsp;${bean.reply }개</span>&nbsp;|&nbsp;
					<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;<span class="cnt-recommend">${bean.num }</span></div>
				</div>
		</c:forEach>
	
	</div>
	</div>



	<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8">
				<br/>
				<br/>
				<button class="btn btn-default more-posts">더보기</button>
				<button class="btn btn-default btn-top">Top</button>
					<!-- <a href="#" id="add" class="btn btn-default" role="button">글쓰기</a> -->
	</div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>