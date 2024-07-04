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
	function replyWrite(button) {
        let replyText = $(button).closest('.reply-form').find('textarea').val();
        let parentCommentSeq = $(button).closest('.media-block');
	
        if (!replyText.trim()) {
            alert("대댓글 내용을 입력해주세요.");
            return;
        }

        let data = {
            boardSeq: $("#boardSeq").val(),
            parentCommentSeq: parentCommentSeq.data("comment-seq"),
            commentText: replyText,
            boardGrpSeq : 1,
            regUserSeq: 1 // 예시로 사용자 ID를 1로 설정. 실제 구현에서는 로그인한 사용자 ID를 사용해야 함.
        };
        
        console.log(data);

        $.ajax({
            type: "POST",
            url: "/comment/reply",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            success: function(result) {
                if (result === "SUCCESS") {
                	// 대댓글을 동적으로 추가
                    addReply(parentCommentSeq, replyText);
                    // 대댓글 입력창 초기화
                    $(button).closest('.reply-form').find('textarea').val('');
                    // 대댓글 입력창 숨기기
                    $(button).closest('.reply-form').remove();
                }
            },
            error: function(e) {
                console.log(e);
                alert("대댓글 작성에 실패했습니다.");
            }
        });
    }


	// 대댓글을 부모 댓글 아래에 추가
	function addReply(parentCommentSeq, replyText) {
	    let replyHtml = `
	        <div class="reply">
	            <p>${replyText}</p>
	        </div>
	    `;
	    $(`.media-block[data-comment-seq="${parentCommentSeq}"] .replies`).append(replyHtml);
	}
	
	//button : 클릭된 버튼을 기준으로 대댓글 입력 폼을 해당 버튼 아래에 추가하거나 제거합니다.
	function showReplyForm(button) {
	
	    // 클릭된 댓글 아래에 있는 대댓글 입력 창을 찾음
	    let replyFormContainer = $(button).closest(".media-body").find(".reply-form-container");

	    // 대댓글 입력 창이 이미 있는 경우 제거, 그렇지 않으면 생성 후 .reply-form 클래스를 가진 요소를 찾아
	    if (replyFormContainer.children('.reply-form').length > 0) {
	    	//.reply-form-container 내의 모든 내용을 제거
	        replyFormContainer.empty();
	    } else {
	        // 이미 있는 다른 대댓글 입력 창은 제거
	        $(".reply-form").remove();

	        // 대댓글 입력 창을 생성
	        //`...`: 백틱(`)을 사용하여 멀티라인 문자열을 정의
	        let replyForm = `
	            <div class="reply-form">
	                <textarea class="form-control" rows="2" placeholder="대댓글을 작성해주세요"></textarea>
	                <div class="mar-top clearfix">
	                    <button class="btn btn-sm btn-primary pull-right" type="submit" onclick="replyWrite(this)"><i class="fa fa-pencil fa-fw"></i>작성</button>
	                </div>
	            </div>
	        `;
	        // 클릭된 댓글 아래에 대댓글 입력 창을 추가
	        //replyForm을 .reply-form-container 내부에 HTML로 삽입
	        replyFormContainer.html(replyForm);
	    }
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

			<!-- 댓글 작성 -->
			<div class="panel">
				<div class="panel-body">

					<p class="text-muted text-sm">닉네임</p>
					<textarea class="form-control" id="commentText" rows="2"
						placeholder="댓글을 작성해주세요"></textarea>
					<div class="mar-top clearfix">
						<button class="btn btn-sm btn-primary pull-right" type="submit"
							onclick="commentWrite()">
							<i class="fa fa-pencil fa-fw"></i>작성
						</button>
					</div>
				</div>
			</div>
			<!-- 댓글 작성 끝 -->

			<!-- 댓글 목록 -->
			<c:if test="${not empty commentList}">
				<div class="panel">
					<div class="panel-body">
						<c:forEach var="commentList" items="${commentList}">
							<!-- <!-- HTML5의 사용자 정의 데이터 속성(attribute) 규칙 때문에 data-comment-seq 하이픈 사용 -->
							<div class="media-block" data-comment-seq="${commentList.commentSeq}">
								<a class="media-left" href="#"></a>
								<div class="media-body">
									<div class="mar-btm">
										<a href="#"
											class="btn-link text-semibold media-heading box-inline">닉네임</a>
										<p class="text-muted text-sm">닉네임</p>
										<p class="text-muted text-sm">${commentList.regDt}</p>
									</div>
									<p>${commentList.commentText}</p>
									<div class="pad-ver">
										<div class="btn-group">
											<a class="btn btn-sm btn-default btn-hover-success" href="#"><i
												class="fa fa-thumbs-up"></i></a> <a
												class="btn btn-sm btn-default btn-hover-danger" href="#"><i
												class="fa fa-thumbs-down"></i></a>
										</div>
										<a class="btn btn-sm btn-default btn-hover-primary" href="#"
											onclick="showReplyForm(this)">댓글</a> 											
										<a	class="btn btn-sm btn-default btn-hover-primary" href="#">수정</a>
										<a class="btn btn-sm btn-default btn-hover-primary" href="#">삭제</a>
									</div>
									<hr>
									<!-- 대댓글 입력 창이 여기 동적으로 추가될 것입니다 -->
									<div class="reply-form-container"></div>
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