<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="/resources/bootstrap.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="/resources/bootstrap.min.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>회원정보 수정</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	// 취소
	$(".cencle").on("click", function(){
		location.href = "/";
	})
	// 유효성 체크
	$("#submit").on("click", function(){
		if($("#userPw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#userPw").focus();
			return false;
		}
		if($("#userName").val()==""){
			alert("성명을 입력해주세요.");
			$("#userName").focus();
			return false;
		}
		$.ajax({
			url : "/member/idChk",
			type : "POST",
			dateType : "json",
			data : $("#userId").serializeArray(),
			success: function(data){
				console.log(data);
				if(data == 1){
					$("#updateForm").submit();
				}else{
					alert("아이디가 다릅니다.");
					return;
				}
			}
		})
	});
})
	</script>
<body>
	<section id="container">
		<form action="/member/memberUpdate" method="post" id="updateForm">
			<div class="form-group has-feedback">
				<label class="control-label" for="userId">아이디</label> <input
					class="form-control" type="text" id="userId" name="userId"
					value="${member.userId}" readonly="readonly" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="userPw">패스워드</label> <input
					class="form-control" type="password" id="userPw" name="userPw" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="userName">성명</label> <input
					class="form-control" type="text" id="userName" name="userName"
					value="${member.userName}" />
			</div>
		</form>
		<div class="form-group has-feedback">
			<button class="btn btn-success" type="button" id="submit">회원정보수정</button>
			<button class="cencle btn btn-danger" type="button">취소</button>
		</div>
	</section>

</body>

</html>
