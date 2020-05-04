<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
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
			<form name="writeForm" role="form" method="post" action="/board/write" enctype="multipart/form-data">
					<legend>글 작성하기</legend>
					<hr>
					<c:if test="${member.userId != null}">
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
					<div class="form-group">
						<input type="file" name="file" class="form-control chk" >
					</div>
					<button type="submit" class="btn btn-primary write_btn">작성</button>
					<button class="fileAdd_btn" type="button">파일추가</button>
					<button type="submit" class="btn btn-primary cancel_btn">취소</button>
					</c:if>
					<c:if test="${member.userId == null}">
						<p>로그인 후에 작성하실 수 있어용</p>
					</c:if>
			</form>
		</section>
			<hr />
		</div>
	</body>
</html>
