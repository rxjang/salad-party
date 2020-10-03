<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
	var date = "${bean.updatetime }";
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
			updatetime = new Date(new Date(date).toLocaleString("en-US", {timeZone: "Asia/Seoul"})).format('a/p hh:mm');
		}else{
			updatetime = new Date(new Date(date).toLocaleString("en-US", {timeZone: "Asia/Seoul"})).format('yyyy-MM-dd');
		}
		return updatetime;
	}
	
	$(function() {
		console.log(date);
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
		if(cnt_posts<9){
			$('.more-posts').hide();
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
					var result = data.key;
				
					console.log(result.length);
					if(result.length<10){
						$('.more-posts').hide();
					}
					/* 더보기 누를 때 마다 검색결과를 현재결과 아래 append한다. */
					var posts='';
					for(var i = 0 ; i < result.length; i++){
						//console.log('result = ',result[i].id);
						posts += '<div class="panel panel-default pannel-post">'
						posts += '<div class="panel-body"><a href="${pageContext.request.contextPath }/club/detail/'+result[i].id+'"><span class="lead">'+result[i].title+'</span></a></div>'
						posts += '<div class="panel-body"><span class="user_id"> 유저번호 '+result[i].user_id+'</span>';
						posts += '&nbsp;|&nbsp;<span class="wrote-day">'+todayToTime(result[i].updatetime)+'</span></div>';
						posts += '</div><br/>';
					}
						$('.div-post').append(posts);
					
				},//success
				error:function(){
					swal('error');
				}
			});//ajax
		});//더보기 클릭
		
		/* 리스트 날짜 오늘이면 시간으로 바꾸기 */
		$('.update-day').each(function(){
			console.log($(this).text());
			console.log(new Date($(this).text()).toLocaleString("ko-KR", {timeZone: "Asia/Seoul"}));
			$(this).text(todayToTime($(this).text()));
		});
		
	});//ready
	
</script>
<style type="text/css">

#add{
	float: right;
}

.pannel-post { /*   */
	border: 1px solid rgb(221, 221, 221);
	border-radius: 5px;
	transition-duration: 600ms;
	display: block;
	margin: auto;
	margin-top: 3px;
}
.pannel-post:hover { /*  반짝 */
	transition-duration: 600ms;
	border: 1px solid rgb(139, 169, 137);
	box-shadow: rgb(192, 207, 178) 0px 0px 6px;
	cursor: pointer;
}
#search{
	margin-right:10px;
	width:300px;
}
.form-group{
	width:100%;
}
.form-group input,.form-group button{
	float:left;
}
.div-search{
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<%@ include file="../template/menu.jspf"%>
	<!-- **********content start**********-->
	<div class="row">
		<div class="col-md-2">&nbsp;</div>
		<div class="col-md-8 col-xs-12">
			<h3>
				<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
				북클럽
			</h3>
			<br />
				<small class="lead">${book.title }</small><br/>
				<small>${listSize }건의 게시물이 있습니다.</small>
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
			<form class="form-inline" action="${pageContext.request.contextPath }/club/list/${book.bid }" method="get">
				<div class="form-group">
					<input type="text" class="form-control" id="search"	name="search" placeholder="제목을 입력하세요."/>
					<button type="submit" class="btn btn-default">검색</button>
				</div>
			</form>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="row">
	<div class="col-md-3"></div>
	<div class="col-xs-12 col-md-6  div-post">
	
		<c:forEach items="${list }" var="bean" begin="0" end="9">
				<div class="panel panel-default pannel-post">
					<div class="panel-body"><a href="${pageContext.request.contextPath }/club/detail/${bean.id}"><span class="lead">${bean.title }</span></a></div>
					<div class="panel-body"><span class="user_id"> 유저번호 ${bean.user_id }</span> &nbsp;|&nbsp;<span class="update-day">${bean.updatetime }</span></div>
				</div>
				<br/>
		</c:forEach>
	
	</div>
	<div class="col-md-3"></div>
	</div>



	<div class="row">
	<div class="col-md-3"></div>
	<div class="col-xs-12 col-md-6">
				<br/>
				<br/>
				<button class="btn btn-default more-posts">더보기</button>
				<button class="btn btn-default btn-top">Top</button>
					<a href="#" id="add" class="btn btn-default" role="button">글쓰기</a>
	</div>
	<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>