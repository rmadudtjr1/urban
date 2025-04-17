<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>숙소 등록</title>
<style>
body {
    font-family: sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f7f7f7;
}

.container {
    width: 50%;
    margin: 0 auto;
    padding-top: 50px;
}

.form-box {
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* 공통 입력 필드 */
.input-field {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border-radius: 8px;
    border: 1px solid #ddd;
    font-size: 16px;
    background-color: #f7f7f7;
    transition: all 0.3s ease;
}

.input-field:focus {
    border-color: #ff5a5f;
    background-color: white;
    outline: none;
}

/* 기본 버튼 스타일 */
.submit-button {
    background-color: #ff5a5f;
    color: white;
    border: none;
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 5px;
    cursor: pointer;
}

.submit-button:hover {
    background-color: #f44336;
}

/* row-flex 컨테이너 */
.row-flex {
    display: flex;
    gap: 10px;
    align-items: center;
}

/* select 필드: 두 선택창이 가로로 동일한 넓이로 채움 */
.select-field {
    flex: 1;
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ddd;
    background-color: #f7f7f7;
    font-size: 16px;
}

/* 숙소 이름 입력창은 flex로 확장 */
.flex-grow {
    flex: 1;
}

/* 중복체크 버튼은 고정 너비 및 패딩 줄임 */
.check-button {
    width: 120px;
    padding: 8px 16px;
}
</style>

<!-- ✅ jQuery 보안 적용 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <form method="post"
            action="${contextPath}/accommodation/addNewAccommodation"
            class="form-box" enctype="multipart/form-data">
            <h2>숙소 등록</h2>
            <input type="text" name="accommodation_id"
                value="등록 후 숙소 아이디가 자동으로 생성됩니다." class="input-field" required
                readonly>
            <input type="text" name="admin_id"
                class="input-field" placeholder="관리자 ID" required>

            <div class="row-flex">
                <label class="form-label">주소 검색</label>
            <div class="input-group mb-2">
               <input type="text" class="form-control" name="zipNo" id="zipNo"
                  placeholder="우편번호" readonly />
               <button type="button" class="btn btn-outline-secondary"
                  onclick="execDaumPostcode()">주소 검색</button>
            </div>
            <input type="text" class="form-control mb-2" name="accommodation_address"
               id="roadAddrPart1" placeholder="도로명 주소" readonly />
                
            </div>

            <div class="row-flex">
                <!-- 숙소 이름 입력창은 좌측에 넓게 -->
                <input type="text" id="accommodationName" name="accommodation_name"
                    class="input-field flex-grow" placeholder="숙소 이름" required>
                <!-- 중복체크 버튼은 우측에 고정 너비/높이 -->
                <button type="button" class="submit-button check-button"
                    onclick="checkAccommodationName()">중복체크</button>
            </div>

            <input type="file" name="accommodation_photo[]" class="input-field" placeholder="숙소 사진 경로" required multiple> 
            <input type="text" name="cleaner_admin_id" class="input-field" placeholder="청소 관리자 ID (선택)"> 
            <input type="number" name="capacity" class="input-field" placeholder="최대 인원 수" required>
            <input type="number" name="room_count" class="input-field" placeholder="방 개수" required> 
            <input type="number" name="bathroom_count" class="input-field" placeholder="화장실 개수" required> 
            <input type="number" name="bed_count" class="input-field" placeholder="침대 수" required> 
            <input type="number" name="price" class="input-field" placeholder="가격" required>
            <select name="wifi_avail" class="input-field" required>
                <option value="">와이파이 여부 선택</option>
                <option value="Y">Y</option>
                <option value="N">N</option>
            </select>
            <button type="submit" class="submit-button">등록</button>
        </form>
    </div>
    
    <!-- ✅ 동적 세부 도시 처리 -->
    <script>
    
    </script>

    <!-- ✅ 숙소 이름 중복 체크 -->
    <script>
    function checkAccommodationName() {
        var accommodationName = $("#accommodationName").val();
        console.log("중복 체크를 위한 숙소 이름: " + accommodationName); // 여기서 값 확인
        $.ajax({
            url: "${contextPath}/accommodation/checkName.do",
            method: "POST",
            data: { accommodation_name: accommodationName }, // 파라미터 이름 일치 확인
            success: function(response) {
                if (response.exists) {
                    alert("숙소 이름이 이미 존재합니다.");
                } else {
                    alert("사용 가능한 숙소 이름입니다.");
                }
            },
            error: function(xhr, status, err) {
                alert("❌ 오류 발생:\nstatus: " + xhr.status + "\nmessage: " + err);
                
            }
        });
    }
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
</body>
</html>
