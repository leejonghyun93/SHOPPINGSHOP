<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!-- 세션 사용 설정 -->

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId }"/>

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
            align-items: flex-start; /* 컨텐츠가 푸터와 겹치지 않도록 수정 */
            padding-bottom: 50px; /* 푸터와 겹치지 않도록 하단에 공간 추가 */
        }

        .container {
            display: flex;
            max-width: 1200px;
            width: 100%;
            margin-top: 50px;
            padding: 20px;
        }

        /* 상품 이미지 */
        .product-image {
            flex: 1;
            padding-right: 20px;
        }

        .product-image img {
            width: 100%;
            max-width: 400px;
            border-radius: 8px;
        }

        /* 상품 정보 */
        .product-details {
            flex: 2;
            display: flex;
            flex-direction: column;
            border-bottom: 1px solid #ddd;
            padding: 0px 0px 20px 0px;
        }

        .productTitle {
            margin-top: 0px;
            margin-bottom: 0px;
            font-size: 28px;
            margin-bottom: 10px;
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

        /* 선택 버튼 */
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

        /* 구매 버튼 */
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

        /* 추가 정보 리스트 */
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

        /* 선택한 정보 표시 */
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
        <!-- 상품 이미지 -->
        <div class="product-image">
            <img src="${pageContext.request.contextPath}/resources/img/shoes.JPG" class="productTitleImg" alt="상품 이미지">
        </div>

        <!-- 상품 정보 -->
        <div class="product-details">
            <h1 class="productTitle">상품 이름 : ${productDetail.proName}</h1>
            <span class="productPrice">상품 가격 : ${productDetail.proPrice}원</span>

            <h5 class="productDetail">
                상품 정보
                <button id="toggleButton" class="toggle-btn">+</button>
            </h5>

            <!-- 추가 정보 (토글로 표시) -->
            <ul class="additional-info" id="additionalInfo">
                <li>판매가: ${productDetail.totalPrice}원</li>
                <li>할인가: ${productDetail.proPrice}원</li>
                <li>배송비: ${productDetail.shippingFee}원</li>
            </ul>

            <!-- 색상 선택 버튼 -->
            <div class="option-section">
                <span class="option-label">색상</span>
                <div class="option-buttons" id="colorOptions">
                    <c:forEach var="color" items="${productDetail.proColor.split(',')}">
                        <div class="option-button" data-value="${color}">${color}</div>
                    </c:forEach>
                </div>
            </div>

            <!-- 사이즈 선택 버튼 -->
            <div class="option-section">
                <span class="option-label">사이즈</span>
                <div class="option-buttons disabled" id="sizeOptions">
                    <c:forEach var="size" items="${productDetail.proSize.split(',')}">
                        <div class="option-button" data-value="${size}">${size}</div>
                    </c:forEach>
                </div>
            </div>

            <!-- 선택한 옵션 표시 -->
            <div id="selectedProductInfo">
                <h3>선택한 상품 정보</h3>
                <div style="display: flex; align-items: center;">
                    <p>색상: <span id="selectedColor"></span></p>
                    <p>사이즈: <span id="selectedSize"></span></p>

                    <!-- 수량 조절 버튼 -->
                    <div style="margin-left: 20px;">
                        <button id="decreaseQuantity" style="width: 30px;">-</button>
                        <span id="quantity" style="margin: 0 10px;">1</span>
                        <button id="increaseQuantity" style="width: 30px;">+</button>
                    </div>

                    <!-- 선택한 상품의 총 가격 -->
                    <p style="margin-left: 20px;">총 가격: <span id="totalPrice"></span>원</p>

                    <!-- 삭제 버튼 -->
                    <button id="removeProduct" style="margin-left: 20px; color: red; background: none; border: none; font-size: 18px; cursor: pointer;">X</button>
                </div>
            </div>

            <!-- 구매하기 버튼 -->
            <a href="#" class="buy-button">구매하기</a>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    // 색상 버튼 클릭 시 사이즈 선택 활성화 및 스타일 변경
    const colorButtons = document.querySelectorAll('#colorOptions .option-button');
    const sizeButtons = document.querySelectorAll('#sizeOptions .option-button');
    const sizeOptions = document.getElementById('sizeOptions');
    const selectedProductInfo = document.getElementById('selectedProductInfo');
    const selectedColorElement = document.getElementById('selectedColor');
    const selectedSizeElement = document.getElementById('selectedSize');

    let selectedColor = '';
    let selectedSize = '';
    let selectedProducts = []; // 선택한 상품 정보를 저장할 배열

    colorButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedColor = button.getAttribute('data-value');
            selectedColorElement.textContent = selectedColor;
            button.classList.add('active');
            colorButtons.forEach(btn => {
                if (btn !== button) btn.classList.remove('active');
            });
            sizeOptions.classList.remove('disabled'); // 사이즈 선택 활성화
        });
    });

    sizeButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedSize = button.getAttribute('data-value');
            selectedSizeElement.textContent = selectedSize;
            button.classList.add('active');
            sizeButtons.forEach(btn => {
                if (btn !== button) btn.classList.remove('active');
            });
            updateTotalPrice(); // 총 가격 업데이트
            selectedProductInfo.style.display = 'block'; // 선택한 상품 정보 표시
        });
    });

    // 선택한 상품 정보 업데이트
    function updateTotalPrice() {
        const price = ${productDetail.proPrice}; // 상품 가격
        const quantity = parseInt(document.getElementById('quantity').textContent); // 수량
        const totalPrice = price * quantity; // 총 가격 계산
        document.getElementById('totalPrice').textContent = totalPrice; // 총 가격 표시
    }

    // 수량 증가 및 감소
    document.getElementById('increaseQuantity').addEventListener('click', () => {
        const quantityElement = document.getElementById('quantity');
        let quantity = parseInt(quantityElement.textContent);
        if (quantity < 10) { // 최대 10개까지 허용
            quantity++;
            quantityElement.textContent = quantity;
            updateTotalPrice(); // 총 가격 업데이트
        } else {
            alert('최대 10개까지 선택할 수 있습니다.');
        }
    });

    document.getElementById('decreaseQuantity').addEventListener('click', () => {
        const quantityElement = document.getElementById('quantity');
        let quantity = parseInt(quantityElement.textContent);
        if (quantity > 1) {
            quantity--;
            quantityElement.textContent = quantity;
            updateTotalPrice(); // 총 가격 업데이트
        }
    });

    // 선택한 상품 추가
    document.querySelector('.buy-button').addEventListener('click', (e) => {
        e.preventDefault(); // 기본 동작 방지
        if (selectedColor && selectedSize) {
            const quantity = parseInt(document.getElementById('quantity').textContent);
            const totalPrice = document.getElementById('totalPrice').textContent;
            selectedProducts.push({
                color: selectedColor,
                size: selectedSize,
                quantity: quantity,
                totalPrice: totalPrice
            });
            renderSelectedProducts(); // 선택한 상품 리스트 렌더링
        } else {
            alert('색상과 사이즈를 선택하세요.');
        }
    });

    // 선택한 상품 리스트 렌더링
    function renderSelectedProducts() {
        const selectedProductInfo = document.getElementById('selectedProductInfo');
        selectedProductInfo.innerHTML = ''; // 기존 내용 제거

        if (selectedProducts.length === 0) {
            selectedProductInfo.style.display = 'none'; // 선택한 상품이 없을 때 숨김
        } else {
            selectedProductInfo.style.display = 'block'; // 선택한 상품이 있을 때 보임
            selectedProducts.forEach((product, index) => {
                const productDetail = document.createElement('div');
                productDetail.innerHTML = `
                <p>색상: ${product.color} | 사이즈: ${product.size} | 수량: ${product.quantity} | 총 가격: ${product.totalPrice}원</p>
                <button class="remove-button" data-index="${index}" style="color: red; background: none; border: none; cursor: pointer;">X</button>
            `;
                selectedProductInfo.appendChild(productDetail);
            });

            // 삭제 버튼 이벤트 리스너 추가
            document.querySelectorAll('.remove-button').forEach(button => {
                button.addEventListener('click', (e) => {
                    const index = e.target.getAttribute('data-index');
                    selectedProducts.splice(index, 1); // 배열에서 해당 상품 제거
                    renderSelectedProducts(); // 업데이트된 상품 리스트 다시 렌더링
                });
            });
        }
    }

    // 추가 정보 토글 기능
    document.getElementById('toggleButton').addEventListener('click', () => {
        const additionalInfo = document.getElementById('additionalInfo');
        additionalInfo.style.display = additionalInfo.style.display === 'none' ? 'block' : 'none';
        document.getElementById('toggleButton').textContent = additionalInfo.style.display === 'block' ? '-' : '+';
    });
    function renderSelectedProducts() {
        const selectedProductInfo = document.getElementById('selectedProductInfo');
        selectedProductInfo.innerHTML = ''; // 기존 내용 제거

        if (selectedProducts.length === 0) {
            selectedProductInfo.style.display = 'none'; // 선택한 상품이 없을 때 숨김
        } else {
            selectedProductInfo.style.display = 'block'; // 선택한 상품이 있을 때 보임
            selectedProducts.forEach((product, index) => {
                const productDetail = document.createElement('div');
                productDetail.innerHTML = `
                <p>색상: ${product.color} | 사이즈: ${product.size} | 수량: ${product.quantity} | 총 가격: ${product.totalPrice}원</p>
                <button class="remove-button" data-index="${index}" style="color: red; background: none; border: none; cursor: pointer;">X</button>
            `;
                selectedProductInfo.appendChild(productDetail);
            });

            // 삭제 버튼 이벤트 리스너 추가
            document.querySelectorAll('.remove-button').forEach(button => {
                button.addEventListener('click', (e) => {
                    const index = e.target.getAttribute('data-index');
                    selectedProducts.splice(index, 1); // 배열에서 상품 제거
                    renderSelectedProducts(); // 선택한 상품 리스트 재렌더링
                });
            });
        }
    }
</script>
</body>
</html>
