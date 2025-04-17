<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script>
  $(document).ready(function() {
    const currentUrl = window.location.pathname;

    $('.nav-btn').each(function() {
      const btnUrl = $(this).data('url');

      if (currentUrl.includes(btnUrl)) {
        $(this).css({
          'background': '#FF385C',
          'color': 'white'
        });
      }
    });
  });
</script>

<div class="sidebar">
	<div class="divlogo"><a href="/Urban_Village/" class="logo"> Urban&Village </a></div>
		<button class="btn nav-btn" onclick="location.href='${contextPath }/member/myInfo.do?id=${loginId}'" data-url="${contextPath}/member/myInfo.do">내정보 확인</button>
		<button class="btn nav-btn" onclick="location.href='${contextPath }/wishList/wishList.do?memberId=${loginId}'" data-url="${contextPath}/wishList/wishList.do">위시리스트</button>
		<button class="btn nav-btn" onclick="location.href='${contextPath }/cleaner/cleanerForm.do'" data-url="${contextPath}/cleaner/cleanerForm.do">구직지원</button>
		<button class="btn nav-btn" onclick="location.href='${contextPath}/member/deleteMemberForm.do'" data-url="${contextPath}/member/deleteMemberForm.do">회원탈퇴</button>
		<button class="btn nav-btn" onclick="location.href='${contextPath}/reservation/reservationHistory.do'" data-url="${contextPath}/reservation/reservationHistory.do">예약확인하기</button>
</div>