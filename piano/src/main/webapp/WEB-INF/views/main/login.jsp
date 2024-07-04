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

<body>

	<div class="inBody">
		<div class="login-container">
			<h2 class="text-center">👽심포니👽</h2>
			<form>
				<div class="form-group">
					<label for="email">이메일</label> <input type="email"
						class="form-control" id="email" placeholder="이메일을 입력하세요.">
				</div>
				<div class="form-group">
					<label for="password">비밀번호</label> <input type="password"
						class="form-control" id="password" placeholder="비밀번호를 입력하세요.">
				</div>
				<button type="submit" class="btn btn-primary btn-block">로그인</button>
	
				<div class="text-right mt-3">
					<a href="/signUp">회원가입</a>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>