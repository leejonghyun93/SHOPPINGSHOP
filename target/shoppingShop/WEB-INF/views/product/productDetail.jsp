<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId }"/>

<html lang="en">
<head>
    <title>상품 상세보기</title>
    <style>
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

        .container {
            display: flex;
            max-width: 1200px;
            width: 100%;
            margin-top: 50px;
            padding: 20px;
        }

        .product-image {
            flex: 1;
            padding-right: 20px;
        }

        .product-image img {
            width: 100%;
            max-width: 400px;
            border-radius: 8px;
        }

        .product-details {
            flex: 2;
            display: flex;
            flex-direction: column;
            border-bottom: 1px solid #ddd;
            padding: 0px 0px 20px 0px;
        }

        .productTitle {
            margin-top: 0px;
            margin-bottom: 10px;
            font-size: 28px;
        }

        .productPrice {
            font-size: 24px;
            color: #ff5733;
            margin-bottom: 20px;
        }

        .productDetail {
            font-size: 18px;
            margin-bottom: 5px;
            border-top: 1px solid gray;
            border-bottom: 1px solid gray;
            padding-top: 15px;
            padding-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .option-section {
            margin-bottom: 20px;
        }

        .option-label {
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
        }

        .option-buttons {
            display: flex;
            gap: 10px;
        }

        .option-button {
            padding: 10px 20px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .option-button:hover {
            background-color: #e0e0e0;
            border-color: #999;
        }

        .active {
            background-color: #007bff;
            color: white;
            border-color: #0056b3;
        }

        .disabled {
            pointer-events: none;
            opacity: 0.6;
        }

        .buy-button {
            display: inline-block;
            padding: 15px 30px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
            transition: background-color 0.3s;
        }

        .buy-button:hover {
            background-color: #0056b3;
        }

        .additional-info {
            display: none;
            list-style-type: none;
            margin-top: 0px;
            padding: 0;
            border-bottom: 1px solid gray;
        }

        .additional-info li {
            padding: 8px 0;
        }

        .productTitleImg {
            width: 300px;
            height: 400px;
            object-fit: cover;
        }

        #selectedProductInfo {
            display: none;
            margin-top: 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        #selectedProductInfo h3 {
            margin: 0;
            font-size: 20px;
        }

        #selectedProductInfo p {
            margin: 5px 0;
        }
    </style>
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="content">
    <div class="container">
        <div class="product-image">
            <img src="${pageContext.request.contextPath}/resources/img/shoes.JPG" class="productTitleImg" alt="상품 이미지">
        </div>

        <div class="product-details">
            <h1 class="productTitle">상품 이름 : ${productDetail.proName}</h1>
            <span class="productPrice">상품 가격 : ${productDetail.proPrice}원</span>

            <h5 class="productDetail">
                상품 정보
                <button id="toggleButton" class="toggle-btn">+</button>
            </h5>

            <ul class="additional-info" id="additionalInfo">
                <li>판매가: ${productDetail.totalPrice}원</li>
                <li>할인가: ${productDetail.proPrice}원</li>
                <li>배송비: ${productDetail.shippingFee}원</li>
            </ul>

            <div class="option-section">
                <span class="option-label">색상</span>
                <div class="option-buttons" id="colorOptions">
                    <c:forEach var="color" items="${productDetail.proColor.split(',')}">
                        <div class="option-button" data-value="${color}">${color}</div>
                    </c:forEach>
                </div>
            </div>

            <div class="option-section">
                <span class="option-label">사이즈</span>
                <div class="option-buttons disabled" id="sizeOptions">
                    <c:forEach var="size" items="${productDetail.proSize.split(',')}">
                        <div class="option-button" data-value="${size}">${size}</div>
                    </c:forEach>
                </div>
            </div>

            <div id="selectedProductInfo">
                <h3>선택한 상품 정보</h3>
                <div id="selectedItemsContainer"></div>

                <div style="display: flex; align-items: center;">
                    <p>색상: <span id="selectedColor"></span></p>
                    <p>사이즈: <span id="selectedSize"></span></p>

                    <div style="margin-left: 20px;">
                        <button id="decreaseQuantity" style="width: 30px;">-</button>
                        <span id="quantity" style="margin: 0 10px;">1</span>
                        <button id="increaseQuantity" style="width: 30px;">+</button>
                    </div>

                    <p style="margin-left: 20px;">총 가격: <span id="totalPrice"></span>원</p>

                    <button id="removeProduct" style="margin-left: 20px; color: red; background: none; border: none; font-size: 18px; cursor: pointer;">X</button>
                </div>
            </div>

            <a href="#" class="buy-button">구매하기</a>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    const colorButtons = document.querySelectorAll('#colorOptions .option-button');
    const sizeButtons = document.querySelectorAll('#sizeOptions .option-button');
    const sizeOptions = document.getElementById('sizeOptions');
    const selectedProductInfo = document.getElementById('selectedProductInfo');
    const selectedColorElement = document.getElementById('selectedColor');
    const selectedSizeElement = document.getElementById('selectedSize');

    let selectedColor = '';
    let selectedSize = '';

    colorButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedColor = button.getAttribute('data-value');
            colorButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            selectedColorElement.textContent = selectedColor;

            sizeOptions.classList.remove('disabled');
            sizeButtons.forEach(btn => {
                btn.classList.remove('active');
                btn.style.pointerEvents = 'auto';
            });

            selectedProductInfo.style.display = 'block';
        });
    });

    sizeButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedSize = button.getAttribute('data-value');
            sizeButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            selectedSizeElement.textContent = selectedSize;

            updateTotalPrice();
        });
    });

    document.getElementById('toggleButton').addEventListener('click', () => {
        const info = document.getElementById('additionalInfo');
        if (info.style.display === 'block') {
            info.style.display = 'none';
            document.getElementById('toggleButton').textContent = '+';
        } else {
            info.style.display = 'block';
            document.getElementById('toggleButton').textContent = '-';
        }
    });

    let quantity = 1;
    const quantityDisplay = document.getElementById('quantity');

    document.getElementById('increaseQuantity').addEventListener('click', () => {
        if (quantity < 10) {
            quantity++;
            quantityDisplay.textContent = quantity;
            updateTotalPrice();
        } else {
            alert('최대 10개까지 담을 수 있습니다.');
        }
    });

    document.getElementById('decreaseQuantity').addEventListener('click', () => {
        if (quantity > 1) {
            quantity--;
            quantityDisplay.textContent = quantity;
            updateTotalPrice();
        }
    });

    function updateTotalPrice() {
        const price = ${productDetail.proPrice};
        const totalPrice = price * quantity;
        document.getElementById('totalPrice').textContent = totalPrice.toLocaleString();
    }

    let selectedItems = []; // 선택된 상품을 저장할 배열

    document.getElementById('addProduct').addEventListener('click', () => {
        if (!selectedColor || !selectedSize) {
            alert('색상과 사이즈를 선택하세요.');
            return;
        }
        const cartCount = document.getElementById('cartCount').value;
        const newTotalCount = parseInt(cartCount) + quantity;

        if (newTotalCount > 10) {
            alert('최대 10개까지 담을 수 있습니다.');
            return;
        }

        // 선택한 상품 정보 추가
        const selectedItem = {
            color: selectedColor,
            size: selectedSize,
            quantity: quantity,
            totalPrice: (parseFloat(${productDetail.proPrice}) * quantity).toLocaleString()
        };
        selectedItems.push(selectedItem);
        updateSelectedItemsDisplay();

        alert(`"${selectedSize}" 사이즈의 "${selectedColor}" 색상의 상품이 ${quantity}개 추가되었습니다.`);
    });

    function updateSelectedItemsDisplay() {
        const container = document.getElementById('selectedItemsContainer');
        container.innerHTML = ''; // 기존 내용을 지우고 새로운 내용으로 업데이트

        selectedItems.forEach(item => {
            const itemDiv = document.createElement('div');
            itemDiv.innerHTML = `${item.size} 사이즈의 ${item.color} 색상: ${item.quantity}개 - 총 가격: ${item.totalPrice}원`;
            container.appendChild(itemDiv);
        });
    }

    document.getElementById('removeProduct').addEventListener('click', () => {
        selectedColor = '';
        selectedSize = '';
        selectedColorElement.textContent = '';
        selectedSizeElement.textContent = '';
        quantity = 1;
        quantityDisplay.textContent = quantity;
        colorButtons.forEach(btn => btn.classList.remove('active'));
        sizeButtons.forEach(btn => btn.classList.remove('active'));
        selectedProductInfo.style.display = 'none';
    });
</script>
</body>
</html>
