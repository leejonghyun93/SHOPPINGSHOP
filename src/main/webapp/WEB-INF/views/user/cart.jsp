<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}"/>
<html>
<head>
    <title>장바구니</title>
    <style>
        /* 기존 스타일 유지 */
        body {
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
            flex-direction: column;
            width: 80%;
            margin: 0 auto;
        }

        /* 장바구니 테이블 스타일 */
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #f9f9f9; /* 배경색 추가 */
            border-radius: 8px; /* 테이블 모서리 둥글게 */
            overflow: hidden; /* 테두리 둥글게 유지 */
        }

        .cart-table th, .cart-table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 12px 15px; /* 셀 간격 늘려서 여유롭게 */
            font-size: 14px; /* 텍스트 크기 조정 */
            background-color: #fff; /* 셀 배경색 */
        }

        .cart-table th {
            background-color: #007bff; /* 헤더 배경색 */
            color: white; /* 텍스트 색 */
            font-weight: bold;
        }

        .cart-table tbody tr:hover {
            background-color: #f1f1f1; /* 마우스 오버 시 행 배경색 */
        }

        .cart-table td {
            color: #555; /* 테이블 데이터 색상 */
        }

        .cart-table .delete-button {
            background-color: #e74c3c; /* 삭제 버튼 배경색 */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            padding: 8px 12px;
            transition: background-color 0.3s ease;
        }

        .cart-table .delete-button:hover {
            background-color: #c0392b; /* 삭제 버튼 호버 효과 */
        }

        /* 제목 위치 조정 */
        h1 {
            text-align: left;
            margin-left: 0;
            font-size: 24px;
            color: #333;
        }

        /* 버튼 스타일링 */
        form button {
            padding: 12px 18px;
            background-color: #28a745; /* 기본 버튼 색상 */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 16px;
            width: 200px;
            margin-top: 20px;
        }

        form button:hover {
            background-color: #218838; /* 호버 시 색상 */
            transform: scale(1.05); /* 호버 시 버튼 크기 커지기 */
        }

        form button:active {
            transform: scale(1); /* 클릭 시 버튼 크기 원래대로 */
        }

        /* 장바구니 비우기, 결제하기 버튼 */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .action-buttons button {
            width: auto;
        }

        form button:last-child {
            background-color: #007bff;
        }

        form button:last-child:hover {
            background-color: #0056b3; /* 결제하기 버튼 호버 색상 */
        }

    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" />
<div class="content">
    <!-- 상품 상세 -->
    <h1>장바구니</h1>
    <table class="cart-table">
        <thead>
        <tr>
            <th>상품명</th>
            <th>색상</th>
            <th>사이즈</th>
            <th>수량</th>
            <th>가격</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cartItem" items="${cartItems}">
            <tr>
                <td>${cartItem.proName}</td>
                <td>${cartItem.proColor}</td>
                <td>${cartItem.proSize}</td>
                <td>${cartItem.quantity}</td>
                <td>${cartItem.totalPrice}</td>
                <td>
                    <form action="/cart/delete/${cartItem.cartId}" method="post">
                        <button type="submit" class="delete-button">삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="action-buttons">
        <form action="/clearCart" method="post">
            <button type="submit">장바구니 비우기</button>
        </form>
        <form action="/checkout" method="post">
            <button type="submit">결제하기</button>
        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer/footer.jsp" />
</body>
</html>
