<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<title>🐸심포니🐸</title>

<body>
	<!-- +++ 임시 여기 바디가 들어가도 되는지 확인 필요 -->
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<!-- Brand -->
		<a class="navbar-brand" href="/">🐸심포니🐸</a>

		<!-- Links -->
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="/list?boarGrpSeq=1">공지사항</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="/list?boarGrpSeq=2">수업후기</a>
			</li>

			<!-- Dropdown -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 😊 </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="/myPage">마이페이지</a>
					<a class="dropdown-item" href="/login">로그인</a> 
				</div>
			</li>
		</ul>
	</nav>

</body>