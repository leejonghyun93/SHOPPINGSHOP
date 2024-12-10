<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            border-right: 1px solid #ddd;
        }

        .product-image img {
            max-width: 100%;
            max-height: 400px;
            border-radius: 8px;
        }

        .product-details {
            flex: 2;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .productTitle {
            font-size: 28px;
            font-weight: bold;
        }

        .productPrice {
            font-size: 24px;
            color: #ff5733;
        }

        .option-section {
            margin-top: 20px;
        }

        .option-label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
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

        .active {
            background-color: #007bff;
            color: white;
        }

        .buy-button {
            padding: 15px 30px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .buy-button:hover {
            background-color: #0056b3;
        }

        #selectedProductInfo {
            display: none;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        #selectedProductInfo p {
            margin: 5px 0;
        }

        .toggle-btn {
            background: none;
            border: none;
            font-size: 16px;
            cursor: pointer;
            color: #007bff;
        }

        .additional-info {
            display: none;
            list-style: none;
            padding: 0;
            margin: 0;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>

<div class="content">
    <div class="container">
        <div class="product-image">
            <img src="resources/img/shoes.JPG" alt="상품 이미지">
        </div>

        <div class="product-details">
            <c:if test="${not empty productDetail}">
                <h1 class="productTitle">${productDetail.proName}</h1>
                <span class="productPrice">${productDetail.proPrice}원</span>
            </c:if>

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
                <div class="option-buttons" id="sizeOptions">
                    <c:forEach var="size" items="${productDetail.proSize.split(',')}">
                        <div class="option-button size-button" data-value="${size}">${size}</div>
                    </c:forEach>
                </div>
            </div>

            <div id="selectedProductInfo">
                <h3>선택한 상품 정보</h3>
                <p>색상: <span id="selectedColor"></span></p>
                <p>사이즈: <span id="selectedSize"></span></p>
                <p>총 가격: <span id="totalPrice"></span>원</p>
            </div>

            <a href="#" class="buy-button" onclick="addToCart()">구매하기</a>
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
    const totalPriceElement = document.getElementById('totalPrice');
    const pricePerItem = ${productDetail.proPrice};

    let selectedColor = '';
    let selectedSize = '';

    colorButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedColor = button.dataset.value;
            selectedColorElement.textContent = selectedColor;

            colorButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
        });
    });

    sizeButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedSize = button.dataset.value;
            selectedSizeElement.textContent = selectedSize;

            sizeButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            if (selectedColor && selectedSize) {
                selectedProductInfo.style.display = 'block';
                totalPriceElement.textContent = pricePerItem;
            }
        });
    });

    function addToCart() {
        if (!selectedColor || !selectedSize) {
            alert("색상과 사이즈를 모두 선택해주세요.");
            return;
        }

        const cartData = {
            proId: "${productDetail.proId}",
            proColor: selectedColor,
            proSize: selectedSize,
            proName: "${productDetail.proName}",
            quantity: 1,
            totalPrice : "${productDetail.totalPrice}"
        };

        fetch('/cart/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(cartData), // JSON 형식으로 변환
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text); });
                }
                return response.json(); // JSON으로 응답 처리
            })
            .then(data => {
                console.log('서버 응답:', data);
                alert(data.message); // 서버가 반환한 메시지 표시
                window.location.assign('/cart/cart'); // cart.jsp로 이동
            })
            .catch(error => {
                console.error('오류:', error.message);
                alert('오류 발생: ' + error.message);
            });
    }

</script>
</body>
</html>