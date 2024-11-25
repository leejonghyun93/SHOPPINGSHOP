<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            width: 80%;
            margin-bottom: 20px;
        }

        .basketDetail th,
        .basketDetail td {
            padding: 10px;
            border: 1px solid #000;
            text-align: center;
        }

        .basketDetail th {
            background-color: #f2f2f2;
        }

        .action-buttons button {
            padding: 10px 20px;
            margin: 5px;
        }
    </style>
</head>
<body>
<div class="center-container">
    <h1>장바구니</h1>
    <table class="basketDetail">
        <thead>
        <tr>
            <th>이미지</th>
            <th>상품명</th>
            <th>색상</th>
            <th>사이즈</th>
            <th>수량</th>
            <th>가격</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody id="cartItems"></tbody>
    </table>
    <div class="action-buttons">
        <button id="clearCart">장바구니 비우기</button>
        <button id="checkout">결제하기</button>
    </div>
</div>

<script>
    const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];
    const cartItemsContainer = document.getElementById('cartItems');

    function renderCartItems() {
        cartItemsContainer.innerHTML = cartItems.map((item, index) => `
            <tr>
                <td><img src="${item.image}" alt="상품 이미지" style="width: 80px;"></td>
                <td>${item.name}</td>
                <td>${item.color}</td>
                <td>${item.size}</td>
                <td>${item.quantity}</td>
                <td>${(item.quantity * item.price).toLocaleString()}원</td>
                <td><button onclick="removeItem(${index})">X</button></td>
            </tr>
        `).join('');
    }

    function removeItem(index) {
        cartItems.splice(index, 1);
        localStorage.setItem('cartItems', JSON.stringify(cartItems));
        renderCartItems();
    }

    document.getElementById('clearCart').addEventListener('click', () => {
        if (confirm('정말로 장바구니를 비우시겠습니까?')) {
            localStorage.removeItem('cartItems');
            renderCartItems();
        }
    });

    document.getElementById('checkout').addEventListener('click', () => {
        if (cartItems.length === 0) {
            alert('장바구니에 상품이 없습니다.');
        } else {
            alert('결제 페이지로 이동합니다.');
            window.location.href = '/checkout';
        }
    });

    renderCartItems();
</script>
</body>
</html>
