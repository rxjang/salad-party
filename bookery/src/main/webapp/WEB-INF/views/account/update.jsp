<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="co.salpa.bookery.model.entity.UserVo" %>
<!DOCTYPE>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Bookery</title>
	<%@ include file="../template/head.jspf" %>
	<style type="text/css">
	.update{
		display: flex;
		margin: 0px auto;
		width: 300px;
		text-align: center;
		overflow: hidden;
		margin-top: 100px;
	}
	.update input {
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
	.update input::-webkit-input-placeholder{
		color:#999;
		font-size:16px
	}
	.update input::placeholder{
		color:#999;
		font-size:16px
	}
	.tel{
		margin: 0px auto;
		float: left;
		margin-right:10px;
		text-align: center;
	}
	#updateBtn {
		width: 240px;
		height: 50px;
		border: none;
		background: linear-gradient(to right, rgb(19, 78, 94), rgb(113, 178, 128));
		color: rgb(193, 207, 178);
		font-size: 16px;
		margin-top: 5px;
		border-radius: 50px;
	}
	#updateBtn:hover{
		border: solid 1px #e4e4e4;
		color: white;
	}
	.message{
		color: #FC5B57;
		display: inherit;
	}
	#passwordChkMessage{
		font-size:12px;
	}
	.update-sub-menu{
		width: 100%;
		display: block;
		text-align: right;
	}
	.update-sub-menu>a{
		color: #999;
		margin-right: 15px;
		font-size: 12px;
	}
	</style>
	<script type="text/javascript">
	
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
	$('#updateForm').on('submit',function(){ //등록버튼 눌렀을 때 이벤트.
		/* console.log('서브밋'); */
		var contact = $('#tel1').val() + $('#tel2').val() + $('#tel3').val();
		var param = 'email=' + $('#email').val()+'&password='+$('#password').val()+'&name='+$('#name').val()+'&nickname='+$('#nickname').val()+'&tel='+contact;
		console.log(param);
		/* 
			비밀번호는 영문 + 숫자 조합, 8~12자리 
		*/
		var passwordVal = $('#password').val(); //비밀번호
		var signuppw2 = $('#passwordChk').val(); //비밀번호2
		var chk = $('#emailChk');
		
		$('#passwordMessage').text('');
		$('#passwordChkMessage').text('');
		$('#nameMessage').text('');
		$('#nicknameMessage').text('');
		$('#telMessage').text('');
		
		if($('#password').val() == ""){
			$('#passwordMessage').text('비밀번호를 입력해주세요.');
		}else if($('#name').val() == ""){
			$('#nameMessage').text('이름을 입력해주세요.');
		}else if($('#nickname').val() == "") {
			$('#nicknameMessage').text('닉네임을 입력해주세요.');
		}else if($('#nickname').val().length < 3) {
			$('#nicknameMessage').text('닉네임은 3자 이상 입력해주세요.');
		}else if($('#tel1').val() == "" || $('#tel2').val() == "" || $('#tel3').val() == ""){
			$('#telMessage').text('전화번호를 입력해주세요.');
		}else if(pwCheck(passwordVal)){
			//비밀번호 검증 하기.	영문이나 숫자가 포함되어야함., 포함되어있으면 false 영어나숫자만 true
			$('#passwordMessage').text('비밀번호는 영문 + 숫자 조합이어야 합니다.');
		}else if(passwordVal.length < 8 || passwordVal.length > 12){
			//비밀번호 길이는 8자~12자까지. 
			$('#passwordMessage').text('비밀번호는 8 ~ 12자리 입니다.');	
		}else if(passwordVal!=signuppw2){
			$('#emailChkMessage').text('비밀번호가 일치하지 않습니다.');	
		}else{
			$.ajax('${pageContext.request.contextPath}/account/update',{
				'method':'post',
				'data':param,
				'dataType': 'json',
				'success':function(data){
					var result = data.result;
					if(result == 'ok') {
						$('#cover').css('display', 'none');
						swal({
							  title: "정보 수정 완료",
							  text: "회원 정보 수정이 완료 되었습니다.",
							  icon: "success",
							  buttons: {
							  confirm:{
							    	text:"확인",
							    	value:true
							    }
							  },
						}).then((value) => {	//value가 true이면 로그인 페이지로 이동한다.
							if(value){
									location.reload();
							}//if
						});//swal						
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
	
     $('#tel1').focus(function(){
     	var keyEventCount1 = 0;
    	 $("#tel1").keyup(function(e){
      	   if(e.keyCode == 18) {
      		   return true;
      	   }
           keyEventCount1++;
           if(keyEventCount1 == 3 && $("#tel1").val().length == 3) {
         		$("#tel2").focus();
         		keyEventCount1 = 0;
         	 }
         	 else if($("#tel1").val().length == 0){
         		keyEventCount1 = 0;
         	 }
       	});
     });
       
     $('#tel2').focus(function(){
      var keyEventCount2 = 0;
	      	$("#tel2").keyup(function(e){
	      		if(e.keyCode == 18) return true;
	      			keyEventCount2++;
	     		if(keyEventCount2 == 4 && $("#tel2").val().length == 4) {
	     			$("#tel3").focus();
	     			keyEventCount2 = 0;
	     	  	}
	     	 	if($("#tel2").val().length == 0) {
	       			$("#tel1").focus();
	       	 }
	     });
    }); 
   	$("#tel3").keyup(function(){
   		if($("#tel3").val().length == 0) {
       		$("#tel2").focus();
       	 }
   	});
});//ready
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
function delchk() {
	swal({
		  title: "탈퇴 전 확인",
		  text: "정말로 탈퇴 하시겠습니까?",
		  icon: "info",
		  buttons: {
			cancel: "아니오", //취소버튼 false
		    confirm:{
		    	text:"네",
		    	value:true
		    }
		  },
	}).then((value) => {	//value가 true이면 내서재로 이동한다.
		if(value){
				location.href = '${pageContext.request.contextPath }/account/delete/${user.id}';
		}//if
	});//swal
	return false;
}
	</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<% 
	UserVo userBean = (UserVo)request.getAttribute("userBean");
	String mobile = userBean.getTel();
	String tel1 = "", tel2 = "", tel3 = "";
	if(mobile.length() == 10) {
		tel1 = mobile.substring(0,3);
		tel2 = mobile.substring(3,6);
		tel3 = mobile.substring(6,mobile.length());
	} else if(mobile.length() == 11) {
		tel1 = mobile.substring(0,3);
		tel2 = mobile.substring(3,7);
		tel3 = mobile.substring(7,mobile.length());
	}
%>
<!-- **********content start********** --> 
<div class="update">
	<div class="col-xs-12 col-md-12">
		<form method="post" id="updateForm">
				<!-- <h1><img src="" alt="Bookery" class="logo"></h1> -->
				<h1>정보수정</h1>
			 	<input type="text" placeholder="이메일" name="email" id="email" value="${userBean.email }" readonly/><span id="emailMessage" class="message"></span>
			 	<input type="hidden" id="emailChk" value="false" />
			 	<input type="password" placeholder="비밀번호" name="password" id="password" /><span id="passwordMessage" class="message"></span>
			 	<input type="password" placeholder="비밀번호 확인" name="passwordChk" id="passwordChk" /><span id="passwordChkMessage" class="message"></span>
			 	<input type="text" placeholder="이름" name="name" id="name" value="${userBean.name }"/><span id="nameMessage" class="message"></span>
			 	<input type="text" placeholder="닉네임" name="nickname" id="nickname" value="${userBean.nickname }"/><span id="nicknameMessage" class="message"></span>
			 	<input type="text" placeholder="010" name="tel1" id="tel1" class="tel" value="<%=tel1 %>" style="width: 80px;" onkeypress="onlyNumber();" maxlength="3" oninput="numberMaxLength(this);"/>
			 	<input type="text" placeholder="1234"name="tel2" id="tel2" class="tel" value="<%=tel2 %>" style="width: 80px;" onkeypress="onlyNumber();" maxlength="4" oninput="numberMaxLength(this);"/>
			 	<input type="text" placeholder="5678"name="tel3" id="tel3" class="tel" value="<%=tel3 %>" style="width: 80px;" onkeypress="onlyNumber();" maxlength="4" oninput="numberMaxLength(this);" />
			 	<span id="telMessage" class="message"></span>
				<button type="submit" class="btn btn-default updateBtn" id="updateBtn">정보수정</button>
		</form>
		<div class="update-sub-menu">
			<a href="#" onclick="delchk();">탈퇴하기</a>
		</div>
	</div>
	
</div>
<!-- **********content end********** --> 
<%@ include file="../template/footer.jspf" %>
</body>
</html>
