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
				boardSeq : boardSeq
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
	
	//대댓글
	function writeReply(){
		
		
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
    <textarea class="form-control" id="commentText" rows="2" placeholder="댓글을 작성해주세요"></textarea>
    <div class="mar-top clearfix"> 
      <button class="btn btn-sm btn-primary pull-right" type="submit"  onclick="writeComment()"><i class="fa fa-pencil fa-fw"></i>작성</button>
    </div>
  </div>
</div>
<!-- 댓글 작성 끝 -->

<div class="panel">
    <div class="panel-body">
<!-- 댓글 -->
    <!--===================================================-->
    <div class="media-block">
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
          <a class="btn btn-sm btn-default btn-hover-primary" href="#">댓글</a>
          <a class="btn btn-sm btn-default btn-hover-primary" href="#">수정</a>
          <a class="btn btn-sm btn-default btn-hover-primary" href="#">삭제</a>
        </div>
        <hr>
<!-- 댓글 끝 -->

<!-- 대댓글 -->
        <div>
          <div class="media-block">
            <a class="media-left" href="#"></a>
            <div class="media-body">
              <div class="mar-btm">
                <a href="#" class="btn-link text-semibold media-heading box-inline">대댓글 닉네임</a>
                <p class="text-muted text-sm">작성 시간</p>
              </div>
              <p>대댓글 내용</p>
              <div class="pad-ver">
                <div class="btn-group">
                  <a class="btn btn-sm btn-default btn-hover-success active" href="#"><i class="fa fa-thumbs-up"></i> You Like it</a>
                  <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i class="fa fa-thumbs-down"></i></a>
                </div>
                <a class="btn btn-sm btn-default btn-hover-primary" href="#">Comment</a>
              </div>
              <hr>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 대댓글끝 -->

  </div>
</div>
</div>
</div>


	
   
</body>
</html>