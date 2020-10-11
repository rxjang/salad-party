<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<% 	
	String dest = (String)session.getAttribute("dest");

	String ip = request.getHeader("X-Forwarded-For");
	   if (ip == null) ip = request.getRemoteAddr();
	   else if (ip == "127.0.0.1") ip = "localhost";
	   System.out.println(ip);
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
	.login-sub-menu>a{
		color: #999;
	}
	.separate{
		color: #999;
		margin: 0px 3px;
	}
	</style>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
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
            		 window.location.replace("http://<%=ip%>:"+<%=request.getServerPort()%> +""+ dest);
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
			 <!-- 네이버아이디로로그인 버튼 노출 영역 -->
		  <div id="naver_id_login" style="display:none;"></div>
		  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
		<c:set var="naverClientId">
	    	<spring:eval expression='@naver["naver.LoginClientId"]'/>
		</c:set>
			
		  <script type="text/javascript">
			  	var naver_id_login = new naver_id_login("${naverClientId}", "http://localhost:8080/bookery/account/navercallback");
			  	var state = naver_id_login.getUniqState();
			  	naver_id_login.setButton("white", 2,40);
			  	naver_id_login.setDomain("http://localhost:8080/bookery/account/login");
			  	naver_id_login.setState(state);
			  	naver_id_login.setPopup();
			  	naver_id_login.init_naver_id_login();
		  </script>
		  
			<a href="#"><img src="${pageContext.request.contextPath}/resources/imgs/kakaoLogin.png" alt="카카오로 로그인" class="img-circle" id="kakaoLogin" /></a>
			<img onclick="document.getElementById('naver_id_login_anchor').click();" src="${pageContext.request.contextPath}/resources/imgs/naverLogin.png" alt="네이버로 로그인" class="img-circle" id="naverLogin" />
		</div>
		<div class="login-sub-menu">
			<a href="${pageContext.request.contextPath}/account/join">회원가입</a>
			<span class="separate">|</span>
			<a href="${pageContext.request.contextPath}/account/find">아이디∙패스워드 찾기</a>
		</div>
	</div>
</div>
<!--  **********content end********** -->
<%@ include file="../template/footer.jspf" %>
</body>
</html>
</body>
</html>