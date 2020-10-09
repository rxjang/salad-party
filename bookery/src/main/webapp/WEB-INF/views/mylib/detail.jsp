<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<Script type="text/javascript">

</Script>
<style type="text/css">
	.title{
		margin:15px auto;
		text-align:center;
	}
	.book-title{
		margin:0px;
		font-size:1.5em;
	}
	.book-img-container{
		text-align:center;
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:5em;
	}
	.dates{
		background-color:#ecece9;
		border-radius:10px;
		display:flex;
		width:100%;
		margin:20px auto;
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
	.chart-inner{
		margin:0px auto;
		width:70%;
		height:300px;
	}
 	@media (max-width:800px) {
		.book-image{margin-bottom:2em;}
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
		<h3>완독 기록</h3>
	</div>
	<div class="col-md-2"></div>
</div><!-- row end --> 
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-xs-12 col-md-2">
		<div class="book-img-container">
			<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
		</div>
	</div>
	<div class="col-xs-12 col-md-6 all-data">
		<h4 class="book-title"><strong>${v_study.title}</strong></h4>
		<h5>본 책은 총 <strong class="color-green">${v_study.pages}</strong>페이지 입니다</h5>
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
		</div>
	</div>
	<div class="col-md-2"></div>
</div><!-- .row end -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-xs-12 col-md-10">
		<div class="chart-inner">
			<canvas id="myChart" width="400" height="400"></canvas>
		</div>
		
	</div>
	<div class="col-md-1"></div>
</div>
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
		}, {
			label: '실제 공부한 양',
			backgroundColor: '#8ba989',
			borderColor: '#8ba989',
			fill: false,
			data: actual,
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
