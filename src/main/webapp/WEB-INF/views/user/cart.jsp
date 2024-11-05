<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId }"/>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="center-container">
    <h1>장바구니</h1>
    <table class="baskeyDetail">
        <tr>
            <th class="selectBoxBaskey"><input type="checkbox" onchange="toggleDeleteButton(this)"></th>
            <th class="imageBaskey">이미지</th>
            <th class="productBaskey">상품정보</th>
            <th class="priceBaskey">판매가</th>
            <th class="quantityBaskey">수량</th>
            <th class="allPriceBaskey">총금액</th>
            <th class="selectBaskey">선택</th>
        </tr>
        <tr>
            <td><input type="checkbox" class="choice"></td>
            <td>1</td>
            <td class="leftProduct">2</td>
            <td class="rightPrice">3</td>
            <td>
                <div class="quantity-container">
                    <div class="quantity-controls">
                        <input type="number" value="1" min="1">
                        <button onclick="increaseQuantity(this)">+</button>
                        <button onclick="decreaseQuantity(this)">-</button>
                    </div>
                    <button class="update-button" onclick="updateQuantity(this)">변경</button>
                </div>
            </td>
            <td class="rightAllPrice">5</td>
            <td>6</td>
        </tr>
    </table>
    <div class="selectProduct">
        <h4>선택상품을</h4>
        <button class="deleteBaskey" onclick="deleteSelectedItems()">삭제하기</button>
    </div>
    <div class="button-container">
        <button class="allOrderBy">전체 주문</button>
        <button class="selectOrderBy">선택 주문</button>
    </div>
    <div class="statusMessage"></div>
</div>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>

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
    }

    .baskeyDetail th,
    .baskeyDetail td {
        padding: 10px;
        border: 1px solid #000;
        text-align: center;
        vertical-align: middle;
    }

    .baskeyDetail th {
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

    .baskeyDetail .leftProduct {
        text-align: left;
    }
    .baskeyDetail .rightPrice {
        text-align: right;
    }

    .baskeyDetail .rightAllPrice {
        text-align: right;
    }

    .selectProduct {
        width: 15%;
        margin-top: 20px;
        display: flex;
        justify-content: center;
    }

    .deleteBaskey {
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

    .allOrderBy {
        background-color: black;
        color: white;
        border: 1px solid rgb(233, 233, 233);
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
    }

    .selectOrderBy {
        background-color: white;
        border: 1px solid rgb(233, 233, 233);
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
    }

    .button-container button {
        width: 40%;
        height: 40px;
        margin: 0 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .quantity-container {
        display: flex;
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

<script>
    function toggleDeleteButton(checkbox) {
        const deleteButton = document.querySelector('.deleteBaskey');
        const statusMessage = document.querySelector('.statusMessage');
        if (checkbox.checked) {
            deleteButton.classList.add('active');
            deleteButton.removeAttribute('disabled');
        } else {
            deleteButton.classList.remove('active');
            deleteButton.setAttribute('disabled', true);
        }
    }

    function deleteSelectedItems() {
        const choiceCheckboxes = document.querySelectorAll('.choice');
        let hasChecked = false;

        choiceCheckboxes.forEach(checkbox => {
            if (checkbox.checked) {
                hasChecked = true;
            }
        });

        if (hasChecked) {
            if (confirm('선택된 상품을 삭제하시겠습니까?')) {
                alert('선택된 상품이 삭제되었습니다.');
                // 여기에 선택된 상품을 삭제하는 로직을 추가할 수 있습니다.
            }
        } else {
            alert('선택된 항목이 없습니다.');
        }
    }

    function decreaseQuantity(button) {
        let input = button.previousElementSibling.previousElementSibling;
        if (input.value > 1) {
            input.value = parseInt(input.value) - 1;
        }
    }

    function increaseQuantity(button) {
        let input = button.previousElementSibling;
        input.value = parseInt(input.value) + 1;
    }

    function updateQuantity(button) {
        let input = button.previousElementSibling.querySelector('input');
        alert('변경된 수량: ' + input.value);
        // 여기서 변경된 수량을 서버로 전송하거나 다른 로직을 추가할 수 있습니다.
    }
</script>