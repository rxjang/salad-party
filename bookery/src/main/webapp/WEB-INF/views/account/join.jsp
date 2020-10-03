<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Bookery</title>
	<%@ include file="../template/head.jspf" %>
	<style type="text/css">
	.join{
		display: flex;
		margin: 0px auto;
		width: 300px;
		text-align: center;
		overflow: hidden;
	}
	.join input {
		margin-bottom:12px;
		border:none;
		border-bottom:1px solid #ccc;
		border-radius:2px;
		width:100%;
		height:40px;
		padding-left:12px;
		background-color:transparent;
		color:black;
		font-size:16px;
	}
	.join input::-webkit-input-placeholder{
		color:#999;
		font-size:16px
	}
	.join input::placeholder{
		color:#999;
		font-size:16px
	}
	.tel{
		margin: 0px auto;
		float: left;
		margin-right:10px;
		text-align: center;
	}
	#emailChkBtn{
		text-align:center;
		margin: 0px auto;
		width: 150px;
		height: 25px;
		border: none;
		background:linear-gradient(to right, rgb(19, 78, 94), rgb(113, 178, 128));
		color: rgb(169, 234, 58);
		font-size:12px;
		border-radius: 50px;
	}
	#signupBtn {
		width: 240px;
		height: 50px;
		border: none;
		background: linear-gradient(to right, rgb(19, 78, 94), rgb(113, 178, 128));
		color: rgb(193, 207, 178);
		font-size: 16px;
		border-radius: 50px;
	}
	#signupBtn:hover{
		border: solid 1px #e4e4e4;
		color: white;
	}
	#emailChkBtn:hover{
		border: solid 1px #e4e4e4;
		color: white;
	}
	.message{
		color: #FC5B57;
	}
	#passwordChkMessage{
		font-size:12px;
	}
	</style>
	<script type="text/javascript">
	var regMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'\",.<>\/?]).{8,16}$/);
	
	var overlapCheck;
	function pwCheck(passwordVal){
		var chek_num = passwordVal.search(/[0-9]/g);
		var chek_eng = passwordVal.search(/[a-z]/g);
		if(chek_num<0 || chek_eng<0){
			return true;
		}else{
			return false;
		}	
	}
	
	$(function(){
	$('#joinForm').on('submit',function(){ //등록버튼 눌렀을 때 이벤트.
		console.log('서브밋');
		var emailVal = $("#email").val(); // 입력된 e-mail 
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var contact = $('#tel1').val() + $('#tel2').val() + $('#tel3').val();
		var param = 'email=' + $('#email').val()+'&password='+$('#password').val()+'&name='+$('#name').val()+'&nickname='+$('#nickname').val()+'&tel='+contact;
		console.log(param);
		/* 
			비밀번호는 영문 + 숫자 조합, 8~12자리 
		*/
		var passwordVal = $('#password').val(); //비밀번호
		var signuppw2 = $('#passwordChk').val(); //비밀번호2
		var chk = $('#emailChk');
		
		$('#emailMessage').text('');
		$('#passwordMessage').text('');
		$('#passwordChkMessage').text('');
		$('#nameMessage').text('');
		$('#telMessage').text('');
		
		if($('#email').val() == ""){
			$('#emailMessage').text('이메일을 입력해주세요.');
		}else if($('#password').val() == ""){
			$('#passwordMessage').text('비밀번호를 입력해주세요.');
		}else if($('#name').val() == ""){
			$('#nameMessage').text('이름을 입력해주세요.')
		}else if($('#tel1').val() == "" || $('#tel2').val() == "" || $('#tel3').val() == ""){
			$('#telMessage').text('전화번호를 입력해주세요.');
		}else if(emailVal.match(regExp) == null){
			('#emailMessage').text('아이디는 이메일 형식 입니다.');
		}else if($('#emailChk').val() != 'true'){
			$('#emailMessage').text('아이디 중복확인을 해주세요.');
		}else if(pwCheck(passwordVal)){
			//비밀번호 검증 하기.	영문이나 숫자가 포함되어야함., 포함되어있으면 false 영어나숫자만 true
			$('#passwordMessage').text('비밀번호는 영문 + 숫자 조합이어야 합니다.');
		}else if(passwordVal.length < 8 || passwordVal.length > 12){
			//비밀번호 길이는 8자~12자까지. 
			$('#passwordMessage').text('비밀번호는 8 ~ 12자리 입니다.');	
		}else if($('#emailChk').val() == 'false'){
			$('#emailMessage').text('아이디 중복확인을 해주세요.');
		}else if(passwordVal!=signuppw2){
			$('#emailChkMessage').text('비밀번호가 일치하지 않습니다.');	
		}else{
			$.ajax('${pageContext.request.contextPath}/account/join',{
				'method':'post',
				'data':param,
				'dataType': 'json',
				'success':function(data){
					var result = data.result;
					if(result == 'ok') {
						swal('가입 완료', '북커리 회원이 되신 것을 축하합니다.', 'success');
						window.location.replace("${pageContext.request.contextPath }/account/login");						
					} else if(result == 'nickname') {
						$('#nicknameMessage').text('이미 사용중인 닉네임 입니다. 다른 닉네임을 사용해주세요.');
					} else if(result == 'tel') {
						$('#telMessage').text('이미 등록된 연락처 입니다. 다른 연락처를 사용해주세요.');
					}
				}//success
				
			});//ajax
			
		}//else			
		return false;
	});//submit
	
	$('#email').on('keyup', function(){
		$('#emailChk').val('false');
		var chk_id = $('#email').val();
		$('#emailChkBtn').css('display', 'none');
		
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(chk_id == ''){
			$('#emailMessage').text('이메일을 입력해주세요.');
		}else if(chk_id.match(regExp) == null){
			$('#emailMessage').text('아이디는 이메일 형식입니다.');
		}else{
			$('#emailMessage').text('');
			$('#emailChkBtn').css('display', 'block');
		}
	});
		
	$('#password').on('keyup',function() {
		signuppw1 = $('#password').val();		//비밀번호1
		
		if(pwCheck(signuppw1)){
			$('#passwordMessage').text('비밀번호는 영문+숫자 조합이어야 합니다');
		}else if(signuppw1.length<8||signuppw1.length>12){
			$('#passwordMessage').text('비밀번호는 8~12 자리입니다');
		}else{
			$('#passwordMessage').text('');
		}
	});
	
	$('#passwordChk').on('keyup',function(){
		signuppw1 = $('#password').val();		//비밀번호1
		signuppw2 = $('#passwordChk').val();		//비밀번호2
		
		if(signuppw2 == ''){
			$('#passwordChkMessage').text('비밀번호를 한번 더 입력해주세요.');
		}else if((signuppw1 == signuppw2) && (signuppw2 != null)){
			$('#passwordChkMessage').text('');
		}else{
			$('#passwordChkMessage').text('비밀번호가 일치하지 않습니다.다시 입력해주세요.');
		}
	});
	
     var keyEventCount1 = 0;
       $("#tel1").keyup(function(e){
    	   if(e.keyCode == 18) return true;
        	console.log(keyEventCount1, $("#tel1").val().length);
        	keyEventCount1++;
       	  if(keyEventCount1 == 3 && $("#tel1").val().length == 3) {
       		 $("#tel2").focus();
       		keyEventCount1 = 0;
       	 }
 
     	});
        
      var keyEventCount2 = 0;
      	$("#tel2").keyup(function(e){
      		if(e.keyCode == 18) return true;
      		console.log(keyEventCount1);
      		keyEventCount2++;
     	  if(keyEventCount2 == 4 && $("#tel2").val().length == 4) {
     		 $("#tel3").focus();
     		keyEventCount2 = 0;
     	  }
     	 if($("#tel2").val().length == 0) {
       		 $("#tel1").focus();
       	 }
     });
      
	   	$("#tel3").keyup(function(){
	   		console.log("tel3");
	   		if($("#tel3").val().length == 0) {
	       		 $("#tel2").focus();
	       	 }
	   	});
	$('#emailChkBtn').on('click',function(){ // 아이디 중복검사 버튼
		var chk_id=$('#email').val();
		$('#emailChk').val('false');
		$('#emailMessage').css('color', '#FC5B57');
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(chk_id == ''){
			$('#emailMessage').text('이메일을 입력해주세요.');
			return;
		}else if(chk_id.match(regExp) == null){
			$('#emailMessage').text('아이디는 이메일 형식 입니다.');
		}else{
			 $.ajax('${pageContext.request.contextPath}/account/chkEmail',{ //idoverlapcheck.java
				'method':'post',
				'data':'email='+chk_id,
				'dataType': 'json',
				'success':function(data){
				 var result = data.result;
					if(result == 'ok'){
						$('#emailChk').val('true');
					 	console.log('성공', $(data).find('overlap').text());
					 	$('#emailChkBtn').css('display', 'none');
					 	$('#emailMessage').text('중복 확인 완료').css('color', 'blue');
					} else if(result == 'fail'){
						$('#emailMessage').css('white-space', 'pre-line');
						$('#emailMessage').text('이미 등록된 이메일 입니다.         다른 이메일을 사용해주세요.');
					}
				},
				'error':function(){
					console.log('error');
				}
			})//ajax
		}
	});//click
}	);//ready
function onlyNumber(e){
    if((event.keyCode<48)||(event.keyCode>57)) {
       event.returnValue = false;    	
    }
}
function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}
	</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start********** --> 
<div class="join">
	<div class="col-xs-12 col-md-12">
		<form method="post" id="joinForm">
				<!-- <h1><img src="" alt="Bookery" class="logo"></h1> -->
				<h1>회원가입</h1>
			 	<input type="text" placeholder="이메일" name="email" id="email" /><span id="emailMessage" class="message"></span>
			 	<input type="hidden" id="emailChk" value="false" />
			 	<button type="button" id="emailChkBtn" style="display: none;">중복확인</button>
			 	<input type="password" placeholder="비밀번호" name="password" id="password" /><span id="passwordMessage" class="message"></span>
			 	<input type="password" placeholder="비밀번호 확인" name="passwordChk" id="passwordChk" /><span id="passwordChkMessage" class="message"></span>
			 	<input type="text" placeholder="이름" name="name" id="name" /><span id="nameMessage" class="message"></span>
			 	<input type="text" placeholder="닉네임" name="nickname" id="nickname" /><span id="nicknameMessage" class="message"></span>
			 	<input type="text" placeholder="010" name="tel1" id="tel1" class="tel" style="width: 80px;" onkeypress="onlyNumber();" maxlength="3" oninput="numberMaxLength(this);"/>
			 	<input type="text" placeholder="1234"name="tel2" id="tel2" class="tel" style="width: 80px;" onkeypress="onlyNumber();" maxlength="4" oninput="numberMaxLength(this);"/>
			 	<input type="text" placeholder="5678"name="tel3" id="tel3" class="tel" style="width: 80px;" onkeypress="onlyNumber();" maxlength="4" oninput="numberMaxLength(this);" />
			 	<span id="telMessage" class="message"></span>
				<button type="submit" class="btn btn-default signupBtn" id="signupBtn">회원가입</button>
		</form>
	</div>
</div>
<!-- **********content end********** --> 
<%@ include file="../template/footer.jspf" %>
</body>
</html>
