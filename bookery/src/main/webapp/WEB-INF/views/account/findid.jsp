<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Bookery</title>
	<%@ include file="../template/head.jspf" %>
	<style type="text/css">
	.findid{
		display: flex;
		margin: 0px auto;
		width: 300px;
		height:100%;
		text-align: center;
		overflow: hidden;
		margin-top: 100px;
	}
	.findid input {
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
	.findid input::-webkit-input-placeholder{
		color:#999;
		font-size:16px
	}
	.findid input::placeholder{
		color:#999;
		font-size:16px
	}
	.tel{
		margin: 0px auto;
		float: left;
		margin-right:10px;
		text-align: center;
	}
	#findidBtn {
		width: 240px;
		height: 50px;
		border: none;
		background: linear-gradient(to right, rgb(19, 78, 94), rgb(113, 178, 128));
		color: rgb(193, 207, 178);
		font-size: 16px;
		border-radius: 50px;
		margin-top: 5px;
	}
	#findidBtn:hover{
		border: solid 1px #e4e4e4;
		color: white;
	}
	</style>
	<script type="text/javascript">
	$(function(){
		$('#findidForm').on('submit',function(){ //등록버튼 눌렀을 때 이벤트.
		/* 	console.log('서브밋'); */
			
			var contact = $('#tel1').val() + $('#tel2').val() + $('#tel3').val();
			var param = 'name='+$('#name').val()+'&tel='+contact;
			/* console.log(param); */
			
			$('#nameMessage').text('');
			$('#telMessage').text('');
			
			if($('#name').val() == ""){
				$('#nameMessage').text('이름을 입력해주세요.')
			}else if($('#tel1').val() == "" || $('#tel2').val() == "" || $('#tel3').val() == ""){
				$('#telMessage').text('전화번호를 입력해주세요.');
			}else {
				$.ajax('${pageContext.request.contextPath}/account/findid',{
					'method':'post',
					'data':param,
					'dataType': 'json',
					'success':function(data){
						var result = data.result;
						var lvl = data.lvl;
						
						if(result != 'fail') {
							if(lvl == 'naver' || lvl == 'kakao') {
								if(lvl == 'naver') lvl = '네이버';
								if(lvl == 'kakao') lvl = '카카오';
								swal({
									  title: "가입 이메일 확인",
									  text: "회원은 " + lvl +"통해 가입하셨습니다. \n " + lvl +"로 로그인 해주세요.",
									  icon: "success",
									  buttons: {
									    confirm:{
									    	text:"로그인 페이지로 이동",
									    	value:true
									    }
									  },
								}).then((value) => {	//value가 true이면 로그인 페이지로 이동한다.
									if(value){
											location.href = '${pageContext.request.contextPath }/account/login';
									}//if
								});//swal		
							} else{
								swal({
									  title: "가입 이메일 확인",
									  text: "회원님의 이메일 계정은 \'" + result  + "\' 입니다.",
									  icon: "success",
									  buttons: {
									    confirm:{
									    	text:"로그인 페이지로 이동",
									    	value:true
									    }
									  },
								}).then((value) => {	//value가 true이면 로그인 페이지로 이동한다.
									if(value){
											location.href = '${pageContext.request.contextPath }/account/login';
									}//if
								});//swal			
							}//else		
						} else if(result == 'fail') {
						    swal("계정 조회 실패", "가입된 이력이 없는 회원 정보입니다.\n 이름과 연락처를 확인해주세요.","warning");
						} else {
							  swal("계정 조회 실패", "가입된 이력이 없는 회원 정보입니다.\n 이름과 연락처를 확인해주세요.","warning");
						}
					}, //success
					error:function(){
				            swal('계정 조회 실패', '통신 장애','warning');
				    }//error
					
				});//ajax
				
			}//else			
			return false;
		});//submit
		
	     $('#tel1').focus(function(){
	     	var keyEventCount1 = 0;
	    	 $("#tel1").keyup(function(e){
	      	   if(e.keyCode == 18) return true;
	          	
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
		      		if(e.keyCode == 18) {
		      			return true;
		      		}
		      	/* 	console.log(keyEventCount2); */
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
	</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start********** --> 
<div class="findid">
	<div class="col-xs-12 col-md-12">
		<form method="post" id="findidForm">
				<!-- <h1><img src="" alt="Bookery" class="logo"></h1> -->
				<h1>이메일 찾기</h1>
			 	<input type="text" placeholder="이름" name="name" id="name" /><span id="nameMessage" class="message"></span>
			 	<input type="text" placeholder="010" name="tel1" id="tel1" class="tel" style="width: 80px;" onkeypress="onlyNumber();" maxlength="3" oninput="numberMaxLength(this);"/>
			 	<input type="text" placeholder="1234"name="tel2" id="tel2" class="tel" style="width: 80px;" onkeypress="onlyNumber();" maxlength="4" oninput="numberMaxLength(this);"/>
			 	<input type="text" placeholder="5678"name="tel3" id="tel3" class="tel" style="width: 80px;" onkeypress="onlyNumber();" maxlength="4" oninput="numberMaxLength(this);" />
				<button type="submit" class="btn btn-default findidBtn" id="findidBtn">이메일 찾기</button>
		</form>
	</div>
</div>
<!-- **********content end********** --> 
<%@ include file="../template/footer.jspf" %>
</body>
</html>