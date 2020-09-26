<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>

<script type="text/javascript">
var chapters, book_id, title, writer, publisher, pages, category, isbn, translator, title_original, publication_date, revision,imgUrl;
var description;
var img_link;
var bid = ${bid}; //컨트롤러에서 bid를 받아온다.
var owlItem='';
var bookMap ={};
$(function(){
//console.log(bid);
	writer=''; publisher=''; pages=''; category=''; isbn=''; translator=''; title_original=''; publication_date=''; revision='';
	img_link='';//혹시 남아있을지 모를 값들을 페이지 로딩할 때 초기화 해둔다.
	
	$.ajax('${pageContext.request.contextPath }/find/crawling',{
		method:'get',
		data:'bid='+bid,	
		success:function(data){
			var bookInfo = $(data).find('.book_info');
			img_link = bookInfo.find('.thumb_type img').attr('src');
			//console.log(img_link);
			title = bookInfo.find('h2').text(); //책제목
			//console.log('title = ' + title);
			title_original = bookInfo.find('.tit_ori').text().replace('원제','').trim(); //원제
			//console.log('original_title = '+title_original);
			description = $(data).find('#bookIntroContent').html(); //책 소개
			$('#bookIntroContent').html(description);
			var translator_cnt = 1;
			var author_cnt = 1;
			$(data).find('.book_info_inner').children().eq(1).find('a').each(function(){
				//저자, 역자, 출판사, 출간일 정보가 담겨있는 div
				//console.log($(this).attr('class'));
				var aClassName = $(this).attr('class');
				if(aClassName.includes('author',0)) {
					if(author_cnt==1){							//저자
						writer += $(this).text();									
					}else{
						writer += ', '+$(this).text();
					}
					author_cnt++;
				}else if(aClassName.includes('translator',0)){
					if(translator_cnt==1){							//역자
						translator += $(this).text();									
					}else{
						translator += ', '+$(this).text();
					}
					translator_cnt++;
				}else if(aClassName.includes('publisher',0))
					publisher = $(this).text();						//출판사
			});//each
			//console.log('저자='+writer,'역자='+translator,'출판사='+publisher);
			var revision_tmp = $(data).find('.book_info_inner div:contains("페이지")').text().substring( $(data).find('.book_info_inner div:contains("페이지")').text().lastIndexOf('개정'),$(data).find('.book_info_inner div:contains("페이지")').text().lastIndexOf('판')+1).trim();
			//개정
			if(revision_tmp.includes('개정',0)) {
				revision = revision_tmp;
				//console.log('개정 = '+revision);
			}
			pages_tmp = $(data).find('.book_info_inner div:contains("페이지")').text().substring( $(data).find('.book_info_inner div:contains("페이지")').text().indexOf('지')+1, $(data).find('.book_info_inner div:contains("페이지")').text().indexOf('|')).trim();      
			//총 페이지 수
				pages = pages_tmp;
			if ($.isNumeric(pages)){
				//console.log('총 페이지  = ' +pages);
			}else{
				pages=''; //혹시 페이지가 없으면 그냥 공백처리
			}
			publication_date = $(data).find('.book_info_inner div:contains("저자")').text().substring($(data).find('.book_info_inner div:contains("저자")').text().lastIndexOf('|')+1).trim();
			publication_date = publication_date.replace(/\./gi, "-");
			//출간일
			//console.log('출간일 = '+publication_date);
			category = $(data).find('#category_location1_depth').text();
			//console.log('분류 = '+category);
			///카테고리
			
			imgUrl = $(bookInfo).find('.thumb_type img').attr('src');
			//image url 이미지 URL
			//https://bookthumb-phinf.pstatic.net/cover/163/114/16311458.jpg?type=m140&udate=20200701
			//console.log(imgUrl);

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
			$('.owl-stage-outer').html(owlItem);
			$('.owl-item').css('text-align','center');
			$('.owl-item small').css('color','#8f8f8f');
			$('.caro-cnt').css({'font-size':'110%','font-weight':'500'});
			
			/**********************    캐러셀    **********************/
			$('.owl-stage-outer').owlCarousel({
				items:4,
				loop : false,
				autoplay : true,
				margin : 10,
				merge : false,
				nav : false,
				responsive : {//반응성 window size에따라 캐러셀 사진 수 조절.
				}
			});//owl캐러셀
			
			var book_thumbnail_html = '<div class="media-img">';
			book_thumbnail_html += '<a href="#">';
			book_thumbnail_html += '<img class="media-object" src="'+img_link+'" alt="...">';
			book_thumbnail_html += '</a>';
			book_thumbnail_html += '</div>';
			$('#book_thumbnail').html(book_thumbnail_html);
			var	book_info_html = '<div class="media"><div class="media-body">';
				book_info_html += '<h4 class="media-heading">'+title+'</h4>';
				book_info_html += '<p><small>저자</small> '+writer+'</p>';
			if(title_original!=''){
				book_info_html += '<p><small>원제</small> '+title_original+'</p>';
			}
				book_info_html += '</div></div>';
			$('#book_detail').html(book_info_html).css('text-align','center');
			
			$('.media-img img').css({'box-shadow':'rgb(135, 165, 134) 5px 5px 10px','display':'block','margin':'auto'});
			//책 썸네일 그림자색
			
			var list = $(data).find('#tableOfContentsContent');
				/*************	네이버북스 책목차는 tableOfContentsContent아래에 있다	*************/

				var newLineText = $(list).html().replace(/<(\/br|br)([^>]*)>/gi, "\n");
				//br태그를 \n으로 변경
			//	console.log(newLineText);
				var noTagText = newLineText.replace(/(<([^>]+)>)/ig, "");
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
					$('#chapter_list').html(list_group);
				/* *********************************************** */
				chapters = noTagText;//가공한 목차 정보
				//이용자가 책을 선정하면 noTagText를 컨트롤러로 보내서 목차 테이블에 저장

			},
			'error':function(){
				swal('error');
				}//success
			
		});//ajax

		/*******  body에 있는 내서재가기 a tag : display none상태-검색된 책누르면 show()  ******/
		$('#putChapters').on('click', function() {
			
			location.href = '${pageContext.request.contextPath }/mylib';
			//시간이 오래걸리는 목차 입력은 비동기로 요청해두고 내서재 페이지이동을 먼저한다.
			$.post('${pageContext.request.contextPath }/find/put', {
				'chapters' : chapters,
				'bid' : bid,
				'title' : title,
				'writer' : writer,
				'publisher' : publisher,
				'pages' : pages,
				'category' : category,
				'isbn' : isbn,
				'translator' : translator,
				'titleoriginal' : title_original,
				'publicationdate' : publication_date,
				'revision' : revision,
				'coverurl': imgUrl
			}, function() {
				//DB에 목차정보랑 책ID를 전달함
			}).fail(function() {
				swal("통신 에러");
			});//ajax
			return false;//a tag 이동 방지
		});

						
		$('#moveTop').on('click',function(){ //탑 버튼, 문서 제일 위로 이동
			$(document).scrollTop(0);
		});//탑 버튼 클릭
		
		if (!window.Cypress) {//aos 적용.
	        const scrollCounter = document.querySelector('.js-scroll-counter');

	        AOS.init({
	          mirror: true
	        });

	        document.addEventListener('aos:in', function(e) {
	          //console.log('in!', e.detail);
	        });
	      }//AOS
	      
	      $('.panel-body').hide();//책소개 내용 처음엔 숨김
	      $('.panel-heading').css('cursor','pointer');
	      $('.panel-heading').on('click',function(){ //책소개 클릭 시 책소개 내용 Slide down
				if($(this).find('.triangle').text() == '▷'){
					
					$(this).find('.triangle').text('▼');
					$(this).next().slideDown(500);
				}else if($(this).find('.triangle').text() == '▼'){
					
					$(this).find('.triangle').text('▷');
					$(this).next().slideUp(500,function(){
					});//slideup
				}//else
			})//click
			
			$('.mylib-btn').css('text-align','center');//내서재,공부방 버튼 가운데정렬
	});//ready

</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
	<!-- **********content start**********--> 
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
		<div class="col-md-12 col-xs-12 bottom-line"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div id="book_info_carousel" class="col-xs-12 col-md-6">
			<div class="owl-carousel owl-themeowl-loading owl-loaded">
				<div class="owl-stage-outer">
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
			<a id="" class="btn btn-default" role="button" href="#">공부방 참여하기</a>
		</div>
	<div class="col-md-3"></div>
	</div>

	<br/>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="faq-box col-xs-12 col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading"><span class="triangle">▷</span>&nbsp;책 소개</div>
				<div class="panel-body" id="bookIntroContent">${description }</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>

	<div class="row">
		<div class="col-md-3"></div>
			<div id="chapter_list" class="col-xs-12 col-md-6"></div>
		<div class="col-md-3"></div>
	</div>
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
