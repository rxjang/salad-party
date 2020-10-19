<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
	#calOuter{
		overflow:hidden;
		padding:10px;
		background: linear-gradient(#e4e6da,#c0cfb2,#8ba989);
	}
	#calendar{
		margin-top:15px;
		padding:30px 30px 0 30px;
		background-color:white;
		opacity:0.9;
	}
	#index{
		height:30px;
		line-height: 30px;
		background-color:white;
		opacity:0.9;
		margin-bottom:15px;
		font-size: 0.9em;
		color:#777777;
		text-align:center;
	}
	#index>div{
		margin:0 auto;
		display:block;
	}
	#index>div span{
		padding:0;
		margin:0;
		display:inline-block;
	}
	.bull{
		font-size:1.3em;
	}
	.green1{
		color:#54BD54;
	}
	.green2{
		color:#A8F552;
	}
	.red{
		color:#FF0000;
	}
	.gray{
		color:#bebebe;
	}

@media (max-width:1000px) {
	#calOuter>div{
		padding:0px;
	}
	#calendar{
		margin:0px;
		padding:10px;
		padding-bottom:0;
	}
	#index{
		margin-bottom:0;
		padding-left:5px;
	}
}
</style>
<script type="text/javascript">
	var map='${map}';
	var arr=[];
	arr=JSON.parse(map).cal;
	
	document.addEventListener('DOMContentLoaded',function(){
		var calendarEl=document.getElementById('calendar');
		
		var calendar=new FullCalendar.Calendar(calendarEl,{
			initialView: 'dayGridMonth',
			headerToolbar:{
				left:'title',
				right:'today prevYear,prev,next,nextYear'
			},
			navLinks:false,
			editable:false,
			dayMaxEvents:true,
			contentHeight: 550,
			eventLimit: true,
			locale:'ko',
			displayEventTime: false,
			events: arr
		});
		calendar.render();
	});
</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********--> 
<div class="row" id="calOuter">
	<div class="col-md-12 col-xs-12">
		<div id='calendar' ></div>
		<div id='index'>
			<div>
				<span class="bull green1">&#x25CF;</span><span>&nbsp;Goal over-achieved &nbsp;&nbsp;</span>
				<span class="bull green">&#x25CF;</span><span>&nbsp;Goal achieved &nbsp;&nbsp;</span>
				<span class="bull red">&#x25CF;</span><span>&nbsp;Goal missed &nbsp;&nbsp;</span>
				<span class="bull gray">&#x25CF;</span><span>&nbsp;To do</span>
			</div>
		</div>
	</div>
</div>
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>