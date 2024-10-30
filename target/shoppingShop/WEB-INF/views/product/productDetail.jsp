<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId }"/>

<html lang="ko">
<head>
    <title>상품 상세보기</title>
    <style>
        /* CSS 스타일 설정 (변경 없음) */
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
            font-size: 28px;
            margin-bottom: 10px;
        }
        .productPrice {
            font-size: 24px;
            color: #ff5733;
            margin-bottom: 20px;
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
        #selectedProductInfo {
            margin-top: 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: none; /* 기본적으로 숨김 상태 */
        }
        .selected-product {
            margin-bottom: 5px;
        }
        .remove-button {
            color: red;
            background: none;
            border: none;
            cursor: pointer;
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
                <div id="selectedProductsList"></div>
                <div>총 가격: <span id="totalPrice">0</span>원</div>
            </div>

            <a href="#" class="buy-button" id="buyButton">구매하기</a>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    let selectedColor = '';
    let selectedSize = '';
    let selectedProducts = []; // 선택한 상품 정보를 저장할 배열
    const productPrice = ${productDetail.proPrice}; // 상품 가격

    const colorButtons = document.querySelectorAll('#colorOptions .option-button');
    const sizeButtons = document.querySelectorAll('#sizeOptions .option-button');
    const selectedProductInfo = document.getElementById('selectedProductInfo');
    const selectedProductsList = document.getElementById('selectedProductsList');
    const totalPriceElement = document.getElementById('totalPrice');

    colorButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedColor = button.getAttribute('data-value');
            button.classList.add('active');
            colorButtons.forEach(btn => {
                if (btn !== button) btn.classList.remove('active');
            });
            document.getElementById('sizeOptions').classList.remove('disabled'); // 사이즈 선택 활성화
        });
    });

    sizeButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedSize = button.getAttribute('data-value');
            button.classList.add('active');
            sizeButtons.forEach(btn => {
                if (btn !== button) btn.classList.remove('active');
            });

            // 색상과 사이즈가 모두 선택된 경우에만 상품 추가
            if (selectedColor) {
                addProduct(selectedColor, selectedSize); // 상품 추가
            } else {
                alert('색상을 먼저 선택하세요.');
            }
        });
    });

    function addProduct(color, size) {
        if (color && size) {
            if (selectedProducts.length < 10) { // 최대 10개 추가
                const productDetail = {
                    color: color,
                    size: size,
                    price: productPrice // 가격 추가
                };
                selectedProducts.push(productDetail);
                renderSelectedProducts(); // 상품 추가 후 렌더링
            } else {
                alert('최대 10개까지 선택할 수 있습니다.'); // 10개 초과 시 경고 메시지
            }
        } else {
            alert('색상과 사이즈를 선택하세요.');
        }
    }

    function renderSelectedProducts() {
        selectedProductsList.innerHTML = ''; // 기존 내용 제거

        // 선택한 상품 정보 표시
        if (selectedProducts.length > 0) {
            selectedProducts.forEach((product, index) => {
                const productDetail = document.createElement('div');
                productDetail.classList.add('selected-product');
                productDetail.innerHTML = `
            색상: ${product.color}, 사이즈: ${product.size} - <span class="remove-button" onclick="removeProduct(${index})">삭제</span>
        `;
                selectedProductsList.appendChild(productDetail);
            });

            selectedProductInfo.style.display = 'block'; // 상품 정보가 있을 경우 보이도록 설정
        } else {
            selectedProductInfo.style.display = 'none'; // 상품 정보가 없을 경우 숨김
        }

        totalPriceElement.textContent = `${selectedProducts.length * productPrice}원`; // 총 가격 계산
    }

    function removeProduct(index) {
        selectedProducts.splice(index, 1); // 선택한 상품 삭제
        renderSelectedProducts(); // 업데이트된 목록 렌더링
    }
</script>
</body>
</html>
