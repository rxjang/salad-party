<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Bookery</title>
<%@ include file="../template/head.jspf"%>
<script type="text/javascript">
var date = "${club.updatetime}";
var recommendChkList = "${recommendChk}";
var session_user_id = '${user.id}';

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

	/* document ready */
	$(function() {
			
		//내가 추천한 글번호목록.
		//댓글의 추천버튼 체크
		recommendChkList = JSON.parse(recommendChkList);
		recommendChkList.forEach(function(ele){
			$('.panel-reply').each(function(idx,reply){
				if($(reply).find('#reply_id').val() == ele){
					$(reply).find('.reply-recommend').css({'color':'#8ba989','border':'1px solid #8ba989'})//해당 댓글의 추천버튼 녹색
													 .addClass('recommend-down').removeClass('recommend-up');
				}
			});//each
		});//foreach
		
		//본문글 추천 버튼 체크
		var club_id = '${club.id}';
		recommendChkList.forEach(function(ele){
			if( Number(club_id) == ele){
					$('.post-recommend').css({'color':'#8ba989','border':'1px solid #8ba989'})//해당 댓글의 추천버튼 녹색
													 .addClass('recommend-down').removeClass('recommend-up');
				}
		});//foreach
		// {   'key'  :  [{} {} {} {} {}]     } 
		
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
		//	var session_user_id = '${user.id}';
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
				$(this).html($(this).text().substring(0,19)+'&nbsp;');
			});//reply each
	
			/* 게시글 수정버튼 수정 후 디테일로 이동*/
			$('.btn-edit').on('click',function(){
				location.href="${pageContext.request.contextPath}/club/edit/${club.id}/${club.book_bid}";
			});//click
			
			/* 게시글 삭제버튼. 삭제후 리스트로 이동 */
			$('.btn-delete').click(function(){
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
						$('.delete-post').submit();
					}//if
				});//swal
				
				return false;
			});
			
			$('.panel-reply').each(function(idx,ele){
				$(ele).find('.reply-delete').click(function(){
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
							$(ele).find('.delete-reply').submit();
						}//if
					});//swal
					return false;
				});//swal
			});//each
			
			/* 수정폼에 이전 내용표시 */
			$('.panel-reply-edit').each(function(idx,ele){
				var reply_content = $(ele).find('textarea').val().replace(/(<br\/>)/g, '');
				$(ele).find('textarea').val(reply_content);
			});//each
			
			/* 댓글 수정버튼  */
			
			$('.panel-reply').each(function(idx,ele){
				$(ele).find('.reply-edit').click(function(){
					$(ele).find('.panel-reply-edit').show();
					$(ele).find('.reply-content').hide();
					$(ele).find('.reply-btn').hide();
				});//click
			});//each
			
			/* 댓글별 추천 버튼 이벤트. 추천&추천취소 */
			$('.panel-reply').each(function(idx,ele){
				
				$(ele).find('.reply-recommend').on('click',function(){
					if($(this).attr('class').includes('recommend-up',0)){
						$.ajax({
							url:'${pageContext.request.contextPath}/club/reply/recommend',
							method:'get',
							data:'id='+$(ele).find('#reply_id').val(),
							dataType:'json',
							success:function(data){
								console.log(data.success);
								console.log(data.num);
								$(ele).find('.cnt-recommend').text(data.num);
								$(ele).find('.reply-recommend').css({'color':'#8ba989','border':'1px solid #8ba989'})
															   .addClass('recommend-down').removeClass('recommend-up');
							},//success
							error:function(){}//error
						});//ajax
					}else if($(this).attr('class').includes('recommend-down',0)){
						$.ajax({
							url:'${pageContext.request.contextPath}/club/reply/recommenddown',
							method:'get',
							data:'id='+$(ele).find('#reply_id').val(),
							dataType:'json',
							success:function(data){
								console.log(data.success);
								console.log(data.num);
								$(ele).find('.cnt-recommend').text(data.num);
								$(ele).find('.reply-recommend').css({'color':'black','border':'1px solid #ccc'})
															   .removeClass('recommend_down').addClass('recommend-up');
							},//success
							error:function(){}//error
						});//ajax
					}//if
				});//click
			});//each
			
			
			/* 본문 글 추천버튼 */
			$('.post-recommend').click(function(){
				
				if($(this).attr('class').includes('recommend-up',0)){
					$.ajax({
						url:'${pageContext.request.contextPath}/club/recommend',
						method:'get',
						data:'id=${club.id}',
						dataType:'json',
						success:function(data){
							console.log(data.success);
							console.log(data.num);
							$('.post-recommend').find('.cnt-recommend').text(data.num);
							$('.post-recommend').css({'color':'#8ba989','border':'1px solid #8ba989'})
														   .addClass('recommend-down').removeClass('recommend-up');
						},//success
						error:function(){
							swal('error');
						}//error
					});//ajax
				}else if($(this).attr('class').includes('recommend-down',0)){
					$.ajax({
						url:'${pageContext.request.contextPath}/club/recommenddown',
						method:'get',
						data:'id=${club.id}',
						dataType:'json',
						success:function(data){
							console.log(data.success);
							console.log(data.num);
							$('.post-recommend').find('.cnt-recommend').text(data.num);
							$('.post-recommend').css({'color':'black','border':'1px solid #ccc'})
														   .removeClass('recommend_down').addClass('recommend-up');
						},//success
						error:function(){
							swal('error');
						}//error
					});//ajax
				}//if
				
			});//click
			
			
			
			/* 베스트 댓글 */
				var items = $('.panel-reply .cnt-recommend').get(); 
				items.sort(function(a,b){ 
					  var keyA = $(a).text();
					  var keyB = $(b).text();
					  if (keyB > keyA) return -1;
					  if (keyA > keyB) return 1;
					  return 0;
				});	
				$.each(items, function(idx, ele){
					console.log($(ele).text().trim());
				
					var best_reply = $(ele).parent().parent().parent().clone();
					best_reply.removeAttr('id');
					if($(ele).text().trim()>=10){
							best_reply.find('.reply-updatetime').after($('<span class="label label-danger">BEST</span>'));
							best_reply.css('background-color','#ecece9');
							var move_reply = $('<a href="#'+$(ele).parent().parent().parent().attr('id')+'">&nbsp;[이동]&nbsp;</a>')
							best_reply.find('.reply-btn').prepend(move_reply);
							
							$('.div-bestreply').append(best_reply);		
					}
				});//each

	});//ready
	
</script>
<style type="text/css">

.jumbotron{
	background-color: white;
	padding-top: 0px;
	padding-bottom: 0px;
}
.panel-post{
	box-shadow: 0 2px 8px rgba(0,0,0,.1), 0 8px 10px rgba(0,0,0,.1);
	border-radius: 16px;
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
.delete-form,.panel-reply-edit{
	display:none;
}
.post-recommend-div{
	text-align: center;
}
small span{
	color:#747474;
}
.panel-reply{
	border-left:0px;
	border-right:0px;
	border-radius: 16px;
	-webkit-box-shadow: 0 0px 0px rgba(0,0,0,.05);
		box-shadow: 0 2px 8px rgba(0,0,0,.1), 0 8px 20px rgba(0,0,0,.1);
}
.badge{
	color:white;
	background-color: #c0cfb2;
}
.btn-reply,.submit-reply{
	color:white;
	background-color: #c0cfb2;
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
					<small>${book.writer }</small><br/>
					<small>${book.publisher }</small>
				</div>
			</div>
		</div>

		<div class="bottom-line col-xs-12 col-md-12"></div>
	</div>
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8 side-line">

			<div class="jumbotron">

				<!-- 글 내용  -->
				<div class="panel panel-default panel-post">
					<div class="panel-body panel-title">
						<span class="lead">${club.title }</span><br/>
						<small><span class="user_id">${club.nickname}</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class="updatetime"></span></small>
					</div>
					<div class="bottom-line"></div>
					<div class="panel-body post-content">${club.content}</div>

					<!-- 추천버튼 -->
					<div class="panel-body post-recommend-div">
					<button class="btn btn-default post-recommend recommend-up btn-sm"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
					<span class="cnt-recommend">&nbsp;<c:if test="${not empty club.num}">${club.num}</c:if>
					<c:if test="${empty club.num}">0</c:if></span></button>
					</div>
					
				</div>
				
				<div class="div-btn">
				<button class="btn btn-default btn-reply">댓글달기</button>
				<button class="btn btn-default" onclick="history.back();">뒤로가기</button>
				<button class="btn btn-default btn-edit">수정</button>
				<button class="btn btn-default btn-delete">삭제</button>
				<form class="delete-form delete-post" action="${pageContext.request.contextPath}/club/delete" method="post">
					<input type="hidden" name="_method" value="DELETE"/>
					<input type="hidden" name="book_bid" value="${club.book_bid }" />
					<input type="hidden" name="id" value="${club.id }"/>
		 			<button type="submit" class="btn btn-default">삭제</button>
				</form>
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
								<button type="submit" class="btn btn-default submit-reply">등록</button>
							</div>
						</div>
					</form>
				</div>
				<div class="bottom-line"></div></div>


				<!-- <div class="panel panel-default panel-reply">
					<div class="panel-body">reply</div>
					<div class="panel-body">book_bid, club-id, depth=1인 row select // orderby createtime desc</div>
				</div> -->
			</div>
		</div>
	</div>
	<div class="row">
	<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8">
			<div class="jumbotron">
				<a href="#">Comment <span class="badge">${fn:length(replylist)}</span></a>
			</div>
			<div class="jumbotron div-bestreply">
			
			</div>
			<br/>
		</div>
	</div>
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8 div-reply">
			<div class="jumbotron div-reply">
			<!-- 댓글 목록 -->
				<c:forEach items="${replylist }" var="bean">
				
				<div id="reply_${bean.id }" class="panel panel-default panel-reply">
					<input type="hidden" id="user_id" name ="user_id" value="${bean.user_id}"/>
					<div class="panel-body">${bean.nickname}&nbsp;&nbsp;<small><span class="reply-updatetime">${bean.updatetime }</span></small>
						<!-- <button class="btn btn-default btn-sm"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;4</button> -->
					</div>
					<div class="panel-body reply-content">${bean.content}</div>
					<!-- 댓글 수정 폼 -->
					<div class="panel-body panel-reply-edit">
						<form id="form-reply" class="form-horizontal"
						action="${pageContext.request.contextPath }/club/reply/update"
						method="post">
						<input type="hidden" name="_method" value="PUT" />

						<div class="form-group">
							<div class="col-sm-10">
								<textarea class="form-control" rows="2" name="content"
									class="reply-edit-content">${bean.content}</textarea>
							</div>
						</div>
							<input type="hidden" name="id" value="${bean.id }"/>
							<input type="hidden" name="post_id" value="${club.id }"/>
						<div class="form-group">
							<div class="col-sm-10">
								<button type="submit" class="btn btn-default">수정</button>
							</div>
						</div>
					</form>					
					</div>
					
					<div class="panel-body reply-btn">
					<button class="btn btn-default reply-edit btn-sm">수정</button>
					<button class="btn btn-default reply-delete btn-sm">삭제</button>
					<!-- 댓글 삭제폼 -->
					<form action="${pageContext.request.contextPath }/club/reply/delete" method="post" class="delete-form delete-reply">
						<input type="hidden" name="_method" value="DELETE"/>
						<input type="hidden" name="book_bid" value="${bean.book_bid }" />
						<input type="hidden" name="id" id="reply_id" value="${bean.id }"/>
						<input type="hidden" name="post_id" value="${club.id }"/>
		 				<button type="submit" class="btn btn-default">삭제</button>
					</form>
					
					<button class="btn btn-default reply-recommend recommend-up btn-sm"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
					<span class="cnt-recommend">&nbsp;<c:if test="${not empty bean.num}">${bean.num}</c:if>
					<c:if test="${empty bean.num}">0</c:if></span></button>
					</div>
				</div>
				
				</c:forEach>
		
			</div>
		</div>
	</div>
	<!--**********content end**********-->
	<%@ include file="../template/footer.jspf"%>
</body>
</html>