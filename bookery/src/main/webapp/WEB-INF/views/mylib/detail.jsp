<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<Script type="text/javascript">

</Script>
<style type="text/css">
	.book-info{
		margin-left:30px;
	}
	.title{
		margin:15px auto;
		text-align:center;
	}
	.book-title{
		margin:0px;
	}
	.book-img-container{
		text-align:center;
		margin-top:20px;
	}
	.book-img-container span{
		color:rgb(143,143,143);
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:1em;
	}
	.dates{
		background-color:#f7f7f7;
		border-radius:10px;
		display:flex;
		width:97%;
		margin-left:20px;
		margin-bottom:20px;
	}
	.date{
		text-align:center;
		margin:5px auto;
		padding:0.5em;
		width:33%;
	 	display: flex;
  		flex-direction: column;
		font-size:0.9em;
		border-left:1px solid white;
	}
	.date:first-child {
		border-left:0px;
	}
	.date-data{
		font-size:1.2em;
		font-weight:bold;
		color:#505050;
	}
	.chart-title{
		text-align:center;
	}
	.chart-inner{
		margin:0px auto;
		width:100%;
		height:300px;
	}
 	@media (max-width:800px) {
 		.book-info{
			margin-left:0px;
		}
		.book-image{
			margin-bottom:2em;
		}
		.dates{
			width:100%;
			margin:2em auto;
			margin-top:1em;
		}
		.all-data{
			text-align:center;
		}
		.chart-inner{
			width:100%;
			height:250px;
		}
	}
</style>

</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-8 title">
	</div>
	<div class="col-md-2"></div>
</div><!-- row end --> 
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-2">
		<div class="book-img-container">
			<img class="book-image" src="${bookInfo.coverurl }" alt="책 이미지">
			<h5><span>저자</span> <strong>${bookInfo.writer }</strong></h5>
			<h5><span>출판사</span> <strong>${bookInfo.publisher}</strong></h5>
			<h5><span>출간일</span> <strong>${bookInfo.publicationdate}</strong></h5>
		</div>
	</div>
	<div class="col-xs-12 col-md-6 all-data">
		<div class="book-info">
			<h3 class="book-title"><strong>${bookInfo.title}</strong></h3>
			<h5>본 책은 총 <strong class="color-green">${v_study.pages}</strong>페이지 입니다</h5>
		</div>
		<div class="chart-inner">
			<canvas id="myChart" width="400" height="400"></canvas>
		</div><!-- chart-inner -->
		<div class="dates">
			<div class="date">
				시작일<br/>
				<span class="date-data">${v_study.startdate}</span>
			</div>
			<div class="date">
				목표일<br/>
				<span class="date-data">${v_study.enddate}</span>
			</div>
			<div class="date">
				완료일<br/>
				<span class="date-data">${v_study.updatetime}</span>
			</div>
		</div><!-- dates -->
	</div><!-- all-data -->
	<div class="col-md-2"></div>
</div><!-- .row end -->
<!--**********content end**********-->
<script>
var finData='${finData}';
var finList=JSON.parse(finData).key;
var arr=new Array();
var plan=new Array();
var actual=new Array();

finList.forEach(function(ele){
	var temp=(new Date(ele.date).format('yyyy-MM-dd'));
	arr.push(temp);
	plan.push(ele.plan_accum);
	actual.push(ele.actual_accum);
});//forEach

var ctx = document.getElementById('myChart');

var config = {
	type: 'line',
	data: {
		labels:arr,
		datasets: [{
			label: '계획한 양',
			backgroundColor: '#e4e6da',
			borderColor: '#e4e6da',
			fill: false,
			data: plan,
			pointRadius: 2,
			pointHoverRadius: 2,
			pointBackgroundColor:'white',
			lineTension:0
		}, {
			label: '실제 공부한 양',
			backgroundColor: '#8ba989',
			borderColor: '#8ba989',
			fill: true,
			data: actual,
			pointStyle:'rectRounded',
			pointRadius: 2,
			pointHoverRadius: 2,
			pointBackgroundColor:'#c0cfb2',
			lineTension:0
		}]
	},
	options: {
		maintainAspectRatio: false,
		title: {
			text: 'Chart.js Time Scale'
		},
		scales: {
			yAxes: [{
				scaleLabel: {
					display: true,
					labelString: '페이지'
				},
				ticks:{
					beginAtZero: true,
				}
			}]
		},
		
	}
};
 
//차트 그리기
var myChart = new Chart(ctx, config);
</script>
<%@ include file="../template/footer.jspf" %>
</body>
</html>
