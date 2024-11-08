<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />

<html>
<head>
    <title>장바구니</title>
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

    function updateTotalPrice(input) {
        const row = input.closest('tr');
        const price = parseInt(row.querySelector('.rightPrice').textContent.replace('원', ''));
        const totalPriceCell = row.querySelector('.rightAllPrice');
        totalPriceCell.textContent = `${price * input.value}원`;
    }
</script>
</body>
</html>