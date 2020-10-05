<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
		<meta charset="UTF-8">
		<title>Bookery</title>
	<%@ include file="../template/head.jspf" %>
</head>
<body>
<script type="text/javascript"> 
	$(document).ready(function(){
		swal({
			  title: "탈퇴 완료",
			  text: "그 동안 Bookery를 이용해주셔서 감사합니다.\n더 좋은 모습으로 만날 수 있길 바랍니다.",
			  icon: "success",
			  buttons: {
			    confirm:{
			    	text:"확인",
			    	value:true
			    }
			  },
		}).then((value) => {	//value가 true이면 메인페이지로 이동한다.
			if(value){
					location.href = '${pageContext.request.contextPath }/';
			}//if
		});//swal
	});
</script>
</body>
</html>