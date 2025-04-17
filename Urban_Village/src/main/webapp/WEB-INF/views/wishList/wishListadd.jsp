<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 위시리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<style>
    .wishlist-container {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .wishlist-item {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        padding: 10px;
        border: 1px solid #eee;
        border-radius: 3px;
    }

    .wishlist-item img {
        width: 150px;
        height: 100px;
        margin-right: 15px;
        object-fit: cover;
        border-radius: 3px;
    }

    .wishlist-details {
        flex-grow: 1;
    }

    .wishlist-details h3 {
        margin-top: 0;
        margin-bottom: 5px;
    }

    .wishlist-actions button {
        padding: 8px 12px;
        margin-left: 10px;
        cursor: pointer;
        border: 1px solid #d9534f;
        background-color: #f44336;
        color: white;
        border-radius: 3px;
    }

    .wishlist-actions button:hover {
        background-color: #d32f2f;
    }

    .empty-wishlist {
        text-align: center;
        padding: 20px;
        font-style: italic;
        color: #777;
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
        <h1>내 위시리스트</h1>
        <div class="wishlist-container">
            <c:choose>
                <c:when test="${not empty wishlist}">
                    <c:forEach var="wishlistItem" items="${wishlist}">
                        <div class="wishlist-item">
                            <img src="${pageContext.request.contextPath}/resources/image/imagePlaceholder.jpg" alt="${wishlistItem.accommodationId} 숙소 이미지">
                            <div class="wishlist-details">
                                <h3>숙소 ID: ${wishlistItem.accommodationId}</h3>
                                <p>회원 ID: ${wishlistItem.memberId}</p>
                                </div>
                            <div class="wishlist-actions">
                                <button onclick="removeFromWishlist('${wishlistItem.memberId}', '${wishlistItem.accommodationId}')">제거</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="empty-wishlist">위시리스트에 저장된 숙소가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <a href="${pageContext.request.contextPath}/">메인 페이지로 돌아가기</a>
    </div>
</body>
</html>