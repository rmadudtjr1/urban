<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 현황</title>
<style>
.button-container {
	margin-bottom: 10px;
}
table {
	width: 80%;
	border-collapse: collapse;
	margin-top: 20px;
}
th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}
th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
<h1>매출 현황</h1>

<div class="button-container">
	<button onclick="location.href='${contextPath}/member/getDailySales.do'">일별 매출</button>
	<button onclick="location.href='${contextPath}/member/getMonthlySales.do'">월별 매출</button>
	<button onclick="location.href='${contextPath}/member/getYearlySales.do'">연도별 매출</button>
</div>

<c:if test="${not empty dailySalesList}">
	<h2>일별 매출</h2>
	<table>
		<thead>
			<tr>
				<th>매출일</th>
				<th>총 매출</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sales" items="${dailySalesList}">
				<tr>
					<td>${sales.sale_date}</td>
					<td><fmt:formatNumber value="${sales.total_sales}" pattern="#,###.##" /> 원</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</c:if>

<c:if test="${not empty monthlySalesList}">
	<h2>월별 매출</h2>
	<table>
		<thead>
			<tr>
				<th>매출월</th>
				<th>총 매출</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sales" items="${monthlySalesList}">
				<tr>
					<td>${sales.sales_month}</td>
					<td><fmt:formatNumber value="${sales.total_sales}" pattern="#,###.##" /> 원</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</c:if>

<c:if test="${not empty yearlySalesList}">
	<h2>연도별 매출</h2>
	<table>
		<thead>
			<tr>
				<th>매출년도</th>
				<th>총 매출</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sales" items="${yearlySalesList}">
				<tr>
					<td>${sales.sales_year}</td>
					<td><fmt:formatNumber value="${sales.total_sales}" pattern="#,###.##" /> 원</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</c:if>

<c:if test="${empty dailySalesList and empty monthlySalesList and empty yearlySalesList}">
	<p>매출 데이터가 없습니다.</p>
</c:if>
</body>
</html>
