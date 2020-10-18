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
		background-image: url("${pageContext.request.contextPath }/resources/imgs/cal1.jpg");
		background-size: 100% 100%;
		background-repeat: none;
	}
	#calendar{
		margin:50px;
		padding:50px;
		background-color:white;
		opacity:0.9;
	}
@media (max-width:1000px) {
	#calOuter{
/* 		padding:0px; */
	}
	#calendar{
		margin:0px;
		padding:10px;
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
	<div id='calendar' class="col-md-12 col-xs-12"></div>
</div>
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
