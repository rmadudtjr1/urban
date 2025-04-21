<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 위시리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
    :root {
        /* 한옥 느낌의 색상 팔레트 */
        --hanok-brown: #8C634A;
        --hanok-light-brown: #D4BEA2;
        --hanok-beige: #F0E4D4;
        --hanok-dark: #433730;
        --hanok-accent: #BF4342;
    }
    
    body {
        background-color: var(--hanok-beige);
        font-family: 'Noto Sans KR', sans-serif;
        color: var(--hanok-dark);
    }
    
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    h1 {
        color: var(--hanok-brown);
        text-align: center;
        font-size: 2.5rem;
        margin-bottom: 30px;
        border-bottom: 2px solid var(--hanok-light-brown);
        padding-bottom: 15px;
    }
    
    .wishlist-container {
        width: 90%;
        margin: 20px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }
    
    .wishlist-item {
        display: flex;
        align-items: center;
        margin-bottom: 25px;
        padding: 20px;
        border: none;
        border-radius: 8px;
        background-color: white;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .wishlist-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .wishlist-item img {
        width: 200px;
        height: 150px;
        margin-right: 25px;
        object-fit: cover;
        border-radius: 8px;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
    }
    
    .wishlist-details {
        flex-grow: 1;
        padding: 0 10px;
    }
    
    .wishlist-details h3 {
        margin-top: 0;
        margin-bottom: 10px;
        color: var(--hanok-brown);
        font-size: 1.4rem;
    }
    
    .wishlist-details p {
        color: #666;
        margin-bottom: 8px;
    }
    
    .wishlist-actions button {
        padding: 10px 16px;
        border: none;
        background-color: transparent;
        color: var(--hanok-accent);
        font-size: 1.5rem;
        cursor: pointer;
        transition: transform 0.2s ease;
        display: flex;
        align-items: center;
    }
    
    .wishlist-actions button i {
        margin-right: 8px;
    }
    
    .wishlist-actions button:hover {
        transform: scale(1.1);
    }
    
    .empty-wishlist {
        text-align: center;
        padding: 40px 20px;
        font-style: italic;
        color: #999;
        font-size: 1.2rem;
        background-color: white;
        border-radius: 8px;
    }
    
    .empty-wishlist i {
        font-size: 3rem;
        color: var(--hanok-light-brown);
        margin-bottom: 15px;
        display: block;
    }
    
    .main-button {
        display: block;
        width: 220px;
        margin: 30px auto;
        padding: 12px 25px;
        background-color: var(--hanok-brown);
        color: white;
        text-align: center;
        border-radius: 30px;
        text-decoration: none;
        font-weight: bold;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    
    .main-button:hover {
        background-color: var(--hanok-dark);
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    
    .destination-tag {
        display: inline-block;
        background-color: var(--hanok-light-brown);
        color: var(--hanok-dark);
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.8rem;
        margin-top: 5px;
    }
    
    /* 한옥 문양 장식 */
    .hanok-decoration {
        width: 100%;
        height: 30px;
        background-image: url("${pageContext.request.contextPath}/resources/image/pattern.png");
        background-repeat: repeat-x;
        margin: 20px 0;
        opacity: 0.6;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    function removeFromWishlist(memberId, accommodationId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/wishList/remove.do",
            type: "POST",
            data: {
                memberId: memberId,
                accommodationId: accommodationId
            },
            success: function(response) {
                if (response === "1") {
                    alert("위시리스트에서 제거되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("위시리스트 제거에 실패했습니다.");
                }
            },
            error: function(error) {
                console.error("Error removing from wishlist:", error);
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    }
</script>
</head>
<body>
   <div class="container">
    <h1>나의 가고 싶은 곳</h1>
    <div class="hanok-decoration"></div>
    <div class="wishlist-container">
    
        <%-- <c:choose>
            <c:when test="${not empty wishlist}">
                <c:forEach var="wishlistItem" items="${wishlist}">
                    <c:forEach var="acc" items="${accommodation}">
                        <c:if test="${wishlistItem.accommodationId == acc.accommodation_id}">
                            <div class="wishlist-item">
                                <c:set var="imageStr" value="${acc.accommodation_photo}" />
                                <c:set var="images" value="${fn:split(imageStr, ',')}" />
                                <img
                                    src="${contextPath}/download.do?imageFileName=${images[0]}&accommodation_id=${acc.accommodation_id}&timestamp=<%= System.currentTimeMillis() %>"
                                    alt="${acc.accommodation_name}">
                                <div class="wishlist-details">
                                    <h3>숙소 ID: ${wishlistItem.accommodationId}</h3>
                                    <p>회원 ID: ${wishlistItem.memberId}</p>
                                    <span class="destination-tag"><i class="fas fa-map-marker-alt"></i> 가고 싶은 곳</span>
                                </div>
                                <div class="wishlist-actions">
                                    <button onclick="removeFromWishlist('${wishlistItem.memberId}', '${wishlistItem.accommodationId}')">
                                        <i class="fas fa-heart"></i> 취소
                                    </button>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </c:when>
            <c:otherwise> --%>
                <div class="empty-wishlist">
                    <i class="far fa-heart"></i>
                    <p>아직 위시리스트에 저장된 숙소가 없습니다.</p>
                    <p>마음에 드는 한옥 숙소를 찾아 하트를 눌러보세요!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="hanok-decoration"></div>
    <a href="${pageContext.request.contextPath}/" class="main-button">메인 페이지로 돌아가기</a>
</div>

</body>
</html>