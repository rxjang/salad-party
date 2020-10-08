<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<style type="text/css">
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
				left:'prevYear,prev,next,nextYear today',
				center: 'title',
				right: 'dayGridMonth,dayGridWeek'
			},
			navLinks:false,
			editable:false,
			dayMaxEvents:true,
			contentHeight: 'auto',

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
<div class="row">
	<div class="col-xs-12 col-md-12">
	<h2>스터디캘린더</h2>
	<div id='calendar'></div>
	<div class="row">
		<div class="col-md-8 col-md-offset-2 col-xs-12">
			<c:forEach items="${cals }" var="cal">
				${cal.user_id} 
				${cal.sid_date} 
				${cal.type} 
				${cal.study_id} 
				${cal.date} 
				${cal.plan} 
				${cal.actual} 
				${cal.status}<br>
			</c:forEach>
			
		</div>
	</div>
</div>
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
