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

<div class="content">
    <div class="register-container">
        <h2>회원가입</h2>
        <form action="<c:url value='/membership/registerSubmit' />" method="post" onsubmit="return showAlert()" id="registerForm" >
            <div class="form-group">
                <label for="userId">아이디</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="userId" name="userId" required placeholder="아이디를 입력하세요" style="flex: 3;">
                    <button type="button" id="checkIdButton" style="flex: 1; background-color: #4CAF50; color: white; border: none; padding: 8px; border-radius: 4px; cursor: pointer;">중복 확인</button>
                </div>
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
    // 문서가 완전히 로드된 후 실행
    document.addEventListener('DOMContentLoaded', function () {

        // 회원가입 폼 유효성 검사 함수
        function showAlert() {
            combineAddress(); // 주소 합치기 함수 호출

            // 입력된 값들을 가져와 공백을 제거한 후 저장
            const username = document.getElementById('userId').value.trim();
            const password = document.getElementById('userPwd').value.trim();
            const confirmPassword = document.getElementById('confirmPwd').value.trim();
            const email = document.getElementById('userEmail').value.trim();
            const phone = document.getElementById('userPhone').value.trim();
            const userAddress = document.getElementById('userAddress').value.trim();
            const detailAddress = document.getElementById('detailAddress').value.trim();

            // 아이디 입력 확인
            if (username === "") {
                alert("아이디를 입력해주세요.");
                return false;
            }

            // 비밀번호 입력 확인
            if (password === "") {
                alert("비밀번호를 입력해주세요.");
                return false;
            }

            // 비밀번호 최소 길이 검사
            if (password.length < 6) {
                alert("비밀번호는 6자 이상이어야 합니다.");
                return false;
            }

            // 비밀번호 확인 입력 확인
            if (confirmPassword === "") {
                alert("비밀번호 확인을 입력해주세요.");
                return false;
            }

            // 주소 입력 확인
            if (userAddress === "") {
                alert("주소를 입력해주세요.");
                return false;
            }

            // 상세 주소 입력 확인
            if (detailAddress === "") {
                alert("상세주소를 입력해주세요.");
                return false;
            }

            // 비밀번호 일치 여부 확인
            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            // 이메일 형식 유효성 검사
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("이메일 주소가 유효하지 않습니다.");
                return false;
            }

            // 전화번호 형식 유효성 검사 (숫자만 입력 가능)
            const phoneRegex = /^[0-9]+$/;
            if (!phoneRegex.test(phone)) {
                alert("전화번호는 숫자만 입력할 수 있습니다.");
                return false;
            }

            // 모든 검사 통과 시 회원가입 성공 메시지 출력
            alert("회원가입이 성공적으로 완료되었습니다.");
            return true; // 폼 제출 허용
        }

        // 회원가입 폼 제출 시 실행되는 이벤트 리스너
        document.getElementById('registerForm').addEventListener('submit', function (e) {
            combineAddress(); // 주소 합치기 함수 호출
            if (!showAlert()) {
                e.preventDefault(); // 유효성 검사 실패 시 폼 제출 방지
            }
        });

        // 아이디 중복 확인 버튼 클릭 시 실행되는 이벤트 리스너
        document.getElementById('checkIdButton').addEventListener('click', function () {
            const userId = document.getElementById('userId').value.trim();

            // 아이디 입력 확인
            if (userId === "") {
                alert("아이디를 입력해주세요.");
                return;
            }

            // AJAX 요청을 이용한 아이디 중복 확인
            fetch('/membership/checkUserId', {
                method: 'POST', // HTTP 요청 방식
                headers: {
                    'Content-Type': 'application/json', // JSON 형식의 데이터 전송
                },
                body: JSON.stringify({ userId: userId }), // 서버로 보낼 데이터
            })
                .then(response => response.json()) // 응답을 JSON 형태로 변환
                .then(data => {
                    if (data.available) {
                        alert("사용 가능한 아이디입니다.");
                    } else {
                        alert("이미 사용 중인 아이디입니다.");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("아이디 중복 확인 중 오류가 발생했습니다.");
                });
        });
    });

    // Daum 주소 찾기 API 실행 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) { // 주소 검색이 완료되었을 때 실행되는 콜백 함수
                // 도로명 주소 또는 지번 주소 중 하나를 userAddress 입력 필드에 설정
                document.getElementById("userAddress").value = data.roadAddress || data.jibunAddress;
                combineAddress(); // 주소 합치기 함수 호출
            }
        }).open(); // 주소 검색창 열기
    }

    // 기본 주소와 상세 주소를 결합하여 fullAddress 입력 필드에 저장하는 함수
    function combineAddress() {
        const userAddress = document.getElementById("userAddress").value.trim(); // 기본 주소 가져오기
        const detailAddress = document.getElementById("detailAddress").value.trim(); // 상세 주소 가져오기

        if (userAddress && detailAddress) { // 두 입력값이 모두 존재하는 경우
            const combined = `${userAddress} ${detailAddress}`.trim(); // 주소 결합 후 공백 제거
            document.getElementById("fullAddress").value = combined; // fullAddress 필드에 설정
        } else {
            document.getElementById("fullAddress").value = ''; // 입력값이 없을 경우 비우기
        }
    }


</script>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
