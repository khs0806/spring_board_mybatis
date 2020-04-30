<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="/resources/bootstrap.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="/resources/bootstrap.min.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>${read.title}</title>
	 	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
			
			// 수정 
			$(".update_btn").on("click", function(){
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			// 삭제
			$(".delete_btn").on("click", function(){
				
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
					
				formObj.attr("action", "/board/delete");
				formObj.attr("method", "post");
				formObj.submit();
					
				}
			})
			// 취소
			$(".list_btn").on("click", function(){
				
				location.href = "/board/list";
			})
			// 댓글 작성
			$(".replyWriteBtn").on("click", function(){
				  var formObj = $("form[name='replyForm']");
				  formObj.attr("action", "/board/replyWrite");
				  formObj.submit();
			});
			//댓글 수정 View
			$(".replyUpdateBtn").on("click", function(){
				location.href = "/board/updateViewReply?bno=${read.bno}"
								+ "&page=${scri.page}"
								+ "&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}"
								+ "&keyword=${scri.keyword}"
								+ "&rno="+$(this).attr("data-rno");
			});
					
			//댓글 삭제 View
			$(".replyDeleteBtn").on("click", function(){
				location.href = "/board/deleteViewReply?bno=${read.bno}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&rno="+$(this).attr("data-rno");
			});
		})
	</script>
	</head>
	
	<body>
		<div class="container">
			<header>
			<div>
				<%@include file="nav.jsp" %>
			</div>
			</header>
			<hr />
			<section id="container">
				<form name="readForm" role="form" method="post">
					<input type="hidden" id="bno" name="bno" value="${read.bno}" />
					<input type="hidden" id="page" name="page" value="${scri.page}"> 
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				</form>
			
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly" />
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content" name="content" class="form-control" readonly="readonly"><c:out value="${read.content}" /></textarea>
				</div>
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="writer" name="writer" class="form-control" value="${read.writer}"  readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">작성날짜</label>
					<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd" />	
				</div>
				<div>
					<button type="submit" class="update_btn btn btn-primary btn-xl" >수정</button>
					<button type="submit" class="delete_btn btn btn-primary btn-xl">삭제</button>
					<button type="submit" class="list_btn btn btn-primary btn-xl">목록</button>	
				</div>
				
				<!-- 댓글 -->
				<section class="comment-form">
				<div id="reply" >
				  <ol class="replyList">
				    <c:forEach items="${replyList}" var="reply">
				      <li>
				        <p class="comment-form-comment">
				        작성자 : ${reply.writer}<br />
				        작성 날짜 :  <fmt:formatDate value="${reply.regdate}" pattern="yyyy-MM-dd" />
				        </p>
				        <p class="comment-form-comment">${reply.content}</p>
				        <div>
						  <button type="button" class="replyUpdateBtn btn btn-warning" data-rno="${reply.rno}">수정</button>
						  <button type="button" class="replyDeleteBtn btn btn-danger" data-rno="${reply.rno}">삭제</button>
						</div>
				      </li>
				    </c:forEach>   
				  </ol>
				</div>
				</section>
				<form name="replyForm" method="post" class="form-horizontal">
					<label for="name">댓글 작성</label>
					<input type="hidden" id="bno" name="bno" value="${read.bno}" />
			        <input type="hidden" id="page" name="page" value="${scri.page}"> 
				    <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				    <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
				    <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
					<div class="container">
						<label for="name">name</label>
						<div class="input-group">
							<input type="text" class="form-control" id="writer" name="writer"
								placeholder="이름을 입력하세요.">
						</div>
					</div>
					<div class="container">
						<label for="comment">comment</label>
						<div class="input-group">
							<input type="text" class="form-control" id="content"
								name="content" placeholder="내용을 입력하세요.">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="replyWriteBtn btn btn-success">작성</button>
						</div>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>
		