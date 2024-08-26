<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<jsp:directive.include file="../head.jsp"/>

<script type="text/javascript">

	// ****************************************************************************************
	// 초기화
	// ****************************************************************************************
	
	$(document).ready(function()  {	
		//조회수 증가
		let boardSeq = $("#boardSeq").val(); 
		var data = {
			boardSeq : boardSeq	
			,boardViewCount : true
		};
		
		$.ajax({
			type: "POST"
			,url: "/board/" + boardSeq // TODO: 조회1. RESTFULL 을 위해서 같은 url 사용하는 것이므로 조회 증가하는 것은 다른 url을 사용해보기
			,cache: false
			,contentType: 'application/json; charset=utf-8'
			,data: JSON.stringify(data)
			,success: function(result) {
				if (result == "SUCCESS") {
					console.log('조회수 증가 성공');
					var curentView = parseInt($("#view").text());
					console.log("curentView" , curentView);
					$("#view").text(curentView + 1);
				}
			}
			,error : function(e) {
				console.log('조회수 증가 실패');
			}
		})//ajax end	
	});


	
	// ****************************************************************************************
	// 함수
	// ****************************************************************************************	

	//삭제
	function contentDetele() {
		if(confirm("삭제하시겠습니까?")){
			let boardSeq = $("#boardSeq").val(); 
			let delYn ="Y";
			
			var data = {
				 boardSeq : boardSeq
				,boardGrpSeq : 1
				,userSeq : 1 
				,delYn : delYn
			};
		
			// console.log("data", data);
			
			$.ajax({
				 type : "DELETE"
				,url : "/board/"+boardSeq
				,cache : false
				,contentType : 'application/json; charset=utf-8'
				,data : JSON.stringify(data)
				,success : function(result) {
					if (result == "SUCCESS") {
						alert("삭제되었습니다.");
						location.href = "/list";
					}
				}
				,error : function(e) {
					alert("삭제 실패했습니다.");
					console.log(e);
				}
			})//ajax end	
		}//if end
	}//contentDetele() end
	
	//댓글
	function showReplyForm(action, commentSeq) {
		
		// 클릭 버튼 가져오기
		let button = event.target;
		//let replyFormContainer = $(button).closest(".media-body").find(".reply-form-container");

		// 모든 reply-form-container에서 reply-form 제거
		//$(".reply-form-container").empty();
		
		//data-level값 가져오기
		let parentComment = $(button).closest('.media-block');
		let parentLevel = parseInt(parentComment.find('.media-level').attr('data-level'), 10);
		console.log("parentLevel :" , parentLevel);
		
		// 대댓글 입력 폼 컨테이너 찾기
		let replyFormContainer = parentComment.find('.reply-form-container').first();
		
		// 클릭된 댓글의 다른 모든 reply-form-container에서 reply-form 제거
		parentComment.find('.reply-form-container').not(replyFormContainer).empty();
		
		// 대댓글 입력 창이 이미 있는 경우 제거, 그렇지 않으면 생성 후 .reply-form 클래스를 가진 요소를 찾아 추가
		if (replyFormContainer.find('.reply-form').length > 0) {
			replyFormContainer.empty(); // 이미 있는 대댓글 입력 창이 있는 경우, 제거
		} else {
			// 다른 대댓글 입력 창이 이미 있는 경우도 제거
			parentComment.find('.reply-form').remove(); 

			// 템플릿 클론 생성(commentFormTemplate 복제)
			let template = document.getElementById('commentFormTemplate').content.cloneNode(true);
			let form = $(template).find('.reply-form');

			// 부모 댓글의 레벨 가져오기 및 새 레벨 설정
			let newLevel = parentLevel + 1;
			console.log("newLevel :" , newLevel);
	
			// 폼을 해당 컨테이너에 추가
			replyFormContainer.append(form);
			//들여쓰기 하기
			
			replyFormContainer.css('--level', newLevel);
		}

		// 수정 모드인 경우
		if (action === 'modify') {
			// 수정할 댓글 내용 가져오기
			let commentText = $(button).closest('.media-block').find('.comment-text').text().trim();
			console.log(commentText);

			// 수정 폼에서 댓글 내용 설정
			replyFormContainer.find('.comment-textarea').val(commentText);

			// 수정 폼에서 '작성' 버튼 대신 '수정'과 '취소' 버튼 보이도록 설정
			replyFormContainer.find('#commentModifyBtn').show();
			replyFormContainer.find('#commentCancleBtn').show();			
			replyFormContainer.find('#replySubmitBtn').hide();
		} else {
			// 대댓글 작성 모드로 처리
			replyFormContainer.find('#replySubmitBtn').show();
			replyFormContainer.find('#commentCancleBtn').show();
			replyFormContainer.find('#commentModifyBtn').hide();
		}
	}//showReplyForm()end

	function cancelComment(){
		$(event.target).closest('.reply-form').remove();
	}//cancelComment()end

	//댓글 작성
	function commentWrite() {
		let commentText = $("#commentText").val();
		
		if(!commentText.trim()) {
			alert("댓글 내용을 입력해주세요.");
		return;
		}
		
		let data = {
			boardSeq: $("#boardSeq").val()
			,commentText: commentText
			,boardGrpSeq : 1 
			,regUserSeq: 1
		};

		$.ajax({
			type: "POST"
			,url: "/comment/"
			,contentType: 'application/json; charset=utf-8'
			,data: JSON.stringify(data)
			,success: function(result) {
				if (result === "SUCCESS") {
				location.reload();
				}
			}
			,error: function(e) {
				console.log(e);
				alert("댓글 작성에 실패했습니다.");
			}
		});
	}//commentWrite()end

	// 대댓글 작성
	// button은 클릭된 버튼 요소를 참조
	function writeReply(event) {
		
		let button = event.target;
		
		let parentComment = $(button).closest('.media-block');
		//let repliesContainer = parentComment.find('.replies');
		let repliesContainer = parentComment.find('.replies').first();
		let commentText = $(button).closest('.reply-form').find('textarea').val();
		//let commentText = $("#replyText").val();
		
		let parentCommentSeq = parentComment.data("comment-seq");			
		//let parentCommentSeq = parentComment.find('.media-block').attr('comment-seq');
		
		let parentLevel = parseInt(parentComment.find('.media-level').attr('data-level'), 10);
		
		console.log("parentLevel: ",parentLevel);
		
		if (!commentText.trim()) {
			alert("대댓글 내용을 입력해주세요.");
			return;
		}

		let data = {
			boardSeq: $("#boardSeq").val()
			//parentCommentSeq: parentCommentSeq.data("comment-seq")
			,parentCommentSeq: parentCommentSeq
			,commentText: commentText
			,boardGrpSeq : 1
			,regUserSeq: 1 
			,level: parentLevel + 1
		};

		$.ajax({
			type: "POST"
			,url: "/comment/reply"
			,contentType: 'application/json; charset=utf-8'
			,data: JSON.stringify(data)
			,success: function(result) {
				console.log("reply" + result);
				if (result === "SUCCESS") {
				console.log("parentCommentSeq:", parentCommentSeq);
				console.log("Comment text:", commentText);  
				
				let newReplyTemplate = $('#commentListTemplate').find('.media-block').first().clone();
				newReplyTemplate.attr('data-comment-seq', result.commentSeq);
				newReplyTemplate.find('.comment-text').text(commentText);
				
				//새로운 자식 data-level 값 변경해서 넣기
				let newLevel = parentLevel + 1;
				newReplyTemplate.find('.media-level').attr('data-level', newLevel).css('--level', newLevel);
				//console.log("newLevel: ", newLevel);
				
				// 부모 댓글 아래의 대댓글 목록에 추가
				//parentComment.find('.replies').append(newReplyTemplate);
				repliesContainer.append(newReplyTemplate);


				// 대댓글 입력창 초기화
				//$(button).closest('.reply-form').find('textarea').val('');
				// 대댓글 입력창 숨기기
				//$(button).closest('.reply-form').remove();
								
				//let replyForm = $(button).closest('.reply-form');
				//console.log(replyForm);// '.reply-form' 요소를 출력하여 확인
			
				//let textarea = replyForm.find('textarea');
				//console.log(textarea); // 'textarea' 요소를 출력하여 확인
			
				//textarea.val('');
				//replyForm.remove();
			
				// 대댓글 입력창 초기화 및 제거
				let replyForm = $(button).closest('.reply-form');
				replyForm.find('textarea').val('');
				replyForm.remove();
				
				} else {
					alert("대댓글 작성에 실패했습니다.");
				}	
			}
			,error: function(e) {
				console.log(e);
				alert("대댓글 작성에 실패했습니다.");
			}
		});
	}//writeReply()end
	
	function changeLevel(){
		
	}


	//댓글 수정
	function modifyComment() {
		let button = event.target || event.srcElement;
		let replyFormContainer = $(button).closest(".reply-form");
		let commentSeq = $(button).closest('.media-block').data('comment-seq');
		let commentText = replyFormContainer.find('.comment-textarea').val().trim();

		if (!commentText) {
		alert("댓글 내용을 입력해주세요.");
		return;
		}

		let data = {
			commentSeq: commentSeq
			,commentText: commentText
		};

		$.ajax({
			type: "PUT"
			,url: "/comment/" + commentSeq
			,contentType: 'application/json; charset=utf-8'
			,data: JSON.stringify(data)
			,success: function(result) {
				if (result === "SUCCESS") {
					location.reload();
				} else {
					alert("댓글 수정에 실패했습니다.");
				}
			}
			,error: function(e) {
				console.log(e);
				alert("댓글 수정에 실패했습니다.");
			}
		});
	}//modifyComment()end

	
	//댓글 삭제
	function deleteComment(commentSeq){
		console.log(commentSeq);	
		let data = {
			commentSeq : commentSeq
			,boardSeq: $("#boardSeq").val()
			,boardGrpSeq : 1
			,userSeq : 1
		};
		
		$.ajax({
			type : "DELETE"
			,url : "/comment/"+commentSeq
			,cache : false
			,contentType : 'application/json; charset=utf-8'
			,data : JSON.stringify(data)
			,success : function(result) {
				if (result == "SUCCESS") {
					location.reload();
				}
			}
			,error : function(e) {
				alert("삭제 실패했습니다.");
				console.log(e);
			}
		})//ajax end
	}//deleteComment()end

</script>


</head>
<body>

	<div class="container">
		<br />
		<h2>글</h2>
		<br /> 
		<input type="hidden" id="boardSeq" value="${content.boardSeq}">
		<input type="hidden" name="delYn" id="delYn" value="">
		<table class="table table-bordered">
			<tr>
				<td>번호</td>
				<td>${content.boardSeq}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td id="view">${content.boardView}</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>${content.userNickname}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input id="boardTitle" value="${content.boardTitle}"
					disabled style="width: 100%;"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" id="boardText" disabled
						style="width: 100%;">${content.boardText}</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="btn btn-success"
						onclick="location.href='/list'">목록보기</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-warning"
						onclick="location.href='/contentModifyForm/${content.boardSeq}'">수정</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-danger"
						onclick="contentDetele()">삭제</button>
				</td>
			</tr>

		</table>
	</div>
<!-- 댓글 영역 -->

<!-- 댓글 템플릿 -->	
	<div class="container bootdey">
		<div class="col-md-12 bootstrap snippets">			
			<div class="panel">
				<div class="panel-body">
					<p class="text-muted text-sm">닉네임</p>
					<textarea id="commentText" class="form-control comment-textarea"
						rows="2" placeholder="댓글을 작성해주세요"></textarea>
					<div class="mar-top clearfix">
						<button id="commentSubmitBtn"
								class="btn btn-sm btn-primary pull-right" type="button"
								onclick="commentWrite()">
								<i class="fa fa-pencil fa-fw"></i>작성
						</button>														
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container bootdey">
		<div class="col-md-12 bootstrap snippets">
			<!-- 대댓글 / 수정 템플릿 -->
			<template id="commentFormTemplate">
				<div class="panel reply-form">
					<div class="panel-body">
						<p class="text-muted text-sm">닉네임</p>
						<textarea id="replyText" class="form-control comment-textarea"
							rows="2" placeholder="댓글을 작성해주세요"></textarea>

						<div class="mar-top clearfix">							
							<button id="replySubmitBtn"
								class="btn btn-sm btn-primary pull-right" type="button"
								onclick="writeReply(event)">
								<i class="fa fa-pencil fa-fw"></i>작성
							</button>
							<!-- 댓글 수성 취소 버튼 -->
							<button id="commentCancleBtn"
								class="btn btn-sm btn-primary pull-right" type="button"
								onclick="cancelComment()">
								<i class="fa fa-pencil fa-fw"></i>취소
							</button>
							<!-- 댓글 수정 버튼 -->
							<button id="commentModifyBtn"
								class="btn btn-sm btn-primary pull-right" type="button"
								onclick="modifyComment()">
								<i class="fa fa-pencil fa-fw"></i>수정
							</button>
						</div>
					</div>
				</div>
			</template>

			<!-- 댓글 목록 -->
			<div id="commentListTemplate">
				<c:if test="${not empty commentList}">
					<div class="panel" id="replylist">
						<div class="panel-body">
							<c:forEach var="comment" items="${commentList}">
								<!-- HTML5의 사용자 정의 데이터 속성(attribute) 규칙 때문에 data-comment-seq 하이픈 사용 -->
								<div class="media-block" data-comment-seq="${comment.commentSeq}">
									<a class="media-left" href="#"></a>
									<div class="media-body">
										<div class="media-level" data-level="${comment.level}">	
											<div class="mar-btm">											
												<p class="text-muted text-sm">닉네임</p>
												<p class="text-muted text-sm">${comment.regDt}</p>
											</div>
											<!-- 댓글 내용 -->
											<div class="comment-text-container">
												<p class="comment-text">${comment.commentText}</p>
											</div>
											<div class="pad-ver">
												<div class="btn-group">
													<a class="btn btn-sm btn-default btn-hover-success" href="#"><i class="fa fa-thumbs-up"></i></a> 
													<a class="btn btn-sm btn-default btn-hover-danger" href="#"><i class="fa fa-thumbs-down"></i></a>
												</div>
													<a class="btn btn-sm btn-default btn-hover-primary" onclick="showReplyForm()">댓글</a> 
													<a class="btn btn-sm btn-default btn-hover-primary" onclick="showReplyForm('modify', ${comment.commentSeq})">수정</a>
													<a class="btn btn-sm btn-default btn-hover-primary" onclick="deleteComment(${comment.commentSeq})">삭제</a>
											</div>
										</div>	
										<hr>
										<!-- 부모 댓글 아래에 대댓글 / 수정 입력 폼을 추가  -->
										<div class="reply-form-container"></div>
										<!-- 부모 댓글 아래에 대댓글 목록을 표시 -->
										<div class="replies"></div>
										<hr>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:if>
			</div>
			<!-- 댓글 목록 끝 -->
		</div>
	</div>
</body>
</html>