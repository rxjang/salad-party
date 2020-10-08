<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<Script type="text/javascript">
</Script>
<style type="text/css">
	img{
		width:200px;
	}
	.jumbotron{
		width:90%;
		margin:0 auto;
		width:90%;
		background-color:white;	
	}
	.jumbotron a{
		color:white
	}
	.jumbotron a:hover{
		text-decoration:none; color:#ECEBC9
	}
	#award-account{
		height:280px;
		background:url('${pageContext.request.contextPath}/resources/imgs/award.jpg')center/cover;
		color:white;
		padding:30px 60px;
	}
	#number-of-awards{
		margin-top:30px;
		font-size:1.3em;
		color:white;
		width:50%;
		padding-bottom:10px;
		margin-bottom:20px;
		border-bottom: 1px rgba(255, 255, 255, .5) solid
	}
	.achieve-awards{
		opacity: 0.8;
	}
	.count-achieve-awards{
		border-top:0px;
		padding:5px 0px;
	}
	.award-info-ment{
		margin-top:10px;
		text-shadow: 2px 2px 2px gray;
	}
	.award-info-ment span{
		opacity: 0.8;
	}
	.all-medal{
		width:100%;
		border: 1px solid #e4e4e4;
	}
	.all-medal li{
		width:20%;
		float:left;
		list-style:none;
		margin-bottom:10px;
	}
	.temp{
	}
	
	@media (max-width:1000px) {
		.jumbtron{
			width:100%;
		}
		#award-account{
			height:250px;
			padding:20px;
			padding-left:30px;
		}
		.award-info-ment{
			font-weight:bold;
			text-shadow: 3px 3px 3px #000000;
			font-size:1.1em;
		}
		#award-account{
			font-weight:bold;
		}
	}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
	<!-- **********content start**********-->
<div class="row">
	<div class="col-xs-12 col-md-12">
		<div class="jumbotron" id="award-account">
			<h3>${user.nickname }님의 어워즈</h3>
			<div id="number-of-awards">
				<h4 class="achieve-awards">획득한 어워즈</h4>
				<h4 class="count-achieve-awards">${countAchieveMedal }</h4>
			</div><!-- #number-of-awards end -->
			<div class="award-info-ment">
				<a href="${pageContext.request.contextPath }/today">
					목표를 달성하여 어워드를 늘려보아요!<br/><span>기록하러 가기</span>			
				</a>
			</div><!-- .award-info-ment end -->
		</div><!-- award-account -->	
		<div class="jumbotron">
			메달 목록
			<ul class="all-medal">
			<c:forEach items="${medalList }" var="medal">
					<li>${medal.criteria }</li>
			</c:forEach>			
			</ul>
		</div>
		<div class="jumbotron">
		달성 목록
			<ul class="all-medal">
			<c:forEach items="${achieveMedalList }" var="award">
					<li>${award.criteria }</li>
			</c:forEach>			
			</ul>
		</div>
		<div class="jumbotron temp">
			<img src="${pageContext.request.contextPath}/resources/imgs/award/achieve-1st.png"/>
			<img src="${pageContext.request.contextPath}/resources/imgs/award/achieve-3rd.png"/>
		</div>
	</div>
</div><!-- .row end -->
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
