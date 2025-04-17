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
   font-family: 'Arial', sans-serif;
}

.divlogo {
   color: #FF385C;
   font-size: 24px;
   font-weight: bold;
   margin-bottom: 20px;
}
.logo {
   font-size: 24px;
   font-weight: bold;
   text-decoration: none;
   color: #333;
}

.content {
   margin-left: 750px;
   padding: 40px;
}

.info-box {
   background: white;
   padding: 20px;
   border-radius: 10px;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   max-width: 500px;
}

.info-box label {
   font-weight: bold;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
        $(document).ready(function() {
            $("form").submit(function(event) {
               
                var newPwd = $("input[name='newPwd']").val();
                var confirmPwd = $("input[name='confirmPwd']").val();
                var hasError = false;
               

                $(".error-message").remove();

                if (newPwd === "") {
                    $("<p class='error-message'>암호을 입력하세요.</p>").insertAfter($("input[name='newPwd']"));
                    $("input[name='newPwd']").focus();
                    hasError = true;
                } else if (confirmPwd === "") {
                    $("<p class='error-message text-danger'>암호 확인을 입력하세요.</p>")
                    .insertAfter($("input[name='confirmPwd']"));
                 $("input[name='confirmPwd']").focus();
                 hasError = true;
              } else if (newPwd !== confirmPwd) {
                 $("<p class='error-message text-danger'>비밀번호가 일치하지 않습니다.</p>")
                    .insertAfter($("input[name='confirmPwd']"));
                 $("input[name='confirmPwd']").focus();
                 hasError = true;
              }

                if (hasError) {
                    event.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
   <div class="content">
      <h2>암호수정 페이지</h2>
      <div class="info-box">
         <form action="${contextPath}/member/modPwdMember.do" method="post">
            <c:if test="${memberList != null}">
               <input type="hidden" id="id" name="id" value="${memberList[0].id}">
               <div class="mb-3">
                  <label for="password" class="form-label">비밀번호</label> <input
                     type="text" class="form-control" id="pwd" name="pwd"
                     value="${memberList[0].pwd}">
               </div>
               <div class="mb-3">
                  <label for="newPwd" class="form-label">새로운 비밀번호</label> <input
                     type="password" class="form-control" id="newPwd" name="newPwd">
               </div>
               <div class="mb-3">
                  <label for="newPwd" class="form-label">새로운 비밀번호 확인</label> <input
                     type="password" class="form-control" id="confirmPwd" name="confirmPwd">
               </div>
               
               <button type="submit" class="btn btn-primary">수정하기</button>
            </c:if>
         </form>
      </div>
   </div>
</body>
</html>