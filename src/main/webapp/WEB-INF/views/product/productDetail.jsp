<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
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
            justify-content: center;
            align-items: flex-start;
            padding-bottom: 50px;
        }
        .container {
            display: flex;
            max-width: 1200px;
            width: 100%;
            background-color: #fff;
        }

        .product-image {
            flex: 2;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .product-image img {
            max-width: 100%;
            max-height: 400px;
            border-radius: 8px;
        }

        .product-details {
            flex: 1;
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
            margin: 20px 0;
            text-align: center; /* 선택한 상품 정보 가운데 정렬 */
        }

        #selectedProductInfo p {
            margin: 5px 0;
        }

        /* 탭 스타일 추가 */
        .tab-section {
            display: flex;
            flex-direction: column; /* 탭과 콘텐츠를 세로로 배치 */
            margin-top: 30px;
            width: 100%; /* 전체 너비 사용 */
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
        }

        .tab {
            padding: 15px 20px;
            cursor: pointer;
            font-weight: bold;
            transition: border-color 0.3s, color 0.3s;
            flex: 1; /* 탭 너비를 균등하게 배분 */
            text-align: center; /* 탭 텍스트 가운데 정렬 */
        }

        .tab:hover, .tab.active {
            color: #007bff;
            border-bottom: 3px solid #007bff;
        }

        .tab-content {
            display: none;
            padding: 20px;
        }

        .tab-content.active {
            display: block;
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>

<div class="content">
    <div class="container">
        <!-- 상품 이미지 및 상세 정보 -->
        <div class="product-image">
            <img src="resources/img/shoes.JPG" alt="상품 이미지">
        </div>

        <div class="product-details">
            <c:if test="${not empty productDetail}">
                <h1 class="productTitle">${productDetail.proName}</h1>
                <span class="productPrice">${productDetail.proPrice}원</span>
            </c:if>

            <!-- 색상 및 사이즈 옵션 -->
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

            <!-- 선택한 상품 정보 -->
            <div id="selectedProductInfo">
                <h3>선택한 상품 정보</h3>
                <p>색상: <span id="selectedColor"></span></p>
                <p>사이즈: <span id="selectedSize"></span></p>
                <p>총 가격: <span id="totalPrice"></span>원</p>
            </div>

            <!-- 구매 버튼 -->
            <a href="#" class="buy-button" onclick="addToCart()">구매하기</a>
        </div>
    </div>

    <!-- 탭 영역 (상품 이미지 및 상세 정보 아래에 배치) -->
    <div class="tab-section">
        <div class="tabs">
            <div class="tab active" onclick="showTab('reviews')">상품 후기</div>
            <div class="tab" onclick="showTab('details')">상세 정보</div>
            <div class="tab" onclick="showTab('inquiry')">상품 문의</div>
            <div class="tab" onclick="showTab('guide')">구매 안내</div>
        </div>
        <div class="tab-content active" id="reviews">
            <h3>상품 후기</h3>
            <p>여기에 사용자들의 상품 후기가 표시됩니다.</p>
        </div>
        <div class="tab-content" id="details">
            <h3>상세 정보</h3>
            <img src="resources/img/detail1.jpg" alt="상세 이미지 1" width="100%">
            <img src="resources/img/detail2.jpg" alt="상세 이미지 2" width="100%">
        </div>
        <div class="tab-content" id="inquiry">
            <h3>상품 문의</h3>
            <textarea rows="5" cols="50" placeholder="문의 내용을 입력하세요."></textarea>
            <button>문의하기</button>
        </div>
        <div class="tab-content" id="guide">
            <h3>구매 안내</h3>
            <p>배송, 교환, 환불 정책에 대한 안내가 표시됩니다.</p>
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
    // 탭 기능
    function showTab(tabId) {
        document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

        document.querySelector(`.tab[onclick="showTab('${tabId}')"]`).classList.add('active');
        document.getElementById(tabId).classList.add('active');
    }

</script>
</body>
</html>