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
<link rel="stylesheet"
	href="${contextPath}/resources/css/styleJoinMember.css">
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
     
    <!-- From Uiverse.io by ammarsaa -->
    <form class="form" action="${contextPath }/member/addMember.do" method="post">
        <p class="title">회원가입창</p>
        <p class="message">회원가입후 즐겨보세요!</p>
        
        <div class="form-column left-column">
        <div class="flex">
            <label style="flex: 1;">
                <input class="input" type="text" name="id" id="id" required>
                <span>아이디</span>
            </label>
            <button type="button" class="submit" id="checkIdBtn" style="flex: 0 1 100px;" onclick="fn_checkId()">중복체크</button>
        </div>
        
        <label>
            <input class="input" type="password" name="pwd" required>
            <span>비밀번호</span>
        </label>
	
		<div class="flex"> 
		<label style="flex: 1;">
          <input class="input" type="email" name="email" id="email" required>
            <span>이메일</span>
      	</label>
      <button type="button" class="submit" id="sendCodeBtn" onclick="sendVerificationCode()">인증번호 보내기</button>
	</div>
      <label id="verificationSection" style="display: none; width: 100%;">
          <input class="input" type="text" id="verificationCodeInput" placeholder="인증번호 입력">
      </label>
          
      <button type="button" class="submit" id="verifyBtn" style="display: none;" onclick="verifyCode()">인증 확인</button>
	</div>
		
		<div class="form-column right-column">
		
		<div class="date-input-group">
        <label for="birth">
            <input class="input" type="date" name="birth" required>
            <span>생년월일</span>
        </label>
		</div>
		
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
        </div>

        <button class="submit" id="submitBtn" type="submit" disabled>회원가입</button>
        <p class="signin">이미 계정이 있으신가요? <a href="${contextPath }/member/loginForm.do">로그인</a></p>
    </form>


</body>
</html>