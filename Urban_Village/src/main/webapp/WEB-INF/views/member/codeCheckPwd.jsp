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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<h3>이메일로 전송된 코드를 입력하세요</h3>

<c:if test="${not empty codeError}">
    <p class="text-danger">${codeError}</p>
</c:if>

<form action="${contextPath}/member/checkCode.do" method="post">
    <input type="hidden" name="member_id" value="${member_id}" />
    <input type="text" name="code" placeholder="인증 코드 입력" />
    <button type="submit">확인</button>
</form>

<c:if test="${codeSuccess}">
    <script>
        alert("암호수정 페이지로 이동합니다.");
        location.href = "${contextPath}/member/resetPwd.do?id=${member_id}";
    </script>
</c:if>

  
</body>
</html>