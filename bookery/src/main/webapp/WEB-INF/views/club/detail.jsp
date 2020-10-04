<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
var date = "${club.updatetime}";


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
		console.log(date);
		console.log(new Date().format('HH:mm:ss'));
		console.log(new Date('${club.updatetime}').format('HH:mm:ss'));
		$('.updatetime').text(todayToTime(date));
		
		
		$('#form-reply').hide();
		$('.btn-reply').click(function(){
			$('#form-reply').show();
		});//댓글달기
		$('#form-reply').on('submit',function(){
			var param = $(this).serialize();
			console.log(param);
			$.ajax({
				url:'${pageContext.request.contextPath }/club/reply',
				method:'post',
				data:param,
				success:function(data){
					$('#content').val('');//이전내용지움
					location.reload();//페이지새로고침					
				},//success
				error:function(){
					swal('error');
				}//error
			});//ajax
			return false;
		});//submit
		
	});//ready
</script>
<style type="text/css">

.jumbotron{
	background-color: white;
}
.div-btn{
	margin-bottom:20px;
}
textarea{
	resize: none;
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
			<br /><small>같은 책을 읽는 사람들과 소통할 수 있어요!</small>
		</div>

		<div class="bottom-line col-xs-12 col-md-12"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6 side-line">

			<div class="jumbotron">


				<div class="panel panel-default pannel-post">
					<div class="panel-body">
						<span class="lead">${club.title }</span>
					</div>
					<div class="panel-body">
						<span class="user_id">${club.nickname}</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="updatetime"></span>
					</div>
					<div class="bottom-line"></div>
					<div class="panel-body post-content">${club.content}</div>
				</div>
				
				<div class="div-btn">
				<button class="btn btn-default btn-reply">댓글달기</button>
				<button class="btn btn-default">수정</button>
				<button class="btn btn-default">삭제</button>
				</div>
				<div class="panel panel-default input-reply">
			<form id="form-reply" class="form-horizontal" action="${pageContext.request.contextPath }/club/reply" method="post">
	
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label" id="session_user_id">${user.nickname }</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="2" name="content" id="content"></textarea>
					</div>
				</div>
				
				<input type="hidden" name="book_bid" value="${club.book_bid }" />
				<input type="hidden" name="depth" value="1" />
				<input type="hidden" name="ref" value="${club.id }" />

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">등록</button>
					</div>
				</div>
			</form>
				</div>
								
				
				<!-- <div class="panel panel-default pannel-reply">
					<div class="panel-body">reply</div>
					<div class="panel-body">book_bid, club-id, depth=1인 row select // orderby createtime desc</div>
				</div> -->
				<c:forEach items="${replylist }" var="bean" begin="0" end="9">
				
				<div class="panel panel-default pannel-reply">
					<div class="panel-body">${bean.nickname}&nbsp;|&nbsp;${bean.updatetime }</div>
					<div class="panel-body">${bean.content}</div>
				</div>
				
				</c:forEach>



			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>