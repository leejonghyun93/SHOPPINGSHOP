<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">
<head>
    <title>장바구니</title>
    <style>
        /* 스타일링 */
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
        }

        .product-container, .cart-container {
            margin-bottom: 40px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            text-align: center;
        }

        .product-image img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }

        .product-details, .cart-details {
            margin-top: 20px;
        }

        .option-section {
            margin-top: 20px;
        }

        .option-buttons {
            display: flex;
            gap: 10px;
        }

        .option-button {
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            background-color: #f9f9f9;
            transition: background-color 0.3s;
        }

        .option-button:hover {
            background-color: #e0e0e0;
        }

        .option-button.active {
            background-color: #007bff;
            color: white;
        }

        .buy-button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .cart-table th, .cart-table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }

        .cart-table th {
            background-color: #f2f2f2;
        }

        .action-buttons {
            margin-top: 20px;
        }

        .action-buttons button {
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
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
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.proName}</td>
                <td>${item.proColor}</td>
                <td>${item.proSize}</td>
                <td>${item.quantity}</td>
                <td>${item.totalPrice}</td>
                <td>
                    <form action="/cart/delete/${item.cartId}" method="post">
                        <button type="submit">삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <form action="/clearCart" method="post">
        <button type="submit">장바구니 비우기</button>
    </form>
    <form action="/checkout" method="post">
        <button type="submit">결제하기</button>
    </form>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
