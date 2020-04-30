<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="/resources/bootstrap.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="/resources/bootstrap.min.css">
	 	<title>게시판</title>
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<style>
	 		
	 	</style>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/list";
			})
		})
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	</script>
	<body>
	
		<div id="root">
			<header>
			<div>
				<%@include file="nav.jsp" %>
			</div>
			</header>
			<hr />
			
			<section id="container" style="width:70%; margin: 0 auto;">
			<form name="writeForm" role="form" method="post" action="/board/write">
					<legend>글 작성하기</legend>
					<hr>
					<div class="form-group">
						<label for="title">제목</label>
						<input type="text" class="form-control chk" id="title" name="title"
							aria-describedby="emailHelp" placeholder="Title"> 
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea class="form-control chk" id="content" rows="3"
							name="content" placeholder="Contents"></textarea>
					</div>
					<div class="form-group">
						<label for="user">작성자</label>
						<input type="text" class="form-control chk" id="writer" name="writer"
							aria-describedby="emailHelp" placeholder="작성자"> 
					</div>
					<button type="submit" class="btn btn-primary write_btn">작성</button>
					<button type="submit" class="btn btn-primary cancel_btn">취소</button>
			</form>
		</section>
			<hr />
		</div>
	</body>
</html>
