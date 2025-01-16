<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />
<html>
<head>
    <title>주문 완료</title>
    <style>
        body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            font-family: Arial, sans-serif;
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            padding: 20px;
        }

        h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            color: #555;
            margin: 10px 0;
        }

        .action-buttons {
            margin-top: 30px;
            display: flex;
            justify-content: center; /* 버튼을 가로로 가운데 배치 */
            width: 100%; /* 부모 컨테이너의 전체 너비 사용 */
        }

        .action-buttons button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .action-buttons button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="content">
    <h1>주문이 완료되었습니다!</h1>
    <p>주문 내역은 마이페이지에서 확인하세요.</p>
    </div>
    <div class="action-buttons">
        <button onclick="location.href='/'">홈으로</button>
    </div>
</div>


<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
