<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    java.util.Date today = new java.util.Date(); // 현재 날짜
    pageContext.setAttribute("today", today); // JSP에서 사용할 수 있도록 설정
%>

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
        .containerHistory {
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
        .btnReview {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #ff5a5f;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #e04848;
        }
        .empty-reservations {
            text-align: center;
            margin-top: 20px;
        }
        .empty-reservations a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .empty-reservations a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="containerHistory">
        <h1>예약 내역</h1>
        <c:if test="${empty reservations}">
            <div class="empty-reservations">
                <p>예약 내역이 없습니다.</p>
                <a href="${contextPath}/accommodation/main.do" class="btn">새 예약하기</a>
            </div>
        </c:if>
        <c:forEach var="reservation" items="${reservations}">
            <div class="reservation-item">
                <div class="row">
                    <div class="label">예약 번호</div>
                    <div class="value">${reservation.reservation_id}</div>
                </div>
                <div class="row">
                    <div class="label">숙소 이름</div>
                    <div class="value">${reservation.accommodation_name}</div>
                </div>
                <div class="row">
                    <div class="label">숙소 아이디</div>
                    <div class="value">${reservation.accommodation_id}</div>
                </div>
                <div class="row">
                    <div class="label">체크인</div>
                    <div class="value">
                        <fmt:formatDate value="${reservation.checkin_date}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>
                <div class="row">
                    <div class="label">체크아웃</div>
                    <div class="value">
                        <fmt:formatDate value="${reservation.checkout_date}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>
                <div class="row">
                    <div class="label">게스트 수</div>
                    <div class="value">${reservation.guest_count}</div>
                </div>
                <div class="row">
                    <div class="label">청소비</div>
                    <div class="value">
                        <fmt:formatNumber value="5000" pattern="#,###"/>원
                    </div>
                </div>
                <div class="row">
                    <div class="label">수수료 (10%)</div>
                    <div class="value">
                        <fmt:formatNumber value="${reservation.total_price * 0.1}" pattern="#,###"/>원
                    </div>
                </div>
                <div class="total-row">
                    <div class="label">총 가격</div>
                    <div class="value">
                        <fmt:formatNumber value="${reservation.total_price}" pattern="#,###"/>원
                    </div>
                </div>
                <c:choose>
                    <c:when test="${reservation.checkin_date > today}">
                        <button class="btn cancel" onclick="confirmCancel('${contextPath}/reservation/delReservation?reservation_id=${reservation.reservation_id}')">
                            예약 취소
                        </button>
                    </c:when>
                    <c:when test="${reservation.checkout_date < today}">
                        <a href="${contextPath}/review/write?reservation_id=${reservation.reservation_id}&accommodation_name=${reservation.accommodation_name}&accommodation_id=${reservation.accommodation_id}" class="btnReview">후기 작성</a>
                    </c:when>
                    <c:otherwise>
                    	<p>사용중입니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </div>
    <script>
        // 예약 취소 확인 함수
        function confirmCancel(url) {
            const userConfirmed = confirm("예약을 취소하시겠습니까?");
            if (userConfirmed) {
                // "확인"을 눌렀을 때 해당 URL로 이동
                window.location.href = url;
            } else {
                // "취소"를 눌렀을 때 아무 일도 하지 않음 (현재 페이지 유지)
                console.log("예약 취소가 취소되었습니다.");
            }
        }
    </script>
</body>
</html>