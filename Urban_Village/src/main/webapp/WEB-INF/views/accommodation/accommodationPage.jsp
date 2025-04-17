<%@page
	import="com.test.Urban_Village.accommodation.dto.AccommodationDTO"%>
<%@page import="java.util.Random"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    // 현재 시간을 타임스탬프로 사용
    long currentTimestamp = System.currentTimeMillis();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4144168e9f9cd514608615aac5e437e5"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
.heart {
	font-size: 24px;
	cursor: pointer;
	color: #ccc;
}

.heart.active {
	color: red;
}

.hidden {
	display: none;
}
.error-message {
         font-size: 0.9em;
         color: red;
         margin-top: 4px;
         margin-bottom: 8px;
      }

.accommodation-image-container {
    position: relative;
    width: 800px; /* 숙소 이미지 전체 컨테이너 너비 */
    height: 500px; /* 숙소 이미지 컨테이너 높이 */
    margin: 0 auto; /* 중앙 배치 */
    border: 1px solid #ddd;
    border-radius: 10px;
    overflow: hidden;
}

.accommodation-image {
    width: 100%; /* 컨테이너 크기에 맞춤 */
    height: auto; /* 비율 유지하며 크기 조정 */
    object-fit: cover; /* 비율 유지하며 크기 조정 */
}

/* 이전 및 다음 버튼 스타일 */
.image-navigation {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 100%;
    display: flex;
    justify-content: space-between;
    pointer-events: none; /* 버튼 이외의 영역 클릭 방지 */
}

.nav-button {
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    font-size: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    pointer-events: auto; /* 버튼 클릭 허용 */
}

.nav-button:hover {
    background-color: rgba(0, 0, 0, 0.8);
}

/* 후기 이미지 스타일 */
.review-images img {
    width: 100px; /* 작게 표시 */
    height: 80px;
    object-fit: cover; /* 비율 유지하며 크기 조정 */
    margin: 5px;
    border: 1px solid #ddd;
    border-radius: 5px;
    cursor: pointer;
}

/* 모달 스타일 */
.modal-overlay {
    display: none; /* 초기에는 숨김 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 1); /* 완전한 검은색 배경 */
    justify-content: center;
    align-items: center;
    z-index: 9999; /* 가장 위에 표시 */
}

/* 모달 컨텐츠 */
.modal-content {
    position: relative;
    max-width: 80%; /* 모달 너비 */
    max-height: 80%; /* 모달 높이 */
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px;
}

/* 모달 이미지 */
.modal-content img {
    width: auto;
    height: auto;
    max-width: 100%;
    max-height: 100%;
    display: block;
}

/* 닫기 버튼 스타일 */
.close-button {
    position: absolute;
    top: 20px; /* 상단 위치 */
    left: 20px; /* 좌측 위치 */
    background: transparent; /* 배경 없음 */
    color: white; /* 텍스트 색상 */
    border: none;
    font-size: 18px; /* 텍스트 크기 */
    font-weight: bold; /* 텍스트 굵기 */
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 5px; /* 아이콘과 텍스트 간격 */
}

.close-button:hover {
    color: #ff6666; /* 호버 시 색상 변경 */
    text-decoration: underline; /* 호버 시 밑줄 추가 */
}

.close-button:focus {
    outline: none;
}

/* 이전 및 다음 버튼 스타일 */
.modal-nav-button {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(255, 255, 255, 0.5); /* 반투명 배경 */
    color: black;
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    font-size: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    z-index: 1001;
}

#modalPrevButton {
    left: 10px;
}

#modalNextButton {
    right: 10px;
}

.modal-nav-button:hover {
    background-color: rgba(255, 255, 255, 0.8); /* 호버 시 배경색 변경 */
}

/* 별점 스타일 */
.star {
    color: #ffc107; /* 노란색 */
    font-size: 20px; /* 별 크기 */
}

.star-empty {
    color: #ddd; /* 비어있는 별의 색상 */
    font-size: 20px; /* 별 크기 */
}
</style>
</head>
<body>

	<main class="container mt-4">
		<div class="d-flex justify-content-between align-items-center">

			<h1 class="fw-bold">🌟
				${sessionScope.accommodation.accommodation_name}</h1>
			<span class="heart" onclick="toggleHeart()">❤️</span>
		</div>
		<p class="text-muted">${sessionScope.accommodation.capacity}</p>
		<p name="commodation_id">숙소 ID
			:${sessionScope.accommodation.accommodation_id}</p>
		 <div class="container mt-4">
         <h3 class="fw-bold text-center">숙소 이미지</h3>
         <div class="accommodation-image-container">
            <!-- DB에 저장된 이미지 파일명이 콤마로 구분되어 있다고 가정 -->
            <c:set var="imageStr"
               value="${sessionScope.accommodation.accommodation_photo}" />
            <c:set var="images" value="${fn:split(imageStr, ',')}" />
            <c:forEach var="img" items="${images}" varStatus="status">
               <img
                   src="${contextPath}/download.do?imageFileName=${img}&accommodation_id=${sessionScope.accommodation.accommodation_id}&timestamp=<%= currentTimestamp %>"
                   class="accommodation-image" alt="숙소 이미지"
                   style="display: ${status.index == 0 ? 'block' : 'none'}"
                   data-index="${status.index}" onclick="showModal(this.src, [...document.querySelectorAll('.accommodation-image')].map(el => el.src))">
            </c:forEach>
            <div class="image-navigation">
               <button class="nav-button" id="prevButton">&lt;</button>
               <button class="nav-button" id="nextButton">&gt;</button>
            </div>
         </div>
      </div>

		<div class="row">
			<div class="col-md-6">
				<h3 class="fw-bold">${sessionScope.accommodation.price}원/ 박</h3>
				<p>
					<strong>⭐ 4.93 후기 294개</strong>
				</p>
				<input type="date" id="checkin" class="form-control mb-2"
					onchange="calculatePrice()" placeholder="YYYY-MM-DD"> <input
					type="date" id="checkout" class="form-control mb-2"
					onchange="calculatePrice()" placeholder="YYYY-MM-DD"> <label>인원:</label>
				<select id="guests" class="form-control mb-2">
					<option value="1">1명</option>
					<option value="2">2명</option>
					<option value="3">3명</option>
					<option value="4">4명</option>
				</select>
				<p class="fw-bold">
					총 금액: <span id="totalPrice">₩0</span>
				</p>
				<button type="button" class="btn btn-danger w-100" onclick="goToReservation()">예약하기</button>

			</div>

			<div class="col-md-6">
				<h3>편의시설 확인</h3>
				<ul>
					<li>✅ WiFi ${sessionScope.accommodation.wifi_avail}</li>
					<li>✅ 침실 갯수 ${sessionScope.accommodation.room_count}</li>
					<li>✅ 화장실 갯수 ${sessionScope.accommodation.bathroom_count}</li>
					<li>✅ 침대 갯수 ${sessionScope.accommodation.bed_count}</li>
				</ul>
				<h3>숙소 규칙</h3>
				<ul>
					<li>🚫 반려동물 금지</li>
					<li>🚫 금연</li>
					<li>🔇 밤 10시 이후 정숙</li>
				</ul>
			</div>
		</div>

		<h3 class="mt-4">위치 ${sessionScope.accommodation.capacity}</h3>
		<div id="map" style="width: 100%; height: 400px; background: #ddd;"></div>

		<h3 class="mt-4">📝 후기</h3>
      <div id="reviews">
         <c:if test="${not empty reviews}">
            <c:forEach var="review" items="${reviews}">
               <div class="review-item">
                  <p>
                        <strong>${review.id}</strong> 
                        (<fmt:formatDate value="${review.created_at}" pattern="yyyy년 MM월 dd일 HH시 mm분" />):
                    </p>
                  <div>
                      <span>평점: </span>
                      <c:forEach begin="1" end="${review.rating}">
                          <span class="star">★</span>
                      </c:forEach>
                      <c:forEach begin="${review.rating + 1}" end="5">
                          <span class="star-empty">☆</span>
                      </c:forEach>
                  </div>
                  <p>${review.review_data}</p>
                  <c:if test="${not empty review.review_photo}">
                     <div class="review-images">
                        <c:forEach var="photo"
                           items="${fn:split(review.review_photo, ',')}">
                           <img
                               src="${contextPath}/download1.do?imageFileName=${photo}&review_id=${review.review_id}&timestamp=<%= currentTimestamp %>"
                               alt="리뷰 이미지" onclick="showModal(this.src, [...document.querySelectorAll('.review-images img')].map(el => el.src))">
                        </c:forEach>
                     </div>
                  </c:if>
               </div>
               <hr>
            </c:forEach>
         </c:if>
         <c:if test="${empty reviews}">
            <p>아직 후기가 없습니다. 첫 번째 후기를 작성해보세요!</p>
         </c:if>
      </div>

      <!-- 이미지 확대 모달 -->
      <div class="modal-overlay" id="imageModal">
          <div class="modal-content">
              <!-- 닫기 버튼 수정 -->
              <button class="close-button" onclick="closeModal()">✖ 닫기</button>
              <img id="modalImage" src="" alt="확대 이미지">
              <!-- 이전 및 다음 버튼 -->
              <button class="modal-nav-button" id="modalPrevButton" onclick="showPrevImage()">◀</button>
              <button class="modal-nav-button" id="modalNextButton" onclick="showNextImage()">▶</button>
          </div>
      </div>
	</main>


	<script>
	function calculatePrice() {
	    let checkin = document.getElementById("checkin").value;
	    let checkout = document.getElementById("checkout").value;
	    let pricePerNight = Number("<c:out value='${sessionScope.accommodation.price}' />");

	    if (checkin && checkout) {
	    	
	        let nights = (new Date(checkout) - new Date(checkin)) / (1000 * 60 * 60 * 24);
	        if (nights > 0) {
	            let totalPrice = nights * pricePerNight;
	            document.getElementById("totalPrice").textContent = "₩" + totalPrice.toLocaleString();

	        } else {
	            document.getElementById("totalPrice").textContent = "₩0";
	        }
	    }
	}

    
    // 카카오맵 초기화 함수
    function initKakaoMap() {
        var container = document.getElementById('map'); // 지도 표시 영역
        var options = {
            center: new kakao.maps.LatLng(37.653, 127.236), // 남양주 좌표
            level: 5 // 확대 레벨 (낮을수록 더 확대)
        };

        var map = new kakao.maps.Map(container, options); // 지도 생성
        var marker = new kakao.maps.Marker({ 
            position: new kakao.maps.LatLng(37.653, 127.236), 
            map: map 
        });
    }

    // 찜하기(하트) 기능
    function toggleHeart() {
        let heart = document.querySelector(".heart");
        heart.classList.toggle("active");
        alert(heart.classList.contains("active") ? "찜 목록에 추가되었습니다!" : "찜 목록에서 제거되었습니다.");
    }
	
    
    
    document.addEventListener('DOMContentLoaded', function() {
        const checkinInput = document.getElementById('checkin');
        const checkoutInput = document.getElementById('checkout');
        const guestsInput = document.getElementById('guests');

        // ✅ 로컬스토리지 완전 초기화
        localStorage.removeItem('reservationCheckin');
        localStorage.removeItem('reservationCheckout');
        localStorage.removeItem('reservationGuests');
        localStorage.removeItem('reservationTotalPrice');

        // ✅ input 초기화
        if (checkinInput) checkinInput.value = "";
        if (checkoutInput) checkoutInput.value = "";
        if (guestsInput) guestsInput.selectedIndex = 0; // 첫 번째 옵션 선택
    });

    function goToReservation() {
        let checkin = document.getElementById("checkin").value;
        let checkout = document.getElementById("checkout").value;
        let guests = document.getElementById("guests").value;
        let pricePerNight = Number("${sessionScope.accommodation.price}");
        let hasError = false;

        // 기존 에러 메시지 제거
        document.querySelectorAll(".error-message").forEach(el => el.remove());

        if (!checkin) {
            if (!document.getElementById("checkin").nextElementSibling?.classList.contains("error-message")) {
                let errorMsg = document.createElement("p");
                errorMsg.className = "error-message";
                errorMsg.textContent = "체크인 날짜를 선택해주세요.";
                document.getElementById("checkin").insertAdjacentElement('afterend', errorMsg);
            }
            document.getElementById("checkin").focus();
            hasError = true;
        }

        if (!checkout) {
            if (!document.getElementById("checkout").nextElementSibling?.classList.contains("error-message")) {
                let errorMsg = document.createElement("p");
                errorMsg.className = "error-message";
                errorMsg.textContent = "체크아웃 날짜를 선택해주세요.";
                document.getElementById("checkout").insertAdjacentElement('afterend', errorMsg);
            }
            document.getElementById("checkout").focus();
            hasError = true;
        } else if (checkin && checkout && (checkin >= checkout)) {
            if (!document.getElementById("checkout").nextElementSibling?.classList.contains("error-message")) {
                let errorMsg = document.createElement("p");
                errorMsg.className = "error-message";
                errorMsg.textContent = "체크아웃 날짜는 체크인 날짜 이후여야 합니다.";
                document.getElementById("checkout").insertAdjacentElement('afterend', errorMsg);
            }
            document.getElementById("checkout").focus();
            hasError = true;
        }

        if (!guests || isNaN(guests) || Number(guests) < 1) {
            if (!document.getElementById("guests").nextElementSibling?.classList.contains("error-message")) {
                let errorMsg = document.createElement("p");
                errorMsg.className = "error-message";
                errorMsg.textContent = "인원수를 선택해주세요.";
                document.getElementById("guests").insertAdjacentElement('afterend', errorMsg);
            }
            document.getElementById("guests").focus();
            hasError = true;
        }

        if (hasError) {
            return;
        }

        let nights = (new Date(checkout) - new Date(checkin)) / (1000 * 60 * 60 * 24);
        let totalPrice = nights > 0 ? nights * pricePerNight : 0;

        // 로컬 스토리지 저장
        localStorage.setItem('reservationCheckin', checkin);
        localStorage.setItem('reservationCheckout', checkout);
        localStorage.setItem('reservationGuests', guests);
        localStorage.setItem('reservationTotalPrice', totalPrice);

        // 디버깅 메시지 추가
        console.log("예약 정보 저장 완료, 페이지 이동 시도");
        console.log("이동할 경로:", "/Urban_Village/reservation/reservationForm.do");

        // 예약 페이지로 이동
        window.location.href = "${contextPath}/reservation/reservationForm.do";
    }



    // 후기 더보기 기능
    function toggleReviews() {
        document.querySelectorAll(".review.hidden").forEach(el => el.classList.toggle("hidden"));
    }
 // 초기화된 이미지 배열 및 현재 이미지 인덱스 관리
    let imageArray = [];
    let currentImageIndex = 0;

    // 숙소 이미지 및 후기 이미지 클릭 이벤트 추가
    document.addEventListener('DOMContentLoaded', () => {
    const accommodationImages = [...document.querySelectorAll('.accommodation-image')].map(el => el.src);
    const reviewImages = [...document.querySelectorAll('.review-images img')].map(el => el.src);

    // showModal을 호출하지 않음
    document.querySelectorAll('.accommodation-image').forEach((img) => {
        img.addEventListener('click', () => {
            showModal(img.src, accommodationImages);
        });
    });

    document.querySelectorAll('.review-images img').forEach((img) => {
        img.addEventListener('click', () => {
            showModal(img.src, reviewImages);
        });
    });
});

    // 모달 표시 함수
    function showModal(imageSrc, images) {
        const modal = document.getElementById("imageModal");
        const modalImage = document.getElementById("modalImage");

        // 이미지 배열 초기화 및 현재 인덱스 설정
        imageArray = images;
        currentImageIndex = images.indexOf(imageSrc);

        if (currentImageIndex === -1) {
            console.error("현재 이미지가 배열에서 찾을 수 없습니다.");
            return;
        }

        modalImage.src = imageSrc; // 확대할 이미지 설정
        modal.style.display = "flex"; // 모달 표시
    }

    // 이전 이미지 표시
    function showPrevImage() {
        if (currentImageIndex > 0) {
            currentImageIndex--;
            document.getElementById("modalImage").src = imageArray[currentImageIndex];
        } else {
            alert("첫 번째 이미지입니다.");
        }
    }

    // 다음 이미지 표시
    function showNextImage() {
        if (currentImageIndex < imageArray.length - 1) {
            currentImageIndex++;
            document.getElementById("modalImage").src = imageArray[currentImageIndex];
        } else {
            alert("마지막 이미지입니다.");
        }
    }

    // 모달 닫기
    function closeModal() {
        const modal = document.getElementById("imageModal");
        modal.style.display = "none"; // 모달 숨기기
    }

    // 페이지 로드 시 지도 표시
    window.onload = initKakaoMap;
</script>
</body>
</html>