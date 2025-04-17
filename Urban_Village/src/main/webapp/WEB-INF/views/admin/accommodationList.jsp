<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>숙소 수정/삭제</title>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<div class="container-fluid">
		</div>
	</nav>

	<div class="container">
		<h2>숙소 목록</h2>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>이름</th>
					<th>수용 인원</th>
					<th>가격</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="acc" items="${accommodationList}">
					<tr>
						<td>${acc.accommodation_id}</td>
						<td>${acc.accommodation_name}</td>
						<td>${acc.capacity}</td>
						<td>${acc.price}</td>
						
						<td>
							<button class="btn btn-primary btn-sm"
								onclick="location.href='${contextPath}/accommodation/modAccommodationForm.do?accommodation_id=${acc.accommodation_id}'">수정</button>
						</td>
						<td>
							<button class="btn btn-danger btn-sm"
								onclick="confirmDelete('${acc.accommodation_id}')">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<script>
		function confirmDelete(accommodationId) {
			if (confirm("정말로 숙소를 삭제하시겠습니까?")) {
				location.href = "${contextPath}/accommodation/delAccommodation.do?accommodation_id=" + accommodationId;
			}
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>