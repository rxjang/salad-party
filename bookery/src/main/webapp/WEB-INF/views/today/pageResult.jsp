<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>

<script type="text/javascript">


	var success = "${v_study.success_rate}";
	$(function(){
		//목표치
		if(success > 100){		//초과달성
			
			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/rupee-rain.jpg"/>';
			$('#result').html(image);

		}else if(success == 100){		//달성
			
			var image = '<img src="${pageContext.request.contextPath}/resources/imgs/rupee-smile.jpg"/>';
			$('#result').html(image);

		}else if(success < 100){		//미달성
			
			var image = '<h1>공부좀더해..</h1><img src="${pageContext.request.contextPath}/resources/imgs/rupee-cry.jpg"/>';
			$('#result').html(image);
		}//if
		
		
	});//ready

</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
	<!-- **********content start**********--> 
<div class="row">
	<div class="col-xs-12 col-md-12">
	
	<div id="result"></div>
	</div>
</div>
	<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
