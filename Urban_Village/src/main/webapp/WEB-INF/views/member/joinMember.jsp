<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<style>
    /* Imported Google Fonts */
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap');

    body {
        margin: 0;
        font-family: 'Nanum Gothic', sans-serif;
        /* --- Background Image Styles --- */
        background-image: url('${contextPath}/resources/WebSiteImages/abc.png'); /* Correct web path */
        background-size: cover; /* Scale image to cover the entire viewport */
        background-position: center center; /* Center the image */
        background-repeat: no-repeat; /* Do not repeat the image */
        background-attachment: fixed; /* Fix image relative to viewport */
        /* --- End Background Image Styles --- */

        color: #333;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: flex-start; /* Align items to the start to allow for top/bottom margins */
        padding: 20px;
        box-sizing: border-box;
        position: relative; /* Needed for overlay pseudo-element positioning */
    }

    /* --- Background Overlay for Readability --- */
    body::before {
        content: "";
        position: fixed; /* Cover the entire viewport */
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(253, 252, 249, 0.7); /* Semi-transparent overlay matching form background */
        z-index: -1; /* Place it between the body background and the form */
    }
      /* --- End Background Overlay --- */


    .form {
        display: flex; /* Default: Single column for mobile */
        flex-direction: column;
        gap: 15px; /* Vertical gap for single column */
        width: 100%;
        max-width: 450px; /* Max width for single column */
        padding: 40px;
        border-radius: 20px;
        position: relative;
        background-color: #FDFCF9; /* Form background color */
        color: #333;
        border: 1px solid #D3C6B5;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        margin: 15px auto; /* Add top and bottom margin for spacing from header/footer */
        box-sizing: border-box;
         z-index: 1; /* Ensure form is above the overlay */
    }

    .form-column {
        display: flex;
        flex-direction: column;
        gap: 15px; /* Vertical gap within each column */
        width: 100%;
    }

    /* Explicitly define column widths within the form for mobile to ensure they take full width */
    .left-column, .right-column {
        width: 100%;
    }

    .title {
        font-size: 28px;
        font-weight: 700;
        letter-spacing: -1px;
        position: relative;
        display: flex;
        align-items: center;
        padding-left: 30px;
        color: #4A3E38;
        font-family: 'Noto Serif KR', serif;
        margin-bottom: 15px;
    }

    .title::before,
    .title::after {
        position: absolute;
        content: "";
        height: 16px;
        width: 16px;
        border-radius: 50%;
        left: 0px;
        background-color: #A07A61;
    }
    .title::before {
        width: 18px;
        height: 18px;
    }

    .title::after {
        width: 18px;
        height: 18px;
        animation: pulse 1s linear infinite;
    }

    .message,
    .signin {
        font-size: 15px;
        color: #6B4F4F;
        text-align: center;
        margin-top: 0;
        margin-bottom: 20px;
    }

    .signin {
        text-align: center;
        font-size: 14px;
        color: #666;
    }

    .signin a:hover {
        text-decoration: underline #A07A61;
    }

    .signin a {
        color: #A07A61;
        font-weight: 600;
        text-decoration: none;
        transition: color 0.3s ease, text-decoration 0.3s ease;
    }

    .flex {
        display: flex;
        width: 100%;
        gap: 10px;
        align-items: flex-end;
    }

    .flex label {
        flex-grow: 1;
        flex-direction: column;
        display: flex;
    }

    .form label {
        position: relative;
        width: 100%;
    }

    /* Date input group styles */
    .date-input-group {
        display: flex;
        flex-direction: column;
        width: 100%;
        gap: 8px; /* Gap between label and input */
    }

    /* Label for date input field */
    .date-input-group label {
        position: static; /* Remove absolute positioning */
        margin-bottom: 0;
        font-size: 15px;
        color: #6B4F4F;
        font-weight: 500;
    }

    .form label .input,
    .form label select.input,
    .date-input-group .input { /* Style for all input types including date */
        background-color: #FDFCF9;
        color: #333;
        width: 100%;
        padding: 14px 10px;
        outline: 0;
        border: 1px solid #D3C6B5;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 16px;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    /* Custom select arrow */
    .form label select.input {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23A07A61%22%20d%3D%22M287%2C114.7L159.3%2C2.1c-5.9-5.9-15.4-5.9-21.2%2C0L5.4%2C114.7c-5.9%2C5.9-5.9%2C15.4%2C0%2C21.2l14.1%2C14.1%20113.6%2C113.6%20113.6%2C-113.6%2014.1%2C-14.1C292.9%2C130.1%2C292.9%2C120.5%2C287%2C114.7z%22%2F%3E%3C%2Fsvg%3E');
        background-repeat: no-repeat;
        background-position: right 10px top 50%;
        background-size: 12px auto;
        padding-right: 30px;
        padding-top: 14px;
        padding-bottom: 14px;
    }

    /* Adjust date input padding if needed for browser default icon */
    .date-input-group .input[type="date"] {
         padding: 14px 10px;
         padding-right: 10px; /* Ensure space for default date picker icon */
    }


    /* Floating label styles for inputs (not in date-input-group) */
    .form label:not(.date-input-group label) .input + span {
        color: #6B4F4F;
        position: absolute;
        left: 10px;
        top: 14px; /* Initial position */
        font-size: 0.9em;
        cursor: text;
        transition: 0.3s ease;
        pointer-events: none;
    }

    /* Adjust floating label position for select */
    .form label select.input + span {
         top: 14px; /* Align with select padding */
    }

    /* Hide span for labels within date-input-group as the label text is used directly */
    .date-input-group label span {
        display: none;
    }


    .form label:not(.date-input-group label) .input:placeholder-shown + span {
        top: 14px;
        font-size: 0.9em;
        color: #6B4F4F;
    }

    .form label:not(.date-input-group label) .input:focus + span,
    .form label:not(.date-input-group label) .input:valid + span {
        color: #A07A61;
        top: 0px;
        font-size: 0.75em;
        font-weight: 600;
        background-color: #FDFCF9;
        padding: 0 5px;
        left: 8px;
    }
     /* Floating label position for select on focus/valid */
    .form label select.input:focus + span,
    .form label select.input:valid + span {
         top: 0px;
    }


    .input {
        font-size: 16px;
    }

    .submit {
        border: none;
        outline: none;
        padding: 12px;
        border-radius: 8px;
        color: white;
        font-size: 17px;
        font-weight: 700;
        background-color: #A07A61;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.1s ease;
        margin-top: 5px;
    }

    .submit:hover {
        background-color: #8D6C55;
    }
    .submit:active {
        transform: scale(0.98);
    }

    .submit:disabled {
        background-color: #D3C6B5;
        cursor: not-allowed;
    }

    @keyframes pulse {
        from {
            transform: scale(0.9);
            opacity: 1;
        }
        to {
            transform: scale(1.8);
            opacity: 0;
        }
    }

    /* Two-column layout for medium screens and up */
    @media (min-width: 768px) {
        .form {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Two equal columns */
            gap: 40px 40px; /* Vertical gap between rows, Horizontal gap between columns */
            max-width: 800px; /* Increased max width for two columns */
        }

        /* Place column divs into grid columns */
        .form-column.left-column {
            grid-column: 1; /* Place in the first column */
        }

        .form-column.right-column {
            grid-column: 2; /* Place in the second column */
        }

        /* Elements that span across both columns */
        .form .title,
        .form .message,
        .form .submit,
        .form .signin {
            grid-column: 1 / span 2; /* Start at column 1 and span 2 columns */
        }

        /* Adjust margin for elements that now span two columns */
         .form .message {
             margin-bottom: 0; /* Reduce bottom margin as it's followed by columns */
         }

        /* Adjust top margin for the submit button to create space after columns */
        .form .submit {
            margin-top: 20px; /* Increase top margin to space from columns above */
        }

        /* Ensure flex items (input + button) in .flex behave correctly in the grid cell */
        .flex {
            width: 100%; /* Ensure flex container takes full width of grid cell */
        }
         .flex label {
             flex-grow: 1; /* Allow label to take up remaining space */
         }

         /* Adjust layout for the email section buttons on large screens */
         .form .flex:has(#email) {
             flex-direction: row; /* Make it a row for side-by-side layout */
             align-items: flex-end; /* Align items to the bottom */
             gap: 10px;
         }
         .form .flex:has(#email) label {
             flex-grow: 1; /* Email input takes remaining space */
              /* Ensure vertical alignment with button */
             display: flex;
             flex-direction: column;
             justify-content: flex-end; /* Align content to bottom */
         }
          .form .flex:has(#email) button {
              /* Let the button take a fixed width */
               flex: 0 0 120px; /* Fixed basis for width, prevent growing/shrinking */
               height: auto; /* Height determined by padding/content */
               margin-top: 0; /* Remove default top margin */
               align-self: flex-end; /* Align to the bottom */
          }

    }

    /* Small screen (mobile) adjustments */
    @media (max-width: 576px) {
        .form {
            padding: 20px;
            gap: 10px;
             margin: 15px auto; /* Ensure margin is applied */
        }

        .title {
            font-size: 24px;
            padding-left: 25px;
        }
        .title::before, .title::after {
            width: 14px;
            height: 14px;
        }

        .message, .signin {
            font-size: 14px;
            margin-bottom: 15px;
        }

        .submit {
            padding: 10px;
            font-size: 15px;
        }

        .form label .input,
        .form label select.input,
        .date-input-group .input {
            padding: 12px 10px;
            font-size: 15px;
        }

        /* Floating label adjustments for small screens */
        .form label:not(.date-input-group label) .input + span {
            top: 11px;
            font-size: 0.8em;
        }
        .form label:not(.date-input-group label) .input:placeholder-shown + span {
             top: 11px;
        }

        .form label:not(.date-input-group label) .input:focus + span,
        .form label:not(.date-input-group label) .input:valid + span {
             top: 0px;
             font-size: 0.7em;
        }
         .form label select.input:focus + span,
         .form label select.input:valid + span {
              top: 0px;
         }
    }

    /* Specific adjustments for the email verification section */
    #verificationSection label {
         margin-top: 15px; /* Add some space above the verification input */
         margin-bottom: 0; /* Remove bottom margin */
    }
     /* Adjust flex layout for email and verification buttons */
    .form .flex:has(#email) { /* Target the flex containing the email input */
        flex-direction: column; /* Stack vertically on small screens */
        align-items: stretch; /* Stretch items to full width */
        gap: 10px;
    }
     .form .flex:has(#email) label,
     .form .flex:has(#email) button {
         width: 100%; /* Make items in this flex column full width on small screens */
          flex: none; /* Remove flex properties that might interfere */
     }
     /* Hide the span label for the verification input as we will use the placeholder */
      #verificationSection label span {
          display: none;
      }
      /* Style the verification input placeholder */
      #verificationSection label .input::placeholder {
          color: #6B4F4F;
          opacity: 0.7; /* Make placeholder slightly transparent */
      }

    /* --- Styles for the smaller Email Verification Buttons --- */
    #sendCodeBtn, #verifyBtn {
        padding: 12px 15px; /* Adjusted padding to better match input height */
        font-size: 15px; /* Slightly increased font size */
        /* Remove inline styles that set explicit height/flex-basis */
        height: auto !important; /* Override any fixed height */
        margin-top: 5px; /* Add a small margin above the buttons */
    }
    /* Specific style for the verify button when shown */
    #verifyBtn {
         /* No extra styles needed here, inherits from #sendCodeBtn */
         margin-top: 10px; /* Add a bit more space above verify button */
    }


    /* Adjustments for the first flex container (ID check) */
     .form .flex:has(#id) label {
         flex-grow: 1; /* Ensure label takes available space */
     }
     .form .flex:has(#id) button {
         /* Ensure ID check button retains its size/flex properties */
          flex: 0 0 100px; /* Fixed basis for width, prevent shrinking/growing */
          height: 50px; /* Keep original height */
          margin-top: 0; /* Remove default top margin */
          align-self: flex-end; /* Align to the bottom */
     }


</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function fn_checkId() {
    var userId = $("#id").val();
    if (userId === "") {
        alert("아이디를 입력하세요.");
        return;
    }

     // Disable the button while checking
     $("#checkIdBtn").prop('disabled', true).text('확인 중...');


    $.ajax({
        url: "${contextPath}/member/checkId.do",
        method: "POST",
        data: { id: userId },
        success: function(response) {
             // Assuming the backend returns JSON like { "exists": true } or { "exists": false }
            if (response && response.exists !== undefined) {
                if (response.exists) {
                    alert("아이디가 이미 존재합니다.");
                     $("#submitBtn").prop("disabled", true); // Disable submit if ID exists
                } else {
                    alert("사용 가능한 아이디입니다.");
                     // You might want to set a flag here or enable the submit button
                     // but typically you'd validate on form submission as well.
                     // For simplicity, let's just inform the user.
                }
            } else {
                 alert("아이디 중복 체크 응답 오류.");
                 $("#submitBtn").prop("disabled", true); // Disable on error
            }
        },
        error: function(xhr, status, error) {
             console.error("AJAX error:", status, error);
            alert("아이디 중복 체크 중 오류가 발생했습니다.");
             $("#submitBtn").prop("disabled", true); // Disable on error
        },
         complete: function() {
             $("#checkIdBtn").prop('disabled', false).text('중복체크'); // Re-enable and reset text
         }
    });
}

// Global variable to track email verification status
let emailVerified = false;

function sendVerificationCode() {
    const email = $("#email").val();

    // 이메일 형식 검사
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("올바른 이메일 형식을 입력해주세요.");
        return;
    }

     // Disable the button to prevent multiple clicks
     $("#sendCodeBtn").prop('disabled', true).text('발송 중...');


    $.ajax({
        url: "${contextPath}/email/sendJoinCode.do",
        type: "POST",
        data: { email: email },
        success: function(response) {
             // Assuming the backend returns a success indicator or the code (less secure)
             // It's better for the backend to just indicate success/failure for sending
             if (response && response.success) { // Assuming backend sends { "success": true, "message": "..." }
                alert("인증번호가 이메일로 발송되었습니다.");
                $("#verificationSection").show(); // Show the verification input field
                $("#verifyBtn").show(); // Show the verify button
                 $("#sendCodeBtn").text('재전송'); // Change button text
             } else {
                 alert("인증번호 발송에 실패했습니다. 응답: " + (response ? response.message : '알 수 없는 오류'));
                 $("#sendCodeBtn").prop('disabled', false).text('인증번호 보내기'); // Re-enable button
             }
        },
        error: function(xhr, status, error) {
             console.error("AJAX error:", status, error);
            alert("인증번호 발송 중 오류가 발생했습니다.");
             $("#sendCodeBtn").prop('disabled', false).text('인증번호 보내기'); // Re-enable button
        }
    });
}

function verifyCode() {
    const inputCode = $("#verificationCodeInput").val();
     if (inputCode === "") {
         alert("인증번호를 입력해주세요.");
         return;
     }

     // Disable the button to prevent multiple clicks
      $("#verifyBtn").prop('disabled', true).text('확인 중...');


    $.ajax({
        url: "${contextPath}/email/checkJoinCode.do",
        type: "POST",
        data: { inputCode: inputCode },
         success: function(response) {
             // Assuming backend returns { "isValid": true } or { "isValid": false }
             if (response && response.isValid !== undefined) {
                 if (response.isValid) {
                     alert("이메일 인증이 완료되었습니다!");
                     emailVerified = true; // Set the flag
                     $("#submitBtn").prop("disabled", false); // Enable 회원가입 button
                     $("#verificationCodeInput").prop("disabled", true); // Disable input after verification
                     $("#verifyBtn").hide(); // Hide verify button
                     $("#sendCodeBtn").prop('disabled', true).text('인증 완료'); // Disable send button and change text
                 } else {
                     alert("인증번호가 일치하지 않습니다.");
                      emailVerified = false; // Reset flag
                      $("#submitBtn").prop("disabled", true); // Keep submit disabled
                      $("#verifyBtn").prop('disabled', false).text('인증 확인'); // Re-enable verify button
                 }
             } else {
                  alert("인증 확인 응답 오류.");
                  emailVerified = false;
                  $("#submitBtn").prop("disabled", true);
                  $("#verifyBtn").prop('disabled', false).text('인증 확인');
             }
         },
        error: function(xhr, status, error) {
             console.error("AJAX error:", status, error);
            alert("인증 확인 중 오류가 발생했습니다.");
             emailVerified = false;
             $("#submitBtn").prop("disabled", true);
             $("#verifyBtn").prop('disabled', false).text('인증 확인');
        }
    });
}

// Function to perform final checks before form submission
function validateForm() {
    if (!emailVerified) {
        alert("이메일 인증을 완료해주세요.");
        return false; // Prevent form submission
    }
    // Add other client-side validations here if needed (e.g., password match, required fields)
     // You might also want to check if ID check was successful, though backend should verify again.

    return true; // Allow form submission if all checks pass
}


</script>
</head>
<body>
    <form class="form" action="${contextPath }/member/addMember.do" method="post" onsubmit="return validateForm()">
        <p class="title">회원가입창</p>
        <p class="message">회원가입하고 다양한 혜택을 즐겨보세요!</p>

        <div class="form-column left-column">
            <div class="flex">
                <label style="flex: 1;">
                    <input class="input" type="text" name="id" id="id" required autocomplete="off">
                    <span>아이디</span>
                </label>
                 <button type="button" class="submit" id="checkIdBtn" onclick="fn_checkId()">중복체크</button>
            </div>

            <label>
                <input class="input" type="password" name="pwd" required autocomplete="new-password">
                <span>비밀번호</span>
            </label>

             <div class="flex"> <label style="flex: 1;">
                    <input class="input" type="email" name="email" id="email" required autocomplete="email">
                    <span>이메일</span>
                </label>
                 <button type="button" class="submit" id="sendCodeBtn" onclick="sendVerificationCode()">인증번호 보내기</button>
            </div>
             <label id="verificationSection" style="display: none; width: 100%;">
                 <input class="input" type="text" id="verificationCodeInput" placeholder="인증번호 입력" autocomplete="one-time-code">
                 </label>
              <button type="button" class="submit" id="verifyBtn" style="display: none;" onclick="verifyCode()">인증 확인</button>


        </div>

        <div class="form-column right-column">

             <div class="date-input-group">
                 <label for="birth">생년월일</label>
                 <input class="input" type="date" name="birth" id="birth" required>
            </div>


            <label>
                <select class="input" name="gender" required>
                    <option value="" disabled selected>성별 선택</option>
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
                 <span>성별</span> </label>

            <label>
                <input class="input" type="tel" name="phonenumber" required autocomplete="tel">
                <span>전화번호</span>
            </label>

            <label>
                <input class="input" type="text" name="name" required autocomplete="name">
                <span>이름</span>
            </label>
        </div>

        <button class="submit" id="submitBtn" type="submit" disabled>회원가입</button>
        <p class="signin">이미 계정이 있으신가요? <a href="${contextPath }/member/loginForm.do">로그인</a></p>
    </form>

</body>
</html>