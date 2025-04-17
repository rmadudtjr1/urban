<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title></title>
<style>
        /* From Uiverse.io by ammarsaa */
        .form {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 350px;
            padding: 20px;
            border-radius: 20px;
            position: relative;
            background-color: #f3f3f3; /* 배경색을 밝게 변경 */
            color: #333; /* 텍스트 색상 변경 */
            border: 1px solid #ddd; /* 경계 색상 변경 */
            margin-left: 420px;
        }

        .title {
            font-size: 28px;
            font-weight: 600;
            letter-spacing: -1px;
            position: relative;
            display: flex;
            align-items: center;
            padding-left: 30px;
            color: #ff5a5f;
        }

        .title::before {
            width: 18px;
            height: 18px;
        }

        .title::after {
            width: 18px;
            height: 18px;
            animation: pulse 1s linear infinite;
        }

        .title::before,
        .title::after {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            border-radius: 50%;
            left: 0px;
            background-color: #ff5a5f;
        }

        .message,
        .signin {
            font-size: 14.5px;
            color: rgba(51, 51, 51, 0.7); /* 텍스트 색상 변경 */
        }

        .signin {
            text-align: center;
        }

        .signin a:hover {
            text-decoration: underline #ff5a5f;
        }

        .signin a {
            color: #ff5a5f;
        }

        .flex {
            display: flex;
            width: 100%;
            gap: 6px;
        }

        .form label {
            position: relative;
        }

        .form label .input {
            background-color: #fff; /* 입력 필드 배경색을 흰색으로 변경 */
            color: #333; /* 입력 필드 텍스트 색상 변경 */
            width: 100%;
            padding: 20px 05px 05px 10px;
            outline: 0;
            border: 1px solid #ddd; /* 경계 색상 변경 */
            border-radius: 10px;
        }

        .form label .input + span {
            color: rgba(51, 51, 51, 0.5); /* 텍스트 색상 변경 */
            position: absolute;
            left: 10px;
            top: 0px;
            font-size: 0.9em;
            cursor: text;
            transition: 0.3s ease;
        }

        .form label .input:placeholder-shown + span {
            top: 12.5px;
            font-size: 0.9em;
        }

        .form label .input:focus + span,
        .form label .input:valid + span {
            color: #ff5a5f;
            top: 0px;
            font-size: 0.7em;
            font-weight: 600;
        }

        .input {
            font-size: medium;
        }

        .submit {
            border: none;
            outline: none;
            padding: 10px;
            border-radius: 10px;
            color: #fff;
            font-size: 16px;
            transform: .3s ease;
            background-color: #ff5a5f;
        }

        .submit:hover {
            background-color: #ff5a5f96;
        }

        @keyframes pulse {
            from {
                transform: scale(0.9);
                opacity: 1;
            }

            to {
                transform: scale(1.8);
                opacity: 0;
            }
        }
        /* header부분 */
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .header .user-links {
            display: flex;
            align-items: center;
        }

        .header .user-links a {
            text-decoration: none;
            color: #333;
            margin-left: 10px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-left: 600px;
            padding: 5px;
        }

        .search-bar input[type="text"] {
            border: none;
            padding: 8px;
            margin-right: 5px;
            flex-grow: 1;
        }

        .search-bar button {
            background-color: #ff5a5f;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .categories {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .categories a {
            text-decoration: none;
            color: #333;
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .accommodations {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .accommodation {
            width: 30%;
            margin: 20px;
            border: 1px solid #ddd;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
        }

        .accommodation img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .details {
            padding: 10px;
        }

        .details h3 {
            margin-top: 0;
        }

        .details p {
            margin-bottom: 5px;
        }

        @media (max-width: 768px) {
            .accommodation {
                width: 45%;
            }
        }

        @media (max-width: 480px) {
            .accommodation {
                width: 100%;
            }
        }
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function fn_checkId() {
    var userId = $("#id").val();
    if (userId === "") {
        alert("아이디를 입력하세요.");
        return;
    }

    $.ajax({
        url: "${contextPath}/member/checkId.do",
        method: "POST",
        data: { id: userId },
        success: function(response) {
            if (response.exists) {
                alert("아이디가 이미 존재합니다.");
            } else {
                alert("사용 가능한 아이디입니다.");
            }
        },
        error: function() {
            alert("아이디 중복 체크 중 오류가 발생했습니다.");
        }
    });
}
let sentCode = "";

function sendVerificationCode() {
    const email = $("#email").val();

    // 이메일 형식 검사
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("올바른 이메일 형식을 입력해주세요.");
        return;
    }

    $.ajax({
        url: "${contextPath}/email/sendJoinCode.do",
        type: "POST",
        data: { email: email },
        success: function(code) {
            sentCode = code;
            alert("인증번호가 이메일로 발송되었습니다.");
            $("#verificationSection").show();
            $("#verifyBtn").show();
        },
        error: function() {
            alert("인증번호 발송 중 오류가 발생했습니다.");
        }
    });
}

function verifyCode() {
    const inputCode = $("#verificationCodeInput").val();

    $.ajax({
        url: "${contextPath}/email/checkJoinCode.do",
        type: "POST",
        data: { inputCode: inputCode },
        success: function(isValid) {
            if (isValid) {
                alert("이메일 인증이 완료되었습니다!");
                $("#submitBtn").prop("disabled", false); // 회원가입 버튼 활성화
            } else {
                alert("인증번호가 일치하지 않습니다.");
            }
        },
        error: function() {
            alert("인증 확인 중 오류가 발생했습니다.");
        }
    });
}

</script>
</head>
<body>
   <div class="container">
     
    <!-- From Uiverse.io by ammarsaa -->
    <form class="form" action="${contextPath }/member/addMember.do" method="post">
        <p class="title">회원가입창</p>
        <p class="message">회원가입후 즐겨보세요!</p>
        
        <div class="flex">
            <label style="flex: 1;">
                <input class="input" type="text" name="id" id="id" required>
                <span>아이디</span>
            </label>
            <button type="button" class="submit" style="flex: 0 1 100px;" onclick="fn_checkId()">중복체크</button>
        </div>
        
        <label>
            <input class="input" type="password" name="pwd" required>
            <span>비밀번호</span>
        </label>

        <label>
    		<input class="input" type="email" name="email" id="email" required>
   			<span>이메일</span>
		</label>
		<button type="button" class="submit" onclick="sendVerificationCode()">인증번호 보내기</button>

		<label id="verificationSection" style="display: none;">
    		<input class="input" type="text" id="verificationCodeInput" placeholder="인증번호 입력">
    		<span>인증번호</span>
		</label>
		<button type="button" class="submit" id="verifyBtn" style="display: none;" onclick="verifyCode()">인증 확인</button>


        <label>
            <input class="input" type="date" name="birth" required>
            <span>생년월일</span>
        </label>

        <label>
            <select class="input" name="gender" required>
                <option value="" disabled selected>성별</option>
                <option value="M">남성</option>
                <option value="F">여성</option>
            </select>
        </label>

        <label>
            <input class="input" type="tel" name="phonenumber" required>
            <span>전화번호</span>
        </label>

        <label>
            <input class="input" type="text" name="name" required>
            <span>이름</span>
        </label>

        <button class="submit" id="submitBtn" type="submit" disabled>회원가입</button>
        <p class="signin">이미 계정이 있으신가요? <a href="${contextPath }/member/loginForm.do">로그인</a></p>
    </form>
   </div>


</body>
</html>