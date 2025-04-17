
 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 등록</title>
    
    <link rel="stylesheet" href="${contextPath}/resources/css/style.css"> 

    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 40px;
            font-size: 28px;
            color: #222;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 50px auto;
        }

        .accommodation-card {
            background-color: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: box-shadow 0.3s;
        }

        .accommodation-card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .accommodation-card p {
            margin: 10px 0;
            font-size: 16px;
            color: #333;
        }

        .accommodation-card input[type="text"] {
            width: 100%;
            max-width: 300px;
            padding: 10px 12px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-top: 5px;
        }

        .accommodation-card input[type="submit"] {
            margin-top: 20px;
            padding: 10px 24px;
            font-size: 15px;
            font-weight: bold;
            color: #fff;
            background-color: #ff385c;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .accommodation-card input[type="submit"]:hover {
            background-color: #e61e4d;
        }

        .no-data {
            text-align: center;
            font-size: 17px;
            color: #777;
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <!-- ✅ header include -->
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <h1>비어있는 숙소 리스트</h1>

    <div class="container">
        <c:if test="${empty accListByCleanerNull}">
            <p class="no-data">비어있는 숙소가 없습니다.</p>
        </c:if>

        <c:forEach var="acc" items="${accListByCleanerNull}" varStatus="status">
            <form action="${contextPath}/cleaner/addCleanerId.do" method="post">
                <div class="accommodation-card">
                    <p><strong>숙소 ID:</strong> ${acc.accommodation_id}</p>
                    <input type="hidden" name="accommodation_id" value="${acc.accommodation_id}">

                    <p><strong>숙소 이름:</strong> ${acc.accommodation_name}</p>

                    <p><strong>청소 관리자 ID:</strong></p>
                    <input type="text" name="cleaner_admin_id" id="add_${status.index}" placeholder="청소 관리자 ID를 입력하세요">

                    <input type="submit" value="이곳에 배정">
                </div>
            </form>
        </c:forEach>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const member_id = localStorage.getItem('addAccMemberId');
        if (member_id) {
            document.querySelectorAll('input[id^="add_"]').forEach(input => {
                input.value = member_id;
            });
        }
    });
    </script>

</body>
</html>
 