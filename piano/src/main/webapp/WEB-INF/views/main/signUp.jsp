<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
	<jsp:directive.include file="../head.jsp"/>
</head>

<style>
	/* 추가적인 스타일 설정 */
	.inBody {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		background-color: #f8f9fa;
	}
	
	.signup-container {
		width: 100%;
		max-width: 400px;
		padding: 15px;
		border: 1px solid #e3e3e3;
		border-radius: 5px;
		background-color: #fff;
	}
</style>

<body>

	<div class="inBody">
		<div class="signup-container">
			<h2 class="text-center">회원가입</h2>
			<form>
				<div class="form-group">
					<label for="username">아이디</label> <input type="text" class="form-control" id="userId" placeholder="">
				</div>
				<div class="form-group">
					<label for="password">비밀번호</label> <input type="password" class="form-control" id="password" placeholder="">
				</div>
				<div class="form-group">
					<label for="confirm-password">비밀번호 확인</label>
					<input type="password" class="form-control" id="confirm-password" placeholder="">
				</div>
				<div class="form-group">
					<label for="username">이름</label> <input type="text" class="form-control" id="userNm">
				</div>
				<div class="form-group">
					<label for="username">회원가입 유형</label> <input type="text" class="form-control" id="userType" placeholder="">
				</div>
				<button type="submit" class="btn btn-primary btn-block">회원가입</button>
			</form>
		</div>
	</div>

</body>
</html>