<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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
			<tr>
                <td>댓글 작성</td>
                <td>
                	<span>닉네임</span>
                    <textarea rows="5" id="replyText" style="width:100%;"></textarea>
                    <br/>
                    <button type="button" class="btn btn-primary" onclick="writeReply()">작성</button>
                </td>
            </tr>
			
			
		</table>
	</div>
   
</body>
</html>