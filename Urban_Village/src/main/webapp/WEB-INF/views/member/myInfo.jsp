<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
    background-color: #f8f9fa;
}

.mymycontent {
    margin-left: 450px;
    padding: 40px;
}

.myinfo-box {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    max-width: 500px;
}

.myinfo-box label {
    font-weight: bold;
}

.myerror-message {
    color: red;
    font-size: 0.9em;
    margin-top: 5px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("form").submit(function(event) {
            var phoneNumber = $("input[name='phonenumber']").val();
            var email = $("input[name='email']").val();
            var name = $("input[name='name']").val();
            var pwd = $("input[name='pwd']").val(); // 비밀번호는 수정 시 필수가 아닐 수 있음
            var birth = $("input[name='birth']").val();
            var gender = $("select[name='gender']").val();
            var hasError = false;
            var phoneRegex = /^\d{3}-\d{4}-\d{4}$/;
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            $(".myerror-message").remove();

            if (name === "") {
                $("<p class='myerror-message'>이름을 입력하세요.</p>").insertAfter($("input[name='name']"));
                $("input[name='name']").focus();
                hasError = true;
            }

            if (email === "") {
                $("<p class='myerror-message'>이메일을 입력하세요.</p>").insertAfter($("input[name='email']"));
                $("input[name='email']").focus();
                hasError = true;
            } else if (!emailRegex.test(email)) {
                $("<p class='myerror-message'>이메일 형식이 올바르지 않습니다.</p>").insertAfter($("input[name='email']"));
                $("input[name='email']").focus();
                hasError = true;
            }

            if (birth === "") {
                $("<p class='myerror-message'>생년월일을 입력하세요.</p>").insertAfter($("input[name='birth']"));
                $("input[name='birth']").focus();
                hasError = true;
            }

            if (gender === "") {
                $("<p class='myerror-message'>성별을 선택하세요.</p>").insertAfter($("select[name='gender']").parent());
                $("select[name='gender']").focus();
                hasError = true;
            }

            if (phoneNumber === "") {
                $("<p class='myerror-message'>전화번호를 입력하세요.</p>").insertAfter($("input[name='phonenumber']"));
                $("input[name='phonenumber']").focus();
                hasError = true;
            } else if (!phoneRegex.test(phoneNumber)) {
                $("<p class='myerror-message'>전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)</p>").insertAfter($("input[name='phonenumber']"));
                $("input[name='phonenumber']").focus();
                hasError = true;
            }

            // 비밀번호는 수정 시 필수가 아닐 수 있으므로 검사 조건에 따라 추가

            if (hasError) {
                event.preventDefault();
            }
        });
    });
</script>
</head>
<body>
    <div class="mymycontent">
        <h2>내 정보 페이지</h2>
        <div class="myinfo-box">
            <form action="${contextPath}/member/updateUserInfo.do" method="post">
                <c:if test="${memberList != null}">
                    <div class="mb-3">
                        <label for="id" class="form-label">아이디</label> <input type="text"
                            class="form-control" id="id" name="id"
                            value="${memberList[0].id}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label> <input
                            type="password" class="form-control" id="pwd" name="pwd"
                            value="${memberList[0].pwd}">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">이메일</label> <input
                            type="email" class="form-control" id="email" name="email"
                            value="${memberList[0].email}">
                    </div>
                    <div class="mb-3">
                        <label for="birthdate" class="form-label">생년월일</label> <input
                            type="date" class="form-control" id="birthdate" name="birth"
                            value="${memberList[0].birth}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="gender" class="form-label">성별</label> <select
                            class="form-control" id="gender" name="gender" readonly>
                            <option value="남성"
                                ${memberList[0].gender == '남성' ? 'selected' : ''}>남성</option>
                            <option value="여성"
                                ${memberList[0].gender == '여성' ? 'selected' : ''}>여성</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">전화번호</label> <input
                            type="tel" class="form-control" id="phone" name="phonenumber"
                            value="${memberList[0].phonenumber}">
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">이름</label> <input type="text"
                            class="form-control" id="name" name="name"
                            value="${memberList[0].name}">
                    </div>
                   
                    <button type="submit" class="btn btn-primary">수정하기</button>
                </c:if>
            </form>
        </div>
    </div>
</body>
</html>