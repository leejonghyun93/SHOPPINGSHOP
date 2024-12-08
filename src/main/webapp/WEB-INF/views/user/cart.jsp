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

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            overflow: hidden;
        }

        .cart-table th, .cart-table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 12px 15px;
            font-size: 14px;
            background-color: #fff;
        }

        .cart-table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .cart-table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .cart-table td {
            color: #555;
        }

        h1 {
            text-align: left;
            margin-left: 0;
            font-size: 24px;
            color: #333;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .action-buttons button {
            padding: 12px 18px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: auto;
        }

        .action-buttons button:last-child {
            background-color: #007bff;
        }

        .action-buttons button:hover {
            transform: scale(1.05);
        }

        .action-buttons button:last-child:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function submitSelected() {
            const form = document.getElementById('checkoutForm');
            const checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');

            if (checkboxes.length === 0) {
                alert('결제할 상품을 선택하세요.');
                return;
            }

            checkboxes.forEach(checkbox => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'cartIds';
                input.value = checkbox.value;
                form.appendChild(input);
            });

            form.submit();
        }
    </script>
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
            <th>선택</th>
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
                <td><input type="checkbox" name="selectedItems" value="${cartItem.cartId}"></td>
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
        <form id="checkoutForm" action="/orders/checkout" method="post">
            <button type="button" onclick="submitSelected()">선택상품 주문</button>
        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer/footer.jsp" />
</body>
</html>
