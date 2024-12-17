<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />
<html>
<head>
    <title>로그인</title>
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
            align-items: center;
        }

        .form-container {
            max-width: 400px;
            text-align: center;
        }

        h1 {
            margin-bottom: 20px;
            font-size: 24px;
            text-align: center;
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            text-align: left;
        }

        input[type="text"], input[type="email"], button {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border: none;
        }

        button:hover {
            background-color: #45a049;
        }

        .message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="content">
    <div class="form-container">
        <h1>아이디 찾기</h1>
        <form action="findId" method="post">
            <label for="userName">이름</label>
            <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요" required>

            <label for="userEmail">이메일</label>
            <input type="email" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요" required>

            <button type="submit">아이디 찾기</button>
        </form>

        <c:if test="${not empty foundId}">
            <div class="message">
                <p>찾으신 아이디는: <strong>${foundId}</strong> 입니다.</p>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="message">
                <p>${errorMessage}</p>
            </div>
        </c:if>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
