<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
<head>
    <title>도움말 센터 | Urban&Village</title>
    <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
       @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap');
       
        /* 기본 스타일 */
        body {
            /* 시스템 한글 폰트와 제네릭 산세리프 폰트 사용 */
            font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', Dotum, Gulim, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #faf7f2; /* 한옥 느낌의 따뜻한 배경색 */
            color: #4e3629; /* 나무색과 유사한 텍스트 색상 */
        }
        /* 이하 스타일 코드는 이전과 동일 */
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .header {
            text-align: center;
            padding: 30px 0;
            background-color: #8b5a2b; /* 한옥 기둥 색상 */
            color: #fff;
            border-bottom: 5px solid #d4a76a; /* 한옥 처마 색상 */
        }

        .header h1 {
            font-size: 36px;
            font-weight: 700;
            margin: 0;
            letter-spacing: 1px;
        }

        .subtitle {
            color: #d4a76a;
            font-size: 18px;
        }

        .section {
            margin-bottom: 60px;
            padding: 30px;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background-color: #8b5a2b; /* 한옥 무늬 색상 */
        }

        h2 {
            color: #8b5a2b;
            font-size: 28px;
            margin-top: 10px;
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: #d4a76a;
        }

        p {
            font-size: 16px;
            line-height: 1.7;
            color: #4e3629;
        }

        /* 카드 스타일 */
        .link-box {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            margin-top: 30px;
        }

        .link-card {
            flex: 1 1 45%;
            border: 1px solid #e0d6c6; /* 한옥 내부 벽 색상 */
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(139, 90, 43, 0.1);
            background-color: #fdfbf7; /* 약간 밝은 배경 */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .link-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(139, 90, 43, 0.2);
        }

        .link-card h3 {
            font-size: 22px;
            margin-bottom: 15px;
            color: #8b5a2b;
            border-bottom: 2px solid #d4a76a;
            padding-bottom: 10px;
        }

        .link-card p {
            font-size: 16px;
            color: #5d4b3c;
        }

        /* 애니메이션 스타일 */
        .animate-on-scroll {
            opacity: 0;
            transition: opacity 1s ease-out, transform 1s ease-out;
            will-change: opacity, transform;
        }

        /* 아래에서 위로 나오는 애니메이션 */
        .animate-bottom {
            transform: translateY(50px);
        }

        .animate-bottom.is-visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* 좌우 애니메이션도 유지 */
        .animate-left {
            transform: translateX(-50px);
        }

        .animate-left.is-visible {
            opacity: 1;
            transform: translateX(0);
        }

        .animate-right {
            transform: translateX(50px);
        }

        .animate-right.is-visible {
            opacity: 1;
            transform: translateX(0);
        }

        /* 주의사항 깜빡임 스타일 */
        .caution {
            background-color: #fff0f0;
            border-left: 5px solid #ff5252;
            padding: 15px;
            margin: 20px 0;
            position: relative;
            animation: cautionBlink 2s infinite;
        }

        @keyframes cautionBlink {
            0% { background-color: #fff0f0; }
            50% { background-color: #ffdbdb; }
            100% { background-color: #fff0f0; }
        }

        /* 중요 내용 스타일 */
        .important {
            color: #ff3333;
            text-decoration: underline;
            font-weight: bold;
        }

        /* 이미지 섹션 */
        .image-section {
            text-align: center;
            margin: 60px 0;
        }

        .image-section img {
            max-width: 90%;
            height: auto;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            border: 8px solid #d4a76a; /* 한옥 느낌의 테두리 */
        }

        /* 빠른 도움말 요약 스타일 */
        .info-summary {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            margin-top: 30px;
        }

        .info-box {
            flex: 1 1 30%;
            border: 1px solid #e0d6c6;
            border-radius: 12px;
            padding: 25px;
            background-color: #fdfbf7;
            box-shadow: 0 4px 10px rgba(139, 90, 43, 0.1);
            transition: transform 0.3s ease;
        }

        .info-box:hover {
            transform: translateY(-5px);
        }

        .info-box h4 {
            margin-bottom: 15px;
            font-size: 20px;
            color: #8b5a2b;
            position: relative;
            padding-left: 25px;
        }

        .info-box h4::before {
            content: '✧';
            position: absolute;
            left: 0;
            color: #d4a76a;
        }

        .info-box p {
            font-size: 15px;
            color: #5d4b3c;
        }

        /* 한옥 장식 요소 */
        .hanok-divider {
            height: 30px;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
            background-repeat: repeat-x;
            background-size: 100px 20px;
            margin: 40px 0;
        }

        /* 목록 스타일 */
        ul {
            padding-left: 25px;
            line-height: 1.9;
            color: #5d4b3c;
        }

        ul li::before {
            content: '•';
            color: #d4a76a;
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-left: -1em;
        }

        /* 푸터 스타일 */
        .footer {
            background-color: #8b5a2b;
            padding: 30px 20px;
            border-top: 5px solid #d4a76a;
            font-size: 14px;
            text-align: center;
            color: #ffffff;
        }

        .footer a {
            color: #fff;
            margin: 0 10px;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer a:hover {
            color: #ffcc99;
            text-decoration: underline;
        }

        /* 버튼 스타일 */
        .btn {
            display: inline-block;
            background-color: #8b5a2b;
            color: white;
            padding: 12px 25px;
            border-radius: 30px;
            margin-top: 15px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: 2px solid #8b5a2b;
        }

        .btn:hover {
            background-color: #d4a76a;
            border-color: #d4a76a;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
        }

        /* 반응형 조정 */
        @media (max-width: 768px) {
            .link-card, .info-box {
                flex: 1 1 100%;
            }

            h2 {
                font-size: 24px;
            }

            .section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Urban&Village 도움말 센터</h1>
    <p class="subtitle">한옥의 아름다움과 함께하는 특별한 여행을 도와드립니다</p>
</div>

<div class="container">

    <div class="section animate-on-scroll animate-bottom">
        <h2>이용 약관 및 정책</h2>
        <div class="link-card">
            <h3>Urban&Village 커뮤니티 가이드라인</h3>
            <p>
                본 사이트를 이용함으로써 회원은 다음의 가이드라인을 준수해야 합니다. 고객 간 신뢰와 안전을 바탕으로 한 커뮤니티를 운영하기 위해 아래 정책을 꼭 확인해 주세요.
            </p>
            <ul>
                <li>모든 이용자는 <span class="important">실제 정보를 기반으로 계정을 생성</span>해야 합니다.</li>
                <li>숙소 등록자는 정확한 사진과 설명을 제공해야 합니다.</li>
                <li>고객 간 예의 바른 커뮤니케이션을 유지해야 하며, 차별 또는 혐오 표현은 금지됩니다.</li>
                <li>불법 활동, 무단 침입, 기물 파손 등은 즉각적인 제재의 대상이 됩니다.</li>
            </ul>
        </div>

        <div class="caution">
            <p><strong>주의사항:</strong> Urban&Village 계정 정보를 타인과 공유하거나 양도하는 행위는 <span class="important">서비스 이용 제한</span>의 사유가 될 수 있습니다. 계정 보안에 각별히 유의해주세요.</p>
        </div>

        <div class="link-card" style="margin-top: 25px;">
            <h3>개인정보 처리방침</h3>
            <p>
                Urban&Village는 회원님의 개인정보 보호를 최우선으로 생각합니다. 고객 정보는 안전하게 보호되며, 동의 없이 제3자에게 제공되지 않습니다.
            </p>
            <ul>
                <li>수집하는 개인정보: 이름, 이메일, 전화번호, 생년월일, 결제 정보</li>
                <li>개인정보 보관 기간: 회원 탈퇴 후 최대 <span class="important">5년간 보관</span> (관련 법령에 따름)</li>
                <li>개인정보 열람 및 정정: 언제든지 마이페이지에서 가능</li>
                <li>마케팅 정보 수신 동의는 마이페이지에서 언제든지 변경 가능합니다</li>
            </ul>
        </div>
    </div>

    <div class="hanok-divider"></div>

    <div class="section animate-on-scroll animate-bottom">
        <h2>호스트 정책</h2>
        <div class="link-card">
            <h3>호스트의 책임과 권한</h3>
            <p>
                Urban&Village 플랫폼을 통해 숙소를 운영하는 호스트는 다음의 정책을 따릅니다.
            </p>
            <ul>
                <li>숙소의 상태와 서비스는
                    <span class="important">숙소 설명과 동일</span>해야 합니다.</li>
                <li>게스트의 문의에 24시간 이내에 응답해야 합니다.</li>
                <li>정확한 체크인·체크아웃 정보를 사전에 안내해야 합니다.</li>
                <li>게스트 리뷰는 객관적이고 공정하게 대응해야 합니다.</li>
            </ul>
        </div>

        <div class="link-card" style="margin-top: 25px;">
            <h3>숙소 등록 및 관리</h3>
            <p>
                숙소를 등록하고 관리하는 과정에서 다음 사항을 준수해야 합니다.
            </p>
            <ul>
                <li>모든 사진은 <span class="important">최근 3개월 이내</span>에 촬영된 실제 숙소 사진이어야 합니다.</li>
                <li>편의시설, 주변 환경, 접근성에 대한 정보를 정확하게 기재해야 합니다.</li>
                <li>숙소 가격은 추가 비용 없이 투명하게 공개되어야 합니다.</li>
                <li>호스트 직접 응대가 어려운 경우, 대체 연락처를 반드시 제공해야 합니다.</li>
                <li>숙소 내 안전 장비(소화기, 구급상자 등)의 위치를 게스트에게 안내해야 합니다.</li>
            </ul>
        </div>

        <div class="caution">
            <p><strong>주의사항:</strong> 허위 정보 등록이나 과장된 설명으로 인해 게스트에게 피해가 발생할 경우, <span class="important">계정 영구 정지 및 법적 책임</span>이 발생할 수 있습니다.</p>
        </div>
    </div>

    <div class="hanok-divider"></div>

    <div class="section animate-on-scroll animate-bottom">
        <h2>게스트 행동 수칙</h2>
        <div class="link-card">
            <h3>모두를 위한 안전하고 즐거운 여행</h3>
            <p>
                Urban&Village의 게스트는 다음과 같은 행동 수칙을 준수해야 합니다.
            </p>
            <ul>
                <li>숙소 내 물품을 파손하거나 무단으로 반출해서는 안 됩니다.</li>
                <li>숙소에서의 <span class="important">과도한 소음, 파티 등은 제한</span>됩니다.</li>
                <li>호스트 및 이웃과의 모든 커뮤니케이션은 존중을 기반으로 해야 합니다.</li>
                <li>숙소 이용 시 제공된 체크인/아웃 시간을 준수해야 합니다.</li>
                <li>숙소 내 안전 장비(소화기, 구급상자 등)의 위치를 게스트에게 안내해야 합니다.</li>
            </ul>
        </div>

        <div class="link-card" style="margin-top: 25px;">
            <h3>예약 및 결제 정책</h3>
            <p>
                게스트는 예약 및 결제와 관련하여 다음 사항을 숙지해야 합니다.
            </p>
            <ul>
                <li>예약 확정 후 발생하는 <span class="important">취소 수수료</span>는 예약 시점과 체크인 날짜에 따라 달라집니다.</li>
                <li>체크인 7일 전 취소: 전액 환불</li>
                <li>체크인 3-6일 전 취소: 50% 환불</li>
                <li>체크인 2일 전 이후 취소: 환불 불가</li>
                <li>천재지변, 호스트 취소 등 불가항력적 상황에서는 전액 환불 가능합니다.</li>
            </ul>
        </div>

        <div class="caution">
            <p><strong>주의사항:</strong> 숙소 내 <span class="important">흡연 및 지정된 인원 초과</span> 이용은 즉각적인 퇴실 조치와 추가 청소 비용이 발생할 수 있습니다.</p>
        </div>
    </div>

    <div class="hanok-divider"></div>

    <div class="section animate-on-scroll animate-bottom">
        <h2>애완동물 출입 시 이용약관</h2>
        <div class="link-card">
            <h3>반려동물과 함께하는 여행</h3>
            <p>
                Urban&Village는 반려동물과 함께하는 여행을 지원합니다. 다만, 모든 게스트와 호스트의 편안한 이용을 위해 다음 규정을 준수해주세요.
            </p>
            <ul>
                <li><span class="important">반려동물 동반 가능 숙소</span>에만 예약이 가능합니다.</li>
                <li>예약 시 반려동물의 종류, 크기, 수를 정확히 기재해야 합니다.</li>
                <li>모든 반려동물은 예방접종을 완료한 상태여야 합니다.</li>
                <li>반려동물로 인한 숙소 내 파손이 발생할 경우, 게스트가 수리 비용을 부담해야 합니다.</li>
                <li>공용 공간에서는 반드시 목줄을 착용해야 합니다.</li>
            </ul>
        </div>

        <div class="link-card" style="margin-top: 25px;">
            <h3>반려동물 동반 시 추가 비용</h3>
            <p>
                반려동물과 함께 숙소를 이용할 경우 다음과 같은 추가 비용이 발생할 수 있습니다.
            </p>
            <ul>
                <li>소형 동물(10kg 미만): 1박당 <span class="important">20,000원</span> 추가</li>
                <li>중형 동물(10-25kg): 1박당 30,000원 추가</li>
                <li>대형 동물(25kg 이상): 1박당 40,000원 추가</li>
                <li>안내견 및 도우미견은 추가 비용 없이 이용 가능합니다.</li>
                <li>특수 동물(파충류, 조류 등)은 호스트와 사전 협의가 필요합니다.</li>
            </li>
            </ul>
        </div>

        <div class="caution">
            <p><strong>주의사항:</strong> 숙소 예약 시 <span class="important">반려동물 동반 여부를 숨기고 입실</span>하는 경우, 즉시 퇴실 조치되며 환불이 불가합니다.</p>
        </div>
    </div>

    <div class="hanok-divider"></div>

    <div class="section image-section animate-on-scroll animate-bottom">
        <h2>Urban&Village 한옥 체험</h2>
        <img src="https://via.placeholder.com/800x500" alt="Urban&Village 한옥 전경">
        <p style="text-align: center; margin-top: 15px; font-style: italic;">전통과 현대가 공존하는 Urban&Village의 특별한 한옥 체험</p>
    </div>

    <div class="hanok-divider"></div>

    <div class="section animate-on-scroll animate-bottom">
        <h2>빠른 도움말 요약</h2>
        <div class="info-summary">
            <div class="info-box">
                <h4>내 정보 확인</h4>
                <p>계정 정보 및 비밀번호 변경 등 프로필 설정을 확인하세요.</p>
                <a href="#" class="btn">프로필 관리</a>
            </div>
            <div class="info-box">
                <h4>위시리스트</h4>
                <p>관심 숙소를 저장하고 다시 쉽게 찾아볼 수 있어요.</p>
                <a href="#" class="btn">위시리스트 보기</a>
            </div>
            <div class="info-box">
                <h4>직원 채용</h4>
                <p>채용 중인 포지션을 확인하고 지원해 보세요.</p>
                <a href="#" class="btn">채용 정보</a>
            </div>
            <div class="info-box">
                <h4>회원 탈퇴</h4>
                <p>계정을 영구 삭제하거나 휴면 전환할 수 있습니다.</p>
                <a href="#" class="btn">계정 관리</a>
            </div>
            <div class="info-box">
                <h4>예약 확인하기</h4>
                <p>이전 예약 내역과 체크인 일정을 빠르게 확인하세요.</p>
                <a href="#" class="btn">예약 확인</a>
            </div>
            <div class="info-box">
                <h4>고객센터 문의</h4>
                <p>추가 도움이 필요하시면 언제든지 문의해 주세요.</p>
                <a href="#" class="btn">문의하기</a>
            </div>
        </div>
    </div>

</div>

<div class="footer">
    <p>© 2025 Urban&Village. 모든 권리 보유.</p>
    <div style="margin-top: 15px;">
        <a href="#">이용약관</a> |
        <a href="#">개인정보처리방침</a> |
        <a href="#">고객센터</a> |
        <a href="#">소셜미디어</a>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 애니메이션 요소 선택
    const animatedElements = document.querySelectorAll('.animate-on-scroll');

    // Intersection Observer 설정
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.2 // 20%가 보일 때 애니메이션 시작
    };

    // Observer 콜백 함수
    const observerCallback = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // 요소가 화면에 보이면 is-visible 클래스 추가
                entry.target.classList.add('is-visible');
                // 애니메이션이 한 번만 실행되도록 관찰 중단
                observer.unobserve(entry.target);
            }
        });
    };

    // Observer 인스턴스 생성
    const observer = new IntersectionObserver(observerCallback, observerOptions);

    // 각 요소 관찰 시작
    animatedElements.forEach(element => {
        observer.observe(element);
    });
});
</script>

</body>
</html>