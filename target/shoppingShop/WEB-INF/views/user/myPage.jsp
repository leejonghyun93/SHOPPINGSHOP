<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />
<html>
<head>
    <title>마이페이지</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        /* 기본 설정 */
        .content {
            width: 100%;
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px 20px;
            box-sizing: border-box;
            background-color: #f5f5f5;
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #333;
        }

        /* 전체 레이아웃 */
        /*.container {*/
        /*    display: flex;*/
        /*    gap: 30px;*/
        /*    max-width: 1200px;*/
        /*    margin: 0 auto;*/
        /*}*/

        .container {
            display: flex;
            gap: 30px;
            width: 100%;  /* 너비를 100%로 설정 */
            padding: 0 20px;  /* 여백 추가 */
            box-sizing: border-box;
        }

        /* 왼쪽 레이어 */
        .left-layer {
            width: 30%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* 오른쪽 레이어 */
        .right-layer {
            width: 70%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* 메뉴 항목 스타일 (오른쪽 레이어) */
        .right-layer .menu-item {
            margin-bottom: 20px;
            text-align: center;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fafafa;
            transition: all 0.3s ease;
        }

        .right-layer .menu-item a {
            text-decoration: none;
            color: #333;
            font-size: 16px;
            font-weight: 500;
            display: block;
        }

        .right-layer .menu-item:hover {
            background-color: #007bff;
            border-color: #007bff;
        }

        .right-layer .menu-item:hover a {
            color: #fff;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="content">
    <!-- 마이페이지 제목 -->
    <h1 class="page-title">마이페이지</h1>

    <div class="container">
        <!-- 왼쪽 레이어 -->
        <div class="left-layer">
            <p>왼쪽 레이어입니다. 필요한 내용을 추가하세요.</p>
        </div>

        <!-- 오른쪽 레이어 -->
        <div class="right-layer">
            <div class="menu-item">
                <a href="<c:url value='/orders/list'/>">주문내역</a>
            </div>
            <div class="menu-item">
                <a href="<c:url value='/membership/edit'/>">회원정보 수정</a>
            </div>
            <div class="menu-item">
                <a href="<c:url value='/board/list'/>">게시판</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
