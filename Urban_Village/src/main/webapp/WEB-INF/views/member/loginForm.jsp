<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>A Login</title>
    <c:choose>
       <c:when test='${param.result == "loginFailed"}'>
            <script>
                alert('아이디나 비밀번호가 틀립니다. 다시 로그인 하세요.');
            </script>
       </c:when>
       <c:when test="${param.result == 'logout' }">
            <script>
                alert('로그아웃 되었습니다. 다시 로그인 하세요.');
            </script>
       </c:when>
       <c:when test="${param.result == 'notLogin' }">
            <script>
                alert('로그인이 되어 있지 않습니다. 로그인 하세요.');
            </script>
       </c:when>
    </c:choose>
    <style>
    body {
        margin: 0;
        font-family: 'Apple SD Gothic Neo', sans-serif;
        background: #F7F7F7; /* Airbnb 스타일 연한 배경 */
    }

    .login-page {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .advertisement {
        width: 20%;
        height: 500px;
        position: relative;
        overflow: hidden;
        border-radius: 20px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .advertisement-slide {
        display: none;
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 20px;
        position: absolute;
        top: 0;
        left: 0;
    }

    .advertisement-slide.active {
        display: block;
    }

    .login-container {
        width: 30%;
        padding: 40px;
        background-color: #fff;
        border-radius: 30px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        margin: 0 40px;
    }

    .social-login {
        margin-bottom: 30px;
    }

    .social-login h2, .login-form h2 {
        margin-bottom: 20px;
        color: #222;
        text-align: center;
        font-weight: 600;
    }

    .social-button {
        display: flex;
        align-items: center;
        justify-content: center;
        border: none;
        border-radius: 10px;
        padding: 12px;
        margin: 10px 0;
        font-size: 16px;
        cursor: pointer;
        text-decoration: none;
        color: #fff;
    }

    .social-icon {
        width: 20px;
        height: 20px;
        margin-right: 10px;
    }

    .kakao-login {
        background-color: #FEE500;
        color: #000;
    }

    .facebook-login {
        background-color: #4267B2;
    }

    .google-login {
        background-color: #DB4437;
    }

    .login-form .input-group {
        margin-bottom: 20px;
    }

    .input-field {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 12px;
        font-size: 16px;
        background-color: #FAFAFA;
        box-sizing: border-box;
    }

    .login-button {
        width: 100%;
        padding: 14px;
        background-color: #FF385C; /* Airbnb 핑크 */
        border: none;
        border-radius: 12px;
        color: white;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .login-button:hover {
        background-color: #e11c4b; /* 강조 hover */
    }

    .signup-link {
        margin-top: 15px;
        text-align: center;
        font-size: 14px;
        color: #666;
    }

    .signup-link a {
        color: #FF385C;
        text-decoration: none;
        font-weight: 500;
    }

    .signup-link a:hover {
        text-decoration: underline;
    }

    .admin-login-button {
        background-color: green;
        color: white;
        border: none;
        padding: 12px 24px;
        font-size: 16px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        margin-top: 15px;
    }
</style>

</head>
<body>
    <div class="login-page">
        <div class="advertisement left-ad">
            <img src="/Urban_Village/resources/images/ad1.jpg" class="advertisement-slide active" alt="광고1">
            <img src="/Urban_Village/resources/images/ad2.jpg" class="advertisement-slide" alt="광고2">
        </div>
      
        <div class="login-container">
            <form action="/Urban_Village/member/login.do" method="post" class="login-form">
                <h2>로그인</h2>
                <div class="input-group">
                    <label for="id">아이디</label>
                    <input type="text" id="id" name="id" class="input-field" required>
                </div>
                <div class="input-group">
                    <label for="pwd">비밀번호</label>
                    <input type="password" id="pwd" name="pwd" class="input-field" required>
                </div>
                <button type="submit" class="login-button">로그인</button>
                <div class="social-login">
                    <h2>소셜 로그인</h2>
                    <a href="#" class="social-button kakao-login">
                        <img src="/Urban_Village/resources/icons/kakao-icon.png" class="social-icon" alt="카카오">
                        카카오로 로그인
                    </a>
                    <a href="#" class="social-button facebook-login">
                        <img src="/Urban_Village/resources/icons/facebook-icon.png" class="social-icon" alt="페이스북">
                        페이스북으로 로그인
                    </a>
                    <a href="#" class="social-button google-login">
                        <img src="/Urban_Village/resources/icons/google-icon.png" class="social-icon" alt="구글">
                        구글로 로그인
                    </a>
                </div>

                <div class="signup-link">
                    계정이 없으신가요? <a href="/Urban_Village/member/joinMember.do">회원가입</a>
                </div>
                <div class="signup-link">
                    비밀번호를 잊으셨나요? <a href="/Urban_Village/member/findPwd.do">암호찾기</a>
                </div>
            </form>
        </div>

        <div class="advertisement right-ad">
            <img src="/Urban_Village/resources/images/ad3.jpg" class="advertisement-slide active" alt="광고3">
            <img src="/Urban_Village/resources/images/ad4.jpg" class="advertisement-slide" alt="광고4">
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const leftAds = document.querySelectorAll('.left-ad .advertisement-slide');
            const rightAds = document.querySelectorAll('.right-ad .advertisement-slide');
            let leftIndex = 0;
            let rightIndex = 0;

            function changeAd(ads, index, nextIndex) {
                ads[index].classList.remove('active');
                ads[nextIndex].classList.add('active');
            }

            setInterval(() => {
                let nextLeftIndex = (leftIndex + 1) % leftAds.length;
                changeAd(leftAds, leftIndex, nextLeftIndex);
                leftIndex = nextLeftIndex;

                let nextRightIndex = (rightIndex + 1) % rightAds.length;
                changeAd(rightAds, rightIndex, nextRightIndex);
                rightIndex = nextRightIndex;
            }, 5000);

            // 광고 클릭 이벤트 (선택사항)
            window.onclick = function (event) {
                if (event.target.classList.contains('advertisement-slide')) {
                    console.log('광고 클릭됨:', event.target.alt);
                }
            };
        });
    </script>
</body>
</html>