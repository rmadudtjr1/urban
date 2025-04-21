
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-Control"
    content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<title>숙소 예약</title>
<style>
/* 기존 스타일 유지 */
.accommodation {
    border: none;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    margin-bottom: 30px;
    max-width: 400px;
    background-color: #fff;
    transition: transform 0.2s;
}

.accommodation:hover {
    transform: scale(1.02);
}

.accommodation>a {
    text-decoration: none;
    color: black;
    display: block;
}

.accommodation img {
    width: 100%;
    height: 250px;
    object-fit: cover;
}

.details {
    padding: 16px;
}

.details h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 600;
}

.details p {
    margin: 4px 0;
    color: #555;
    font-size: 14px;
}

.heart-icon {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 22px;
    cursor: pointer;
    color: white;
    text-shadow: 0 0 4px rgba(0, 0, 0, 0.5);
    z-index: 2;
}

.heart-icon.liked {
    color: red;
}

.accommodation {
    position: relative;
}

@keyframes blink {
  0% { opacity: 1; }
  50% { opacity: 0; }
  100% { opacity: 1; }
}
.blink-text {
    text-align: center;
    color: red;
    animation: blink 1s infinite;
}

/* 수정된 슬라이더 스타일 */
.hero-slider-container {
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 50px;
}

.hero-slider {
    display: flex;
    transition: transform 0.5s ease-in-out;
}

.slide {
    min-width: 100%;
    position: relative;
}

.slide img {
    width: 100%;
    display: block;
    height: 500px;
    object-fit: cover;
}

.slide-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: white;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 20px;
    border-radius: 10px;
    width: 80%;
}

.slide-text h3 {
    font-size: 1.8em;
    margin-bottom: 10px;
}

.slide-text p {
    font-size: 1.2em;
}

.prev-button, .next-button {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    font-size: 2em;
    color: white;
    cursor: pointer;
    padding: 10px;
    z-index: 10;
    opacity: 0.7;
    transition: opacity 0.3s ease;
}

.prev-button:hover, .next-button:hover {
    opacity: 1;
}

.prev-button {
    left: 20px;
}

.next-button {
    right: 20px;
}

/* About Us 섹션 스타일은 유지 */
.about-us-container {
    padding: 50px 20px;
    text-align: center;
    background-color: #f9f9f9;
}

.about-us-title {
    font-size: 2.5em;
    margin-bottom: 30px;
}

.about-us-content {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap; /* 화면이 작아지면 아래로 내려가도록 */
    max-width: 1200px;
    margin: 0 auto;
}

.about-us-image {
    flex: 1;
    max-width: 300px;
    margin: 20px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    opacity: 0;
    transform: translateX(-50px);
    transition: opacity 0.5s ease-out, transform 0.5s ease-out;
}

.about-us-image.show {
    opacity: 1;
    transform: translateX(0);
}

.about-us-image img {
    width: 100%;
    display: block;
    height: auto;
    object-fit: cover;
}

.about-us-text {
    flex: 2;
    min-width: 300px;
    padding: 20px;
    text-align: left;
    opacity: 0;
    transform: translateX(50px);
    transition: opacity 0.5s ease-out 0.3s, transform 0.5s ease-out 0.3s; /* 약간의 딜레이 */
}

.about-us-text.show {
    opacity: 1;
    transform: translateX(0);
}

.about-us-paragraph {
    line-height: 1.6;
    margin-bottom: 15px;
}
</style>
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
const contextPath = '${contextPath}';

function toggleWishlist(element, memberId, accommodationId) {
    $.ajax({
        url: contextPath + '/wishList/check.do',
        method: 'POST',
        data: {
            memberId: memberId,
            accommodationId: accommodationId
        },
        success: function(response) {
            if (response === "true") {
                // 이미 찜한 상태면 제거
                removeFromWishlist(memberId, accommodationId, element);
            } else {
                // 찜 안한 상태면 추가
                addToWishlist(memberId, accommodationId, element);
            }
        },
        error: function() {
            alert("고객으로 로그인을 해주세요. 찜 처리 중 오류가 발생했습니다.");
        }
    });
}

function addToWishlist(memberId, accommodationId, element) {
    $.ajax({
        url: contextPath + '/wishList/add.do',
        method: 'POST',
        data: {
            memberId: memberId,
            accommodationId: accommodationId
        },
        success: function(response) {
            if (response == "1") {
                // 찜 성공 시 하트 아이콘 상태 변경
                $(element).addClass("liked").html("&#9829;"); // ♥
                alert("위시리스트에 추가되었습니다."); // 추가 성공 메시지
            }
        },
        error: function() {
            alert("찜 추가 중 오류 발생");
        }
    });
}

function removeFromWishlist(memberId, accommodationId, element) {
    $.ajax({
        url: contextPath + '/wishList/remove.do',
        method: 'POST',
        data: {
            memberId: memberId,
            accommodationId: accommodationId
        },
        success: function(response) {
            if (response == "1") {
                // 찜 제거 시 하트 아이콘 원래대로
                $(element).removeClass("liked").html("&#9825;"); // ♡
                alert("위시리스트에서 제거되었습니다."); // 삭제 성공 메시지
            }
        },
        error: function() {
            alert("찜 삭제 중 오류 발생");
        }
    });
}

$(document).ready(function() {
    // about-us 섹션 애니메이션
    $(window).scroll(function() {
        var scrollPosition = $(window).scrollTop();
        var aboutUsContainer = $('.about-us-container');
        var aboutUsOffsetTop = aboutUsContainer.offset().top;
        var windowHeight = $(window).height();

        // about-us 컨테이너의 상단이 윈도우 하단보다 위에 있고,
        // about-us 컨테이너의 하단이 윈도우 상단보다 아래에 있을 때 (화면에 보일 때)
        if (aboutUsOffsetTop < scrollPosition + windowHeight && aboutUsOffsetTop + aboutUsContainer.outerHeight() > scrollPosition) {
            $('.about-us-image').addClass('show');
            $('.about-us-text').addClass('show');
        }
    });

    // 이미지 슬라이더 기능 (수정됨)
    const slides = $('.slide');
    const slideCount = slides.length;
    let currentIndex = 0;

    // 슬라이드 이동 함수
    function showSlide(index) {
        $('.hero-slider').css('transform', `translateX(-${index * 100}%)`);
        
        // 슬라이드 텍스트 업데이트 (옵션)
        const currentSlide = slides.eq(index);
        if(currentSlide.data('text')) {
            const textParts = currentSlide.data('text').split(', ');
            currentSlide.find('.slide-text h3').text(textParts[0] || '');
            currentSlide.find('.slide-text p').text(textParts[1] || '');
        }
    }

    // 다음 슬라이드 이동
    function nextSlide() {
        currentIndex = (currentIndex + 1) % slideCount;
        showSlide(currentIndex);
    }

    // 이전 슬라이드 이동
    function prevSlide() {
        currentIndex = (currentIndex - 1 + slideCount) % slideCount;
        showSlide(currentIndex);
    }

    // 버튼 이벤트 연결
    $('.next-button').on('click', nextSlide);
    $('.prev-button').on('click', prevSlide);

    // 자동 슬라이드 (10초마다)
    setInterval(nextSlide, 10000);
    
    // 초기 슬라이드 설정
    showSlide(0);
});
</script>
</head>

<body>

    <div class="hero-slider-container">
        <div class="hero-slider">
            <div class="slide" data-text="한옥과 현대적 감각의 조화, 동묘앞 도보 5분 거리 스테이">
                <img src="${contextPath}/resources/WebSiteImages/aaa.png" alt="슬라이드 1">
                <div class="slide-text">
                    <h3>한옥과 현대적 감각의 조화</h3>
                    <p>동묘앞 도보 5분 거리 스테이</p>
                </div>
            </div>
            <div class="slide" data-text="5-6월 얼리투숙 시 10% 할인, 서촌 여행을 계획 중이라면 이곳으로">
                <img src="${contextPath}/resources/WebSiteImages/bbb.jpg" alt="슬라이드 2">
                <div class="slide-text">
                    <h3>5-6월 얼리투숙 시 10% 할인</h3>
                    <p>서촌 여행을 계획 중이라면 이곳으로</p>
                </div>
            </div>
            <div class="slide" data-text="기획&마케팅 분야 8인의 베스트 스테이, 완벽한 서울 도심 속 힐링">
                <img src="${contextPath}/resources/WebSiteImages/ccc.jpg" alt="슬라이드 3">
                <div class="slide-text">
                    <h3>기획&마케팅 분야 8인의 베스트 스테이</h3>
                    <p>완벽한 서울 도심 속 힐링</p>
                </div>
            </div>
            <div class="slide" data-text="신규 오픈 숙소, 지금 예약하고 할인 혜택 받기">
                <img src="${contextPath}/resources/WebSiteImages/ddd.jpg" alt="슬라이드 4">
                <div class="slide-text">
                    <h3>신규 오픈 숙소</h3>
                    <p>지금 예약하고 할인 혜택 받기</p>
                </div>
            </div>
            <div class="slide" data-text="휴식이 필요할 때, 편안한 분위기의 객실">
                <img src="${contextPath}/resources/WebSiteImages/eee.jpeg" alt="슬라이드 5">
                <div class="slide-text">
                    <h3>휴식이 필요할 때</h3>
                    <p>편안한 분위기의 객실</p>
                </div>
            </div>
            <div class="slide" data-text="도심 속 한적한 공간, 여유로운 시간을 만끽하세요">
                <img src="${contextPath}/resources/WebSiteImages/fff.jpg" alt="슬라이드 6">
                <div class="slide-text">
                    <h3>도심 속 한적한 공간</h3>
                    <p>여유로운 시간을 만끽하세요</p>
                </div>
            </div>
            <div class="slide" data-text="특별한 날을 위한 특별한 공간, 최고의 뷰와 서비스">
                <img src="${contextPath}/resources/WebSiteImages/ggg.jpg" alt="슬라이드 7">
                <div class="slide-text">
                    <h3>특별한 날을 위한 특별한 공간</h3>
                    <p>최고의 뷰와 서비스</p>
                </div>
            </div>
        </div>
        <button class="prev-button">&lt;</button>
        <button class="next-button">&gt;</button>
    </div>

    <div class="container">

        <div class="categories-container">
            <div class="categories">
                <a
                    href="${contextPath}/accommodation/searchAddress?keyword=김천ㆍ칠곡ㆍ고령ㆍ성주">김천
                    ㆍ 칠곡 ㆍ 고령 ㆍ 성주</a> <a
                    href="${contextPath}/accommodation/searchAddress?keyword=구미ㆍ상주ㆍ의성ㆍ문경">구미
                    ㆍ 상주 ㆍ 의성 ㆍ 문경</a> <a
                    href="${contextPath}/accommodation/searchAddress?keyword=예천ㆍ안동ㆍ영주ㆍ봉화">예천
                    ㆍ 안동 ㆍ 영주 ㆍ 봉화</a> <a
                    href="${contextPath}/accommodation/searchAddress?keyword=영양ㆍ울진ㆍ영덕ㆍ청송">영양
                    ㆍ 울진 ㆍ 영덕 ㆍ 청송</a> <a
                    href="${contextPath}/accommodation/searchAddress?keyword=포항ㆍ영천ㆍ경주ㆍ경산">포항
                    ㆍ 영천 ㆍ 경주 ㆍ 경산</a> <a
                    href="${contextPath}/accommodation/searchAddress?keyword=한옥ㆍ울릉ㆍ청도ㆍ독도">울릉 ㆍ 청도 ㆍ 독도</a>
            </div>
        </div>
        <div class="accommodations">
            <c:forEach items="${accommodationList}" var="accommodation">
                <div class="accommodation">
                    <span class="heart-icon ${accommodation.liked ? 'liked' : ''}"
                        onclick="event.stopPropagation(); toggleWishlist(this, '${loginId}', '${accommodation.accommodation_id}')">
                        &#10084; </span> <a
                        href="${pageContext.request.contextPath}/accommodation/accommodationPage.do?accommodation_id=${accommodation.accommodation_id}&accommodation_name=${accommodation.accommodation_name}">

                        <div>
                            <c:forEach var="bestAcc" items="${hostBestAccIdList}">
                                <c:if
                                    test="${accommodation.accommodation_id eq bestAcc.accommodation_id}">
                                    <p class="blink-text">★ 호스트 추천 숙소 ★</p>
                                </c:if>
                            </c:forEach>
                        </div> 
                        <c:set var="imageStr"
                            value="${accommodation.accommodation_photo}" /> 
                            <c:set
                            var="images" value="${fn:split(imageStr, ',')}" /> 
                            <img
                        src="${contextPath}/download.do?imageFileName=${images[0]}&accommodation_id=${accommodation.accommodation_id}&timestamp=<%= System.currentTimeMillis() %>"
                        alt="${accommodation.accommodation_name}">
                        <div class="details">
                            <h3>${accommodation.accommodation_name}</h3>
                            <c:set var="addrParts"
                                value="${fn:split(accommodation.accommodation_address, ' ')}" />
                            <p>★ ${accommodation.averageRating} / ${addrParts[0]}
                                ${addrParts[1]}</p>
                            <p>수용인원 : ${accommodation.capacity}명</p>
                            <p>₩ ${accommodation.price} / 박</p>
                            <c:if test="${not empty accommodation.latestReview}">
                         <p>게스트 한마디: ${accommodation.latestReview}</p>
                     </c:if>
                     <c:if test="${empty accommodation.latestReview}">
                         <p>아직 리뷰가 없습니다.</p>
                     </c:if>
                        </div>
                    </a>
                </div>
            </c:forEach>

        </div>

    </div>

    <div class="about-us-container">
        <h2 class="about-us-title">저희가 이 사이트를 만든 이유</h2>
        <div class="about-us-content">
            <div class="about-us-image">
                <img src="${contextPath}/resources/WebSiteImages/aaa.png" alt="여행 사진 1">
            </div>
            <div class="about-us-text">
                <p class="about-us-paragraph">저희는 여행을 사랑하고, 특히 아름다운 경상북도의 숨겨진 보석
                    같은 숙소들을 발견하는 것을 좋아합니다.</p>
                <p class="about-us-paragraph">기존의 숙박 예약 플랫폼들은 너무 많은 정보와 복잡한 인터페이스로
                    사용자들이 진정으로 원하는 숙소를 찾기 어렵게 만들 때가 많습니다.</p>
                <p class="about-us-paragraph">그래서 저희는 경상북도의 특별하고 매력적인 숙소들을 한눈에
                    보여주고, 쉽고 빠르게 예약할 수 있는 플랫폼을 만들고자 했습니다.</p>
                <p class="about-us-paragraph">저희의 목표는 사용자들이 번거로움 없이 완벽한 숙소를 찾아 행복한
                    여행 경험을 만드는 데 기여하는 것입니다.</p>
            </div>
            <div class="about-us-image">
                <img src="${contextPath}/resources/WebSiteImages/ggg.jpg" alt="여행 사진 2">
            </div>
        </div>
    </div>

</body>
</html>