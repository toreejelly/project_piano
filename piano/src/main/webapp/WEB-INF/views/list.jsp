<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE>
<html>
<head>
	<jsp:directive.include file="head.jsp"/>
</head>
<body>

	<div class="container">
	<br/>
		<h2>게시판</h2>
		<br/>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>제목</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="board" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${board.userNickname}</td>
						<td><a href="/board/${board.boardSeq}">${board.boardTitle}</a></td>
						<td>${board.regDt}</td>
						<td>${board.boardView}</td>							
					</tr>
				</c:forEach>			
			</tbody>	
		</table>	
		<button type="button" class="btn btn-warning" onclick="location.href='/contentWriteForm';">글쓰기</button>
	</div>

</body>
</html>