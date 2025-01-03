<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />

<html>
<head>
    <title>회원가입</title>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* 컨텐츠가 푸터와 겹치지 않도록 수정 */
            padding-bottom: 50px; /* 푸터와 겹치지 않도록 하단에 공간 추가 */
        }

        .register-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            width: 400px;
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input:focus {
            border-color: #4CAF50;
        }

        .register-button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .register-button:hover {
            background-color: #45a049;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
        }

        .login-link a {
            color: #4CAF50;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>

<div class="content">
    <div class="register-container">
        <h2>회원가입</h2>
        <form action="<c:url value='/membership/registerSubmit' />" method="post" onsubmit="return showAlert()">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required placeholder="아이디를 입력하세요">
            </div>
            <div class="form-group">
                <label for="userPwd">비밀번호</label>
                <input type="password" id="userPwd" name="userPwd" required placeholder="비밀번호를 입력하세요">
            </div>
            <div class="form-group">
                <label for="confirmPwd">비밀번호 확인</label>
                <input type="password" id="confirmPwd" name="confirmPwd" required placeholder="비밀번호 확인을 입력하세요">
            </div>
            <div class="form-group">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" required placeholder="이름을 입력하세요">
            </div>
            <div class="form-group">
                <label for="userAddress">주소</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="userAddress" name="userAddress" required placeholder="주소를 입력하세요" readonly style="flex: 3;">
                    <button type="button" onclick="execDaumPostcode()" style="flex: 1; background-color: #4CAF50; color: white; border: none; padding: 8px; border-radius: 4px; cursor: pointer;">주소 찾기</button>
                </div>
            </div>
            <div class="form-group">
                <label for="detailAddress">나머지 주소</label>
                <input type="text" id="detailAddress" name="detailAddress" placeholder="나머지 주소를 입력하세요">
            </div>
            <!-- 숨겨진 필드 추가 -->
            <input type="hidden" id="fullAddress" name="fullAddress">
            <div class="form-group">
                <label for="userPhone">전화번호</label>
                <input type="number" id="userPhone" name="userPhone" required placeholder="전화번호를 입력하세요">
            </div>
            <div class="form-group">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" required placeholder="이메일을 입력하세요">
            </div>
            <button type="submit" class="register-button">회원가입</button>
        </form>

        <div class="login-link">
            <p>이미 계정이 있으신가요? <a href="<c:url value='/login/login' />">로그인</a></p>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        function showAlert() {
            const username = document.getElementById('userId').value.trim();
            const password = document.getElementById('userPwd').value.trim();
            const confirmPassword = document.getElementById('confirmPwd').value.trim();
            const email = document.getElementById('userEmail').value.trim();
            const phone = document.getElementById('userPhone').value.trim();

            // 아이디 유효성 검사
            if (username === "") {
                alert("아이디를 입력해주세요.");
                return false;
            }

            // 비밀번호 유효성 검사
            if (password === "") {
                alert("비밀번호를 입력해주세요.");
                return false;
            }

            if (password.length < 6) {
                alert("비밀번호는 6자 이상이어야 합니다.");
                return false;
            }

            // 비밀번호 확인 검사
            if (confirmPassword === "") {
                alert("비밀번호 확인을 입력해주세요.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            // 이메일 유효성 검사
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("이메일 주소가 유효하지 않습니다.");
                return false;
            }

            // 전화번호 유효성 검사 (숫자만 입력 가능)
            const phoneRegex = /^[0-9]+$/;
            if (!phoneRegex.test(phone)) {
                alert("전화번호는 숫자만 입력할 수 있습니다.");
                return false;
            }

            // 모든 검사가 통과된 경우 성공 알림을 띄운다.
            alert("회원가입이 성공적으로 완료되었습니다.");
            return true; // 폼 제출을 허용
        }

        document.querySelector('form').addEventListener('submit', function(e) {
            if (!showAlert()) {
                e.preventDefault();  // 폼 제출 취소
            }
        });
    });
    function execDaumPostcode() {
        // Daum 주소 찾기 API 호출
        new daum.Postcode({
            oncomplete: function (data) {
                // 도로명 주소나 지번 주소 중 하나를 userAddress에 설정
                document.getElementById("userAddress").value = data.roadAddress || data.jibunAddress;
            }
        }).open();
    }

    // form이 제출되기 전 fullAddress에 값을 합쳐 넣는 함수
    function combineAddress() {
        const userAddress = document.getElementById("userAddress").value.trim();
        const detailAddress = document.getElementById("detailAddress").value.trim();

        // 숨겨진 필드에 합쳐진 주소를 설정
        const combined = `${userAddress} ${detailAddress}`.trim();
        document.getElementById("fullAddress").value = combined;

        // 콘솔 출력 추가
        console.log("Combined Address: " + combined);
    }


    document.querySelector("form").addEventListener("submit", function (event) {
        combineAddress(); // 주소 합치기
    });
</script>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
