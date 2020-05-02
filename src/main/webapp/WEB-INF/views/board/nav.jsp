<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="/">HOME</a>

  <div class="collapse navbar-collapse" id="navbarColor02">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
     	 <a class="nav-link" href="/board/list">목록</a>
      </li>
      <li class="nav-item">
     	 <a class="nav-link" href="/board/writeView">글 작성</a>
      </li>
      <li class="nav-item">
      	<c:if test="${member != null}"><a class="nav-link" href="/member/logout">로그아웃</a></c:if>
      	<c:if test="${member == null}"><a class="nav-link" href="/">로그인</a></c:if>
      </li>
      <li class="nav-item">
      	<c:if test="${member != null}">
      		<p>${member.userId}님 안녕하세요</p>
      	</c:if>
      </li>
      
    </ul>
  </div>
</nav>