<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/checkbox2button.css" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/checkbox2button.min.js"></script>
<style type="text/css">
	label{
	 	width:20%;
	}
	input{
		width:150px;
		border: 1px solid #e4e4e4;
		margin:0.3em auto;
	}
	.jumbotron{
		background-color:white;
		width:70%;
		margin:0 auto;
		padding:10px;
		border:1px solid #e4e4e4;
	}
	.plan-chap-title{
		text-align:center;
		margin-bottom:1em;
	}
	.chap-main{
		display:inline-flex;
		width:100%;
	}
	.tocItem{
		width: 85%;
		margin-right: 5px;
		border: none;
		border-right: 0px;
		border-top: 0px;
		boder-left: 0px;
		boder-bottom: 0px;
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:5em;
	}
	.chap-content{
		margin-left:3em;
		width: 100%;
	}
	.chap-content h4{
		margin-top:0px;
	}
	.choice{
		cursor:pointer;
		line-height:40px;
		border: 1px solid #e4e4e4;
		padding:0.5em 1.5em;
		font-size:1.2em;
		border-radius:10px;
		margin:20px auto;
	}
	.choice:hover{
		color:#8ba989;
		border: 1px solid #8ba989;
	}
	.gray{
		color:#999999;
		font-size:0.9em;
	}
	.by{
		padding-left:10px;
	}
	.calc{
		margin-left:30px;
		background-color:#8ba989;
		color:white;
		line-height:15px;
	}
	.calc:hover{
		background-color:white;
		border:1px solid #8ba989;
		color:#8ba989;
	}
	.assert1,.assert2{
		color:black;
		background-color:white;
		line-height:15px;
		padding:0px 5px;
		margin-bottom:5px;
		font-size:1.2em;
	}
	.assert1:hover,.assert2:hover{
		border:1px solid white;
		color: #49654d;
	} 
	.result{
		border-top:1px solid #e4e4e4;
		padding-top:1em;
		margin-top:1em;
	}
	.comment{
		vertical-align:middle;
		text-align:center;
		margin-top:10px;
	}
	.go-to-page{
		width:100%;
		text-align:right;
		padding-bottom:2em;
	}
	.setToc{
		background-color:white;
		line-height:15px;
		padding:0px 5px;
		margin-bottom:5px;
		font-size:1.2em;
	}
	.setToc:hover{
		border:1px solid white;
		color: #49654d;
	}
	.assert{
		background-color:white;
		line-height:15px;
		padding:0px 5px;
		margin-bottom:5px;
		font-size:1.2em;
	}
	.assert:hover{
		border:1px solid white;
		color: #49654d;
	} 
	.result{
		border-top:1px solid #e4e4e4;
		padding-top:1em;
		margin-top:1em;
	}
	.submenu-main{
	    margin-bottom:120px;
	}
	.addToc, .rmvToc{
		 text-align: center;
	     font-size: 0.7em;
	     text-transform: uppercase;
	     background: #8ba989;
	     padding: 1em 0.5em;
	     color: #fff;
	     width: 30px;
	     height: 30px;
	     line-height: 10px;
	     border: none;
	     margin-left: 2px;
	}
	.addToc:hover, .rmvToc:hover{
		background: #e4e6da;
		color: #c0cb2;
	}
	.lb-chap{
		width: 120px;
		margin-right: 57px;
	}
	.chap{
		width: 120px;
	}
 	@media (max-width:800px) {
 		.jumbotron{width:90%; text-align:center;}
		.book-image{margin-bottom:2em;}
		.chap-main{display:block;}
		.chap-content{
			width:100%;
			margin:0 auto;
			font-size:1.3em;
			text-align: center;
		}
		ul{
			padding: 0px;
		}
		.tocItem{
			width: 80%;
		}
		.temp{
			margin:0px auto;
		}
		.chap-toc{
			margin: 0px auto;
			text-align:center;
		}
		.submenu-main{
	    	margin-bottom:180px;
		}
		.tocListItem{
			font-size: 12px;
		}
		.lb-chap{
			width: 120px;
			margin-right: 10px;
		}
		#input_chap{
			width: 90px;
		}
	}
	@media (max-width:470px) {
		.addToc, .rmvToc{
			width: 15px;
			height: 15px;
			line-height: 5px; 
		}
	}
	
</style>
</head>
<script type="text/javascript">
var cntTocs;
var startdate;
var enddate;
var plan_chap;
var temp;
function get_date_str(date){
    var sYear = date.getFullYear();
    var sMonth = date.getMonth() + 1;
    var sDate = date.getDate();
    sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
    sDate  = sDate > 9 ? sDate : "0" + sDate;
    return sYear +"-"+ sMonth +"-"+ sDate;
}//날짜 형변환
var mql = window.matchMedia("screen and (max-width: 800px)");
mql.addListener(function(e) {
    if(e.matches) {
	    $(".calc").before("<div class=\"temp\"><br/><div/>");
    } else {
		$('.temp').remove();
    }
});
var emptyToc  = '<li class="list-group-item tocListItem"><input type="text" class="tocItem" name="toc" /><button type="button" class="btn btn-default addToc">+</button><button type="button" class="btn btn-default rmvToc">-</button></li>';
	$(document).on('click', '.addToc', function(){
		$(this).parent().after($(emptyToc));
		$('h5 strong').text($('.tocListItem').length);
	});// addToc clicks
	$(document).on('click', '.rmvToc', function(){
		if($('ul>li.tocListItem').size() < 2) {
			swal("주의", "모든 목차를 지울 수 없습니다.","warning");
			return false;
		} else{
			$(this).parent().remove();
			$('h5 strong').text($('.tocListItem').length);
		}
	});// rmvToc click
	$(function() {
		 if (mql.matches) {
			$(".calc").before("<div class=\"temp\"><br/><div/>");
		} else {
			$('.temp').remove();
		}
		//최초 
		$('.chap-chap').hide();
		$('.chap-date').hide();
	  	$('.by-chap').hide();
		$('.by-chapdate').hide();
	 	$('.chap-result').hide();
		$('.chapdate-result').hide();
		$('h5 strong').text($('.tocListItem').length);
		if ($('.tocListItem').length == 1) {
			$('.tocItem').val('목차 정보가 없는 책입니다. 직접 설정해주세요.');
		}
		$('.setToc').on('click', function(){
			$('.plan-chap-title').text('목표설정 by CHAPTER');
			$('.chap-toc').hide();
			$('.chap-chap').show();
			$('.chap-date').show();
			$('.choice').show();
		});
		$(".startdate").prop("min",  get_date_str(new Date()));
		$(".startdate1").prop("min",  get_date_str(new Date()));
		$(".startdate1").on("change", function() {
			$(".enddate").prop("min", $(".startdate1").val());
			var cntToc = $('.tocListItem').length;
			var pos_enddate = new Date($(".startdate1").val());
			pos_enddate = pos_enddate.setDate(pos_enddate.getDate()+cntToc-1);
			pos_enddate = new Date(pos_enddate); // 선택할 수 있는 마칠 날짜
			console.log(get_date_str(pos_enddate));
		     $(".enddate").prop("max", get_date_str(pos_enddate));
		});
		$('.chap-choice').on('click',function(){
				$('.by-chap').show();
				$('.by-chapdate').hide();
			 	$('.chapdate-result').hide();
		});//click
		$('.chapdate-choice').on('click',function(){
			$('.by-chapdate').show();
			$('.by-chap').hide();
			$('.chap-result').hide();
		});//click
			
		$('.chap-btn').on('click',function(){
			startdate=$('.startdate').val();
			$('.start-date').val(startdate);
			plan_chap=$('.chap').val();
			$('.plan-chap').val(plan_chap);
			cntTocs = $('.tocListItem').length;
			temp=Math.ceil(cntTocs /plan_chap); //숫자올림
			$('.study-day').val(temp);
			enddate=new Date(startdate);
			enddate=enddate.setDate(enddate.getDate()+temp-1);//끝나는 날짜 계산
			enddate=new Date(enddate);
			$('.end-date').val(get_date_str(enddate));
			if(startdate==""||plan_chap==""){
				swal({
					  title: "내용이 비어있습니다",
					  text: "시작 날짜와 1일 학습 챕터 개수가 제대로 입력되었는지 확인해 주세요",
					  icon: "error",
					  button: "확인",
				});			
			}else if(startdate<get_date_str(new Date())){
				swal({
					  title: "시작 날짜 입력 오류",
					  text: "시작 날짜는 오늘이나 오늘 이후의 날짜로 입력해 주세요",
					  icon: "error",
					  button: "확인",
					});
			}else if(plan_chap>cntTocs){
				swal({
					  title: "1일 학습 챕터 개수 입력 오류",
					  text: "공부할 양은 총 챕터(목차)의 개수 보다 많을 수 없습니다",
					  icon: "error",
					  button: "확인",
					});
			}else{
				$('.chap-result').show();
			} 
		});//chap-btn click
		$('.enddate-btn').on('click',function(){
			temp=$('.startdate1').val();
			$('.start-date1').val(temp);
			startdate=new Date(temp);
			temp=$('.enddate').val();
			$('.end-date1').val(temp);
			enddate=new Date(temp);
			temp=Math.ceil((enddate.getTime()-startdate.getTime())/(1000*3600*24))+1;
			$('.study-day1').val(temp);
			cntTocs = $('.tocListItem').length;
			plan_chap=Math.ceil(cntTocs/temp);
			$('.plan-chap1').val(plan_chap);
			if($('.startdate1').val()==""||$('.enddate').val()==""){
				swal({
					  title: "내용이 비어있습니다",
					  text: "시작 날짜와 마칠 날짜가 제대로 입력되었는지 확인해 주세요",
					  icon: "error",
					  button: "확인",
				});			
			}else if(plan_chap <= 0){
				swal({
					  title: "1일 학습 챕터 개수 입력 오류",
					  text: "1일 학습 챕터 개수는 적어도 1개 이상이여야 합니다.\n 1일 1챕터 이상 진행이 어려울 경우, '페이지 중심 목표 설정하기'를 이용해주세요.",
					  icon: "error",
					  button: "확인",
				});
			}else if($('.startdate1').val()<get_date_str(new Date())){
				swal({
					  title: "시작 날짜 입력 오류",
					  text: "시작 날짜는 오늘이나 오늘 이후의 날짜로 입력해 주세요",
					  icon: "error",
					  button: "확인",
				});
			}else if($('.startdate1').val()>$('.enddate').val()){
				swal({
					  title: "날짜 입력 오류",
					  text: "마칠 날짜는 시작 날짜 이후여야 합니다",
					  icon: "error",
					  button: "확인",
				});
			}else{
			 	$('.chapdate-result').show();
			}
		});//enddate-btn click
		
		$(".assert1").on("click",function(){
			  $("input[name='toc']").each(function (index, element) {
		        var hidden = '<input type="hidden" class="tocItem" name="toc" value="'+$(this).val()+'"/>';
		        $('#form1').append(hidden);
		     });
			swal({
				title: "목표설정이 완료되었습니다",
				text: "확인 버튼을 누르시면 오늘의 기록으로 이동합니다",
				icon: "success",
				button: "확인",
			}).then(function(value) {
				$(".assert1").closest("form").submit();
			});
		});//click
		
		$(".assert2").on("click",function(){
			$("input[name='toc']").each(function (index, element) {
		        var hidden = '<input type="hidden" class="tocItem" name="toc" value="'+$(this).val()+'"/>';
		        $('#form2').append(hidden);
		    });
			swal({
				title: "목표설정이 완료되었습니다",
				text: "확인 버튼을 누르시면 오늘의 기록으로 이동합니다",
				icon: "success",
				button: "확인",
			}).then(function(value) {
				$(".assert2").closest("form").submit();
			});
		});//click
		
	});//ready
	function onlyNumber(e){
	    if((event.keyCode<48)||(event.keyCode>57)) {
	       event.returnValue = false;    	
	    }
	}
</script>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="jumbotron">
		<h3 class="plan-chap-title">목차 편집</h3>
		<div class="chap-main">
			<div class="book-image-box">
				<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
			</div><!-- book-image-box -->
			<div class="chap-content">
				<div class="book-info-detail">
					<h4><strong>${v_study.title}</strong></h4>
					<h5>현재 목차는 <strong></strong>개 입니다</h5>
				</div><!-- book-info-detail -->
				<div class="chap-toc">
					<div class="edit toc">
						 <ul>
						 	<c:forEach items="${tocList }" var="toc" varStatus="status">
						 	<li class="list-group-item tocListItem"><input type="text" class="tocItem" name="toc" value="${toc.toc }" /><button type="button" class="btn btn-default addToc" >+</button><button type="button" class="btn btn-default rmvToc">-</button></li>
						 	<span><c:out value="${status.end }" /></span>
						 	</c:forEach>
						 </ul>
					</div><!-- edit toc -->
					<div class="comment">
						<button class="btn setToc">해당 목차를 이용하여 목표설정을 하시겠습니까?
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
				</div><!-- chap-toc -->
				<div class="chap-chap">
					<div class="choice chap-choice">
						 <span class="glyphicon glyphicon-duplicate" aria-hidden="true"></span> 하루에 공부할 챕터의 개수를 기준으로<br/>
						 <span class="gray">시작 날짜와 1일 학습 챕터의 개수를 입력하시면 끝나는 날짜가 계산됩니다</span>
					</div><!-- choice -->
					<div class="by-chap by">
						<label for="startdate">시작 날짜</label><input type="date" name="startdate" id="startdate" class="startdate"/><br/>
						<label for="chap" class="lb-chap">1일 학습 챕터 개수</label><input type="text" name="chap" class="chap" onkeypress="onlyNumber();" id="input_chap"/>개
						<button class="btn btn-priamary chap-btn calc">계산</button>
						<div class="chap-result result">
							<form class="form" method="post" action="${pageContext.request.contextPath }/mylib/plan/chap" id="form1">
								<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="start-date" readonly/><br/>
								<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date" readonly/><br/>
								<label for="studyday">총 공부일</label><input type="text" name="studyDay" class="study-day" readonly/><br/>
								<label for="dayChap">1일 학습 챕터 개수</label><input type="text" name="planChap" class="plan-chap" readonly/><br/>
								<label for="memo">메모</label><input type="text" name="memo" class="memo"/>
								<input type="hidden" name="id" value="${v_study.study_id}" readonly/>
								<input type="hidden" name="book_bid" value="${v_study.book_bid}" readonly/>
								<input type="hidden" name="type" value="chap" readonly/><br/>
								<div class="comment">
									<a class="btn assert1">해당 정보로 목표설정을 하시겠습니까?
										<span class="glyphicon glyphicon-ok"></span>
									</a>
								</div>
							</form>
						</div><!-- chap-result -->
					</div><!-- by-chap -->
				</div><!-- chap-chap -->
				<div class="chap-date">
					<div class="choice chapdate-choice">
						 <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> 공부를 마칠 날짜를 기준으로<br/>
						 <span class="gray">시작 날짜와 마칠 날짜를 입력하시면 하루에 공부해야 할 챕터의 개수가 계산됩니다</span>
					</div><!-- choice -->
					<div class="by-chapdate by">
						<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="startdate1" /><br/>
						<label for="enddate">마칠 날짜</label><input type="date" name="enddate" class="enddate"/>
						<button class="btn btn-priamary enddate-btn calc">계산</button>
						<div class="chapdate-result result">
							<form class="form" method="post" action="${pageContext.request.contextPath }/mylib/plan/chap" id="form2">
								<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="start-date1" readonly/><br/>
								<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date1" readonly/><br/>
								<label for="studyday">총 공부일</label><input type="text" name="studyDay" class="study-day1" readonly/><br/>
								<label for="planchap">1일 학습 챕터 개수</label><input type="text" name="planChap" class="plan-chap1" readonly/><br/>
								<label for="memo">메모</label><input type="text" name="memo" class="memo"/>
								<input type="hidden" name="id" value="${v_study.study_id}" readonly/>
								<input type="hidden" name="book_bid" value="${v_study.book_bid}" readonly/>
								<input type="hidden" name="type" value="chap" readonly/><br/>
								<div class="comment">
									<a class="btn assert2">해당 정보로 목표설정을 하시겠습니까?
										<span class="glyphicon glyphicon-ok"></span>
									</a>
								</div>
							</form>
						</div><!-- chap-result -->
					</div><!-- by-chap -->
				</div><!-- chap-date -->
			</div><!-- chap content -->
		</div><!-- .chap-main end -->
		<div class="go-to-page">
			<a href="${pageContext.request.contextPath }/mylib/plan/page/${v_study.study_id}"><em>페이지 목표설정 페이지로 이동</em></a>
		</div>
	</div><!-- jumbotron end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>