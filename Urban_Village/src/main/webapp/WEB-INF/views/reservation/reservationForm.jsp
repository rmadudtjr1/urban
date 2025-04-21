<%-- <%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 정보 확인 및 결제</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">🛏️ 예약 정보 확인</h2>
    <form action="/Urban_Village/reservation/reservation.do" method="post">
        <!-- 예약 기본 정보 -->
        <div class="mb-3">
            <label class="form-label">숙소 이름</label>
            <input type="text" class="form-control" name="accommodation_name" value="${sessionScope.accommodation.accommodation_name}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">숙소 ID</label>
            <input type="text" class="form-control" name="accommodation_id" value="${sessionScope.accommodation.accommodation_id}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">예약 번호</label>
            <input type="text" class="form-control" name="reservation_id" value="<%= new Random().nextInt(900000) + 100000 %>" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">예약자 성함</label>
            <input type="text" class="form-control" name="id" value="${sessionScope.memberName}" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">체크인 날짜</label>
            <input type="date" class="form-control" id="checkinInput" name="checkin_date" required>
        </div>
        <div class="mb-3">
            <label class="form-label">체크아웃 날짜</label>
            <input type="date" class="form-control" id="checkoutInput" name="checkout_date" required>
        </div>
        <div class="mb-3">
            <label class="form-label">게스트 수</label>
            <input type="number" class="form-control" id="guestsInput" name="guest_count" required>
        </div>

        <!-- 결제 상세 내역 -->
        <div class="mb-3">
            <label class="form-label">💰 결제 상세 내역</label>
            <ul class="list-group">
                <li class="list-group-item d-flex justify-content-between">
                    <span>숙박비</span><span id="basePrice">- 원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>수수료 (10%)</span><span id="feePrice">- 원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>청소비</span><span id="cleaningFee">5,000원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <span>쿠폰 할인</span>
                    <div class="d-flex align-items-center">
                        <span id="couponAmount" class="me-3 text-success fw-bold">0원</span>
                        <button type="button" class="btn btn-sm btn-outline-success" onclick="applyCoupon()">쿠폰 사용</button>
                    </div>
                </li>
                <li class="list-group-item d-flex justify-content-between fw-bold align-items-center">
                    <div>
                        <div>총 결제 금액</div>
                        <div id="originalPriceText" class="text-muted" style="font-size: 0.9rem;"></div>
                    </div>
                    <span id="finalPriceText">- 원</span>
                </li>
            </ul>

            <!-- 서버 전달용 -->
            <input type="hidden" id="totalPriceInput" name="total_price"> <!-- 쿠폰 적용 전 -->
            <input type="hidden" id="finalPriceInput" name="final_price"> <!-- 쿠폰 적용 후 -->
            <input type="hidden" id="couponIdInput" name="coupon_id">     <!-- 선택된 쿠폰 ID -->
        </div>

        <button type="submit" class="btn btn-primary w-100">💳 결제하기</button>
    </form>
</div>

<!-- 쿠폰 선택 모달 -->
<div class="modal fade" id="couponModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">🎟️ 쿠폰 선택</h5>
                <button type="button" class="btn btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <ul class="list-group">
                    <c:forEach var="coupon" items="${couponList}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>${coupon.coupon_name}</strong> (${coupon.discount}% 할인)<br>
                                <small>만료일: ${coupon.expiration_date}</small>
                            </div>
                            <button type="button"
                                    class="btn btn-sm btn-success"
                                    data-discount="${coupon.discount}"
                                    data-coupon-id="${coupon.coupon_id}"
                                    onclick="selectCoupon(this)">
                                선택
                            </button>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const checkin = localStorage.getItem('reservationCheckin');
    const checkout = localStorage.getItem('reservationCheckout');
    const guests = localStorage.getItem('reservationGuests');
    const totalStr = localStorage.getItem('reservationTotalPrice');

    if (checkin) document.getElementById('checkinInput').value = checkin;
    if (checkout) document.getElementById('checkoutInput').value = checkout;
    if (guests) document.getElementById('guestsInput').value = guests;

    if (totalStr) {
        const total = parseInt(totalStr, 10);
        window.originalTotal = total;

        const cleaningFee = 5000;
        const fee = Math.round(total * 0.1);  // 수수료 10%
        const basePrice = total - cleaningFee - fee;

        // 값 업데이트
        document.getElementById('basePrice').textContent = basePrice.toLocaleString() + '원';
        document.getElementById('feePrice').textContent = fee.toLocaleString() + '원';

        // 할인 전 / 후 표시
        document.getElementById('finalPriceText').textContent = total.toLocaleString() + '원';
        document.getElementById('originalPriceText').textContent = '할인전금액 :'+total.toLocaleString()+'원';

        // form 전송용
        document.getElementById('totalPriceInput').value = total;
        document.getElementById('finalPriceInput').value = total;

        console.log("✅ 총 금액 로딩 완료:", total);
    } else {
        console.log("🔴 예약 정보 로드 실패");
    }
});

// 쿠폰 적용 시
function applyCoupon() {
    const modal = new bootstrap.Modal(document.getElementById('couponModal'));
    modal.show();
}

// 쿠폰 선택 후 적용
function selectCoupon(element) {
    const discountPercent = parseFloat(element.getAttribute('data-discount'));
    const couponId = element.getAttribute('data-coupon-id');

    const total = window.originalTotal;
    const discountAmount = Math.round(total * (discountPercent / 100));
    const newTotal = total - discountAmount;

    // 쿠폰 할인 금액 표시
    document.getElementById('couponAmount').textContent = '-' + discountAmount.toLocaleString() + '원';

    // 최종 결제 금액 업데이트
    document.getElementById('finalPriceText').textContent = newTotal.toLocaleString() + '원';

    // '할인 전' 금액은 원래 금액 그대로 유지
    setTimeout(function() {
        const originalPriceText = document.getElementById('originalPriceText');
        if (originalPriceText) {
            originalPriceText.textContent = '할인전금액 :'+total.toLocaleString()+'원';
        }
    }, 0);

    // form 전송용
    document.getElementById('finalPriceInput').value = newTotal;
    document.getElementById('couponIdInput').value = couponId;

    // 모달 닫기
    const modal = bootstrap.Modal.getInstance(document.getElementById('couponModal'));
    modal.hide();
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 --%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<label class="form-label">숙소 이름</label> <input type="text"
					class="form-control" name="accommodation_name"
					value="${sessionScope.accommodation.accommodation_name}" readonly>
			</div>
			<div class="mb-3">
				<label class="form-label">숙소 ID</label> <input type="text"
					class="form-control" name="accommodation_id"
					value="${sessionScope.accommodation.accommodation_id}" readonly>
			</div>
			<div class="mb-3">
				<label class="form-label">예약 번호</label> <input type="text"
					class="form-control" name="reservation_id"
					value="<%= new Random().nextInt(900000) + 100000 %>" readonly>
			</div>
			<div class="mb-3">
				<label class="form-label">예약자 성함</label> <input type="text"
					class="form-control" name="id" value="${sessionScope.memberName}"
					readonly>
			</div>
			<div class="mb-3">
				<label class="form-label">체크인 날짜</label> <input type="date"
					class="form-control" id="checkinInput" name="checkin_date" required>
			</div>
			<div class="mb-3">
				<label class="form-label">체크아웃 날짜</label> <input type="date"
					class="form-control" id="checkoutInput" name="checkout_date"
					required>
			</div>
			<div class="mb-3">
				<label class="form-label">게스트 수</label> <input type="number"
					class="form-control" id="guestsInput" name="guest_count" required>
			</div>

			<div class="mb-3">
				<label class="form-label">💰 결제 상세 내역</label>
				<ul class="list-group">
					<li class="list-group-item d-flex justify-content-between"><span>숙박비</span><span
						id="basePrice">- 원</span></li>
					<li class="list-group-item d-flex justify-content-between"><span>수수료
							(10%)</span><span id="feePrice">- 원</span></li>
					<li class="list-group-item d-flex justify-content-between"><span>청소비</span><span
						id="cleaningFee">5,000원</span></li>
					<li
						class="list-group-item d-flex justify-content-between align-items-center">
						<span>쿠폰 할인</span>
						<div class="d-flex align-items-center">
							<span id="couponAmount" class="me-3 text-success fw-bold">0원</span>
							<button type="button" class="btn btn-sm btn-outline-success me-2"
								onclick="applyCoupon()">쿠폰 사용</button>
							<button type="button" id="cancelCouponBtn"
								class="btn btn-sm btn-outline-danger" style="display: none;"
								onclick="cancelCoupon()">취소</button>
						</div>
					</li>
					<li
						class="list-group-item d-flex justify-content-between fw-bold align-items-center">
						<div>
							<div>총 결제 금액</div>
							<div id="originalPriceText" class="text-muted"
								style="font-size: 0.9rem;"></div>
						</div> <span id="finalPriceText">- 원</span>
					</li>
				</ul>

				<input type="hidden" id="totalPriceInput" name="total_price">
				<input type="hidden" id="finalPriceInput" name="final_price">
				<input type="hidden" id="couponIdInput" name="coupon_id">
			</div>

			<button type="submit" class="btn btn-primary w-100">💳 결제하기</button>
		</form>
	</div>

	<div class="modal fade" id="couponModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">🎟️ 쿠폰 선택</h5>
					<button type="button" class="btn btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<ul class="list-group">
						<c:forEach var="coupon" items="${couponList}">
							<li
								class="list-group-item d-flex justify-content-between align-items-center">
								<div>
									<strong>${coupon.coupon_name}</strong> (${coupon.discount}% 할인)<br>
									<small>만료일: ${coupon.expiration_date}</small>
								</div>
								<button type="button" class="btn btn-sm btn-success"
									data-discount="${coupon.discount}"
									data-coupon-id="${coupon.coupon_id}"
									onclick="selectCoupon(this)">선택</button>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script>
document.addEventListener('DOMContentLoaded', function () {
    const checkin = localStorage.getItem('reservationCheckin');
    const checkout = localStorage.getItem('reservationCheckout');
    const guests = localStorage.getItem('reservationGuests');
    const totalStr = localStorage.getItem('reservationTotalPrice');

    if (checkin) document.getElementById('checkinInput').value = checkin;
    if (checkout) document.getElementById('checkoutInput').value = checkout;
    if (guests) document.getElementById('guestsInput').value = guests;

    if (totalStr) {
        const total = parseInt(totalStr, 10);
        window.originalTotal = total;
        window.currentTotal = total; // 현재 총 금액을 추적하는 변수

        const cleaningFee = 5000;
        const fee = Math.round(total * 0.1);  // 수수료 10%
        const basePrice = total - cleaningFee - fee;

        // 값 업데이트
        document.getElementById('basePrice').textContent = basePrice.toLocaleString() + '원';
        document.getElementById('feePrice').textContent = fee.toLocaleString() + '원';

        // 할인 전 / 후 표시
        document.getElementById('finalPriceText').textContent = total.toLocaleString() + '원';
        document.getElementById('originalPriceText').textContent = '할인전금액 :'+total.toLocaleString()+'원';

        // form 전송용
        document.getElementById('totalPriceInput').value = total;
        document.getElementById('finalPriceInput').value = total;
        document.getElementById('couponIdInput').value = ''; // 초기 쿠폰 ID 비움

        console.log("✅ 총 금액 로딩 완료:", total);
    } else {
        console.log("🔴 예약 정보 로드 실패");
    }
});

// 쿠폰 적용 시
function applyCoupon() {
    const modal = new bootstrap.Modal(document.getElementById('couponModal'));
    modal.show();
}

// 쿠폰 선택 후 적용
function selectCoupon(element) {
    const discountPercent = parseFloat(element.getAttribute('data-discount'));
    const couponId = element.getAttribute('data-coupon-id');

    const total = window.originalTotal;
    const discountAmount = Math.round(total * (discountPercent / 100));
    const newTotal = total - discountAmount;

    // 쿠폰 할인 금액 표시
    document.getElementById('couponAmount').textContent = '-' + discountAmount.toLocaleString() + '원';

    // 최종 결제 금액 업데이트
    document.getElementById('finalPriceText').textContent = newTotal.toLocaleString() + '원';

    // '할인 전' 금액은 원래 금액 그대로 유지
    document.getElementById('originalPriceText').textContent = '할인전금액 :'+total.toLocaleString()+'원';

    // form 전송용
    document.getElementById('finalPriceInput').value = newTotal;
    document.getElementById('couponIdInput').value = couponId;

    // 쿠폰 취소 버튼 보이기
    document.getElementById('cancelCouponBtn').style.display = 'inline-block';

    // 현재 총 금액 업데이트
    window.currentTotal = newTotal;

    // 모달 닫기
    const modal = bootstrap.Modal.getInstance(document.getElementById('couponModal'));
    modal.hide();
}

// 쿠폰 취소 시
function cancelCoupon() {
    // 쿠폰 할인 금액 초기화
    document.getElementById('couponAmount').textContent = '0원';

    // 최종 결제 금액을 원래 금액으로 되돌림
    document.getElementById('finalPriceText').textContent = window.originalTotal.toLocaleString() + '원';

    // form 전송용
    document.getElementById('finalPriceInput').value = window.originalTotal;
    document.getElementById('couponIdInput').value = ''; // 쿠폰 ID 초기화

    // 쿠폰 취소 버튼 숨기기
    document.getElementById('cancelCouponBtn').style.display = 'none';

    // 현재 총 금액 업데이트
    window.currentTotal = window.originalTotal;

    // '할인 전' 금액 다시 표시
    document.getElementById('originalPriceText').textContent = '할인전금액 :'+window.originalTotal.toLocaleString()+'원';
}
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>