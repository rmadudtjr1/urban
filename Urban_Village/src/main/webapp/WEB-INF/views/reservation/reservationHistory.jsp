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
        background-color: #f9f9f9;
        margin: 0;
        padding: 20px;
        display: flex;
        justify-content: center;
        font-size: 16px; /* 전체 폰트 크기 증가 */
        margin-left: 410px;
    }
    .rebody { /* body 태그에 직접 스타일을 적용하는 대신 클래스 사용 (선택 사항) */
        width: 100%;
        max-width: 600px;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border: 1px solid #ddd;
    }
    .reh1 {
        font-size: 26px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
        border-bottom: 2px solid #ddd;
        padding-bottom: 10px;
    }
    .rereservation-item {
        padding: 15px;
        border-bottom: 1px solid #ddd;
        margin-bottom: 15px;
    }
    .rerow, .retotal-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    .relabel {
        font-weight: bold;
        color: #333;
        width: 50%;
        font-size: 16px;
    }
    .revalue {
        color: #666;
        text-align: right;
        width: 50%;
        font-size: 16px;
    }
    .retotal-row .revalue {
        font-weight: bold; /* 오른쪽 값도 굵게 */
    }
    .rehr {
        border: 0;
        border-top: 1px dashed #ddd;
        margin: 10px 0;
    }
    .rebtn {
        display: inline-block;
        margin-top: 15px;
        padding: 10px 20px;
        background-color: #ff5a5f;
        color: #fff;
        text-align: center;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .rebtn:hover {
        background-color: #e04848;
    }
    .reempty-reservations {
        text-align: center;
        margin-top: 20px;
    }
    .reempty-reservations a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
        font-size: 16px;
    }
    .reempty-reservations a:hover {
        text-decoration: underline;
    }
    .rereceipt-header {
        text-align: center;
        font-size: 20px;
        margin-bottom: 15px;
        font-weight: bold;
    }
    .rereceipt-footer {
        text-align: center;
        font-size: 16px;
        color: #777;
        margin-top: 20px;
        border-top: 1px solid #ddd;
        padding-top: 10px;
    }
    .rereservation-item p {
        font-size: 18px;
        font-weight: bold;
        color: #333;
        text-align: center;
        margin: 10px 0;
    }
    .rereservation-item .rerow {
        margin-bottom: 12px;
    }
    .rereservation-item .rerow .relabel {
        font-size: 16px;
        font-weight: normal;
        color: #555;
    }
    .rereservation-item .rerow .revalue {
        font-size: 16px;
        color: #444;
    }
    .recancel {
        display: inline-block;
        margin-top: 15px;
        padding: 10px 20px;
        background-color: #dc3545; /* 취소 버튼 색상 변경 */
        color: #fff;
        text-align: center;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease;
        border: none; /* 기본 테두리 제거 */
    }
    .recancel:hover {
        background-color: #c82333; /* 호버 시 색상 변경 */
    }
    </style>

</head>
<body>
    <div class="rebody"> <h1 class="reh1">숙소 예약 내역</h1>
        <c:if test="${empty reservations}">
            <div class="reempty-reservations">
                <p>예약 내역이 없습니다.</p>
                <a href="${contextPath}/accommodation/main.do" class="rebtn">새 예약하기</a>
            </div>
        </c:if>
        <c:forEach var="reservation" items="${reservations}">
            <div class="rereservation-item">
                <p>예약번호: ${reservation.reservation_id}</p> <div class="rerow">
                    <div class="relabel">숙소 이름</div>
                    <div class="revalue">${reservation.accommodation_name}</div>
                </div>
                <div class="rerow">
                    <div class="relabel">체크인</div>
                    <div class="revalue"><fmt:formatDate value="${reservation.checkin_date}" pattern="yyyy-MM-dd" /></div>
                </div>
                <div class="rerow">
                    <div class="relabel">체크아웃</div>
                    <div class="revalue"><fmt:formatDate value="${reservation.checkout_date}" pattern="yyyy-MM-dd" /></div>
                </div>
                <div class="rerow">
                    <div class="relabel">숙박비</div>
                    <div class="revalue"><fmt:formatNumber value="${reservation.total_price - 5000 - (reservation.total_price * 0.1)}" pattern="#,###" /> 원</div>
                </div>
                <div class="rerow">
                    <div class="relabel">청소비</div>
                    <div class="revalue"><fmt:formatNumber value="5000" pattern="#,###" /> 원</div>
                </div>
                <div class="rerow">
                    <div class="relabel">수수료 (10%)</div>
                    <div class="revalue"><fmt:formatNumber value="${reservation.total_price * 0.1}" pattern="#,###" /> 원</div>
                </div>

                <hr class="rehr" />

                <c:choose>
                    <c:when test="${not empty reservation.coupon_name}">
                        <div class="retotal-row">
                            <div class="relabel">총 금액</div>
                            <div class="revalue"><fmt:formatNumber value="${reservation.total_price}" pattern="#,###" /> 원</div>
                        </div>

                        <div class="rerow">
                            <div class="relabel">${reservation.coupon_name}</div>
                            <div class="revalue">- <fmt:formatNumber value="${reservation.total_price - reservation.final_price}" pattern="#,###" /> 원</div>
                        </div>
                        <hr class="rehr" />
                        <div class="retotal-row">
                            <div class="relabel">최종 결제 금액</div>
                            <div class="revalue"><fmt:formatNumber value="${reservation.final_price}" pattern="#,###" /> 원</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="retotal-row">
                            <div class="relabel">최종 결제 금액</div>
                            <div class="revalue"><fmt:formatNumber value="${reservation.final_price}" pattern="#,###" /> 원</div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${reservation.checkin_date > today}">
                        <button class="rebtn recancel" onclick="confirmCancel('${contextPath}/reservation/delReservation?reservation_id=${reservation.reservation_id}&coupon_id=${reservation.coupon_id }')">
                            예약 취소
                        </button>
                    </c:when>
                    <c:when test="${reservation.checkout_date < today}">
                        <a href="${contextPath}/review/write?reservation_id=${reservation.reservation_id}&accommodation_name=${reservation.accommodation_name}&accommodation_id=${reservation.accommodation_id}" class="rebtn">후기 작성</a>
                    </c:when>
                    <c:otherwise>
                        <p>사용중입니다.</p>
                    </c:otherwise>
                </c:choose>

                <div class="rereceipt-footer">
                    <p>감사합니다! 예약을 확인해 주셔서 감사합니다.</p>
                    <p>문의 전화: 123-456-7890</p>
                </div>
            </div>
        </c:forEach>
    </div>
    <script>
        function confirmCancel(url) {
            const userConfirmed = confirm("예약을 취소하시겠습니까?");
            if (userConfirmed) {
                window.location.href = url;
            } else {
                console.log("예약 취소가 취소되었습니다.");
            }
        }
    </script>
</body>
</html>