<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 상세 정보</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 50px auto;
        }

        h2 {
            color: #222;
            font-size: 28px;
            margin-bottom: 30px;
            text-align: center;
        }

        .card {
            background-color: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: box-shadow 0.3s;
        }

        .card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #f0f0f0;
            padding: 14px 16px;
            text-align: left;
            font-size: 16px;
            color: #333;
        }

        tr:nth-child(odd) {
            background-color: #fff9fb;
        }

        a {
            color: #ff385c;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .button-row {
            text-align: center;
            margin-top: 30px;
        }

        input[type="button"], input[type="submit"] {
            background-color: #ff385c;
            color: white;
            border: none;
            padding: 10px 24px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 12px;
            margin: 0 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="button"]:hover, input[type="submit"]:hover {
            background-color: #e61e4d;
        }
    </style>
</head>
<body>
    <form action="${contextPath}/cleaner/cleanerIdDelete.do" method="post">
        <div class="container">
            <h2>클리너 지원자 상세 정보</h2>

            <div class="card">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td id="c_member_id">${cleaner.member_id}</td>
                        <input type="hidden" name="member_id" value="${cleaner.member_id}">
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${cleaner.memberName}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${cleaner.memberPhone}</td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>${cleaner.memberBirth}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>${cleaner.memberGender}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>${cleaner.address}</td>
                    </tr>
                    <tr>
                        <th>등록일</th>
                        <td>${cleaner.regdate}</td>
                    </tr>
                    <tr>
                        <th>소득증빙자료</th>
                        <td><a href="${contextPath}${cleaner.incomeProof}" target="_blank">파일보기</a></td>
                    </tr>
                </table>

                <div class="button-row">
                    <input type="button" name="assignment" onclick="goToReservation()" value="숙소 배정하기">
                    <input type="submit" name="delete" value="불합격">
                </div>
            </div>
        </div>
    </form>
</body>

<script>
function goToReservation() {
    let member_id = document.getElementById("c_member_id").innerText;
    localStorage.setItem('addAccMemberId', member_id);
    window.location.href = "/Urban_Village/cleaner/cleanerAddAcc.do";
}
function goToDelete() {
    let member_id = document.getElementById("c_member_id").innerText;
    localStorage.setItem('addAccMemberId', member_id);
    window.location.href = "/Urban_Village/cleaner/cleanerIdDelete.do";
}
</script>
</html>
 