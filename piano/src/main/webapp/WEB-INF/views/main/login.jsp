<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
	<jsp:directive.include file="../head.jsp"/>
</head>

<style>
	/* +++ 임시 스타일 일괄 적용 필요 */
	.inBody {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		background-color: #f8f9fa;
	}

	.login-container {
		width: 100%;
		max-width: 400px;
		padding: 15px;
		border: 1px solid #e3e3e3;
		border-radius: 5px;
		background-color: #fff;
	}
</style>

<script type="text/javascript">

	// 로그인
	function login() {	
		let userId = $('#userId').val(); // 아이디
		let password = $('#password').val(); // 비밀번호
		
		// 유효성 체크
		if (userId == null || userId == '') {
			alert('이메일을 입력해주세요.');
			return false;
		}
		
		if (password == null || password == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		}
		
		let data = {
			userId: userId
			,password: password
		}

		$.ajax({
			type: 'POST'
			,url: '/loginIn'
			,cache: false
			,data: JSON.stringify(data)
			,contentType: 'application/json; charset=utf-8'
			,success: function(response){
				if (response.result == 'success') {
					alert('로그인 되었습니다.');
					window.location.href = '/';
				} else {
					alert('아이디와 비밀번호가 맞지 않습니다.');
				}
			}
			,error: function(e){
				alert('로그인 할 수 없습니다.');
			}
		});
	}
</script>

<body>

	<div class="inBody">
		<div class="login-container">
			<h2 class="text-center">👽심포니👽</h2>
				<div class="form-group">
					<label for="userId">이메일</label> 
					<input type="email" class="form-control" id="userId" placeholder="이메일을 입력하세요.">
				</div>
				<div class="form-group">
					<label for="password">비밀번호</label> 
					<input type="password" class="form-control" id="password" placeholder="비밀번호를 입력하세요.">
				</div>
				<button class="btn btn-primary btn-block" onclick="login()">로그인</button>

				<div class="text-right mt-3">
					<a href="/signUp">회원가입</a>
				</div>
		</div>
	</div>
	
</body>
</html>