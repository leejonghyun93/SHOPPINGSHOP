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

        .login-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 300px;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }

        .login-h1 {
            margin-bottom: 20px;
        }

        .userLogin {
            font-size: 18px;
            color: #333;
            text-align: left;
            width: 100%;
            padding-bottom: 15px;
            border-bottom: 1px solid black;
        }

        .loginId, .loginPwd {
            width: 100%;
            margin-bottom: 15px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .loginButton {
            width: 100%;
            padding: 10px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 20px;
        }

        .loginButton:hover {
            background-color: #0056b3;
        }

        .membership {
            border-top: 1px solid rgb(162, 162, 162);
            list-style-type: none;
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
        }

        .membership li {
            margin: 0 5px;
            padding-top: 20px;
        }

        .membership li:not(:last-child)::after {
            content: "|";
            margin-left: 5px;
            color: #333;
        }

        .membership li a {
            color: #333;
            text-decoration: none;
        }

        .membership li a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%--<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>--%>
<!-- 메인 콘텐츠 영역 시작 -->
<div class="content">
    <!-- 로그인 컨테이너 -->
    <div class="login-container">
        <!-- 로그인 페이지 제목 -->
        <h1 class="login-h1">로그인</h1>
        <h4 class="userLogin">회원로그인</h4>

        <!-- 로그인 실패 시 오류 메시지를 표시 -->
        <% if (request.getAttribute("error") != null) { %>
        <div style="color: red; margin-bottom: 10px;">
            <%= request.getAttribute("error") %> <!-- 서버에서 전달된 오류 메시지를 출력 -->
        </div>
        <% } %>

        <!-- 로그인 폼 시작 -->
        <form action="${pageContext.request.contextPath}/login/login" method="post">
            <!-- 사용자 아이디 입력 필드 -->
            <input class="loginId" type="text" name="userId" placeholder="아이디" required>
            <!-- 사용자 비밀번호 입력 필드 -->
            <input class="loginPwd" type="password" name="userPwd" placeholder="비밀번호" required>
            <!-- 로그인 버튼 -->
            <button type="submit" class="loginButton">로그인</button>
        </form>
        <!-- 로그인 폼 끝 -->

        <!-- 회원 관련 링크 목록 -->
        <ul class="membership">
            <li><a href="/membership/register">회원가입</a></li> <!-- 회원가입 페이지 이동 링크 -->
            <li><a href="/membership/findId">아이디 찾기</a></li> <!-- 아이디 찾기 페이지 이동 링크 -->
            <li><a href="/membership/findPassword">비밀번호 찾기</a></li> <!-- 비밀번호 찾기 페이지 이동 링크 -->
        </ul>
    </div>
</div>
<!-- 메인 콘텐츠 영역 끝 -->

<!-- 푸터 포함 -->
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<!-- 로그인 상태를 브라우저 세션에 저장하는 스크립트 -->
<script>
    window.onload = function() {
        let userId = "${userId}"; // 서버에서 전달된 userId를 JSP 표현식으로 받아옴
        if (userId) {
            sessionStorage.setItem('userId', userId); // sessionStorage에 userId 저장
            console.log('Logged in as:', userId); // 콘솔에 로그인된 아이디 출력
        } else {
            console.log('Not logged in'); // 로그인되지 않은 경우 콘솔에 출력
        }
    };
</script>


</body>
</html>