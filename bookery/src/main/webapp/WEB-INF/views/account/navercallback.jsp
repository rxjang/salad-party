<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
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
		var name = naver_id_login.getProfileData('name');
		var nickname = naver_id_login.getProfileData('nickname');
		
	    alert(naver_id_login.getProfileData('email'));
	 /*    alert(naver_id_login.getProfileData('nickname'));
	    alert(naver_id_login.getProfileData('age')); */
	  }
</script>
</body>
</html>