<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <title>도움말 센터 | Urban&Village</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff;
            color: #333;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .section {
            margin-bottom: 50px;
        }

        h1, h2 {
            color: #222;
        }

        h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        h2 {
            font-size: 26px;
            margin-top: 30px;
            margin-bottom: 15px;
            text-align: center; 
        }

        p {
            font-size: 16px;
            line-height: 1.6;
        }

        .link-box {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .link-card {
            flex: 1 1 45%;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 1px 1px 6px rgba(0,0,0,0.05);
            background-color: #fafafa;
            transition: box-shadow 0.3s ease;
        }

        .link-card:hover {
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
        }

        .link-card h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #e61e4d;
        }

        .link-card p {
            font-size: 15px;
            color: #555;
        }

        .footer {
            background-color: #f7f7f7;
            padding: 30px 20px;
            border-top: 1px solid #ddd;
            font-size: 14px;
            text-align: center;
            color: #666;
        }

        .footer a {
            color: #666;
            margin: 0 8px;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .btn {
            display: inline-block;
            background-color: #ff385c;
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            margin-top: 10px;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #e61e4d;
        }

        .info-summary {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .info-box {
            flex: 1 1 30%;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            background-color: #fff8f8;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .info-box h4 {
            margin-bottom: 10px;
            font-size: 18px;
            color: #ff385c;
        }

        .info-box p {
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>



<!-- 약관 및 정책 섹션 시작 -->
<div class="section">
    <h2>이용 약관 및 정책</h2>
    <div class="link-card" style="flex: 1 1 100%; max-width: 100%;">
        <h3>Urban&Village 커뮤니티 가이드라인</h3>
        <p>
            본 사이트를 이용함으로써 회원은 다음의 가이드라인을 준수해야 합니다. 고객 간 신뢰와 안전을 바탕으로 한 커뮤니티를 운영하기 위해 아래 정책을 꼭 확인해 주세요.
        </p>
        <ul style="margin-top: 15px; padding-left: 20px; line-height: 1.8; color: #555;">
            <li>모든 이용자는 실제 정보를 기반으로 계정을 생성해야 합니다.</li>
            <li>숙소 등록자는 정확한 사진과 설명을 제공해야 합니다.</li>
            <li>고객 간 예의 바른 커뮤니케이션을 유지해야 하며, 차별 또는 혐오 표현은 금지됩니다.</li>
            <li>불법 활동, 무단 침입, 기물 파손 등은 즉각적인 제재의 대상이 됩니다.</li>
        </ul>
    </div>
</div>

<div class="section">
    <h2>호스트 정책</h2>
    <div class="link-card" style="flex: 1 1 100%; max-width: 100%;">
        <h3>호스트의 책임과 권한</h3>
        <p>
            Urban&Village 플랫폼을 통해 숙소를 운영하는 호스트는 다음의 정책을 따릅니다.
        </p>
        <ul style="margin-top: 15px; padding-left: 20px; line-height: 1.8; color: #555;">
            <li>숙소의 상태와 서비스는 숙소 설명과 동일해야 합니다.</li>
            <li>게스트의 문의에 24시간 이내에 응답해야 합니다.</li>
            <li>정확한 체크인·체크아웃 정보를 사전에 안내해야 합니다.</li>
            <li>게스트 리뷰는 객관적이고 공정하게 대응해야 합니다.</li>
        </ul>
    </div>
</div>

<div class="section">
    <h2>게스트 행동 수칙</h2>
    <div class="link-card" style="flex: 1 1 100%; max-width: 100%;">
        <h3>모두를 위한 안전하고 즐거운 여행</h3>
        <p>
            Urban&Village의 게스트는 다음과 같은 행동 수칙을 준수해야 합니다.
        </p>
        <ul style="margin-top: 15px; padding-left: 20px; line-height: 1.8; color: #555;">
            <li>숙소 내 물품을 파손하거나 무단으로 반출해서는 안 됩니다.</li>
            <li>숙소에서의 과도한 소음, 파티 등은 제한됩니다.</li>
            <li>호스트 및 이웃과의 모든 커뮤니케이션은 존중을 기반으로 해야 합니다.</li>
            <li>숙소 이용 시 제공된 체크인/아웃 시간을 준수해야 합니다.</li>
        </ul>
    </div>
</div>
<!-- 약관 및 정책 섹션 끝 -->

<!-- 내 정보 등 요약 카드 섹션 -->
<div class="section">
    <h2>빠른 도움말 요약</h2>
    <div class="info-summary">
        <div class="info-box">
            <h4>내 정보 확인</h4>
            <p>계정 정보 및 비밀번호 변경 등 프로필 설정을 확인하세요.</p>
        </div>
        <div class="info-box">
            <h4>위시리스트</h4>
            <p>관심 숙소를 저장하고 다시 쉽게 찾아볼 수 있어요.</p>
        </div>
        <div class="info-box">
            <h4>직원 채용</h4>
            <p>채용 중인 포지션을 확인하고 지원해 보세요.</p>
        </div>
        <div class="info-box">
            <h4>회원 탈퇴</h4>
            <p>계정을 영구 삭제하거나 휴면 전환할 수 있습니다.</p>
        </div>
        <div class="info-box">
            <h4>예약 확인하기</h4>
            <p>이전 예약 내역과 체크인 일정을 빠르게 확인하세요.</p>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
