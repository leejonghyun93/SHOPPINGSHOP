<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}" />
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />

<html>
<head>
    <title>회원 수정</title>
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
            align-items: flex-start;
            padding-bottom: 50px;
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
        <h2>회원 수정</h2>
        <form action="<c:url value='/membership/updateSubmit' />" method="post" id="updateForm">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" value="${user.userId}" readonly>
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
                <input type="text" id="userName" name="userName" value="${user.userName}" required>
            </div>
            <div class="form-group">
                <label for="userAddress">주소</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="userAddress" name="userAddress" value="${user.userAddress}" readonly>
                    <button type="button" onclick="execDaumPostcode()">주소 찾기</button>
                </div>
            </div>
            <div class="form-group">
                <label for="detailAddress">나머지 주소</label>
                <input type="text" id="detailAddress" name="detailAddress" value="${user.detailAddress}">
            </div>
            <input type="hidden" id="fullAddress" name="fullAddress">
            <div class="form-group">
                <label for="userPhone">전화번호</label>
                <input type="number" id="userPhone" name="userPhone" value="${user.userPhone}" required>
            </div>
            <div class="form-group">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" value="${user.userEmail}" required>
            </div>
            <button type="submit" class="register-button">회원 수정</button>
        </form>
        <div class="login-link">
            <p>변경을 취소하려면 <a href="<c:url value='/profile' />">프로필 페이지</a>로 돌아가세요.</p>
        </div>
    </div>
</div>

<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                document.getElementById("userAddress").value = data.roadAddress || data.jibunAddress;
                combineAddress();
            }
        }).open();
    }
    function combineAddress() {
        const userAddress = document.getElementById("userAddress").value.trim();
        const detailAddress = document.getElementById("detailAddress").value.trim();
        document.getElementById("fullAddress").value = `${userAddress} ${detailAddress}`.trim();
    }
</script>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
