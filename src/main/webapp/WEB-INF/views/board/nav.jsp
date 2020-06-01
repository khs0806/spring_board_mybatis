<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/bootstrap.min.css">
<link rel="stylesheet" href="/resources/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style type="text/css">
		nav {
			margin:100px;
			margin-bottom:0px;
		}
		
		.nav-link {
	    	color: red;
			font-family: 맑은 고딕;
		}
	</style>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="/">HOME</a>
  <button class="navbar-toggler" type="button" 
  data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" 
  aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
   <div class="navbar-collapse collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
     	 <a class="nav-link" href="/board/list">목록</a>
      </li>
      <li class="nav-item">
     	 <a class="nav-link" href="/board/writeView">글 작성</a>
      </li>
      <li class="nav-item">
      	<c:if test="${member != null}"><a class="nav-link" href="/member/logout">로그아웃</a></c:if>
      	<c:if test="${member == null}"><a class="nav-link trigger-btn" href="#myModal" data-toggle="modal">로그인</a></c:if>
      </li>
      <li class="nav-item">
      	<c:if test="${member != null}">
      		<a class="nav-link" href="#">${member.userId}님 안녕하세요</a>
      	</c:if>
      </li>
    </ul>
  </div>
</nav>