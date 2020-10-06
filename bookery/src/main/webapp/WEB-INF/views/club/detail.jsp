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
		
		
		$('.input-reply').hide();
		var btn_reply_cnt = 0;
		$('.btn-reply').click(function(){
			btn_reply_cnt++;
			if(btn_reply_cnt%2 != 0){
				$('.input-reply').show();
			}else{
				$('.input-reply').hide();
			}
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
		
	/* 	
		$('.panel-post .panel-body').eq(0).css({'background-image':'url("${pageContext.request.contextPath}/resources/imgs/old-unfolded-book-lying-on-the-table-yellow-paper-pages-plenty-of-space-for-text-or-photo.jpg")',
			'background-repeat':'no-repeat',
			'background-size':'100%'
			}); */
			
			
			/* 수정 삭제 버튼 글쓴이만 볼 수 있게. */
			var session_user_id = '${user.id}';
			var writer_id = '${club.user_id}';
			if(session_user_id == writer_id){
				$('.btn-edit,.btn-delete').show();				
			}else{
				$('.btn-edit,.btn-delete').hide();				
			}
			/* 댓글 수정삭제버튼 댓글작성자만 볼 수 있게 */
			$('.panel-reply').each(function(){
				var reply_writer = $(this).find('input').val()
				if(reply_writer==session_user_id){
					$(this).find('.reply-edit,.reply-delete').show();
				}else{
					$(this).find('.reply-edit,.reply-delete').hide();
				}//if
				
			});//reply each
			
			/* 모든 댓글 날짜 substring으로 다듬기 */
			$('.reply-updatetime').each(function(){
				$(this).text($(this).text().substring(0,19));
			});//reply each
	
			/* 게시글 수정버튼 수정 후 디테일로 이동*/
			$('.btn-edit').on('click',function(){
				location.href="${pageContext.request.contextPath}/club/edit/${club.id}/${club.book_bid}";
			});//click
			
			/* 게시글 삭제버튼. 삭제후 리스트로 이동 */
			$('.btn-delete').on('click',function(){
				
				swal({
					  title:'삭제',
					  text: "정말 삭제하시겠습니까?",
					  buttons: {
						cancel: "취소", //취소버튼 false
					    confirm:{
					    	text:"삭제",
					    	value:true
					    }
					  },
					  icon:'warning'
				}).then((value) => {	//swal 버튼을 누른 다음 수행된다.
					if(value){
						$.ajax({
							url:'${pageContext.request.contextPath}/club/delete',
							type:'DELETE',
							data:'id=${club.id}&book_bid=${club.book_bid}',
							success:function(data){},
							error:function(){}
						});				
					}//if
				});//swal
			});
			
	
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
.reply-btn{
	text-align: right;
}
.reply-updatetime{
	color:#747474;
}
.recomend{
	text-align: right;
	
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

				<!-- 글 내용  -->
				<div class="panel panel-default panel-post">
					<div class="panel-body panel-title">
						<span class="lead">${club.title }</span><br/>
					</div>
					<div class="panel-body panel-nickname">
						<span class="user_id">${club.nickname}</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="updatetime"></span>
					</div>
				<!-- 	<div class="bottom-line"></div> -->
					<div class="panel-body post-content">${club.content}</div>
				</div>
				
				<div class="div-btn">
				<button class="btn btn-default btn-reply">댓글달기</button>
				<button class="btn btn-default btn-edit">수정</button>
				<button class="btn btn-default btn-delete">삭제</button>
				</div>

				<!-- 댓글입력 -->
				<div class="input-reply">
				<div class="bottom-line"></div>
				<div class="">
					<form id="form-reply" class="form-horizontal"
						action="${pageContext.request.contextPath }/club/reply"
						method="post">

						<div class="form-group">
							<label for="content" class="col-sm-2 control-label"
								id="session_user_id">${user.nickname }</label>
							<div class="col-sm-10">
								<textarea class="form-control" rows="2" name="content"
									id="content"></textarea>
							</div>
						</div>

						<input type="hidden" name="book_bid" value="${club.book_bid }" />
						<input type="hidden" name="depth" value="1" /> <input
							type="hidden" name="ref" value="${club.id }" />

						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-default">등록</button>
							</div>
						</div>
					</form>
				</div>
				<div class="bottom-line"></div></div>


				<!-- <div class="panel panel-default panel-reply">
					<div class="panel-body">reply</div>
					<div class="panel-body">book_bid, club-id, depth=1인 row select // orderby createtime desc</div>
				</div> -->
				
				<!-- 댓글 목록 -->
				<c:forEach items="${replylist }" var="bean" begin="0" end="9">
				
				<div class="panel panel-default panel-reply">
					<input type="hidden" id="user_id" name ="user_id" value="${bean.user_id}"/>
					<div class="panel-body">${bean.nickname}&nbsp;&nbsp;<small><span class="reply-updatetime">${bean.updatetime }</span></small>
						<!-- <button class="btn btn-default btn-sm"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;4</button> -->
					</div>
					<div class="panel-body">${bean.content}</div>
					<div class="panel-body reply-btn">
					<button class="btn btn-default reply-edit btn-sm">수정</button>
					<button class="btn btn-default reply-delete btn-sm">삭제</button>
					<button class="btn btn-default reply-recommend btn-sm"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;44</button>
					<!-- <button class="btn btn-default reply-recommend"><span class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span></button> -->
					</div>
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