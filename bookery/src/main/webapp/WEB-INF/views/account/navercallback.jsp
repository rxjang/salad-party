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
		var password = naver_id_login.getProfileData('id') + '_naver'; // password로 사용
		var email = naver_id_login.getProfileData('email');
		var name = naver_id_login.getProfileData('name');
		var nickname = naver_id_login.getProfileData('nickname');
		var tel = '';
		var param = 'email=' + email + '&password=' + password + '&name=' + name + '&nickname=' + nickname + '&tel=';
		/* var level = 'naver';
	    alert(naver_id_login.getProfileData('email')); */
	
	    $.ajax('${pageContext.request.contextPath}/account/navercallback',{
			'method':'post',
			'data':param,
			'dataType': 'json',
			'success':function(data){
				var result = data.result;
				if(result == 'login') {
					opener.location.href='${pageContext.request.contextPath }/account/login';
					window.close();
				} else if(result == 'nickname') {
					$('#nicknameMessage').text('이미 사용중인 닉네임 입니다. 다른 닉네임을 사용해주세요.');
				} else if(result == 'tel') {
					$('#telMessage').text('이미 등록된 연락처 입니다. 다른 연락처를 사용해주세요.');
				} else if(result == 'welcome') {
					$('#cover').css('display', 'none');
					swal({
						  title: "가입이 완료되었습니다.",
						  text: "북커리 회원이 되신 것을 축하합니다.",
						  icon: "success",
						  buttons: {
						  confirm:{
						    	text:"로그인 페이지로 이동",
						    	value:true
						    }
						  },
					}).then((value) => { //value가 true이면 로그인 페이지로 이동한다.
						if(value){
							opener.location.href='${pageContext.request.contextPath }/account/login';
							window.close();
						}//if
					});//swal			
				}
			},//success
			'error':function(){
				  swal('네이버 로그인 실패', '통신 장애','warning');
			}
			
		});//ajax
	  }
</script>
</body>
</html>