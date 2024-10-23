<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

        /* 메인 컨텐츠 영역 */
        .content {
            flex: 1; /* 남은 공간을 채워 화면 하단에 푸터를 위치시킴 */
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
            flex-direction: column; /* 요소를 수직으로 배치 */
            align-items: center; /* 수평 중앙 정렬 */
            width: 300px; /* 로그인 박스 너비 설정 */
            background: white; /* 배경색 */
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
            margin-bottom: 15px; /* 입력 필드 간격 */
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* 패딩과 너비 포함 설정 */
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
            list-style-type: none; /* 점 제거 */
            display: flex; /* 가로로 나열 */
            justify-content: center; /* 가운데 정렬 */
            padding: 0; /* 기본 패딩 제거 */
            margin: 0; /* 기본 마진 제거 */
        }

        .membership li {
            margin: 0 5px; /* 링크 사이 간격 */
            padding-top: 20px;
        }

        .membership li:not(:last-child)::after {
            content: "|"; /* 링크 사이에 막대 추가 */
            margin-left: 5px; /* 막대와 글자 사이 간격 */
            color: #333; /* 막대 색상 */
        }

        .membership li a {
            color: #333;
            text-decoration: none; /* 밑줄 제거 */
        }

        .membership li a:hover {
            text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<div class="content">
    <div class="login-container">
        <h1 class="login-h1">로그인</h1>
        <h4 class="userLogin">회원로그인</h4>

        <% if (request.getAttribute("error") != null) { %>
        <div style="color: red; margin-bottom: 10px;">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login/login" method="post">
            <input class="loginId" type="text" name="userId" placeholder="아이디" required>
            <input class="loginPwd" type="password" name="userPwd" placeholder="비밀번호" required>
            <button type="submit" class="loginButton">로그인</button>
        </form>

        <ul class="membership">
            <li><a href="#">회원가입</a></li>
            <li><a href="#">아이디 찾기</a></li>
            <li><a href="#">비밀번호 찾기</a></li>
        </ul>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>

</html>
