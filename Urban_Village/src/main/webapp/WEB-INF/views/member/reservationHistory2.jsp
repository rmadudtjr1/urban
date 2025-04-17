<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>숙소 예약 내역</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
        }
        .container {
            width: 100%;
            max-width: 800px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .reservation-item {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .label {
            font-weight: bold;
            color: #333;
        }
        .value {
            color: #666;
        }
        .fee-info {
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }
        .fee-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 14px;
            color: #777;
        }
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 2px solid #ccc;
            font-weight: bold;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>예약 내역</h1>
        <c:if test="${empty reservations}">
            <p>예약 내역이 없습니다.</p>
        </c:if>
        <c:forEach var="reservation" items="${reservations}">
            <div class="reservation-item">
                <div class="row">
                    <div class="label">예약 번호</div>
                    <div class="value">${reservation.reservation_id}</div>
                </div>
                <div class="row">
                    <div class="label">숙소 이름</div>
                    <div class="value">${reservation.accommodation_name }</div>
                </div>
                <div class="row">
                    <div class="label">체크인</div>
                    <div class="value"><fmt:formatDate value="${reservation.checkin_date}" pattern="yyyy-MM-dd"/></div>
                </div>
                <div class="row">
                    <div class="label">체크아웃</div>
                    <div class="value"><fmt:formatDate value="${reservation.checkout_date}" pattern="yyyy-MM-dd"/></div>
                </div>
                <div class="row">
                    <div class="label">게스트 수</div>
                    <div class="value">${reservation.guest_count}</div>
                </div>
                    <div class="row">
                        <div class="label">청소비</div>
                        <div><fmt:formatNumber value="5000" pattern="#,###"/>원</div>
                    </div>
                    <div class="row">
                        <div class="label">수수료 (10%)</div>
                        <div><fmt:formatNumber value="${reservation.total_price * 0.1}" pattern="#,###"/>원</div>
                    </div>
                <div class="total-row">
                    <div class="label">총 가격</div>
                    <div class="value"><fmt:formatNumber value="${reservation.total_price}" pattern="#,###"/>원</div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>