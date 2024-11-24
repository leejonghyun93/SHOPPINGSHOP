<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />

<html lang="ko">
<head>
    <title>장바구니</title>
    <style>
        .center-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .basketDetail {
            border-collapse: collapse;
            border: 1px solid #000;
            width: 80%;
            margin-bottom: 20px;
        }

        .basketDetail th,
        .basketDetail td {
            padding: 10px;
            border: 1px solid #000;
            text-align: center;
            vertical-align: middle;
        }

        .basketDetail th {
            background-color: #e3e3e3;
        }

        .action-buttons {
            display: flex;
            justify-content: space-around;
        }

        .action-buttons button {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .action-buttons button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="center-container">
    <h1>장바구니</h1>
    <table class="basketDetail">
        <thead>
        <tr>
            <th>상품 이미지</th>
            <th>상품 이름</th>
            <th>색상</th>
            <th>사이즈</th>
            <th>수량</th>
            <th>총 가격</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody id="cartItems">
        <!-- 장바구니 항목은 JavaScript로 동적으로 추가 -->
        </tbody>
    </table>

    <div class="action-buttons">
        <button id="clearCart">장바구니 비우기</button>
        <button id="proceedToCheckout">결제하기</button>
    </div>
</div>

<script>
    const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
    const cartItemsContainer = document.getElementById('cartItems');

    function renderCartItems() {
        cartItemsContainer.innerHTML = '';
        cartItems.forEach((item, index) => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><img src="${item.image}" alt="상품 이미지" style="width: 80px; height: 80px; object-fit: cover;"></td>
                <td>${item.name}</td>
                <td>${item.color}</td>
                <td>${item.size}</td>
                <td>${item.quantity}</td>
                <td>${item.totalPrice.toLocaleString()}원</td>
                <td><button onclick="removeItem(${index})" style="color: red; border: none; background: none; cursor: pointer;">X</button></td>
            `;
            cartItemsContainer.appendChild(row);
        });
    }

    function removeItem(index) {
        cartItems.splice(index, 1);
        localStorage.setItem('cartItems', JSON.stringify(cartItems));
        renderCartItems();
    }

    document.getElementById('clearCart').addEventListener('click', () => {
        if (confirm('장바구니를 비우시겠습니까?')) {
            localStorage.removeItem('cartItems');
            renderCartItems();
        }
    });

    document.getElementById('proceedToCheckout').addEventListener('click', () => {
        if (cartItems.length > 0) {
            alert('결제 페이지로 이동합니다.');
            window.location.href = '/checkout';
        } else {
            alert('장바구니에 상품이 없습니다.');
        }
    });

    renderCartItems();
</script>
</body>
</html>
