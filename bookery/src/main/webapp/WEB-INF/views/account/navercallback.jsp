<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<% 	
	String dest = (String)session.getAttribute("dest");

	String ip = request.getHeader("X-Forwarded-For");
	   if (ip == null) ip = request.getRemoteAddr();
	 /*   else if (ip == "127.0.0.1") ip = "localhost"; */
%>
<!Doctype html>
	<head>
		<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<%@ include file="../template/head.jspf" %>
	</head>
<body>
		<c:set var="naverClientId">
	    	<spring:eval expression='@naver["naver.LoginClientId"]'/>
		</c:set>
<script type="text/javascript">
 	 var naver_id_login = new naver_id_login("${naverClientID}", "http://localhost:8080/bookery/account/navercallback");
	  // 접근 토큰 값 출력
	  /* alert(naver_id_login.oauthParams.access_token); */
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	  function naverSignInCallback() {
		var email = naver_id_login.getProfileData('email');
		var password = naver_id_login.getProfileData('id');
		var name = naver_id_login.getProfileData('name');
		var nickname = naver_id_login.getProfileData('nickname');
		var lvl = "naver";
		
		if(email != null && email != ''){
			var param = 'email=' + email + '&password=' + password + '&name=' + name + '&nickname=' + nickname + '&lvl=' + lvl;
			/* var level = 'naver';
		    alert(naver_id_login.getProfileData('email')); */
		
		    $.ajax('${pageContext.request.contextPath}/account/navercallback',{
				'method':'post',
				'data':param,
				'dataType': 'json',
				'success':function(data){
					var result = data.result;
					if(result == 'login') {
						 var dest = "<%=dest%>";
		            	 if(dest != "null" && dest != "") {
		            		opener.location.replace("http://<%=ip%>:"+<%=request.getServerPort()%> + dest);
		            		self.close();
		            	 } else {
							opener.location.href='${pageContext.request.contextPath }/';
							self.close();
		            	 }
					} else if(result == 'bookerylogin') {
						swal({
							  title: "알림",
							  text: "북커리 계정으로 가입된 이력이 있습니다.\n 북커리 로그인을 이용해주세요.",
							  icon: "warning",
							  buttons: {
							    confirm:{
							    	text:"확인",
							    	value:true
							    }
							  },
						}).then((value) => {	//value가 true이면 내서재로 이동한다.
							if(value){
									self.close();
									window.opener.document.location.reload();
							}//if
						});//swal
							
					} else {
						swal({
							  title: "네이버 로그인 실패",
							  text: "다시 시도해 주세요.",
							  icon: "error",
							  buttons: {
							    confirm:{
							    	text:"확인",
							    	value:true
							    }
							  },
						}).then((value) => {	//value가 true이면 내서재로 이동한다.
							if(value){
									self.close();
									window.opener.document.location.reload();
							}//if
						});//swal
						
					}
				},//success
				'error':function(){
					  swal('네이버 로그인 실패', '통신 장애','warning');
				}
				
			});//ajax
		} //if
		else {
			window.close();
			swal('네이버 로그인 실패', '네이버 계정을 확인해주세요.', 'error');
		}
	  }
</script>
</body>
</html>