<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클리너 등록</title>
<style>
.Ccontainer {
		width: 70%;
		margin: 50px auto; /* 가운데 정렬 + 상하 여백 */
	}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="p-5">
	<div class="Ccontainer">
		<h2>지역 연계 일자리 지원 양식</h2>
		<form action="${contextPath}/cleaner/joinCleaner.do" method="post"
			enctype="multipart/form-data">
			<!-- member 정보는 출력만 하고 수정 불가 -->
			<div class="mb-3">
				<label class="form-label">아이디</label> <input type="text"
					class="form-control" name="member_id"
					value="${sessionScope.loginId}" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label">이메일</label> <input type="email"
					class="form-control" value="${sessionScope.memberPhone}" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label">생년월일</label> <input type="date"
					class="form-control" value="${sessionScope.memberBirth}" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label">성별</label> <input type="text"
					class="form-control" value="${sessionScope.memberGender}" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label">전화번호</label> <input type="text"
					class="form-control" value="${sessionScope.memberPhone}" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label">이름</label> <input type="text"
					class="form-control" value="${sessionScope.memberName}" readonly />
			</div>
			<!-- address 입력 -->
			<div class="mb-3">
				<label class="form-label">주소 검색</label>
				<div class="input-group mb-2">
					<input type="text" class="form-control" name="zipNo" id="zipNo"
						placeholder="우편번호" readonly />
					<button type="button" class="btn btn-outline-secondary"
						onclick="execDaumPostcode()">주소 검색</button>
				</div>
				<input type="text" class="form-control mb-2" name="address"
					id="roadAddrPart1" placeholder="도로명 주소" readonly /> 
					<input	type="text" class="form-control mb-2" name="addrDetail"
					id="addrDetail" placeholder="상세 주소" />
			</div>

			<div class="mb-3">
				<label class="form-label">소득 증빙서류 (PDF, 이미지 등)</label> <input
					type="file" class="form-control" name="income_proof"
					accept=".pdf,.jpg,.png,.jpeg" required />
			</div>

			<button type="submit" class="btn btn-primary">등록</button>
		</form>
	</div>
</body>
<script type="text/javascript">
 
    function execDaumPostcode() {
        const width = 570;
        const height = 420;
        const left = (window.screen.width / 2) - (width / 2);
        const top = (window.screen.height / 2) - (height / 2);
        window.open(
            "${pageContext.request.contextPath}/cleaner/jusoPopup",
            "jusoPopup",
            `width=${width},height=${height},left=${left},top=${top},scrollbars=yes`
        );
    }

    function jusoCallBack(roadAddrPart1, zipNo) {
        document.getElementById("roadAddrPart1").value = roadAddrPart1;
        document.getElementById("zipNo").value = zipNo;
    }
</script>

</html>
