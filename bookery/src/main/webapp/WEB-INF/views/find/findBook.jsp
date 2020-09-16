<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../template/head.jspf"%>
<title>Bookery</title>

<style type="text/css">

</style>

<script type="text/javascript">
var chapters, book_id, title, writer, publisher, pages, category, isbn, translator, title_original, publication_date, revision,imgUrl;
var img_link;
var bid = ${bid}; //컨트롤러에서 bid를 받아온다.
$(function(){
//console.log(bid);
	writer=''; publisher=''; pages=''; category=''; isbn=''; translator=''; title_original=''; publication_date=''; revision='';
	img_link='';//혹시 남아있을지 모를 값들을 페이지 로딩할 때 초기화 해둔다.
	
	$.ajax('${pageContext.request.contextPath }/find/crawling',{
		'method':'get',
		'data':'bid='+bid,
		'success':function(data){
			var bookInfo = $(data).find('.book_info');
			img_link = bookInfo.find('.thumb_type img').attr('src');
			//console.log(img_link);
			title = bookInfo.find('h2').text(); //책제목
			//console.log('title = ' + title);
			title_original = bookInfo.find('.tit_ori').text().replace('원제','').trim(); //원제
			//console.log('original_title = '+title_original);
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
			

			var book_info_html =  '<div class="media">';
				book_info_html += '<div class="media-left media-middle">';
				book_info_html += '<a href="#">';
				book_info_html += '<img class="media-object" src="'+img_link+'" alt="...">';
				book_info_html += '</a>';
				book_info_html += '</div>';
				book_info_html += '<div class="media-body">';
				book_info_html += '<h4 class="media-heading">'+title+'</h4>';
				book_info_html += '<p>저자 '+writer+'</p>';
			if(translator!=''){
				book_info_html += '<p>역자 '+translator+'</p>';
			}
			if(title_original!=''){
				book_info_html += '<p>원제 '+title_original+'</p>';
			}
				book_info_html += '<p>출판사 '+publisher+'</p>';
				book_info_html += '<p>출간일 '+publication_date+'</p>';
				book_info_html += '<p>페이지 '+pages+'</p>';
			if(revision!=''){
				book_info_html += '<p>'+revision+'</p>';
			}			
				book_info_html += '</div></div>';
			$('#book_detail').html(book_info_html);
				var list = $(data).find('#tableOfContentsContent');
				/*************	네이버북스 책목차는 tableOfContentsContent아래에 있다	*************/
				//var sum = bookInfo.html() + list.html();
			//	$('#chapter_list').html(list);

			//	$('#putChapters').show();//책 내서재에 담으면서 내서재페이지로 이동

				var newLineText = $(list).html().replace(/<(\/br|br)([^>]*)>/gi, "\n");
				//br태그를 \n으로 변경
			//	console.log(newLineText);
				var noTagText = newLineText.replace(/(<([^>]+)>)/ig, "");
				//모든 태그요소를 제거

								
								
/* 			<ul class="list-group">
  <li class="list-group-item">Cras justo odio</li>
  <li class="list-group-item">Dapibus ac facilisis in</li>
  <li class="list-group-item">Morbi leo risus</li>
  <li class="list-group-item">Porta ac consectetur ac</li>
  <li class="list-group-item">Vestibulum at eros</li>
</ul> */					

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

			}//success
		});//ajax

		//chapters, book_id, title, writer, publisher, pages, category, isbn, translator, title_original, publication_date, revision;
		/*******  body에 있는 내서재가기 a tag : display none상태-검색된 책누르면 show()  ******/
		$('#putChapters').on('click', function() {
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
				location.href = '${pageContext.request.contextPath }/find/chapters?bid=' + bid;
				//목차정보는 목차정보 DB에 insert하는 컨트롤러로 비동기처리하고 페이지는 원하는 곳으로 이동시킴
				//페이지 이동시키지 않고 그냥 서재에 담았다고 alert로 확인 메세지 띄워도되고
				//다른페이지 이동가능
				//목차보는 페이지로 바로 이동시키면 db insert 오래걸려서 로딩속도가 좀 걸림
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
	      }
	});//ready
</script>


<body>
<%@ include file="../template/menu.jspf"%>
<!-- ************************************ ↑ nav-bar **************************************** -->



<div class="container-fluid">

	<div class="row">
	<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-6">
			<a id="putChapters" class="btn btn-default" role="button" href="#">내
				서재에 담기</a>
			<a id="" class="btn btn-default" role="button" href="#">공부방 참여하기</a>
		</div>
	<div class="col-md-4"></div>
	</div>
	<br/>
	<div class="row">
		<div class="col-md-2"></div>
			<div id="book_detail" class="col-xs-12 col-md-6"></div>
		<div class="col-md-4"></div>
	</div>
	<br/>
	<div class="row">
		<div class="col-md-2"></div>
			<div id="chapter_list" class="col-xs-12 col-md-6"></div>
		<div class="col-md-4"></div>
	</div>
	<br />
	<div class="row">
		<div class="col-md-2"></div>
			<div class="col-xs-12 col-md-6">
				<button id="moveTop" class="btn btn-default">Top</button>
			</div>
		<div class="col-md-4"></div>
		<div class="col-md-12 col-xs-12">&nbsp;</div>
	</div>
</div>

</div>
<%@ include file="../template/footer.jspf"%>	
</body>
</html>
