<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />

<html>
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

        .baskeyDetail {
            border-collapse: collapse;
            border: 1px solid #000;
            width: 80%;
            /* 테이블 전체 너비 조절 */
        }

        .baskeyDetail th,
        .baskeyDetail td {
            padding: 10px;
            /* 셀 안의 패딩 조절 */
            border: 1px solid #000;
            text-align: center;
            vertical-align: middle;
        }

        .baskeyDetail th{
            background-color: rgb(227, 227, 227);
        }
        .baskeyDetail .selectBoxBaskey {
            width: 5%;
        }

        .baskeyDetail .imageBaskey {
            width: 10%;
        }
        .baskeyDetail .productBaskey {
            width: 40%;
        }
        .baskeyDetail .priceBaskey {
            width: 10%;
        }
        .baskeyDetail .quantityBaskey {
            width: 10%;
        }
        .baskeyDetail .allPriceBaskey {
            width: 12%;
        }
        .baskeyDetail .selectBaskey {
            width: 13%;
        }

        .baskeyDetail .leftProduct{
            text-align: left;
        }
        .baskeyDetail .rightPrice{
            text-align: right;
        }

        .baskeyDetail .rightAllPrice {
            text-align: right;
        }

        .selectProduct{
            width: 15%;
            margin-top: 20px;
            display: flex;
            justify-content: center;
            display: flex;
        }
        .deleteBaskey{
            margin-top: 20px;
            width: 55%;
            height: 30px;
            background-color: white;
            border: 1px solid rgb(233, 233, 233);
            margin-left: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }


        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            width: 25%;
        }

        .allOrderBy{
            background-color: black;
            color: white;
            border: 1px solid rgb(233, 233, 233);
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .selectOrderBy{
            background-color: white;
            border: 1px solid rgb(233, 233, 233);
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .button-container button {
            width: 40%;
            height: 40px;
            margin: 0 10px;
            /* 버튼 사이에 10px의 공간을 추가 */
            display: flex;
            align-items: center;
            justify-content: center;

        }

        .quantity-container {
            flex-direction: column;
            align-items: center;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
        }

        .quantity-controls input {
            width: 50px;
            text-align: center;
            margin-right: 5px;
        }

        .quantity-controls button {
            width: 30px;
            height: 30px;
        }

        .update-button {
            margin-top: 10px;
            width: 60px;
            height: 30px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="center-container">
    <h1>장바구니</h1>
    <table class="baskeyDetail">
        <tr>
            <th><input type="checkbox" onchange="toggleDeleteButton(this)"></th>
            <th>이미지</th>
            <th>상품정보</th>
            <th>판매가</th>
            <th>색상</th>
            <th>사이즈</th>
            <th>수량</th>
            <th>총금액</th>
            <th>선택</th>
        </tr>
        <!-- Sample Data Row (Replace with Dynamic Data) -->
        <tr>
            <td><input type="checkbox" class="choice"></td>
            <td><img src="/resources/img/sample.jpg" alt="상품 이미지" width="50"></td>
            <td class="leftProduct">상품명</td>
            <td class="rightPrice">10000원</td>
            <td>
                <select class="color-select" onchange="updateTotalPrice(this)">
                    <option value="Red">Red</option>
                    <option value="Blue">Blue</option>
                    <option value="Green">Green</option>
                </select>
            </td>
            <td>
                <select class="size-select" onchange="updateTotalPrice(this)">
                    <option value="S">S</option>
                    <option value="M">M</option>
                    <option value="L">L</option>
                </select>
            </td>
            <td>
                <div class="quantity-container">
                    <input type="number" value="1" min="1" class="quantity-input" onchange="updateTotalPrice(this)">
                    <button onclick="increaseQuantity(this)">+</button>
                    <button onclick="decreaseQuantity(this)">-</button>
                </div>
            </td>
            <td class="rightAllPrice">10000원</td>
            <td><button class="remove-button">삭제</button></td>
        </tr>
    </table>
    <div class="selectProduct">
        <h4>선택상품을</h4>
        <button class="deleteBaskey" onclick="deleteSelectedItems()" disabled>삭제하기</button>
    </div>
    <div class="button-container">
        <button class="allOrderBy">전체 주문</button>
        <button class="selectOrderBy">선택 주문</button>
    </div>
    <div class="statusMessage"></div>
</div>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    function toggleDeleteButton(checkbox) {
        const deleteButton = document.querySelector('.deleteBaskey');
        deleteButton.disabled = !checkbox.checked;
    }

    function deleteSelectedItems() {
        const selectedItems = document.querySelectorAll('.choice:checked');
        if (selectedItems.length > 0) {
            if (confirm('선택된 상품을 삭제하시겠습니까?')) {
                selectedItems.forEach(item => item.closest('tr').remove());
                alert('선택된 상품이 삭제되었습니다.');
            }
        } else {
            alert('선택된 항목이 없습니다.');
        }
    }

    function decreaseQuantity(button) {
        let input = button.previousElementSibling;
        if (input.value > 1) {
            input.value--;
            updateTotalPrice(input);
        }
    }

    function increaseQuantity(button) {
        let input = button.nextElementSibling;
        input.value++;
        updateTotalPrice(input);
    }

    function updateTotalPrice(element) {
        const row = element.closest('tr');
        const price = parseInt(row.querySelector('.rightPrice').textContent.replace('원', ''));
        const quantity = parseInt(row.querySelector('.quantity-input').value);
        const totalPriceCell = row.querySelector('.rightAllPrice');
        totalPriceCell.textContent = `${price * quantity}원`;
    }
</script>
</body>
</html>