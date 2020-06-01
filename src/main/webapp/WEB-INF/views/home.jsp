<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>김현수의 게시판</title>
<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
	$("#logoutBtn").on("click", function(){
		location.href="member/logout";
	});
	$("#registerBtn").on("click", function(){
		location.href="member/register";
	});
	
	$("#memberUpdateBtn").on("click", function(){
		location.href="member/memberUpdateView";
	});
	$("#memberDeleteBtn").on("click", function(){
		location.href="member/memberDeleteView";
	});
})
</script>
</head>
<body>
	<div class="jumbotron">
		<h2 class="display-3" style="text-align: center;">Welcome, KHS's blog!</h2>
		<p class="lead" style="text-align: center;">김현수의 게시판에 오신 걸 환영합니다.</p>
		<hr class="my-4">
		<c:if test="${member == null}">
		<p class="lead" align = "center">
			<a href="#myModal" class="trigger-btn btn-primary btn-lg" data-toggle="modal" >로그인 하기</a>
		</p>
		</c:if>
		<p class="lead" align = "center">
			<a href="/board/list" class="btn btn-primary btn-lg">게시판 입장</a><br/>
		</p>
	</div>
	<div class="container">
	  <div class="row">
	    <div class="col-sm-4">
	      <h3>Column 2</h3>
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
	      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
	    </div>
	  </div>
	</div>	
<%-- 	<c:if test="${member == null}">
		<div class="text-center">
			<!-- Button HTML (to Trigger Modal) -->
			<a href="#myModal" class="trigger-btn" data-toggle="modal">로그인 하기</a>
		</div>
	</c:if> --%>	
	<c:if test="${member != null}">
		<div>
			<p>${member.userId}님 환영 합니다.</p>
			<a href="/board/list">게시판</a><br />
			<button id="memberUpdateBtn" type="button">회원정보 수정</button>
			<button id="memberDeleteBtn" type="button">회원탈퇴</button>
			<button id="logoutBtn" type="button">로그아웃</button>
		</div>
	</c:if>
	<c:if test="${msg == false}">
		<p>로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
	</c:if>
<!-- Modal HTML -->
	<div id="myModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<div class="avatar">
						<img src="/resources/image/img-01.png" alt="Avatar">
					</div>				
					<h4 class="modal-title">로그인</h4>	
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<form action="/member/login" method="post">
						<div class="form-group">
							<input type="text" class="form-control" name="userId" placeholder="아이디" required="required">		
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="userPw" placeholder="비밀번호" required="required">	
						</div>        
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-lg btn-block login-btn">Login</button>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a href="/member/register">회원가입</a>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>                            