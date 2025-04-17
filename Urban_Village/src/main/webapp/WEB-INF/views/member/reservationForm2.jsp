<%@page import="java.util.Random"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
int randomNumber = (int) (Math.random() * 1000000); // 랜덤 값 생성
request.setAttribute("randomNumber", randomNumber);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>확인 및 결제</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	background-color: #f8f9fa;
}

.container {
	max-width: 1100px;
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	margin-top: 40px;
	display: flex;
	justify-content: space-between;
}

.left-section {
	width: 60%;
}

.right-section {
	width: 38%;
	background: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
}

.total-price {
	font-size: 1.3rem;
	font-weight: bold;
}

.small-text {
	font-size: 1rem;
	color: gray;
}

.logo {
	color: #FF385C;
	font-size: 26px;
	font-weight: bold;
	position: absolute;
	top: 20px;
	left: 20px;
}

.modal-small {
	width: 50%;
	max-width: 400px;
	max-height: 50vh;
	overflow-y: auto;
}

.modal-medium {
	width: 70%;
	max-width: 600px;
	max-height: 70vh;
	overflow-y: auto;
}

.modal-large {
	width: 90%;
	max-width: 800px;
	max-height: 80vh;
	overflow-y: auto;
}
</style>
</head>
<body>

	<div class="container">
		<div class="left-section">
			<h2 class="text-center mb-4">확인 및 결제</h2>

			<div class="mb-3">
				<h5>예약 정보</h5>
				<label for="checkin" class="form-label">체크인 날짜</label> <input
					type="date" class="form-control" id="checkin" value="2025-04-13"
					name="checkin_date"> <label for="checkout"
					class="form-label">체크아웃 날짜</label> <input type="date"
					class="form-control" id="checkout" value="2025-04-18"
					name="checkout_date"> <label for="guests"
					class="form-label">게스트 수</label> <input type="number"
					class="form-control" id="guests" value="1" min="1"
					name="guest_count"> <input name="accommodation_id"
					value="${sessionScope.accommodation.accommodation_id }">
			</div>

			<div class="mb-3">
				<h5>결제 수단</h5>
				<select class="form-select" id="payment-method" required>
					<option value="card">신용카드 또는 체크카드</option>
					<option value="bank">계좌이체</option>
				</select>
			</div>

			<div class="mb-3">
				<h5>기본 규칙</h5>
				<ul>
					<li>체크인: 오후 3시 이후</li>
					<li>체크아웃: 오전 11시까지</li>
					<li>흡연 금지, 반려동물 금지</li>
					<li>파티 및 이벤트 금지</li>
				</ul>
			</div>


			<!-- 여기가 내가 히든으로 정보들 긁어오려고 컨트롤러에 파라미터 값으로 이름 맞춰서 잘려유 정보 넣었어 -->
			<div class="text-center">
				<form action="${pageContext.request.contextPath}/member/reservation.do" method="post">
					<input type="hidden" name="checkin_date" id="checkin_date_hidden">
					<input type="hidden" name="checkout_date" id="checkout_date_hidden">
					<input type="hidden" name="guest_count" id="guest_count_hidden">
					<input type="hidden" name="total_price" id="total_price_hidden">
					<input type="hidden" name="accommodation_id" id="accommodation_id"
						value="${sessionScope.accommodation.accommodation_id }"> <input
						type="hidden" id="randomValue" name="reservation_id"
						value="<%=randomNumber%>">
					<button type="button" class="btn btn-primary btn-lg" onclick="prepareAndShowPaymentModal()">확인 및 결제</button>

				</form>
			</div>

			<div class="modal fade" id="termsModal" tabindex="-1"
				aria-labelledby="termsModalLabel" inert>
				<div class="modal-dialog modal-large">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="termsModalLabel">숙박시설 약관 동의서</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<p>
							<h2>디지털 숙박시설 약관 동의서</h2>
							<h3>[숙박시설명]</h3>
							<p>(이하 "숙소")를 이용해 주셔서 감사합니다. 숙소의 이용과 관련하여 아래 약관을 주의 깊게 읽고
								동의하여 주시기 바랍니다.</p>

							<h3>제1조 (목적)</h3>
							<p>본 약관은 숙소와 이용자 간의 숙박 계약 및 이용에 관한 권리, 의무 및 책임을 규정함을 목적으로
								합니다.</p>

							<h3>제2조 (용어의 정의)</h3>
							<ul>
								<li><strong>"이용자"</strong>라 함은 숙박 계약을 체결하고 숙소를 이용하는 자를
									말합니다.</li>
								<li><strong>"숙박 요금"</strong>이라 함은 객실 요금, 봉사료, 세금 및 숙소에서 별도로
									정하는 부대시설 이용료 등을 합한 금액을 말합니다.</li>
								<li><strong>"예약"</strong>이라 함은 이용자가 숙소에 숙박을 신청하고 숙소가 이를
									승낙하는 행위를 말합니다.</li>
								<li><strong>"취소"</strong>라 함은 예약된 숙박 계약을 이용자의 사정으로 해제하는 행위를
									말합니다.</li>
								<li><strong>"노쇼(No-Show)"</strong>라 함은 예약 후 사전 연락 없이 숙박 당일
									숙소에 도착하지 않는 경우를 말합니다.</li>
							</ul>

							<h3>제3조 (숙박 계약의 성립)</h3>
							<ol>
								<li>숙박 계약은 이용자가 숙소의 예약 신청에 대해 숙소가 승낙함으로써 성립합니다. 단, 숙소가 별도로
									정하는 경우에는 예외로 합니다.</li>
								<li>온라인 예약의 경우, 숙소의 예약 시스템에 따라 예약 절차가 완료된 시점에 숙박 계약이 성립한
									것으로 봅니다.</li>
								<li>단체 예약 등 특별한 경우에는 숙소와 이용자 간의 별도 계약에 따릅니다.</li>
							</ol>

							<h3>제4조 (예약 신청)</h3>
							<p>이용자는 다음 각 호의 사항을 숙소에 제공하여 예약을 신청하여야 합니다.</p>
							<ol>
								<li>이용자의 성명 및 연락처</li>
								<li>숙박 예정일 및 숙박 기간</li>
								<li>객실 종류 및 인원수</li>
								<li>기타 숙소에서 요구하는 정보</li>
							</ol>

							<h3>제5조 (예약 변경 및 취소)</h3>
							<ol>
								<li>이용자가 예약 내용을 변경하고자 할 경우에는 숙소에 변경 가능 여부를 확인하고 숙소의 안내에 따라야
									합니다. 변경으로 인해 발생하는 추가 비용은 이용자가 부담합니다.</li>
								<li>이용자가 예약을 취소하고자 할 경우에는 숙소의 취소 규정에 따라야 합니다. 취소 시점에 따라 취소
									수수료가 발생할 수 있습니다. 숙소의 구체적인 취소 규정은 [별첨 또는 숙소 홈페이지 등 명시]에서 확인할 수
									있습니다.</li>
								<li>이용자의 연락 불능, 정보 오류 등으로 인해 예약 확인이 불가능하거나 숙소 이용에 차질이 발생한
									경우, 숙소는 해당 예약을 취소할 수 있습니다. 이 경우, 숙소는 그로 인한 책임을 지지 않습니다.</li>
							</ol>

							<h3>제6조 (숙박 요금 및 지급)</h3>
							<ol>
								<li>숙박 요금은 숙소 홈페이지, 예약 사이트 또는 숙소 내에 게시된 요금표에 따릅니다.</li>
								<li>숙박 요금은 원칙적으로 숙소 도착 시 또는 숙소에서 지정하는 방식에 따라 지급하여야 합니다. 다만,
									선결제 조건의 예약인 경우에는 예약 시점에 지급하여야 합니다.</li>
								<li>이용자의 사정으로 숙박 기간을 단축하는 경우에도 잔여 숙박 요금은 환불되지 않을 수 있습니다.</li>
							</ol>

							<h3>제7조 (숙소 이용)</h3>
							<ol>
								<li>이용자는 숙소의 안내 및 주의사항을 준수하여야 하며, 다른 이용자에게 불편을 주는 행위를 하여서는
									안 됩니다.</li>
								<li>숙소 내 시설 및 물품을 파손하거나 분실한 경우, 이용자는 그 손해를 배상하여야 합니다.</li>
								<li>숙소 내에서는 화재 위험이 있는 행위, 고성방가, 도박 및 풍기문란 행위를 금지합니다.</li>
								<li>객실 내에서는 숙소에서 허용하지 않는 취사 행위 및 반입 금지 물품의 보관을 금지합니다.</li>
								<li>귀중품은 프런트에 보관하거나 개인적으로 철저히 관리하여야 합니다. 숙소는 이용자의 부주의로 인한
									귀중품의 분실 또는 도난에 대해 책임을 지지 않습니다.</li>
								<li>애완동물 동반 투숙은 숙소의 규정에 따라 제한될 수 있습니다. 애완동물 동반 가능 여부 및 관련
									규정은 사전에 숙소에 문의하여 확인하여야 합니다.</li>
								<li>미성년자의 혼숙은 법률 및 숙소 규정에 따라 제한될 수 있습니다.</li>
								<li>숙소는 이용자의 안전과 편의를 위해 필요한 경우 객실을 점검할 수 있습니다.</li>
							</ol>

							<h3>제8조 (숙소의 책임)</h3>
							<ol>
								<li>숙소는 숙박 계약 및 본 약관에 따라 이용자에게 안전하고 쾌적한 숙박 환경을 제공할 의무를 집니다.</li>
								<li>숙소의 귀책사유로 인해 이용자에게 손해가 발생한 경우, 숙소는 그 손해를 배상할 책임을 집니다.
									다만, 천재지변 등 불가항력적인 사유로 인해 발생한 손해에 대해서는 책임을 지지 않습니다.</li>
								<li>숙소는 제공하는 서비스 및 시설에 대한 정보를 정확하게 제공하기 위해 노력합니다. 다만, 정보의
									오류로 인해 발생한 문제에 대해서는 책임을 지지 않을 수 있습니다.</li>
							</ol>

							<h3>제9조 (이용자의 책임)</h3>
							<ol>
								<li>이용자는 본 약관 및 숙소의 제반 규정을 준수하여야 합니다.</li>
								<li>이용자의 고의 또는 과실로 인해 숙소에 손해가 발생한 경우, 이용자는 그 손해를 배상할 책임을
									집니다.</li>
								<li>이용자는 예약 시 제공한 정보에 변경이 있을 경우, 즉시 숙소에 알려야 합니다. 이를 소홀히 하여
									발생하는 불이익에 대해서는 이용자 본인이 책임을 집니다.</li>
							</ol>

							<h3>제10조 (개인정보 보호)</h3>
							<p>숙소는 이용자의 개인정보를 관련 법령 및 숙소의 개인정보 처리방침에 따라 적절하게 관리합니다.</p>

							<h3>제11조 (분쟁 해결)</h3>
							<p>본 약관과 관련하여 숙소와 이용자 간에 발생하는 모든 분쟁은 상호 협의하여 해결하도록 노력하며, 협의가
								이루어지지 않을 경우에는 관련 법령 및 상관례에 따라 해결합니다.</p>

							<h3>제12조 (약관의 효력 및 변경)</h3>
							<ol>
								<li>본 약관은 이용자가 숙소에 숙박을 신청하고 숙소가 이를 승낙한 시점부터 효력이 발생합니다.</li>
								<li>숙소는 필요하다고 판단될 경우 본 약관을 변경할 수 있으며, 변경된 약관은 숙소 홈페이지 또는 기타
									적절한 방법으로 공지한 시점부터 효력이 발생합니다.</li>
							</ol>

							<h3>부칙</h3>
							<p>본 약관은 [시행일자]부터 시행합니다.</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-bs-dismiss="modal" onclick="goToReservationHistory()">확인</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="paymentModal" tabindex="-1"
				aria-labelledby="paymentModalLabel" inert>
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="paymentModalLabel">결제 확인</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<h5>예약 확인</h5>
							<p>
								<strong>숙소:</strong>
								${sessionScope.accommodation.accommodation_name }
							</p>
							<p>
								<strong>체크인:</strong> <span id="modal-checkin"></span>
							</p>
							<p>
								<strong>체크아웃:</strong> <span id="modal-checkout"></span>
							</p>
							<p>
								<strong>게스트 수:</strong> <span id="modal-guests"></span>명
							</p>
							<p>
								<strong>총 결제 금액:</strong> ₩<span id="modal-total-price"></span>
							</p>
							<hr>
							<input type="checkbox" id="agreeTerms"> <label
								for="agreeTerms">숙박시설 약관에 동의합니다. <a href="#"
								data-bs-toggle="modal" data-bs-target="#termsModal">[내용 확인]</a></label>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary"
								data-bs-dismiss="modal" onclick="goToReservationHistory()">확인</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="successModal" tabindex="-1"
				aria-labelledby="successModalLabel" inert>
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="successModalLabel">결제 완료</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">결제가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-bs-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="right-section">
			<h4>${sessionScope.accommodation.accommodation_name }</h4>
			<p>
				<strong>별장 전체</strong>
			</p>
			<p>⭐⭐⭐⭐⭐ 4.93 (후기 294개) • 슈퍼호스트</p>

			<h5>요금 세부정보</h5>
			<p>
				<a>₩ ${sessionScope.accommodation.price }</a> x <span id="nights">0</span>박
				= ₩<span id="room-price">0</span>
			</p>
			<div class="mb-3 total-price">
				<h5>총액</h5>
				<p>
					₩<span id="totalPriceDisplay">0</span> (KRW)
				</p>
				<p class="small-text">해외에서 결제가 처리되기 때문에 카드 발행사에서 추가 수수료를 부과할 수
					있습니다.</p>
			</div>
		</div>
	</div>

	<script>
	function formatDate(date) {
	    const year = date.getFullYear();
	    const month = String(date.getMonth() + 1).padStart(2, '0');
	    const day = String(date.getDate()).padStart(2, '0');
	    return `${year}-${month}-${day}`;
	}

	function copyValues() {
	    let checkinDate = new Date(document.getElementById("checkin").value);
	    let checkoutDate = new Date(document.getElementById("checkout").value);
	    let guests = document.getElementById("guests").value;
	    let totalPriceDisplay = document.getElementById("totalPriceDisplay").innerText.replace(/[^0-9]/g, "");
	    let accommodation_id = document.getElementById("accommodation_id").value;
	    let reservation_id = document.getElementById("randomValue").value;

	    document.getElementById("checkin_date_hidden").value = formatDate(checkinDate);
	    document.getElementById("checkout_date_hidden").value = formatDate(checkoutDate);
	    document.getElementById("guest_count_hidden").value = guests;
	    document.getElementById("total_price_hidden").value = totalPriceDisplay;
	    document.getElementById("accommodation_id").value = accommodation_id;
	    document.getElementById("randomValue").value = reservation_id;
	    console.log("체크인 날짜:", formatDate(checkinDate));
	    console.log("체크아웃 날짜:", formatDate(checkoutDate));
	    console.log("게스트 수:", guests);
	    console.log("price", totalPriceDisplay);
	    console.log("accommodation_id : ", accommodation_id);
	    console.log("reservation_id : ", reservation_id);
	}

	$(document).ready(function() {
	    // 모달 표시/숨김 시 inert 속성 관리
	    $('#paymentModal, #termsModal, #successModal').on('show.bs.modal', function() {
	        $(this).removeAttr('inert');
	    }).on('hide.bs.modal', function() {
	        $(this).attr('inert', 'inert');
	    });

	    // 가격 업데이트 함수
	    function updatePrice() {
	        let checkin = new Date($('#checkin').val());
	        let checkout = new Date($('#checkout').val());
	        let nights = (checkout - checkin) / (1000 * 60 * 60 * 24);
	        nights = nights > 0 ? nights : 1;

	        let pricePerNight = ${sessionScope.accommodation.price}; // JSP EL 사용
	        let totalRoomPrice = pricePerNight * nights;
	        let serviceFee = 229836; // 예시 값, 실제 값으로 변경 필요
	        let totalPrice = totalRoomPrice + serviceFee;

	        $('#nights').text(nights);
	        $('#room-price').text(totalRoomPrice.toLocaleString());
	        $('#totalPriceDisplay').text('₩' + totalPrice.toLocaleString()); // 총 가격 업데이트
	    }

	    // 가격 업데이트 이벤트 핸들러
	    $('#checkin, #checkout, #guests').on('change', updatePrice);
	    updatePrice(); // 페이지 로딩 시 초기 가격 설정

	    // 폼 제출 이벤트 핸들러
	    $('#reservationForm').on('submit', function(event) {
	        event.preventDefault(); // 기본 제출 동작 방지
	        copyValues(); // hidden 필드에 값 복사
	        $('#paymentModal').modal('show'); // 결제 확인 모달 표시
	    });

	    // 약관 확인 후 체크박스 자동 체크 및 결제 확인 창으로 이동
	    $('#termsModal .btn-primary').click(function() {
	        $('#termsModal').modal('hide');
	        $('#agreeTerms').prop('checked', true).trigger('change');
	        $('#paymentModal').modal('show');
	    });

	    // 약관 동의 체크박스 상태에 따라 확인 버튼 활성화/비활성화
	    $('#agreeTerms').change(function() {
	        $('#confirmPayment').prop('disabled', !this.checked);
	    });

	    // 확인 버튼 클릭 시 폼 제출 및 모달 처리
	    $('#confirmPayment').click(function() {
	        $('#reservationForm')[0].submit();
	        $('#paymentModal').modal('hide');
	        $('#successModal').modal('show');
	    });

	    // 결제 확인 모달 표시 전에 예약 정보 업데이트
	    $('#paymentModal').on('show.bs.modal', function(event) {
	        const checkin = $('#checkin').val();
	        const checkout = $('#checkout').val();
	        const guests = $('#guests').val();
	        const totalPrice = $('#totalPriceDisplay').text();

	        $('#modal-checkin').text(checkin);
	        $('#modal-checkout').text(checkout);
	        $('#modal-guests').text(guests);
	        $('#modal-total-price').text(totalPrice);
	    });
	});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>