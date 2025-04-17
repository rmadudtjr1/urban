<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />

<title></title>
<style>
.accommodation {
    border: none;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    margin-bottom: 30px;
    max-width: 400px;
    background-color: #fff;
    transition: transform 0.2s;
}
.accommodation:hover {
    transform: scale(1.02);
}

.accommodation > a {
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
  text-align : center;
  color: red;
  animation: blink 1s infinite;
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


</script>
<head>
</head>
</head>

<body>

    <div class="container">

        <div class="categories-container">
         <div class="categories">
              <a href="${contextPath}/accommodation/searchAddress?keyword=김천ㆍ칠곡ㆍ고령ㆍ성주">김천 ㆍ 칠곡 ㆍ 고령 ㆍ 성주</a>
             <a href="${contextPath}/accommodation/searchAddress?keyword=구미ㆍ상주ㆍ의성ㆍ문경">구미 ㆍ 상주 ㆍ 의성 ㆍ 문경</a>
              <a href="${contextPath}/accommodation/searchAddress?keyword=예천ㆍ안동ㆍ영주ㆍ봉화">예천 ㆍ 안동 ㆍ 영주 ㆍ 봉화</a> 
              <a href="${contextPath}/accommodation/searchAddress?keyword=영양ㆍ울진ㆍ영덕ㆍ청송">영양 ㆍ 울진 ㆍ 영덕 ㆍ 청송</a> 
              <a href="${contextPath}/accommodation/searchAddress?keyword=포항ㆍ영천ㆍ경주ㆍ경산">포항 ㆍ 영천 ㆍ 경주 ㆍ 경산</a> 
              <a href="${contextPath}/accommodation/searchAddress?keyword=한옥ㆍ울릉ㆍ청도ㆍ독도">한옥 ㆍ 울릉 ㆍ 청도 ㆍ 독도</a>
         </div>
      </div>
<div class="accommodations">
         <c:forEach items="${accommodationList}" var="accommodation">
             <div class="accommodation">
              <span class="heart-icon ${accommodation.liked ? 'liked' : ''}"
      onclick="event.stopPropagation(); toggleWishlist(this, '${loginId}', '${accommodation.accommodation_id}')">
    &#10084;
</span>
                 <a href="${pageContext.request.contextPath}/accommodation/accommodationPage.do?accommodation_id=${accommodation.accommodation_id}&accommodation_name=${accommodation.accommodation_name}">
                     
                     <!-- 사진 처리 -->
                      <div>
                       <c:forEach var="bestAcc" items="${hostBestAccIdList}">
    						<c:if test="${accommodation.accommodation_id eq bestAcc.accommodation_id}">
               					 <p class="blink-text">★ 호스트 추천 숙소 ★</p>
            				</c:if>
						</c:forEach>
                    </div>
                     
                     <c:set var="imageStr" value="${accommodation.accommodation_photo}" />
                     <c:set var="images" value="${fn:split(imageStr, ',')}" />
                     <img src="${contextPath}/download.do?imageFileName=${images[0]}&accommodation_id=${accommodation.accommodation_id}&timestamp=<%= System.currentTimeMillis() %>"
                          alt="${accommodation.accommodation_name}">
                     <div class="details">
                         <h3>${accommodation.accommodation_name}</h3>
                         <!-- 주소를 분리해서 첫 번째와 두 번째 부분만 출력 -->
                         <c:set var="addrParts" value="${fn:split(accommodation.accommodation_address, ' ')}"/>
                         <p>★ ${accommodation.averageRating} / ${addrParts[0]} ${addrParts[1]}</p>
                         <p>수용인원 : ${accommodation.capacity}명</p>
                         <p>₩ ${accommodation.price} / 박</p>
                         <p>게스트 한마디: 정말 예쁘고 깔끔한 곳....</p>
                     </div>
                 </a>
             </div>
         </c:forEach>

      </div>

</div>
</body>
</html>