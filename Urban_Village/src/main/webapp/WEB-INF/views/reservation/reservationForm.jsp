<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 정보 확인 및 결제</title>
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">🛏️ 예약 정보 확인</h2>

    <form action="/Urban_Village/reservation/reservation.do" method="post">

        <div class="mb-3">
            <label for="accommodation_name" class="form-label">숙소 이름</label>
            <input type="text" class="form-control" id="accommodation_name" name="accommodation_name" 
                   value="${sessionScope.accommodation.accommodation_name}" readonly>
        </div>

        <div class="mb-3">
            <label for="accommodation_id" class="form-label">숙소 ID</label>
            <input type="text" class="form-control" id="accommodation_id" name="accommodation_id" 
                   value="${sessionScope.accommodation.accommodation_id}" readonly>
        </div>

        <div class="mb-3">
            <label for="reservation_id" class="form-label">예약 번호</label>
            <input type="text" class="form-control" id="reservation_id" name="reservation_id" 
                   value="<%= new Random().nextInt(900000) + 100000 %>" readonly>
        </div>

        <div class="mb-3">
            <label for="id" class="form-label">예약자 성함</label>
            <input type="text" class="form-control" id="id" name="id" 
                   value="${sessionScope.memberName}" readonly>
        </div>

        <div class="mb-3">
            <label for="checkinInput" class="form-label">체크인 날짜</label>
            <input type="date" class="form-control" id="checkinInput" name="checkin_date" required>
        </div>

        <div class="mb-3">
            <label for="checkoutInput" class="form-label">체크아웃 날짜</label>
            <input type="date" class="form-control" id="checkoutInput" name="checkout_date" required>
        </div>

        <div class="mb-3">
            <label for="guestsInput" class="form-label">게스트 수</label>
            <input type="number" class="form-control" id="guestsInput" name="guest_count" required>
        </div>

        <div class="mb-3">
            <label for="totalPriceInput" class="form-label">총 결제 금액</label>
            <input type="text" class="form-control" id="totalPriceInput" name="total_price" readonly>
        </div>

        <button type="submit" class="btn btn-primary w-100">💳 결제하기</button>
    </form>
</div>

<script>
// localStorage에서 값 가져와서 input에 자동 입력
document.addEventListener('DOMContentLoaded', function () {
    const checkin = localStorage.getItem('reservationCheckin');
    const checkout = localStorage.getItem('reservationCheckout');
    const guests = localStorage.getItem('reservationGuests');
    const totalPrice = localStorage.getItem('reservationTotalPrice');

    if (checkin) document.getElementById('checkinInput').value = checkin;
    if (checkout) document.getElementById('checkoutInput').value = checkout;
    if (guests) document.getElementById('guestsInput').value = guests;
    if (totalPrice) document.getElementById('totalPriceInput').value = totalPrice;
});
</script>

</body>
</html>
