<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>회원 탈퇴</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    .deldelcontainer {
        max-width: 600px;
        margin: 40px auto;
        background: #fff;
        padding: 40px;
        border-radius: 16px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
    }

    .delh1 {
        text-align: center;
        font-size: 24px;
        margin-bottom: 30px;
        color: #2c2c2c;
    }

    .dellabel {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
    }

    .delinput[type="text"], .delinput[type="password"] {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 14px;
        box-sizing: border-box;
    }

    .delbtn-danger {
        background-color: #ff5a5f;
        border: none;
        color: white;
        padding: 12px 24px;
        font-size: 14px;
        border-radius: 25px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-right: 10px;
    }

    .delbtn-danger:hover {
        background-color: #ff4c4c;
    }

    .delbtn-secondary {
        background-color: #ccc;
        border: none;
        color: #333;
        padding: 12px 24px;
        font-size: 14px;
        border-radius: 25px;
        cursor: pointer;
    }

    .delbtn-secondary:hover {
        background-color: #bbb;
    }

    .delform-group {
        margin-bottom: 20px;
    }
</style>

<script>
    function validateForm() {
        var id = document.getElementById("id").value;
        var pwd = document.getElementById("pwd").value;

        if (id === "" || pwd === "") {
            alert("아이디와 비밀번호를 모두 입력해주세요.");
            return false;
        }
        return true;
    }

    function deleteConfirm() {
        if (confirm("정말로 탈퇴하시겠습니까? 모든 정보가 삭제됩니다.")) {
            document.deleteForm.submit();
        }
    }
</script>
</head>
<body>
    <div class="deldelcontainer">
        <h1 class="delh1">회원 탈퇴</h1>
        <form name="deleteForm" action="${contextPath}/member/deleteMember.do" method="post" onsubmit="return validateForm()">
            <div class="delform-group">
                <label for="id" class="dellabel">아이디:</label>
                <input type="text" id="id" name="id" value="${sessionScope.loginId}" class="delinput" readonly>
            </div>
            <div class="delform-group">
                <label for="pwd" class="dellabel">비밀번호:</label>
                <input type="password" id="pwd" name="pwd" class="delinput">
            </div>
            <button type="button" class="delbtn-danger" onclick="deleteConfirm()">회원 탈퇴</button>
            <button type="button" class="delbtn-secondary" onclick="history.back()">취소</button>
        </form>
    </div>
</body>
</html>