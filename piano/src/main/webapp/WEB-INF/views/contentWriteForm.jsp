<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


<meta charset="UTF-8">

<title>글쓰기</title>

<script>
	//작성
	function contentWrite() {
		
		let boardTitle = $("#boardTitle").val();
		let boardText = $("#boardText").val();
		
		
		
		 let data = {
			boardTitle : boardTitle,
			boardText : boardText,
			boardGrpSeq : 1, 
		    regUserSeq : 1 
		};
		
		console.log("data", data);
		
		$.ajax({
			type : "POST"
			,url : "/contentWrite"
			,cache : false
			,data : JSON.stringify(data)
			,contentType : 'application/json; charset=utf-8'
			,success : function(result){
				console.log("result", result);
				alert("작성되었습니다.");
				location.href = "/board/"+result;
				
			}
			,error : function(e){
				console.log(e);
				alert("작성 실패하였습니다.");
			}
		});//ajax end
	
}//contentWrite() end
</script>


</head>
<body>

	<div class="container">
	<br/>
		<h2>글쓰기</h2>
		<br/>
		<table class="table table-bordered">
			<tr>
				<td>닉네임</td>
				<td>
				    <span></span>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input id="boardTitle" style="width:100%;">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="10" id="boardText" style="width:100%;"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="btn btn-success" onclick="location.href='/list'">목록보기</button> &nbsp;&nbsp; 
					<button type="button" class="btn btn-warning" onclick="contentWrite()">작성</button>
				</td>		
			</tr>
		</table>	
	</div>

</body>
</html>