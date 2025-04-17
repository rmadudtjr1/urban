<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클리너 지원자 목록</title>
<style>
	body {
		background-color: #fff;
		margin: 0;
		padding: 0;
	}
	.container {
		width: 70%;
		margin: 50px auto; /* 가운데 정렬 + 상하 여백 */
	}
	h2 {
		color: #d63384;
		border-bottom: 2px solid #d63384;
		padding-bottom: 10px;
		margin-bottom: 30px;
	}
	table {
		width: 100%;
		border-collapse: collapse;
	}
	thead {
		background-color: #f8d7da;
		color: #721c24;
	}
	th, td {
		border: 1px solid #f5c6cb;
		padding: 12px;
		text-align: center;
	}
	tr:nth-child(even) {
		background-color: #fff0f3;
	}
	tr:hover {
		background-color: #ffe3ec;
	}
	a {
		color: #d63384;
		text-decoration: none;
		font-weight: bold;
	}
	a:hover {
		text-decoration: underline;
	}
</style>
</head>
<body>

<div class="container">
	<h2>클리너 지원자 목록</h2>

	<table class="table">
        <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>등록일</th>
                <th>상세보기</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${cleanerList}">
                <c:set var="isAssigned" value="false"/>
                <c:forEach var="assignedId" items="${accCleanerId}">
                    String 타입으로 직접 비교
                    <c:if test="${c.member_id == assignedId}">
                        <c:set var="isAssigned" value="true"/>
                    </c:if>
                </c:forEach>
                <c:if test="${!isAssigned}">
                    <tr>
                        <td>${c.member_id}</td>
                        <td>${c.memberName}</td>
                        <td>${c.memberPhone}</td>
                        <td>${c.regdate}</td>
                        <td><a href="${contextPath}/admin/cleanerDetail.do?member_id=${c.member_id}">보기</a></td>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
 --%>
 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 지원자 목록</title>

    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 40px;
            font-size: 28px;
            color: #000;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        .applicant-card {
            background-color: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: box-shadow 0.3s;
        }

        .applicant-card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .applicant-info p {
            margin: 10px 0;
            font-size: 16px;
            color: #333;
        }

        .detail-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            background-color: #ff5a8a;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .detail-btn:hover {
            background-color: #d63384;
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

    <%-- ✅ 헤더 include --%>
  

    <h2>클리너 지원자 목록</h2>

    <div class="container">
        <c:forEach var="c" items="${cleanerList}">
            <c:set var="isAssigned" value="false" />
            <c:forEach var="assignedId" items="${accCleanerId}">
                <c:if test="${c.member_id == assignedId}">
                    <c:set var="isAssigned" value="true" />
                </c:if>
            </c:forEach>

            <c:if test="${!isAssigned}">
                <div class="applicant-card">
                    <div class="applicant-info">
                        <p><strong>아이디:</strong> ${c.member_id}</p>
                        <p><strong>이름:</strong> ${c.memberName}</p>
                        <p><strong>전화번호:</strong> ${c.memberPhone}</p>
                        <p><strong>등록일:</strong> ${c.regdate}</p>
                    </div>
                    <a class="detail-btn" href="${contextPath}/admin/cleanerDetail.do?member_id=${c.member_id}">상세보기</a>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${empty cleanerList}">
            <p class="no-data">지원자가 없습니다.</p>
        </c:if>
    </div>

</body>
</html>
 