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
<script>
        
    </script>
</head>
<body>
  <form method="post" action="${contextPath}/member/findPwdForId.do">
  찾으실 비밀번호의 아이디를 입력해 주세요 <input type="text" name="member_id">
  <input type="submit" value="암호찾기">
  </form>
  
</body>
</html>