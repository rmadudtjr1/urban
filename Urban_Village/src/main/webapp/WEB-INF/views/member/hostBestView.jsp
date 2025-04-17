<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title></title>

</head>
<body>
	<div>
		<h3>호스트 등록 숙소 목록</h3>
			<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>이름</th>
					<th>수용 인원</th>
					<th>가격</th>
					<th>호스트 추천 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="accBest" items="${hostBestAccIdList}">
					<tr>
						<td>${accBest.accommodation_id}</td>
						<td>${accBest.accommodation_name}</td>
						<td>${accBest.capacity}</td>
						<td>${accBest.price}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>
 