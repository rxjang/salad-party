<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<% 	
	String dest = (String)session.getAttribute("dest");

	String ip = request.getHeader("X-Forwarded-For");
	   if (ip == null) ip = request.getRemoteAddr();
	 /*   else if (ip == "127.0.0.1") ip = "localhost"; */
%>
<!DOCTYPE>
<html>
	<head>
	<title>Bookery</title>
	<%@ include file="../template/head.jspf" %>
	<style type="text/css">
	.login{
		display: flex;
		margin: 0px auto;
		width: 300px;
		height:100%;
		text-align: center;
		overflow: hidden;
		margin-top: 100px;
	}
	.email-login-wrap{
		margin: 0px auto;
		width: 240px;
		margin-bottom: 12px;
	}
	.email-login-wrap input{
		margin-bottom:12px;
		border:none;
		border-bottom:1px solid #ccc;
		border-radius:2px;
		width:100%;
		height:40px;
		padding-left:12px;
		background-color:transparent;
		color:#999;
		font-size:16px
	}
	.phone-login-wrap input::-webkit-input-placeholder{
		color:#999;
		font-size:16px
	}
	.phone-login-wrap input::placeholder
	{
		color:#999;
		font-size:16px
	}
	#loginOption{
		margin-bottom: 10px;
	}
	.defaultLogin{
		width: 240px;
		height: 50px;
		border: none;
		background: linear-gradient(to right, rgb(19, 78, 94), rgb(113, 178, 128));
		color: rgb(193, 207, 178);
		font-size: 16px;
		border-radius: 50px;
		margin-top: 5px;
	}
	.defaultLogin:hover{
		border: solid 1px #e4e4e4;
		color: white;
	}
	.btn-area{
		height: 70px;
		padding: 0px;
		margin: 0px auto;
		margin-bottom: 10px;
	}
	#naverLogin{
		margin: 0px 10px;
		cursor: pointer;
	}
	#kakaoLogin{
		cursor: pointer;
	}
	.login-sub-menu>a{
		color: #999;
	}
	.separate{
		color: #999;
		margin: 0px 3px;
	}
	</style>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">
	var regMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	
	$(function(){
	      $('#loginForm').on('submit',function(){
	         frmSubmit();
	         return false;
	      });//submit
	      
	});//ready
	
	function frmSubmit() {
		var email = $('#email').val();
		var password = $('#password').val();
		console.log("submit!");
		if(email == '' || !regMail.test(email)) {
			$('#email').focus();
			$('#emailMessage').text('이메일을 입력하세요.');
			return false;
		}
		if(email != '' && password == '') {
			$('#password').focus();
			$('#passwordMessage').text('비밀번호를 입력하세요.');
			return false;
		}
		var param = "email=" + $('#email').val() + "&password=" + $('#password').val();
	    var url = "${pageContext.request.contextPath}/account/login";
 	    console.log(param);
 	   $.ajax({
           type: "POST",
           url: url,
           data: $('form').serialize(),
           dataType:"json",
         success : function(data) {
            var fail = data.result;
             if(fail == "fail") {
                swal("로그인 실패", "이메일과 비밀번호를 확인해주세요.","warning"); 
             }else{
            	 var dest = "<%=dest%>";
            	 if(dest != "null" && dest != "") {
            		 window.location.replace("http://<%=ip%>:"+<%=request.getServerPort()%> + dest);
            		 return false;
            	 } else {
                  	window.location.replace("${pageContext.request.contextPath }/"); 
            	 }
              }
          	 },//success
	         error:function(){
	            swal('로그인 실패', '통신 장애','warning');
	         }//error
   		});//ajax 
	
	}
	
	function validateEmail(email) {
		var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return re.test(email);
	}
	
	/* 로그인 관련 쿠키 생성 및 삭제 */
	function setCookie( name , value , expired ){
	 
	 var date = new Date();
	 date.setHours(date.getHours() + expired);
	 var expried_set = "expries="+date.toGMTString();
	 document.cookie = name + "=" + value + "; path=/;" + expried_set + ";"
	 
	}
	</script>
	</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start**********--> 
<div class="login">
	<div class="col-xs-12 col-md-12">
		<form method="post" name="loginForm" id="loginForm">
	 		<div class="email-login-wrap">
				<!-- <h1><img src="" alt="Bookery" class="logo"></h1> -->
				<h1>Bookery</h1>
			 	<input type="text" placeholder="이메일" name="email" id="email" /><span id="emailMessage"></span>
			 	<input type="password" placeholder="비밀번호" name="password" id="password" /><span id="passwordMessage"></span>
				<button type="submit" class="btn btn-default defaultLogin" id="defaultLogin">이메일로 로그인</button>
			</div>
		</form>
		<!----><!----><!----><!----> 
		<img src="${pageContext.request.contextPath}/resources/imgs/loginOption.png" style="width:240px; height:20px;" id="loginOption">
		<div class="btn-area"><!---->
		
		<c:set var="naverClientId">
	    	<spring:eval expression='@naver["naver.LoginClientId"]'/>
		</c:set>
		<c:set var="kakaoAppKey">
	    	<spring:eval expression='@naver["kakao.LoginkakaoAppKey"]'/>
	    </c:set>
	    
			 <!-- 네이버아이디로로그인 버튼 노출 영역 -->
		  <div id="naver_id_login" style="display:none;"></div>
		  <a id="kakao-login-btn" style="display:none;"></a>
		  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
		
		  <script type="text/javascript">
		  		// naver Login start
			  	var naver_id_login = new naver_id_login("${naverClientId}", "http://localhost:8080/bookery/account/navercallback");
			  	var state = naver_id_login.getUniqState();
			  	naver_id_login.setButton("white", 2,40);
			  	naver_id_login.setDomain("http://localhost:8080/bookery/account/login");
			  	naver_id_login.setState(state);
			  	naver_id_login.setPopup();
			  	naver_id_login.init_naver_id_login();
			  	// naver Login end
			  	
			  	// kakao Login start
			  	Kakao.init("${kakaoAppKey}");
				Kakao.isInitialized();
				
				Kakao.Auth.createLoginButton({
				    container: '#kakao-login-btn',
				    success: function(authObj) {
				      Kakao.API.request({
				        url: '/v2/user/me',
				        success: function(res) {
				        	console.log(JSON.stringify(res));
				          /* alert(JSON.stringify(res)); */
				         /*  {"id":1503885531,"connected_at":"2020-10-15T04:29:56Z","properties":{"nickname":"김지우","profile_image":"http://k.kakaocdn.net/dn/dgQSOc/btqKSVe8KIk/TiC0slgwsOME4U989K8bi0/img_640x640.jpg","thumbnail_image":"http://k.kakaocdn.net/dn/dgQSOc/btqKSVe8KIk/TiC0slgwsOME4U989K8bi0/img_110x110.jpg"},"kakao_account":{"profile_needs_agreement":false,"profile":{"nickname":"김지우","thumbnail_image_url":"http://k.kakaocdn.net/dn/dgQSOc/btqKSVe8KIk/TiC0slgwsOME4U989K8bi0/img_110x110.jpg","profile_image_url":"http://k.kakaocdn.net/dn/dgQSOc/btqKSVe8KIk/TiC0slgwsOME4U989K8bi0/img_640x640.jpg"},"has_email":true,"email_needs_agreement":false,"is_email_valid":true,"is_email_verified":true,"email":"jiw00kim227@gmail.com"}} */
				          var id = res.id;
				          var email = res.kakao_account.email;
				          var password = id;
				          if(email == '' || email == null || email.length ==0 ) email = id;
				          var nickname = res.properties.nickname;
				          var lvl = 'kakao';
				          var name = nickname;
				          var param = "email=" + email + "&password=" + password + "&name=" + name + "&nickname=" + nickname + "&lvl=" + lvl;
				          $.ajax({
				              type: "POST",
				              url: "${pageContext.request.contextPath}/account/kakaocallback",
				              data: param,
				              dataType:"json",
				            success : function(data) {
				               var result = data.result;
				                if(result == "fail") {
				                   swal("로그인 실패", "이메일과 비밀번호를 확인해주세요.","warning"); 
				                } else if(result == "test") {
				                	console.log()
				            	}else{
				               	 var dest = "<%=dest%>";
					               	 if(dest != "null" && dest != "") {
					               		 window.location.replace("http://<%=ip%>:"+<%=request.getServerPort()%> + dest);
					               		 return false;
					               	 } else {
					                     	window.location.replace("${pageContext.request.contextPath }/"); 
					               	 }
				                }
				            },//success
				   	         error:function(){
				   	            swal('로그인 실패', '통신 장애','warning');
				   	         }//error
				      		});//ajax 
				        },
				        fail: function(error) {
				          alert(
				            'login success, but failed to request user information: ' +
				              JSON.stringify(error)
				          )
				        },
				      })
				    },
				    fail: function(err) {
				      alert('failed to login: ' + JSON.stringify(err))
				    },
				  })
			  	// kakao Login end
			  	
		  </script>
		  
			<img onclick="document.getElementById('kakao-login-btn').click();" src="${pageContext.request.contextPath}/resources/imgs/kakaoLogin.png" alt="카카오로 로그인" class="img-circle" id="kakaoLogin" />
			<img onclick="document.getElementById('naver_id_login_anchor').click();" src="${pageContext.request.contextPath}/resources/imgs/naverLogin.png" alt="네이버로 로그인" class="img-circle" id="naverLogin" />
		</div>
		<div class="login-sub-menu">
			<a href="${pageContext.request.contextPath}/account/join">회원가입</a>
			<span class="separate">|</span>
			<a href="${pageContext.request.contextPath}/account/find">아이디∙패스워드 찾기</a>
			
			<p id="token-result"></p>
		</div>
	</div>
</div>
<!--  **********content end********** -->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
</body>
</html>