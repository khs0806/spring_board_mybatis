<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="/resources/bootstrap.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="/resources/bootstrap.min.css">
		
	 	<title>게시판</title>
	 	<style type="text/css">
	 		.pagination a.active {
	 			cursor: default;
	 			color: #ffffff;
	 		}
	 		.pagination a:active {
				outline: none;	 		
	 		}
			.navbar .nav-link {
				font-family: 맑은 고딕;
		    	color: rgb(255, 255, 255);
		    	font-weight: bold;
			}
			.navbar .nav-link a:hover{
				color: yellow;
			}
			div[id="container"] {
				margin:0 100px;
			}
			div .search {
				padding:15px;
			}
			
	 	</style>
	</head>
	<body>
			<header>
			 <div>
				<%@include file="nav.jsp" %>
			</div>
			</header>
		<div id="container" >
		<section id="container">
				<form role="form" method="get">
					<table class="table table-striped" style="margin: 0 auto;">
						<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th><th>조회수</th></tr>
						
						<c:forEach items="${list}" var = "list">
							<tr>
								<td><c:out value="${list.bno}" /></td>
								<td>
									<a href="/board/readView?bno=${list.bno}"><c:out value="${list.title}" /></a>
								</td>
								<td><c:out value="${list.writer}" /></td>
								<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
								<td><c:out value="${list.hit}"/></td>
							</tr>
						</c:forEach>
					</table>
					  <div class="search row form-group" >
					    <div>
					 	   <a class="create btn btn-success float-right" href="/board/writeView">글 작성하기</a>
					    </div>
					  	<div class="col-xs-2 col-sm-1" style="text-align:center">
						    <select name="searchType" style="vertical-align:middle" class="custom-select">
						      <option value="t"<c:out value="${scri.searchType eq \"t\" ? 'selected=\"selected\"' : ''}"/>>제목</option>
						      <option value="c"<c:out value="${scri.searchType eq \"c\" ? 'selected=\"selected\"' : ''}"/>>내용</option>
						      <option value="w"<c:out value="${scri.searchType eq \"w\" ? 'selected=\"selected\"' : ''}"/>>작성자</option>
						      <option value="tc"<c:out value="${scri.searchType eq \"tc\" ? 'selected=\"selected\"' : ''}"/>>제목+내용</option>
						    </select>
				        </div>
				        	<!-- 글 검색 -->
							<div class="input-group" style="flex:1; float: right;">
					   		  <input class="form-control col-sm-3" placeholder="Search"
					   		  type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>
								<span class="input-group-btn" style="margin-left: 10px;">
					   	   		  <button id="searchBtn" 
					   	   		  class="btn btn-secondary my-2 my-sm-0"type="button" >검색</button>
					    		</span>
						    </div >
						    <script>
						      $(function(){
						        $('#searchBtn').click(function() {
						          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
						        });
						      });   
						    </script>
						  </div>
						  <hr>
						<!-- 페이징 -->  
						<div>
							<ul class="pagination" style="justify-content: center;">
							<li class="page-item"><a class="page-link"
									href="list${pageMaker.makeSearch(1)}">처음</a></li>
							<c:if test="${pageMaker.prev}">
								<li class="page-item"><a class="page-link"
									href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
							</c:if>
	
							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
							</c:forEach>
	
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li class="page-item"><a class="page-link"
									href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
							</c:if>
							</ul>
						</div>
				</form>
			</section>
			<hr />
			
		</div>
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