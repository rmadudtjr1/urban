<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 - Urban Village</title>
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
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap')
	;

@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap')
	;

.advertisement-slide {
	position: relative;
	display: none;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 15px;
}

.advertisement-slide.active {
	display: block;
}

/* 광고 텍스트 스타일 */
.advertisement-text {
	position: absolute;
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	color: white; /* 텍스트 색상 */
	font-size: 24px; /* 텍스트 크기 */
	font-weight: bold; /* 텍스트 두께 */
	text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5); /* 텍스트에 그림자 추가 */
	padding: 10px 20px; /* 텍스트 패딩 */
	background-color: rgba(0, 0, 0, 0.4); /* 배경색(반투명) */
	border-radius: 10px; /* 둥근 테두리 */
	text-align: center; /* 텍스트 수평 중앙 정렬 */
	line-height: 1.5; /* 줄 높이 조정 (수직 정렬을 좀 더 정확하게 할 수 있도록 도와줌) */
	width: 80%; /* 텍스트 너비 제한 (너비가 너무 넓을 경우 중앙 정렬이 어려울 수 있기 때문에 추가) */
	box-sizing: border-box; /* 패딩을 너비에 포함시켜서 텍스트가 과도하게 확대되지 않도록 함 */
}

body {
	margin: 0;
	font-family: 'Nanum Gothic', sans-serif; /* 한옥 느낌에 어울리는 폰트 */
	background: linear-gradient(to bottom, #FDFCF0, #EAE0D2);
	/* 은은한 그라데이션 배경 */
	color: #333; /* 차분한 기본 글씨 색 */
	min-height: 100vh;
	display: flex;
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
}

.login-page {
	display: flex;
	justify-content: center; /* 내부 요소 수평 중앙 정렬 */
	align-items: center; /* 내부 요소 수직 중앙 정렬 */
	width: 100%;
	max-width: 1200px; /* 최대 너비 설정 */
	padding: 20px;
	box-sizing: border-box;
	margin: 0 auto; /* 블록 요소 수평 중앙 정렬을 명시적으로 추가 */
}

.advertisement {
	display: flex;
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	text-align: center; /* 텍스트 가운데 정렬 */
	width: 25%; /* 광고 영역 너비 조정 */
	max-width: 300px; /* 최대 광고 너비 */
	height: 500px; /* 높이 유지 */
	position: relative;
	overflow: hidden;
	border-radius: 15px; /* 모서리 둥글게 */
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); /* 부드러운 그림자 */
	flex-shrink: 0; /* 크기 줄어들지 않도록 */
}

.advertisement-slide {
	display: none;
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지 비율 유지하며 채우기 */
	border-radius: 15px;
	position: absolute;
	top: 0;
	left: 0;
}

.advertisement-slide.active {
	display: block;
}

.login-container {
	width: 40%; /* 로그인 폼 너비 조정 */
	max-width: 450px; /* 최대 폼 너비 */
	padding: 40px;
	background-color: #FFFFFF; /* 흰색 배경 */
	border-radius: 20px; /* 더 둥글게 */
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15); /* 더 부드러운 그림자 */
	margin: 0 40px; /* 좌우 마진 유지 */
	box-sizing: border-box;
}

.social-login {
	margin-top: 30px; /* 소셜 로그인 위쪽 마진 */
	padding-top: 20px;
	border-top: 1px solid #EAE0D2; /* 구분선 추가 */
}

.social-login h2, .login-form h2 {
	margin-bottom: 25px; /* 제목 아래 마진 */
	color: #4A3E38; /* 차분한 제목 색 */
	text-align: center;
	font-weight: 700; /* 제목 굵기 */
	font-family: 'Noto Serif KR', serif; /* 한옥 느낌 제목 폰트 */
}

.social-button {
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #D3C6B5; /* 은은한 테두리 */
	border-radius: 8px; /* 덜 둥글게 */
	padding: 14px; /* 패딩 조정 */
	margin: 12px 0; /* 마진 조정 */
	font-size: 16px;
	cursor: pointer;
	text-decoration: none;
	color: #4A3E38; /* 차분한 글씨 색 */
	background-color: #FDFCF9; /* 연한 배경색 */
	transition: background-color 0.3s ease, border-color 0.3s ease;
}

.social-button:hover {
	background-color: #EAE0D2; /* 호버 시 배경색 변경 */
	border-color: #C0B2A3;
}

.social-icon {
	width: 20px;
	height: 20px;
	margin-right: 12px; /* 아이콘과 텍스트 사이 마진 */
}

/* 소셜 버튼 개별 색상 (아이콘으로 구분되므로 배경색은 통일) */
.kakao-login {
	
}
/* .facebook-login { } <- 삭제됨 */
.google-login {
	
}

.login-form .input-group {
	margin-bottom: 20px; /* 입력 그룹 아래 마진 */
}

.login-form label {
	display: block; /* 라벨을 블록 요소로 */
	margin-bottom: 8px; /* 라벨 아래 마진 */
	font-size: 15px;
	color: #6B4F4F; /* 라벨 색상 */
	font-weight: 500;
}

.input-field {
	width: 100%;
	padding: 14px; /* 패딩 조정 */
	border: 1px solid #D3C6B5; /* 은은한 테두리 */
	border-radius: 8px; /* 덜 둥글게 */
	font-size: 16px;
	background-color: #FDFCF9; /* 연한 배경색 */
	box-sizing: border-box;
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.input-field:focus {
	border-color: #A07A61; /* 포커스 시 테두리 색상 변경 */
	outline: none;
	box-shadow: 0 0 5px rgba(160, 122, 97, 0.3); /* 은은한 그림자 효과 */
}

.login-button {
	width: 100%;
	padding: 15px; /* 패딩 조정 */
	background-color: #A07A61; /* 나무/흙 느낌의 차분한 색 */
	border: none;
	border-radius: 8px; /* 덜 둥글게 */
	color: white;
	font-size: 17px;
	font-weight: 700; /* 굵게 */
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.1s ease;
	margin-top: 10px; /* 입력 필드와 버튼 사이 마진 */
}

.login-button:hover {
	background-color: #8D6C55; /* 호버 시 색상 변경 */
}

.login-button:active {
	transform: scale(0.98); /* 클릭 시 약간 축소 */
}

.signup-link {
	margin-top: 25px; /* 마진 조정 */
	text-align: center;
	font-size: 14px;
	color: #666;
}

.signup-link a {
	color: #A07A61; /* 링크 색상 변경 */
	text-decoration: none;
	font-weight: 600;
	transition: color 0.3s ease, text-decoration 0.3s ease;
}

.signup-link a:hover {
	color: #8D6C55; /* 호버 시 색상 변경 */
	text-decoration: underline;
}

.admin-login-button {
	background-color: #6B4F4F; /* 어두운 나무 느낌 색 */
	color: white;
	border: none;
	padding: 12px 24px;
	font-size: 16px;
	font-weight: bold;
	border-radius: 8px; /* 덜 둥글게 */
	cursor: pointer;
	width: 100%;
	margin-top: 15px;
	transition: background-color 0.3s ease;
}

.admin-login-button:hover {
	background-color: #5A3E38; /* 호버 시 색상 변경 */
}

/* 반응형 디자인 */
@media ( max-width : 992px) {
	.login-page {
		flex-direction: column; /* 화면이 작아지면 세로로 배치 */
		padding: 10px;
	}
	.advertisement {
		width: 80%; /* 세로 배치 시 광고 너비 조정 */
		max-width: 500px;
		height: 300px; /* 세로 배치 시 광고 높이 조정 */
		margin: 20px auto; /* 위아래 마진 추가 및 중앙 정렬 */
	}
	.login-container {
		width: 90%; /* 세로 배치 시 로그인 폼 너비 조정 */
		max-width: 450px;
		margin: 20px auto; /* 위아래 마진 추가 및 중앙 정렬 */
		padding: 30px;
	}
}

@media ( max-width : 576px) {
	.login-container {
		padding: 20px;
	}
	.social-button, .login-button, .admin-login-button {
		padding: 12px;
		font-size: 15px;
	}
	.social-icon {
		width: 18px;
		height: 18px;
		margin-right: 8px;
	}
	.signup-link, .signup-link a {
		font-size: 13px;
	}
}
</style>
</head>
<body>
	<div class="login-page">
		<div class="advertisement left-ad">
			<%-- 기존 이미지 경로는 그대로 유지 --%>
			<img src="/Urban_Village/resources/image/test.jpg"
				class="advertisement-slide active" alt="광고1"> <img
				src="/Urban_Village/resources/image/test2.jpg"
				class="advertisement-slide" alt="광고2">
			<%-- 필요하다면 한옥/자연 관련 광고 이미지를 사용하면 더 잘 어울립니다. --%>
		</div>

		<div class="login-container">
			<%-- 기존 form action 및 method는 그대로 유지 --%>
			<form action="/Urban_Village/member/login.do" method="post"
				class="login-form">
				<h2>로그인</h2>
				<div class="input-group">
					<label for="id">아이디</label>
					<%-- 기존 input 필드 name, id, required는 그대로 유지 --%>
					<input type="text" id="id" name="id" class="input-field" required>
				</div>
				<div class="input-group">
					<label for="pwd">비밀번호</label>
					<%-- 기존 input 필드 name, id, required는 그대로 유지 --%>
					<input type="password" id="pwd" name="pwd" class="input-field"
						required>
				</div>
				<%-- 기존 button type은 그대로 유지 --%>
				<button type="submit" class="login-button">로그인</button>

				<div class="social-login">
					<h2>소셜 로그인</h2>
					<%-- 기존 a 태그 href는 그대로 유지 --%>
					<a href="#" class="social-button kakao-login"> <%-- 기존 이미지 경로는 그대로 유지 --%>
						<img src="/Urban_Village/resources/icons/kakao-icon.png"
						class="social-icon" alt="카카오"> 카카오로 로그인
					</a> 
					<a
						href="https://accounts.google.com/o/oauth2/v2/auth?scope=email%20profile&access_type=online&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=http://localhost:8080/Urban_Village/oauth2callback&client_id=69381954362-11abld4f76jr615qrjqpqoa1ffjok517.apps.googleusercontent.com"
						class="social-icon" alt="구글">
						Google 로그인 </a>

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
			<%-- 기존 이미지 경로는 그대로 유지 --%>
			<img src="/Urban_Village/resources/image/test3.jpg"
				class="advertisement-slide active" alt="광고3"> <img
				src="/Urban_Village/resources/image/test4.jpg"
				class="advertisement-slide" alt="광고4">
			<%-- 필요하다면 한옥/자연 관련 광고 이미지를 사용하면 더 잘 어울립니다. --%>
		</div>
	</div>

	<script>
        // 기존 광고 슬라이드 JavaScript 코드는 그대로 유지
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

            // 광고 클릭 이벤트 (선택사항, 기존 코드 유지)
            window.onclick = function (event) {
                if (event.target.classList.contains('advertisement-slide')) {
                    console.log('광고 클릭됨:', event.target.alt);
                    // 여기에 광고 클릭 시 이동할 링크 추가 가능
                    // window.location.href = '링크 주소';
                }
            };
        });
    </script>
</body>
</html>