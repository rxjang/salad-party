<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<link href="${pageContext.request.contextPath }/resources/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script src="${pageContext.request.contextPath }/resources/js/datepicker.min.js"></script> <!-- Air datepicker js -->
<script src="${pageContext.request.contextPath }/resources/js/i18n/datepicker.ko.js"></script>
<Script type="text/javascript">

</Script>
<style type="text/css">
	.title{
		margin:15px auto;
		text-align:center;
	}
	.chart-inner{
		width:400px;
		height:300px;
	}
	.book-img-container{
		text-align:center;
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:5em;
	}
 	@media (max-width:800px) {
		.book-image{margin-bottom:2em;}
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
	<div class="col-xs-12 col-md-6">
					<h4><strong>${v_study.title}</strong></h4>
					<h5>본 책은 총 <strong>${v_study.pages}</strong>페이지 입니다</h5>
					메모:${v_study.memo}<br/>
					서재에 책을 담은 날짜:${v_study.createtime}<br/>
					시작일: ${v_study.startdate}<br/>
					목표일: ${v_study.enddate}<br/>
					완료일: ${v_study.updatetime}<br/>
	</div>
	<div class="col-md-2"></div>
</div><!-- .row end -->
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-md-10">
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
	plan.push(ele.plan);
	actual.push(ele.actual);
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
