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
<style>
   a {
            text-decoration: none; /* 밑줄 제거 */
            color: black;          /* 글자색 검정 */
        }
</style>
<title>검색 결과</title>
<script>
    function toggleHeart(icon) {
        if (icon.classList.contains("liked")) {
            icon.innerHTML = "&#9825;"; // 빈 하트
            icon.classList.remove("liked");
        } else {
            icon.innerHTML = "&#9829;"; // 채워진 하트
            icon.classList.add("liked");
        }
    }
</script>
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
            <c:choose>
                <c:when test="${!empty searchResults}">
                    <c:forEach items="${searchResults}" var="accommodation">
                        <div class="accommodation">
                            <a href="${contextPath}/accommodation/accommodationPage.do?accommodation_id=${accommodation.accommodation_id}&accommodation_name=${accommodation.accommodation_name}">
                                <span class="heart-icon" onclick="event.stopPropagation(); toggleHeart(this)">&#9825;</span>
                                <!-- DB에 저장된 콤마로 구분된 이미지 파일명을 배열로 변환하고 첫 번째 이미지만 출력 -->
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
                </c:when>
                <c:otherwise>
                    <p>검색 결과가 없습니다. 다른 키워드로 검색해보세요.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>