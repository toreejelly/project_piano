<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!-- +++ 임시 이 부분도 확인하고 통일이 된다면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
	<jsp:directive.include file="../head.jsp"/><!-- jsp:directive.include 이거를 사용하면 어떻게 되는지 확인하기 -->
</head>
<body>

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<!-- Brand -->
		<a class="navbar-brand" href="#">Logo</a>

		<!-- Links -->
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="/list?boarGrpSeq=1">공지사항</a></li>
			<li class="nav-item"><a class="nav-link" href="/list?boarGrpSeq=2">수업후기</a></li>

			<!-- Dropdown -->
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbardrop"
				data-toggle="dropdown"> Dropdown link </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="#">Link 1</a> <a
						class="dropdown-item" href="#">Link 2</a> <a class="dropdown-item"
						href="#">Link 3</a>
				</div></li>
		</ul>
	</nav>
	<br>

	<div class="container">
		<h3>하하하하하하하하핳</h3>
		<p>김써짜니 똥꾸빵꾸</p>
	</div>

</body>
</html>