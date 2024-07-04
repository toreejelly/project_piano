<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- 댓글 -->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
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
            url: "/comments/",
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
	function writeReply(button) {
        let replyText = $(button).closest('.reply-form').find('textarea').val();
        let parentComment = $(button).closest('.media-body');

        if (!replyText.trim()) {
            alert("대댓글 내용을 입력해주세요.");
            return;
        }

        let data = {
            boardSeq: $("#boardSeq").val(),
            parentCommentSeq: parentComment.data("comment-seq"),
            commentText: replyText,
            boardGrpSeq : 1,
            regUserSeq: 1 // 예시로 사용자 ID를 1로 설정. 실제 구현에서는 로그인한 사용자 ID를 사용해야 함.
        };

        $.ajax({
            type: "POST",
            url: "/comments/reply",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            success: function(result) {
                if (result === "SUCCESS") {
                    location.reload();
                }
            },
            error: function(e) {
                console.log(e);
                alert("대댓글 작성에 실패했습니다.");
            }
        });
    }


	
	function showReplyForm(button) {
	    // 클릭된 댓글 아래에 있는 대댓글 입력 창을 찾음
	    let replyFormContainer = $(button).closest(".media-body").find(".reply-form-container");

	    // 대댓글 입력 창이 이미 있는 경우 제거, 그렇지 않으면 생성
	    if (replyFormContainer.children('.reply-form').length > 0) {
	        replyFormContainer.empty();
	    } else {
	        // 이미 있는 다른 대댓글 입력 창은 제거
	        $(".reply-form").remove();

	        // 대댓글 입력 창을 생성
	        let replyForm = `
	            <div class="reply-form">
	                <textarea class="form-control" rows="2" placeholder="대댓글을 작성해주세요"></textarea>
	                <div class="mar-top clearfix">
	                    <button class="btn btn-sm btn-primary pull-right" type="submit" onclick="replyWrite(this)"><i class="fa fa-pencil fa-fw"></i>작성</button>
	                </div>
	            </div>
	        `;
	        // 클릭된 댓글 아래에 대댓글 입력 창을 추가
	        replyFormContainer.html(replyForm);
	    }
	}
</script>

</head>
<body>

	<div class="container">
	<br/>
		<h2>글</h2>
		<br/>
		<input type="hidden" id="boardSeq" value="${content.boardSeq}">
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
				<td><input id="boardTitle" value="${content.boardTitle}" disabled style="width:100%;"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" id="boardText" disabled style="width:100%;">${content.boardText}</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="btn btn-success" onclick="location.href='/list'">목록보기</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-warning" onclick="location.href='/contentModifyForm/${content.boardSeq}'">수정</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-danger" onclick="contentDetele()">삭제</button> 
				</td>
			</tr>
		
		</table>
	</div>
	

<!-- 댓글.html -->

<div class="container bootdey">
<div class="col-md-12 bootstrap snippets">

<!-- 댓글 작성 -->
<div class="panel">	
  <div class="panel-body">
	<p class="text-muted text-sm">닉네임</p>
    <textarea class="form-control" id="commentText" rows="2" placeholder="댓글을 작성해주세요"></textarea>
    <div class="mar-top clearfix"> 
      <button class="btn btn-sm btn-primary pull-right" type="submit"  onclick="commentWrite()"><i class="fa fa-pencil fa-fw"></i>작성</button>
    </div>
  </div>
</div>
<!-- 댓글 작성 끝 -->

<div class="panel">
    <div class="panel-body">

<!-- 댓글 -->
    <!-- HTML5에서는 속성 이름에 언더스코어(_) 대신 하이픈(-)을 사용하는 것이 일반적입니다.  -->
   <div class="media-block" data-comment-seq="${comment.commentSeq}">
      <a class="media-left" href="#"></a>
  
      <div class="media-body">
        <div class="mar-btm">
          <a href="#" class="btn-link text-semibold media-heading box-inline">닉네임</a>
          <p class="text-muted text-sm">닉네임</p>
          <p class="text-muted text-sm">작성 시간</p>
        </div>
        <p>댓글내용</p>
        <div class="pad-ver">
          <div class="btn-group">
            <a class="btn btn-sm btn-default btn-hover-success" href="#"><i class="fa fa-thumbs-up"></i></a>
            <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i class="fa fa-thumbs-down"></i></a>
          </div>
          <!-- this는 클릭된 버튼을 가리키며, 해당 버튼 요소가 replyWrite 함수의 인자로 전달됩니다. -->
          <a class="btn btn-sm btn-default btn-hover-primary" href="#" onclick="showReplyForm(this)">댓글</a>
          <a class="btn btn-sm btn-default btn-hover-primary" href="#">수정</a>
          <a class="btn btn-sm btn-default btn-hover-primary" href="#">삭제</a>
        </div>
        <hr>
    <!-- 대댓글 입력 창이 여기 동적으로 추가될 것입니다 -->
    <div class="reply-form-container"></div>
        <hr>
        
        
<!-- 댓글 끝 -->



  </div>
</div>
</div>
</div>


	
   
</body>
</html>