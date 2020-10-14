<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>

<script type="text/javascript">
var chapters, book_id, title, writer, publisher, pages, category, isbn, translator, title_original, publication_date, revision,imgUrl;
var description;
var img_link;
var owlItem='';
var bookMap ={};

$(function(){
console.log('DIRECT');
	if('${user}'==''){
		$('#bookclub').hide();
	}else{
		$('#bookclub').show();
	}
	//console.log(bid);
	writer=''; publisher=''; pages=''; category=''; isbn=''; translator=''; title_original=''; publication_date=''; revision='';
	img_link='';//혹시 남아있을지 모를 값들을 페이지 로딩할 때 초기화 해둔다.
	
	bid = "${book.bid}";
	title ="${book.title}"; 
	writer = "${book.writer}";
	publisher = "${book.publisher}";
	pages = "${book.pages}"; 
	category ="${book.category}"; 
	translator ="${book.translator}"; 
	title_original ="${book.titleoriginal}";
	revision = "${book.revision}";
	publication_date ="${book.publicationdate}"; 
	imgUrl = "${book.coverurl}";
	
	console.log("중복체크:${studyOverlap}");


			//bookMap Object에 정보저장. 캐러셀용
			bookMap.publisher=publisher;
			bookMap.pages=pages;
			bookMap.category=category;
			bookMap.translator=translator;
			bookMap.publication_date=publication_date;
			bookMap.revision=revision;
			owlItem = '<div class="owl-stage">';
			if(bookMap.publisher!=""){
				owlItem += '<div class="owl-item">';
				owlItem += '<p><small>출판사</small></p>';
				owlItem += '<p><span class="caro-cnt">'+bookMap.publisher+'</span></p>';
				owlItem += '<p><small>&nbsp;</small></p>';
				owlItem += '</div>';
			}
			if(bookMap.category!=""){
				owlItem += '<div class="owl-item">';
				owlItem += '<p><small>장르</small></p>';
				owlItem += '<p><span class="caro-cnt">'+bookMap.category+'</span></p>';
				owlItem += '<p><small>&nbsp;</small></p>';
				owlItem += '</div>';
			}
			if(bookMap.pages!=""){
				owlItem += '<div class="owl-item">';
				owlItem += '<p><small>길이</small></p>';
				owlItem += '<p><span class="caro-cnt">'+bookMap.pages+'</span></p>';
				owlItem += '<p><small>페이지</small></p>';
				owlItem += '</div>';
			}
			if(bookMap.translator!=""){
				owlItem += '<div class="owl-item">';
				owlItem += '<p><small>역자</small></p>';
				owlItem += '<p><span class="caro-cnt">'+bookMap.translator+'</span></p>';
				owlItem += '<p><small>&nbsp;</small></p>';
				owlItem += '</div>';
			}
			if(bookMap.publication_date!=""){
				owlItem += '<div class="owl-item">';
				owlItem += '<p><small>출간일</small></p>';
				owlItem += '<p><span class="caro-cnt">'+bookMap.publication_date.substring(0,4)+'년</span></p>';
				owlItem += '<p><small>'+bookMap.publication_date.substring(5,7)+'월'+bookMap.publication_date.substring(8,10)+'일</small></p>';
				owlItem += '</div>';
			}
			if(bookMap.revision!=""){
				owlItem += '<div class="owl-item">';
				owlItem += '<p><small>개정</small></p>';
				owlItem += '<p><span class="caro-cnt">'+bookMap.revision+'</span></p>';
				owlItem += '<p><small>&nbsp;</small></p>';
				owlItem += '</div>';
			}//
			console.log(owlItem);
			owlItem+='</div>';
			$('#owl_detail').html(owlItem);
			$('.owl-item').css('text-align','center');
			$('.owl-item small').css('color','#8f8f8f');
			$('.caro-cnt').css({'font-size':'110%','font-weight':'500'});
			
			/**********************    캐러셀    **********************/
			var cnt_item = $('.owl-item').length;
			$('#owl_detail').owlCarousel({
				items:cnt_item,
				loop : false,
				autoplay : false,
				margin : 10,
				merge : false,
				autoWidh:false,
				nav : false,
				responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
				}
			});//owl캐러셀
			//onerror="this.src='불러와야할 이미지없을때 대체될 이미지경로'"
			var book_thumbnail_html = '<div class="media-img">';
			book_thumbnail_html += '<a href="#">';
			book_thumbnail_html += '<img class="media-object" src="${book.coverurl}" onerror="this.src=\'${pageContext.request.contextPath}/resources/imgs/no-image.png\'" alt="...">';
			book_thumbnail_html += '</a>';
			book_thumbnail_html += '</div>';
			$('#book_thumbnail').html(book_thumbnail_html);
			var	book_info_html = '<div class="media"><div class="media-body">';
				book_info_html += '<h4 class="media-heading"> ${book.title}</h4>';
				book_info_html += '<p><small>저자</small> ${book.writer}</p>';
			if(title_original!=''){
				book_info_html += '<p><small>원제</small> '+title_original+'</p>';
			}
				book_info_html += '</div></div>';
			$('#book_detail').html(book_info_html).css('text-align','center');
			$('.media-img img').css({'box-shadow':'12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4)','display':'block','margin':'auto'});
			//책 썸네일 그림자색
			
			var list =$('#crawling_div').find('#tableOfContentsContent');
				/*************	네이버북스 책목차는 tableOfContentsContent아래에 있다	*************/
				var newLineText='';
				var noTagText='';
				if(list.length != 0){
					newLineText = $(list).html().replace(/<(\/br|br)([^>]*)>/gi, "\n");
					noTagText = newLineText.replace(/(<([^>]+)>)/ig, "");
				}
				//br태그를 \n으로 변경
			//	console.log(newLineText);	
				//var noTagText = newLineText.replace(/(<([^>]+)>)/ig, "");
				//모든 태그요소를 제거

				var list_group = '<ul class="list-group">';
				/* ******** 컨트롤러에서 할 일 미리 테스트 ******* */
				chapters = noTagText.split('\n');
				//개행 기준으로 목차 나누기
					for ( var i in chapters ) {
						if(chapters[i].trim()==''){
							continue;
						}else{
							list_group+='<li class="list-group-item" data-aos="fade-up">';
							list_group+=chapters[i].trim();
							list_group+='</li>';
					    //console.log(chapters[i].trim());
						}
					}
					list_group += '</ul>';
				//	$('#chapter_list').html(list_group);
					$('#chapter_list').append($('<div id="chap_list"/>').html(list_group));
					$('#chap_list').hide();//책소개 내용 처음엔 숨김
					$('.list-group-item').css('border','0px');
				/* *********************************************** */
				chapters = noTagText;//가공한 목차 정보
				//이용자가 책을 선정하면 noTagText를 컨트롤러로 보내서 목차 테이블에 저장

			/* },
			'error':function(){
				swal('error');
				}//success
			
		});//ajax */
		/* 로그인한 상태에서 스터디중인 책을 봤을 때 내서재가기 버튼을 오늘의 기록버튼으로 바꾼다. */
		console.log('중복체크${studyOverlap}');
		if('${studyOverlap}'=='0'){
			$('.mylib-btn a').eq(0).attr('id','goToday');
			$('.mylib-btn a').eq(0).text('오늘의 기록');
		}else{
			$('.mylib-btn a').eq(0).attr('id','putChapters');
			$('.mylib-btn a').eq(0).text('내서재에 담기');
		}
		$('#goToday').on('click',function(){
			location.href="${pageContext.request.contextPath}/today";
		});//오늘의 기록으로 이동
		
		
		
		$('#bookclub').on('click',function(){
			location.href='${pageContext.request.contextPath}/club/list/${bid}';			
		});//공부방 참여하기 버튼
		
		
		
		
		console.log(chapters.trim());
		/*******  body에 있는 내서재가기  ******/
		$('#putChapters').on('click', function() {
			if('${user}'==''){
				swal({
					  title: "로그인이 필요합니다.",
					  text: "로그인 페이지로 이동하시겠습니까?",
					  icon: "info",
					  buttons: {
						cancel: "머무르기", //취소버튼 false
					    confirm:{
					    	text:"로그인하러 가기",
					    	value:true
					    }
					  },
				}).then((value) => {	//value가 true이면 내서재로 이동한다.
					if(value){
							location.href = '${pageContext.request.contextPath }/account/login';
					}//if
				});//swal
				return false;
			}else{
				var parameter = 'chapters='+chapters.trim()+'&bid='+ bid+'&title='+ title+'&writer='+ writer+'&publisher='+ publisher+'&pages='+ pages+
					'&category='+ category+'&translator='+ translator+'&titleoriginal='+ title_original+'&publicationdate='+ publication_date+
					'&revision='+ revision+'&coverurl='+ imgUrl;
				//$.post('${pageContext.request.contextPath }/find/put', {
				var jparam ={
					"chapters" : chapters,
					"book":
					{
					"bid" : bid,
					"title" : title,
					"writer" : writer,
					"publisher" : publisher,
					"pages" : pages,
					"category" : category,
					"translator" : translator,
					"titleoriginal" : title_original,
					"publicationdate" : publication_date,
					"revision" : revision,
					"coverurl": imgUrl }}
					
				$.ajax({
					url:'${pageContext.request.contextPath }/find/put',
					type:'post',
					data:JSON.stringify(jparam),
					dataType:'json',
					contentType:'application/json;charset=utf-8',
					success:function(data){
						//DB에 목차정보랑 책ID를 전달함
						$('.mylib-btn a').eq(0).attr('id','goToday');
						$('.mylib-btn a').eq(0).text('오늘의 기록');
					},//success
					error:function(jqXHR, textStatus, errorThrown){
						console.log(jqXHR);
						swal("통신 에러");
					}//errro	
				});//ajax
			}//else 로그인 검사
/* 		
			XHRPOSThttp://localhost:8085/bookery/find/put
				[HTTP/1.1 400  36ms]

				    	
				    chapters	""
				    bid	"12247527"
				    title	"감자가 만났어"
				    writer	"수초이"
				    publisher	"후즈갓마이테일"
				    pages	"48"
				    category	""
				    translator	""
				    titleoriginal	""
				    publicationdate	""
				    revision	""
				    coverurl	"https://bookthumb-phinf.pstatic.net/cover/122/475/12247527.jpg?type"
				    udate	"20191011"
 */
//chapters=&bid=12247527&title=감자가 만났어&writer=수초이&publisher=후즈갓마이테일
//&pages=48&category=&translator=&titleoriginal=&publicationdate=&revision=
//&coverurl=https://bookthumb-phinf.pstatic.net/cover/122/475/12247527.jpg?type=m140&udate=20191011



			
			swal({
				  title: "내서재에 담았습니다.",
				  text: "내서재로 이동하시겠습니까?",
				  icon: "success",
				  buttons: {
					cancel: "머무르기", //취소버튼 false
				    confirm:{
				    	text:"내서재로 가기",
				    	value:true
				    }
				  },
			}).then((value) => {	//value가 true이면 내서재로 이동한다.
				if(value){
						location.href = '${pageContext.request.contextPath }/mylib';
				}else{
					location.reload();					
				}//if
			});//swal

			return false;//a tag 이동 방지
		});

						
		$('#moveTop').on('click',function(){ //탑 버튼, 문서 제일 위로 이동
			$(document).scrollTop(0);
		});//탑 버튼 클릭
		

	  
	      $('.book-info').hide();//책소개 내용 처음엔 숨김
	      $('.panel-heading').css({'cursor':'pointer','background-color':'white'});
	      $('.panel-heading').on('click',function(){ //책소개 클릭 시 책소개 내용 Slide down
	    	  
//	    	  if($(this).find('.triangle').text() == '▷'){
	    	  if($(this).find('span').attr('class').includes('down')){
					
					//$(this).find('.triangle').text('▽');
					$(this).find('span').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
					
					$(this).next().slideDown(500);
					aos();
			//	}else if($(this).find('.triangle').text() == '▽'){
				}else if($(this).find('span').attr('class').includes('up')){
					
					//$(this).find('.triangle').text('▷');
					$(this).find('span').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
					$(this).next().slideUp(500,function(){
					});//slideup
				}//else
			})//click
			
			$('.mylib-btn, #additional-info').css('text-align','center');//내서재,공부방 버튼 가운데정렬
			$('.badge').css('background-color','#8ba989');
			
			$('.additional-info a').css({'margin':'5px 5px 5px 5px','color':'#49654d'});
			$('.book-intro').last().css('border-bottom','1px solid #e4e4e4');
			
			
			$('#crawling_div').remove();
	});//ready

</script>
<style type="text/css">
.media-object{
	width:140px;
}
.additional-info li>a:hover,.additional-info li>a:focus{
	background-color: white;
	color:#49654d;
}
.book-intro{
	border-left:0px;
	border-right:0px;
	border:0px;
	margin-bottom:0px;
	box-shadow: white 0px 0px 0px;
	-webkit-box-shadow:white 0px 0px 0px;
	border-radius: 0px;
	border-top:1px solid #e4e4e4;
}
.panel-heading{
	border:0px;
}
.chap_list{
	display: none;
}
</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
	<!-- **********content start**********--> 
	<div id="crawling_div">
	${crawlingDoc}
	</div>
	<div class="row"><br/><br/></div>

	<div class="row">
		<div class="col-md-3"></div>
			<div id="book_thumbnail" class="col-xs-12 col-md-6"></div>
		<div class="col-md-3"></div>
	<div class="col-md-12 col-xs-12"><br/><br/></div>
	
	</div>
	<div class="row">
		<div class="col-md-3"></div>
			<div id="book_detail" class="col-xs-12 col-md-6"></div>
		<div class="col-md-3"></div>
		<div class="col-md-4"></div>
		<div class="col-md-4 col-xs-12" id="additional-info">
		

			<nav aria-label="...">
				<ul class="pager additional-info">
				<c:if test="${cntReaders.readers ne null }">
					<li><a>함께 읽는 사람 <span class="badge">${cntReaders.readers }명</span></a>
					</li>
				</c:if>
					<li><a>평균 완독 시간 <span class="badge">4일</span></a>
					</li>
					<li><a>평점 <span class="badge">★3.5</span></a>
					</li>
				</ul>
			</nav>
		</div>
		<div class="col-md-4"></div>
		<div class="col-md-12 col-xs-12 bottom-line"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div id="book_info_carousel" class="col-xs-12 col-md-6">
			<div class="owl-carousel owl-themeowl-loading owl-loaded">
				<div class="owl-stage-outer" id="owl_detail">
				</div>
			</div>


		</div>
		<div class="col-md-3"></div>
		<div class="col-md-12 col-xs-12 bottom-line"></div>
	
	</div>
	<br/>
		<div class="row">
	<div class="col-md-3"></div>
		<div class="col-xs-12 col-md-6 mylib-btn">
			<a id="putChapters" class="btn btn-default" role="button" href="#">내
				서재에 담기</a>
			<a id="bookclub" class="btn btn-default" role="button" href="#">북클럽 바로가기</a>
		</div>
	<div class="col-md-3"></div>
	</div>

	<br/>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="faq-box col-xs-12 col-md-6">
			<div class="panel panel-default book-intro">
				<div class="panel-heading"><span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>&nbsp;책 소개</div>
				<div class="panel-body book-info" data-aos="fade-up" id="bookIntro">이 책은 소개가 없습니다.</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="faq-box col-xs-12 col-md-6">
			<div class="panel panel-default book-intro" id="chapter_list">
				<div class="panel-heading"><span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>&nbsp;목차</div>
				<div class="chap_list">
					<ul class="list-group">
						<c:forEach items="${toc }" var="bean">
							<li class="list-group-item" data-aos="fade-up">${bean.toc}</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>

	<div class="row">
		<div class="col-md-3"></div>
			<div id="chapterlist" class="col-xs-12 col-md-6"></div>
		<div class="col-md-3"></div>
	</div>
	<br />

	<br />
	<div class="row">
		<div class="col-md-3"></div>
			<div class="col-xs-12 col-md-6">
				<button id="moveTop" class="btn btn-default">Top</button>
			</div>
		<div class="col-md-3"></div>
		<div class="col-md-12 col-xs-12">&nbsp;</div>
	</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
