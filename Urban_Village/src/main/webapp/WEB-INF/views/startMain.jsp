<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Urban&Village</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Arial', sans-serif;
      overflow-x: hidden;
      background-color: #f7f7f7;
    }
    main { padding: 20px; }
    .section {
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      background: #f4f4f4;
      opacity: 0;
      transform: translateY(100px);
      transition: opacity 1s, transform 1s;
      position: relative;
    }
    .section-content {
      z-index: 1;
      text-align: center;
      max-width: 800px;
      padding: 30px;
      background-color: rgba(255, 255, 255, 0.85);
      border-radius: 15px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .section h2 { font-size: 2.5em; font-weight: bold; color: #333; }
    .section p { font-size: 1.3em; margin-top: 20px; color: #555; }
    .section .button {
      background-color: #FF80C0;
      color: white;
      padding: 12px 25px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 1.2em;
      margin-top: 20px;
    }
    .visible {
      opacity: 1;
      transform: translateY(0);
    }
    .background {
      position: absolute;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background-size: cover;
      background-position: center;
      z-index: -1;
    }
    .section-header {
      background: linear-gradient(to right, #FF80C0, #222);
      padding: 40px;
      text-align: center;
      color: white;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
    }
    .section-header h1 { font-size: 2.5em; font-weight: bold; }
    .section-header p { font-size: 1.2em; margin-top: 10px; }

    /* ✅ 쿠폰 배너 */
    .coupon-banner {
      background-color: #fff0f6;
      color: #d63384;
      text-align: center;
      padding: 20px;
      margin: 0 auto 30px auto;
      border: 2px dashed #ff80c0;
      border-radius: 12px;
      font-size: 1.2em;
      max-width: 800px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.05);
      animation: fadeInDown 1s ease-in-out;
    }

    @keyframes fadeInDown {
      from {
        opacity: 0;
        transform: translateY(-30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .developer-info {
      font-size: 1.1em;
      color: #333;
      text-align: center;
      margin-top: 50px;
    }
  </style>
</head>
<body>
<main>

  <!-- ✅ 헤더 아래에 항상 보이는 쿠폰 영역 -->
  <div class="section-header">
    <h1>Urban&Village에 오신 것을 환영합니다!</h1>
    <p>현대적이고 세련된 여행 숙소를 제공하는 어반빌리지</p>
  </div>

  <div class="coupon-banner">
    🎉 <strong>10% 할인 쿠폰</strong> 증정! <br />
    예약 시 쿠폰 코드 <strong>DISCOUNT10</strong>을 입력해 할인받으세요 🎁
  </div>

  <!-- 본문 섹션들 -->
  <div class="section" id="section1">
    <div class="background" style="background-image: url('<%= request.getContextPath() %>/images/section1.jpg');"></div>
    <div class="section-content">
      <h2>어반빌리지 소개</h2>
      <p>어반빌리지는 현대적이고 세련된 여행 숙소를 제공하는 서비스입니다.</p>
      <button class="button">더 알아보기</button>
    </div>
  </div>

  <div class="section" id="section2">
    <div class="background" style="background-image: url('<%= request.getContextPath() %>/images/section2.jpg');"></div>
    <div class="section-content">
      <h2>다양한 숙소</h2>
      <p>여러 지역에서 다양한 스타일의 숙소를 예약할 수 있습니다.</p>
      <button class="button">숙소 보기</button>
    </div>
  </div>

  <div class="section" id="section3">
    <div class="background" style="background-image: url('<%= request.getContextPath() %>/images/section3.jpg');"></div>
    <div class="section-content">
      <h2>편리한 예약 시스템</h2>
      <p>예약 시스템은 매우 직관적이고 사용하기 쉽습니다.</p>
      <button class="button">예약하기</button>
    </div>
  </div>

  <div class="section" id="section4">
    <div class="background" style="background-image: url('<%= request.getContextPath() %>/images/section4.jpg');"></div>
    <div class="section-content">
      <h2>고객센터</h2>
      <p>문제를 신속하게 해결해 드리는 고객센터가 준비되어 있습니다.</p>
      <button class="button">문의하기</button>
    </div>
  </div>

  <div class="developer-info">
    <p>개발자: 김찬영 · 서하나 · 김대중 · 최승필</p>
  </div>

</main>

<script>
  // 섹션 애니메이션
  const sections = document.querySelectorAll('.section');
  function checkVisibility() {
    sections.forEach(section => {
      const sectionTop = section.getBoundingClientRect().top;
      if (sectionTop <= window.innerHeight * 0.8) {
        section.classList.add('visible');
      } else {
        section.classList.remove('visible');
      }
    });
  }
  window.addEventListener('scroll', checkVisibility);
  window.addEventListener('load', checkVisibility);
</script>
</body>
</html>
