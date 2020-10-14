<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../template/head.jspf" %>
<title>Bookery</title>

<script type="text/javascript">
var imgaeUrl;
$(function(){
	$('.thumbnail').click(function(){
		$('#coverimg').get(0).click();		
	});
	
	$('#coverimg').change(function(e) {
		$('#pic').attr('src',
				URL.createObjectURL(e.target.files[0]));
		
		imgaeUrl = URL.createObjectURL(e.target.files[0]);
		//$('#file').val((URL.createObjectURL(e.target.files[0])));
		console.log('카메라');
	$('#cover_upload').click();
	});//camera change
	
	
	$('#upload-form').on('submit',function(e) {
		e.preventDefault();
		//$("#cover_upload").prop("disabled", true);

		var form = $('#upload-form')[0];
		var data = new FormData(form);//form에 있는 데이터들 전송>>서버에 파일업로드>>ORC분석>>결과반환
		$.ajax('${pageContext.request.contextPath}/find/cover', {
			type:'post',
			enctype: 'multipart/form-data',
			data:data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
			success : function(data) {
				console.log(typeof data);
				console.log(data);
				console.log(data.url);
				//swal('책 이미지','등록완료','success');
				$('#coverurl').val(data.url);
			}//success
			,error: function (xhr, err) {
	               console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status);
	               console.log("responseText: " + xhr.responseText);
	           }
		});//ajax
		console.log('서브밋');
	});//submit
});
</script>

<style type="text/css">
	.direct-input{
		margin: 0px auto;
		text-align: center;
		overflow: hidden;
		margin-top: 30px;
	}
	.direct-input form{
		width:300px;
		display: block;
		margin: 0px auto;
		margin-bottom: 100px;
	}
	.direct-input input {
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
	.direct-input input::-webkit-input-placeholder{
		color:#999;
		font-size:16px
	}
	.direct-input input::placeholder{
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
		color: rgb(193, 207, 178);
		font-size: 12px;
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
		display: inherit;
	}
	#passwordChkMessage{
		font-size:12px;
	}
	#cover{
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		z-index: 100;
		opacity: 0.7;
		text-align: center;
		display: none;
	}
	iframe{
		width: 100%;
		height: 100%;
		position: absolute;
		left: 0;
		top: 0;
	}
	#cover_contents{
		width: 100%;
		height: 100%;
		position: absolute;
		left: 0px;
		top: 0px;
		background-color: #999;
		text-align: center;
	}
	h2{
		text-align:center;
		margin-top: 30px;
		color: black;
	}
.thumbnail { /*   */
	text-align: center;
	border: 1px solid rgb(221, 221, 221);
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1), 0 8px 20px rgba(0, 0, 0, .1);
	border-radius: 16px;
	transition-duration: 600ms;
	display: block;
	margin: auto;
	margin-top: 60px;
	margin-bottom: 40px;
	width:300px;
}

.thumbnail:hover { /*  반짝 */
	transition-duration: 600ms;
	border: 1px solid #8ba989;
	box-shadow: rgb(192, 207, 178) 0px 0px 6px;
	cursor: pointer;
}

.thumbnail img {
	margin-top: 10px;
	margin-bottom: 10px;
	width: 140px;
	height: 190px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1), 0 8px 20px rgba(0, 0, 0, .1);
}
#upload-form,#coverimg{
	display: none;
}

</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<!-- **********content start********** --> 
<div class="row">
	<h2>책 입력하기</h2>
</div>

<div class="row direct-input">
		<div class="col-md-2"></div>
		<div class="col-xs-12 col-md-8">
		<div class="col-xs-12 col-md-6">
			<div class="thumbnail">
				<img
					src='${pageContext.request.contextPath}/resources/imgs/no-image.png\'
					alt="loading fail" id="pic">
				<form action="#" id="upload-form" enctype="multipart/form-data">
					<input type="file" id="coverimg" name="coverimg" accept="image/*" />
					<button type="submit" id="cover_upload">submit</button>
				</form>
				<div class="caption">
					<p class="lead"><em>책 이미지 등록하기</em></p>
				</div>
			</div>



		</div>
		<div class="col-xs-12 col-md-6">
		<form method="post" action="${pageContext.request.contextPath }/find/direct/">
				<!-- <h1><img src="" alt="Bookery" class="logo"></h1> -->
			 	<input type="text" placeholder="제목" name="title" id="title" required="required"/> <!-- 필수 -->
			 	<input type="text" placeholder="원제목" name="titleoriginal" id="titleoriginal" />
			 	<input type="text" placeholder="글쓴이" name="writer" id="writer" required="required"/> <!-- 필수 -->
			 	<input type="text" placeholder="출판사" name="publisher" id="publisher" />
			 	<input type="date" placeholder="출간일" name="publicationdate" id="publicationdate" />
			 	<input type="text" placeholder="역자" name="translator" id="translator" />
			 	<input type="number" placeholder="페이지" name="pages" id="pages" required="required"/> <!-- 필수 -->
			 	<input type="text" placeholder="개정" name="revision" id="revision" />
			 	<input type="text" placeholder="분류" name="category" id="category" />
			 	<input type="hidden" placeholder="이미지주소" name="coverurl" id="coverurl" />
<!-- 			 	<input type="text" name="coverurl" id="coverurl" value=""/> -->
				<button type="submit" class="btn btn-default signupBtn" id="signupBtn">입력하기</button>
		</form>
	</div>
</div>
</div>
<!-- **********content end********** --> 
<%@ include file="../template/footer.jspf" %>
</body>
</html>