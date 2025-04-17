<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    .container {
        max-width: 960px;
        margin: 40px auto;
        background: #fff;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
    }

    h1 {
        text-align: center;
        font-size: 24px;
        margin-bottom: 30px;
        color: #2c2c2c;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }

   th {
        background-color: transparent; /* 배경색을 투명으로 설정 */
        color: #333; /* 텍스트 색상은 검정색으로 유지 */
        font-weight: 500;
        padding: 12px;
        border-bottom: 1px solid #ccc;
    }

    td {
        padding: 12px;
        border-bottom: 1px solid #eee;
        text-align: center;
        color: #333;
    }

    tr:hover {
        background-color: #f0f0f0;
    }

    @media (max-width: 768px) {
        table, th, td {
            font-size: 13px;
        }
    }

    /* 검색창 및 버튼 스타일 */
    .search-container {
        margin-bottom: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .search-input {
        padding: 12px 20px;
        border-radius: 25px;
        border: 1px solid #ccc;
        font-size: 14px;
        width: 300px;
        box-sizing: border-box; /* 테두리가 내부에 포함되도록 설정 */
    }

    .search-button {
        padding: 12px 20px;
        background-color: #ff5a5f; /* 핑크색 */
        border: 2px solid #ff5a5f; /* 버튼에 테두리 추가 */
        border-radius: 25px;
        color: white;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-sizing: border-box; /* 테두리가 내부에 포함되도록 설정 */
    }

    .search-button:hover {
        background-color: #ff4c94; /* 버튼 hover 효과 */
    }
</style>

<div class="container">
    <h1>회원 목록</h1>
<!-- 검색창 및 버튼 -->
<form action="urbanMemberList.do" method="get" class="search-container">

    <input type="text" name="keyword" class="search-input" placeholder="아이디 검색" value="${param.keyword}" />
    <button type="submit" class="search-button">검색</button>
</form>

    

    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>비번</th>
                <th>이름</th>
                <th>이메일</th>
                <th>생년월일</th>
                <th>전화번호</th>
                <th>가입일</th>
                <th>성별</th>
            </tr>
        </thead>
        <tbody>
    <c:if test="${empty membersList}">
        <tr>
            <td colspan="8" style="text-align:center; padding: 20px; color: #999;">
                검색 결과가 없습니다.
            </td>
        </tr>
    </c:if>

    <c:forEach var="m" items="${membersList}">
        <tr>
            <td>${m.id}</td>
            <td>${m.pwd}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td>${m.birth}</td>
            <td>${m.phonenumber}</td>
            <td>${m.regdate}</td>
            <td>${m.gender}</td>
        </tr>
    </c:forEach>
</tbody>

    </table>
</div>
