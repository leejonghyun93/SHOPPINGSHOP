<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />

<html lang="ko">
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
            margin-bottom: 10px;
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
                        <div class="option-button color-button" data-value="${color}">${color}</div>
                    </c:forEach>
                </div>
            </div>

            <div class="option-section">
                <span class="option-label">사이즈</span>
                <div class="option-buttons disabled" id="sizeOptions">
                    <c:forEach var="size" items="${productDetail.proSize.split(',')}">
                        <div class="option-button size-button" data-value="${size}">${size}</div>
                    </c:forEach>
                </div>
            </div>

            <div id="selectedProductInfo">
                <h3>선택한 상품 정보</h3>
                <div style="display: flex; align-items: center;">
                    <p>색상: <span id="selectedColor"></span></p>
                    <p>사이즈: <span id="selectedSize"></span></p>
                    <div style="margin-left: 20px;">
                        <button id="decreaseQuantity" style="width: 30px;">-</button>
                        <span id="quantity" style="margin: 0 10px;">1</span>
                        <button id="increaseQuantity" style="width: 30px;">+</button>
                    </div>
                    <p style="margin-left: 20px;">총 가격: <span id="totalPrice"></span>원</p>
                    <button id="removeProduct"
                            style="margin-left: 20px; color: red; background: none; border: none; font-size: 18px; cursor: pointer;">
                        X
                    </button>
                </div>
            </div>

            <a href="#" class="buy-button" onclick="moveToCart()">구매하기</a>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    const colorButtons = document.querySelectorAll('.color-button');
    const sizeButtons = document.querySelectorAll('.size-button');
    const selectedColorElement = document.getElementById('selectedColor');
    const selectedSizeElement = document.getElementById('selectedSize');
    const selectedProductInfo = document.getElementById('selectedProductInfo');
    let selectedColor = '';
    let selectedSize = '';
    let quantity = 1;
    const pricePerItem = 58000; // 상품 기본 가격

    // 색상 선택 로직
    colorButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedColor = button.getAttribute('data-value');
            selectedColorElement.innerText = selectedColor;

            // 사이즈 버튼 활성화
            document.getElementById('sizeOptions').classList.remove('disabled');
            sizeButtons.forEach(sizeButton => sizeButton.classList.remove('disabled'));

            // 선택한 색상 강조
            colorButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
        });
    });

    // 사이즈 선택 로직
    sizeButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedSize = button.getAttribute('data-value');
            selectedSizeElement.innerText = selectedSize;

            // 선택한 사이즈 강조
            sizeButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            // 상품 정보 표시
            if (selectedColor && selectedSize) {
                selectedProductInfo.style.display = 'block';
                updateTotalPrice();
            } else {
                alert('색상과 사이즈를 모두 선택해 주세요.');
            }
        });
    });

    // 수량 조정
    document.getElementById('increaseQuantity').addEventListener('click', () => {
        quantity++;
        updateTotalPrice();
    });

    document.getElementById('decreaseQuantity').addEventListener('click', () => {
        if (quantity > 1) {
            quantity--;
            updateTotalPrice();
        }
    });

    // 상품 제거
    document.getElementById('removeProduct').addEventListener('click', () => {
        resetSelection();
    });

    function updateTotalPrice() {
        document.getElementById('quantity').innerText = quantity;
        document.getElementById('totalPrice').innerText = pricePerItem * quantity;
    }

    function resetSelection() {
        selectedProductInfo.style.display = 'none';
        selectedColor = '';
        selectedSize = '';
        quantity = 1;
        selectedColorElement.innerText = '';
        selectedSizeElement.innerText = '';
        document.getElementById('quantity').innerText = 1;
        document.getElementById('totalPrice').innerText = pricePerItem;
        colorButtons.forEach(btn => btn.classList.remove('active'));
        sizeButtons.forEach(btn => btn.classList.remove('active'));
    }

    // 상세정보 토글
    document.getElementById('toggleButton').addEventListener('click', () => {
        const additionalInfo = document.getElementById('additionalInfo');
        const isVisible = additionalInfo.style.display === 'block';
        additionalInfo.style.display = isVisible ? 'none' : 'block';
        document.getElementById('toggleButton').innerText = isVisible ? '+' : '-';
    });

    // 장바구니 추가
    function addToCart(productId) {
        if (!selectedColor || !selectedSize) {
            alert('색상과 사이즈를 모두 선택해주세요.');
            return;
        }

        const cartDto = {
            userId: "${sessionScope.userId}",
            proId: productId,
            cartCount: quantity,
            totalPrice: pricePerItem * quantity,
            color: selectedColor,
            size: selectedSize
        };

        fetch('/cart/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(cartDto)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('상품이 장바구니에 추가되었습니다.');
                    window.location.href = '/cart';
                } else {
                    alert('장바구니 추가 실패: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('서버 오류가 발생했습니다.');
            });
    }

    // 장바구니 페이지로 이동
    function moveToCart() {
        if (!selectedColor || !selectedSize) {
            alert('상품 옵션(색상, 사이즈)을 먼저 선택해주세요!');
            return;
        }
        alert("장바구니로 이동합니다.");
        window.location.href = '/cart';
    }
</script>


</body>
</html>
