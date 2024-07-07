<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- 댓글 -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/comment.css">

<meta charset="UTF-8">

<title>글</title>

<script type="text/javascript">
   
	//삭제
	function contentDetele() {
		
		let boardSeq = $("#boardSeq").val();          
		
		var data = {
				boardSeq : boardSeq,
				boardGrpSeq : 1, 
			    regUserSeq : 1 
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
		
	}//contentDetele() end
	
//댓글

  $(document).ready(function()  {
            // 페이지 로드 시 기본 댓글 작성 폼을 추가
            let mainCommentFormContainer = $('#mainCommentFormContainer');
            let template = document.getElementById('commentFormTemplate').content.cloneNode(true);
            mainCommentFormContainer.append(template).show();
        });
  
	// 댓글 작성 폼을 항상 보이도록 하는 함수

	
function showReplyForm(action, commentSeq) {
    // 클릭 버튼 가져오기
    let button = event.target || event.srcElement;
    
    let replyFormContainer = $(button).closest(".media-body").find(".reply-form-container");

    // 대댓글 입력 창이 이미 있는 경우 제거, 그렇지 않으면 생성 후 .reply-form 클래스를 가진 요소를 찾아 추가
    if (replyFormContainer.find('.reply-form').length > 0) {
        replyFormContainer.empty(); // 이미 있는 대댓글 입력 창이 있는 경우, 제거
    } else {
        $(".reply-form").remove(); // 다른 대댓글 입력 창이 이미 있는 경우도 제거
        
        // 템플릿 클론 생성(commentFormTemplate 복제)
        let template = document.getElementById('commentFormTemplate').content.cloneNode(true);
        let form = $(template).find('.reply-form');

        // 폼을 해당 컨테이너에 추가
        replyFormContainer.append(form);
    }
    
    // 수정 모드인 경우
    if (action === 'modify') {
        // 수정할 댓글 내용 가져오기
        let commentText = $(button).closest('.media-block').find('.comment-text').text().trim();
        console.log(commentText);

        // 수정 폼에서 댓글 내용 설정
        replyFormContainer.find('.comment-textarea').val(commentText);

        // 수정 폼에서 '작성' 버튼 대신 '수정'과 '취소' 버튼 보이도록 설정
        replyFormContainer.find('#commentCancleBtn').show();
        replyFormContainer.find('#commentModifyBtn').show();
        replyFormContainer.find('#commentSubmitBtn').hide();
        replyFormContainer.find('#replySubmitBtn').hide();
    } else {
        // 대댓글 작성 모드로 처리
        replyFormContainer.find('#replySubmitBtn').show();
        replyFormContainer.find('#commentCancleBtn').show();
        replyFormContainer.find('#commentSubmitBtn').hide();
        replyFormContainer.find('#commentModifyBtn').hide();
    }
}

	function cancelComment(){
        $(event.target).closest('.reply-form').remove();		
	}

  
  
	//댓글 작성
	function commentWrite() {
		let commentText = $("#commentText").val();
		if(!commentText.trim()) {
			alert("댓글 내용을 입력해주세요.");
		return;
        }

        let data = {
            boardSeq: $("#boardSeq").val(),
            commentText: commentText,
            boardGrpSeq : 1, 
            regUserSeq: 1 // 예시로 사용자 ID를 1로 설정. 실제 구현에서는 로그인한 사용자 ID를 사용해야 함.
        };

        $.ajax({
            type: "POST",
            url: "/comment/",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            success: function(result) {
                if (result === "SUCCESS") {
                    location.reload();
                }
            },
            error: function(e) {
                console.log(e);
                alert("댓글 작성에 실패했습니다.");
            }
        });
    }

	// 대댓글 작성
	// button은 클릭된 버튼 요소를 참조합니다.
	function writeReply(event) {
		let button = event.target || event.srcElement;
		 
		let commentText = $("#commentText").val();
        let parentCommentSeq = $(button).closest('.media-block').data("comment-seq");
	
        if (!commentText.trim()) {
            alert("대댓글 내용을 입력해주세요.");
            return;
        }

        let data = {
            boardSeq: $("#boardSeq").val(),
            // jQuery 객체가 아니라 DOM 요소에서 데이터를 추출한 값이어야 한다.
            //parentCommentSeq: parentCommentSeq.data("comment-seq"),
            parentCommentSeq: parentCommentSeq,
            commentText: commentText,
            boardGrpSeq : 1,
            regUserSeq: 1 // 예시로 사용자 ID를 1로 설정. 실제 구현에서는 로그인한 사용자 ID를 사용해야 함.
        };
        
        //console.log(data);

        $.ajax({
            type: "POST",
            url: "/comment/reply",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            success: function(result) {
                if (result === "SUCCESS") {
                	// 대댓글을 부모 댓글 아래로 추가
                    addReply(parentCommentSeq, commentText);
                    // 대댓글 입력창 초기화
                    $(button).closest('.reply-form').find('textarea').val('');
                    // 대댓글 입력창 숨기기
                    $(button).closest('.reply-form').remove();
                } else {
                    alert("대댓글 작성에 실패했습니다.");
                }
                
            },
            error: function(e) {
                console.log(e);
                alert("대댓글 작성에 실패했습니다.");
            }
        });
    }
	

//이거 안됨
//새로고침 해야 대댓글 뜸
//부모 댓글 아래에 안 뜸
	// 대댓글을 부모 댓글 아래에 추가 
	function addReply(parentCommentSeq, commentText) {
	    let replyHtml = `
	        <div class="reply">
	            <p>${commentText}</p>
	        </div>
	    `;
	   
	    // 부모 댓글 아래에 대댓글을 추가하는 부분
	    $(`.media-block[data-comment-seq="${parentCommentSeq}"] .replies`).append(replyHtml);
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
        commentSeq: commentSeq,
        commentText: commentText
    };

    $.ajax({
        type: "PUT",
        url: "/comment/" + commentSeq,
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data),
        success: function(result) {
            if (result === "SUCCESS") {
                location.reload();
            } else {
                alert("댓글 수정에 실패했습니다.");
            }
        },
        error: function(e) {
            console.log(e);
            alert("댓글 수정에 실패했습니다.");
        }
    });
}

	
	//댓글 삭제
	function deleteComment(commentSeq){
		
		//let commentSeq = $("#commentSeq");
		 console.log(commentSeq);	
		let data = {
				commentSeq : commentSeq,
				boardSeq: $("#boardSeq").val(),
				boardGrpSeq : 1, 
			    regUserSeq : 1
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

	}

</script>

</head>
<body>

	<div class="container">
		<br />
		<h2>글</h2>
		<br /> <input type="hidden" id="boardSeq" value="${content.boardSeq}">
		<table class="table table-bordered">
			<tr>
				<td>번호</td>
				<td>${content.boardSeq}</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${content.boardView}</td>
			</tr>
			<tr>
				<td>이름</td>
				<td></td>
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

<div class="container bootdey">
	<div class="col-md-12 bootstrap snippets">
	<!-- 기본 댓글 작성 폼 -->
	<div id="mainCommentFormContainer"></div>

	<!-- 댓글 작성 템플릿 -->
	<template id="commentFormTemplate">
<!--  style="display: none;"이거 추가함 -->	
		<div class="panel reply-form" >
			<div class="panel-body">
				<p class="text-muted text-sm">닉네임</p>
				<textarea id="commentText" class="form-control comment-textarea" rows="2" placeholder="댓글을 작성해주세요"></textarea>
			
				<div class="mar-top clearfix">
					<button id="commentSubmitBtn" class="btn btn-sm btn-primary pull-right" type="button" onclick="commentWrite()">
						<i class="fa fa-pencil fa-fw"></i>작성
					</button>
					<button id="replySubmitBtn" class="btn btn-sm btn-primary pull-right" type="button" onclick="writeReply(event)">
						<i class="fa fa-pencil fa-fw"></i>대댓글 작성
					</button>
					<!-- 댓글 수성 취소 버튼 -->
					<button id="commentCancleBtn" class="btn btn-sm btn-primary pull-right" type="button" onclick="cancelComment()">
					
						<i class="fa fa-pencil fa-fw"></i>취소
					</button>
					<!-- 댓글 수정 버튼 -->
					<button id="commentModifyBtn" class="btn btn-sm btn-primary pull-right" type="button" onclick="modifyComment()">
						<i class="fa fa-pencil fa-fw"></i>수정
					</button>
				</div>
			</div>
		</div>
	</template>

			<!-- 댓글 목록 -->
			<c:if test="${not empty commentList}">
				<div class="panel">
					<div class="panel-body">
						<c:forEach var="comment" items="${commentList}">
							<!-- <!-- HTML5의 사용자 정의 데이터 속성(attribute) 규칙 때문에 data-comment-seq 하이픈 사용 -->
							<div class="media-block" data-comment-seq="${comment.commentSeq}">
								<a class="media-left" href="#"></a>
								<div class="media-body">
									<div class="mar-btm">
										<a href="#" class="btn-link text-semibold media-heading box-inline">닉네임</a>
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
									<hr>
									<!-- 부모 댓글 아래에 대댓글 입력 폼을 추가  -->
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
			<!-- 댓글 목록 끝 -->
		</div>
	</div>




</body>
</html>