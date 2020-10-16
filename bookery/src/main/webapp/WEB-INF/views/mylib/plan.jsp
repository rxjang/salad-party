<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	.jumbotron{
		background-color:white;
		width:70%;
		margin:0 auto;
		padding:10px;
		border:1px solid #e4e4e4;
	}
	.title{
		font-size:2em;
		text-align:center;
		margin-bottom:1em;
	}
	.question{
		font-size:1.1em;
	}
	.page-main{
		display:inline-flex;
		width:100%;
	}
	.book-info{
		width:15em;
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:1em;
	}
	.page-content{
		margin-left:3em;
		width:100%;
	}
	.choice{
		cursor:pointer;
		border: 1px solid #e4e4e4;
		border-radius:10px;
		margin-bottom:2em;
		padding:1em;
		width:100%;
	}
	.choice:hover{
		border: 1px solid #8ba989;
	}
	.choice-img{
		float:right;
		width:10em;
		box-shadow: 2px 2px 6px rgba(0,0,0,.1), 0 0 2px rgba(0,0,0,.2);
	}
	.gray{
		color:#999999;
	}
	@media (max-width:800px) {
 		.jumbotron{width:90%; text-align:center;}
		.page-main{display:block;}
		.book-info{
			text-align:center;
			width:100%;
		}
		.page-content{
			width:100%;
			margin:0 auto;
			font-size:1.3em;
		}
	}
	@media (max-width:450px) {
		.choice-img{
			width:100%;
			margin-bottom:10px;
		}
		.question{
			font-size:0.9em;
		}
	}
</style>
 <script>

 </script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********-->
<div class="row">
	<div class="jumbotron">
		<h3 class="title">
			목표설정 방식 선택
		</h3>
		<div class="page-main">
			<div class="book-info">
				<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
					<h4><strong>${v_study.title}</strong></h4>
					<h5>본 책은 총 <strong class="color-green">${v_study.pages}</strong>페이지 입니다</h5>
			</div><!-- book-image-box -->
			<div class="page-content">
				<a class="chapter" href="${pageContext.request.contextPath }/mylib/plan/chap/${v_study.study_id }">
					<div class="choice chap-choice">
						<img class="choice-img" src="${pageContext.request.contextPath }/resources/imgs/chap.jpg" alt="chapter">
						<h4 class="question">하루에 한 챕터 이상을 완료할 수 있다면,<br/>순서와 상관없이 원하는 부분부터 공부하고 싶다면,</h4>
						<h3 class="real-title"><strong>챕터 중심으로 목표설정하기</strong></h3>
						<span class="gray">
							선택한 도서의 전체 챕터를 확인합니다<br/>
							필요하다면 원하는 대로 챕터를 추가하거나 삭제합니다<br/>
							하루에 끝낼 챕터의 양 또는 완료하고 싶은 날짜를 정하여 스터디 목표를 설정합니다
						</span>
					</div><!-- choice -->
				</a>
				<a id="link" href="${pageContext.request.contextPath }/mylib/plan/page/${v_study.study_id }">
					<div class="choice page-choice">
						<img class="choice-img" src="${pageContext.request.contextPath }/resources/imgs/page.jpg" alt="chapter">
						<h4 class="question">한 챕터를 끝내는데 여러날이 걸린다면,<br/>책 순서대로 공부하고 싶다면,</h4>
						<h3 class="real-title"><strong>페이지 중심으로 목표설정하기</strong></h3>
						<span class="gray">
							선택한 도서의 전체 페이지를 확인합니다<br/>
							하루에 끝낼 페이지수 또는 완료하고 싶은 날짜를 정하여 스터디 목표를 설정합니다
						</span>
					</div><!-- choice -->
				</a>
			</div><!-- page content -->
		</div><!-- .page-main -->
	</div><!-- jumbotron-->
</div><!-- row -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>