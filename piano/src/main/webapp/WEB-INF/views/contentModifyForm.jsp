<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<meta charset="UTF-8">

<title>글 수정</title>

<script type="text/javascript">
   
	//수정
	function contentModify(){
	   
		let boardSeq = $("#boardSeq").val(); // 게시판 순번
		let boardTitle = $("#boardTitle").val(); // 제목
		let boardText = $("#boardText").val(); // 글          
       
		var data = {
			boardSeq 		: boardSeq
			, boardTitle 	: boardTitle
			, boardText 	: boardText
		};
		
		//console.log("data", data);
		
		$.ajax({
			type : "PUT"
			,url : "/board/"+boardSeq
			,cache : false
			,contentType : 'application/json; charset=utf-8'
			,data : JSON.stringify(data)
			,success : function(result) {
				if (result == "SUCCESS") {
					alert("수정되었습니다.");
					location.href = "/board/"+boardSeq;
				}
			}
			,error : function(e) {
				alert("수정 실패했습니다.");
				console.log(e);
			}
		})//ajax end

	}//contentModify() end
	
</script>

</head>
<body>

	<div class="container">
	<br/>
		<h2>글 수정</h2>
		<br/>
		<input type="hidden" id="boardSeq" value="${content.boardSeq}">
		<table class="table table-bordered">
			<tr>
				<td>번호</td>
				<td>${content.boardSeq}</td>
			</tr>
			<tr>
				<td>이름</td>
				<td></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input id="boardTitle" value="${content.boardTitle}" style="width:100%;"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" id="boardText" style="width:100%;">${content.boardText}</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="btn btn-success" onclick="location.href='/list'">목록보기</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-warning" onclick="contentModify()">저장</button>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
   
</body>
</html>