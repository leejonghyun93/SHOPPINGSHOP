<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginId"
       value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}"/>

<html lang="ko">
<head>
    <title>상품 상세보기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            margin: 0 auto;
            max-width: 1200px;
            width: 100%;
            background-color: #fff;
        }

        .product-image {
            flex: 1;
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
            flex: 0.5;
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
            margin: 30px auto 0; /* 위 30px, 왼쪽/오른쪽 auto, 아래는 0 */
            max-width: 1200px;
            width: 100%;
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            align-items: center;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            font-weight: bold;
            transition: border-color 0.3s, color 0.3s;
            flex: 1; /* 탭 너비를 균등하게 배분 */
            text-align: center; /* 탭 텍스트 가운데 정렬 */
            position: relative; /* 필요 */
        }

        .tab:not(:last-child)::after {
            content: '|';
            position: absolute;
            right: 25%; /* 기호를 중앙에 위치시킴 */
            margin-right: -80px; /* 기호 위치 조정 */
            transform: translateX(50%); /* 수평 축 중앙 위치 조정 */
            color: #ccc; /* 막대 색상 조정 가능 */
            font-size: 20px;
        }

        .tab:hover, .tab.active {
            color: #007bff;
            border-bottom: 3px solid #007bff;
        }

        .tab-content {
            display: none; /* 초기에는 모든 콘텐츠를 숨김 */
        }

        .tab.active {
            font-weight: bold;
            color: #007bff;
        }

        /* 전체 컨테이너 */
        #reviews-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-top: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }


        /* 왼쪽 섹션 */
        #left-section {
            text-align: center;
            width: 40%;
            padding-right: 20px;
            border-right: 2px solid #e1e1e1;
        }

        #star-icon {
            font-size: 100px;
            color: gold;
            margin-bottom: 20px;
        }

        #total-rating {
            font-size: 24px;
            margin-bottom: 20px;
        }

        #write-review-button {
            background-color: #ffcc00;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 18px;
            cursor: pointer;
        }

        #write-review-button:hover {
            background-color: #ffaa00;
        }

        /* 오른쪽 섹션 */
        #reviews {
            width: 50%;
        }

        #rating-bars .rating-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        #rating-bars .bar {
            flex: 1;
            height: 10px;
            background-color: #f0f0f0;
            margin: 0 10px;
            position: relative;
        }

        #rating-bars .rating-bar {
            height: 100%;
            background-color: #4caf50;
            width: 0%;
        }

        .rating-item span {
            font-weight: bold;
        }

        /* 활성화된 탭 */
        .tab-content.active {
            display: block;
        }


        #rating-bars {
            margin-top: 20px;
        }

        .rating-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .rating-item label {
            width: 100px;
            text-align: right;
            margin-right: 10px;
        }

        .rating-bar {
            height: 20px; /* 막대 높이 */
            background-color: #4CAF50; /* 막대 색상 */
        }

        .bar {
            width: 100%; /* 부모 컨테이너 너비 */
            background-color: #ddd; /* 막대 배경색 */
            border-radius: 5px;
            overflow: hidden; /* 막대가 넘치지 않도록 설정 */
        }

        #excellent-bar {
            background-color: #4caf50;
        }

        #good-bar {
            background-color: #2196F3;
        }

        #average-bar {
            background-color: #FFC107;
        }

        #poor-bar {
            background-color: #FF5722;
        }

        #terrible-bar {
            background-color: #F44336;
        }

        .progress {
            width: 0%;
            height: 100%;
            background-color: #4caf50;
            transition: width 0.3s ease;
        }

        .rating-item span {
            width: 50px;
            text-align: left;
        }

        span {
            flex: 1;
            text-align: center;
        }

        .hidden {
            display: none;
        }

        #rating-popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        #rating-popup h3 {
            margin-bottom: 10px;
        }

        #rating-popup div {
            margin-bottom: 10px;
        }

        /************************** 상세보기 이미지 *********************************/

        .product-item {
            display: flex; /* Flexbox 사용 */
            flex-direction: column; /* 이미지를 세로로 정렬 */
            align-items: center; /* 이미지 중앙 정렬 */
            gap: 20px; /* 이미지 간격 */
            width: 100%; /* 부모 컨테이너 너비 */
            margin: 30px auto 0;
            max-width: 1200px;
        }

        .product-item img {
            width: 100%; /* 이미지를 원래 비율로 유지 */
            margin: 30px auto 0;
            max-width: 1200px;
            height: auto; /* 비율 유지 */
            border: 1px solid #ddd; /* 이미지 테두리 */
            border-radius: 10px; /* 둥근 모서리 */
        }

        /************************* 문의 상세보기 스타일 ******************************/
        h4 {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        /* 문의 리스트 스타일 */
        .inquiry-table {
            width: 100%;
            border-collapse: collapse; /* 테두리 사이 간격 없애기 */
            margin: 30px auto 0;
            font-size: 16px;
            text-align: left;
            max-width: 1200px;
        }

        .inquiry-table th, .inquiry-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd; /* 테이블의 아래쪽 테두리 */
            max-width: 1200px;
        }

        .inquiry-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .inquiry-table tr:hover {
            background-color: #f1f1f1; /* 행 호버 시 배경색 */
        }

        /* 상세보기 버튼 스타일 */
        .view-details {
            padding: 8px 12px;
            font-size: 14px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .view-details:hover {
            background-color: #0056b3;
        }

        /* Pagination 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .page-link {
            padding: 8px 12px;
            margin: 0 5px;
            cursor: pointer;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #007bff; /* 기본 링크 색상 */
        }

        .page-link:hover {
            background-color: #007bff;
            color: white;
        }

        .page-link.active {
            font-weight: bold;
            color: red;
        }

        #inquiry-pagination {
            display: flex; /* 플렉스 박스를 사용해 정렬 */
            justify-content: center; /* 가로 정렬을 가운데로 */
            align-items: center; /* 세로 정렬 (필요시) */
            margin-top: 20px; /* 위쪽 여백 조정 */
        }

        #inquiry-pagination a {
            text-decoration: none; /* 밑줄 제거 */
            color: #333; /* 기본 글씨 색 */
            margin: 0 5px; /* 버튼 간격 */
            padding: 5px 10px; /* 버튼 크기 조정 */
            border: 1px solid #ddd; /* 버튼 테두리 */
            border-radius: 4px; /* 버튼 모서리 둥글게 */
            transition: background-color 0.3s ease; /* 마우스 오버 시 효과 */
        }

        #inquiry-pagination a.active {
            background-color: #007bff; /* 활성화된 페이지 배경색 */
            color: #fff; /* 활성화된 페이지 글씨 색 */
            border-color: #007bff; /* 활성화된 페이지 테두리 색 */
        }

        #inquiry-pagination a:hover {
            background-color: #0056b3; /* 마우스 오버 시 배경색 */
            color: #fff; /* 마우스 오버 시 글씨 색 */
            border-color: #0056b3; /* 마우스 오버 시 테두리 색 */
        }
        #guide{
            text-align: center;
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
            <img src="<c:url value='/resources/img/${product.imageUrl}'/>" alt="${product.proName} 이미지"/>
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
            <div id="reviews-tab" class="tab active" onclick="showTab('reviews-container')">상품 후기</div>
            <div id="details-tab" class="tab" onclick="showTab('details')">상세 정보</div>
            <div id="inquiry-tab" class="tab" onclick="showTab('inquiry')">상품 문의</div>
            <div id="guide-tab" class="tab" onclick="showTab('guide')">구매 안내</div>
        </div>
        <div id="reviews-container" class="tab-content active">
            <!-- 왼쪽 섹션 -->
            <div id="left-section">
                <div id="star-icon">
                    ⭐
                </div>
                <div id="total-rating">
                    <h3>총 별점: <span id="average-rating">0</span> / 5</h3>
                </div>
                <button id="write-review-button">상품 리뷰 작성하기</button>
            </div>

            <!-- 오른쪽 섹션 -->
            <div id="reviews">
                <h2>상품 후기</h2>
                <div id="rating-bars">
                    <div class="rating-item">
                        <label>아주좋아요</label>
                        <div class="bar">
                            <div id="excellent-bar" class="rating-bar"></div>
                        </div>
                        <span id="excellent-score">0</span>
                    </div>
                    <div class="rating-item">
                        <label>맘에 들어요</label>
                        <div class="bar">
                            <div id="good-bar" class="rating-bar"></div>
                        </div>
                        <span id="good-score">0</span>
                    </div>
                    <div class="rating-item">
                        <label>보통이에요</label>
                        <div class="bar">
                            <div id="average-bar" class="rating-bar"></div>
                        </div>
                        <span id="average-score">0</span>
                    </div>
                    <div class="rating-item">
                        <label>그냥그래요</label>
                        <div class="bar">
                            <div id="poor-bar" class="rating-bar"></div>
                        </div>
                        <span id="poor-score">0</span>
                    </div>
                    <div class="rating-item">
                        <label>별로에요</label>
                        <div class="bar">
                            <div id="terrible-bar" class="rating-bar"></div>
                        </div>
                        <span id="terrible-score">0</span>
                    </div>
                </div>
                <button id="open-rating-popup">별점 추가</button>
            </div>
        </div>

        <!-- 별점 팝업 -->
        <div id="rating-popup" class="hidden">
            <h3>별점을 선택해주세요</h3>
            <div>
                <input type="radio" id="excellent" name="rating" value="5">
                <label for="excellent">아주좋아요</label><br>
                <input type="radio" id="good" name="rating" value="4">
                <label for="good">맘에 들어요</label><br>
                <input type="radio" id="average" name="rating" value="3">
                <label for="average">보통이에요</label><br>
                <input type="radio" id="poor" name="rating" value="2">
                <label for="poor">그냥그래요</label><br>
                <input type="radio" id="terrible" name="rating" value="1">
                <label for="terrible">별로에요</label><br>
                <textarea id="reviewComment" placeholder="리뷰를 입력해주세요"></textarea>
            </div>
            <button id="submitRating">평점 추가</button>
            <button id="close-popup">닫기</button>
        </div>
    </div>
    <div class="tab-content" id="details">
        <div class="product-item">
            <c:forEach var="image" items="${fn:split(product.imagePath, ',')}">
                <!-- 각 이미지에 대해 동적으로 경로 생성 -->
                <img src="<c:url value='${pageContext.request.contextPath}/resources/img/products/${product.proId}/${image}' />"
                     alt="${product.proName} 이미지">
            </c:forEach>
        </div>
    </div>
    <div id="inquiry" class="tab-content">
        <!-- 문의 리스트 -->
        <div id="inquiry-list">
            <table class="inquiry-table">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                </tr>
                <c:forEach var="inquiry" items="${inquiries}">
                    <tr>
                        <td>${inquiry.inquiryId}</td>
                        <td>${inquiry.content}</td>
                        <td>${inquiry.author}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <!-- 페이지네이션 -->
        <div id="inquiry-pagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}">◀</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="?page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}">▶</a>
            </c:if>
        </div>
    </div>
    <script src="pagination.js"></script>
    <div class="tab-content" id="guide">
        <h3>구매 안내</h3>
        <p>배송, 교환, 환불 정책에 대한 안내가 표시됩니다.</p>
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

    const loginId = "${loginId}";
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
            totalPrice: parseInt(totalPriceElement.textContent) || 0
        };

        // 장바구니에 이미 상품이 있는지 확인
        fetch('/cart/checkCartItem', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(cartData) // JSON 형식으로 변환
        })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.message); // 이미 장바구니에 있는 경우 메시지 추출
                    });
                }
                return response.json(); // JSON으로 응답 처리
            })
            .then(data => {
                // 장바구니에 없으면 추가 처리
                console.log(data.message);  // 장바구니에 추가 가능
                // 상품을 장바구니에 추가하는 로직을 추가
                return fetch('/cart/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(cartData) // 장바구니에 상품 추가
                });
            })
            .then(response => response.json())
            .then(data => {
                alert('장바구니에 상품이 추가되었습니다.');
                window.location.assign('/cart/cart'); // 장바구니 페이지로 이동
            })
            .catch(error => {
                alert(error.message);  // 이미 장바구니에 있을 경우 메시지 출력
            });
    }
    // 탭 기능
    function showTab(tabId) {
        // 모든 탭 콘텐츠 숨기기
        const allTabs = document.querySelectorAll('.tab-content');
        allTabs.forEach(tab => {
            tab.classList.remove('active');
            tab.style.display = 'none'; // 탭 콘텐츠는 숨김
        });

        // 모든 탭에서 'active' 클래스 제거
        const allTabButtons = document.querySelectorAll('.tab');
        allTabButtons.forEach(tabButton => {
            tabButton.classList.remove('active');
        });

        // 선택한 탭 버튼에 'active' 클래스 추가
        const selectedTabButton = document.querySelector(`[onclick="showTab('${tabId}')"]`);
        if (selectedTabButton) {
            selectedTabButton.classList.add('active');
        }

        // 선택한 탭 콘텐츠 보여주기
        const selectedTabContent = document.getElementById(tabId);
        if (selectedTabContent) {
            selectedTabContent.classList.add('active');
            selectedTabContent.style.display = ''; // 탭 콘텐츠를 다시 보여줌
        }
    }

    //************************** 리뷰 **********************************//
    $(document).ready(function () {
        let proId; // 초기화

        async function getProductIdFromBackend() {
            try {
                const response = await $.get(`/product/current?proId=${proId}`);
                if (!response || !response.proId) {
                    throw new Error("상품 ID 가져오기 실패");
                }
                proId = response.proId; // 프로덕트 ID를 proId로 설정
                console.log("프로덕트 ID:", proId);
                await getReviews(proId); // 필수적으로 await 붙이기
            } catch (error) {
                console.error("상품 ID 가져오기 실패:", error);
                if (error.status === 404) {
                    alert("해당 상품이 존재하지 않습니다. 다시 시도해주세요.");
                } else {
                    alert("프로덕트 ID를 가져오는 데 실패했습니다. 다시 시도해주세요.");
                }
            }
        }

        async function getReviews(proId) {
            try {
                const response = await $.get(`/product/review/getByProductId/${proId}`);
                console.log("서버에서 반환된 리뷰 데이터:", response); // 서버 데이터 출력

                if (!response || !Array.isArray(response) || response.length === 0) {
                    throw new Error("리뷰 데이터가 비어 있습니다.");
                }

                const calculatedData = calculateRatings(response);
                updateRatingsOnPage(calculatedData);
            } catch (error) {
                console.error("리뷰 데이터 가져오기 실패:", error);
                alert("리뷰 데이터를 가져오는 데 실패했습니다.");
            }
        }

        function calculateRatings(reviews) {
            let counts = {excellent: 0, good: 0, average: 0, poor: 0, terrible: 0};

            reviews.forEach(review => {
                const rating = parseInt(review.rating, 10); // 문자열을 숫자로 변환
                switch (rating) {
                    case 5:
                        counts.excellent++;
                        break;
                    case 4:
                        counts.good++;
                        break;
                    case 3:
                        counts.average++;
                        break;
                    case 2:
                        counts.poor++;
                        break;
                    case 1:
                        counts.terrible++;
                        break;
                }
            });

            return counts;
        }

        function updateRatingsOnPage(data) {
            console.log("평점 데이터:", data);

            const {excellent, good, average, poor, terrible} = data;
            const totalRatings = excellent + good + average + poor + terrible;

            if (totalRatings === 0) {
                console.log("평점 데이터가 없습니다.");
                return;
            }

            const calculateWidth = (value) => {
                if (totalRatings === 0) return '0%'; // 0% 처리
                const percentage = ((value / totalRatings) * 100).toFixed(2); // 소수점 2자리 고정
                return `${percentage}%`;
            };

            // 막대 그래프 업데이트
            $("#excellent-bar").css("width", calculateWidth(excellent));
            $("#good-bar").css("width", calculateWidth(good));
            $("#average-bar").css("width", calculateWidth(average));
            $("#poor-bar").css("width", calculateWidth(poor));
            $("#terrible-bar").css("width", calculateWidth(terrible));

            // 평점 및 개수 업데이트
            $("#average-rating").text(
                totalRatings > 0
                    ? ((5 * excellent + 4 * good + 3 * average + 2 * poor + terrible) / totalRatings).toFixed(1)
                    : "0.0"
            );
            $("#excellent-score").text(excellent);
            $("#good-score").text(good);
            $("#average-score").text(average);
            $("#poor-score").text(poor);
            $("#terrible-score").text(terrible);
        }

        // 리뷰 추가 처리
        $("#submitRating").on("click", async function () {
            const ratingValue = $("input[name='rating']:checked").val();
            const comment = $("#reviewComment").val(); // 추가된 리뷰 코멘트

            if (!ratingValue) {
                alert("별점을 선택해주세요.");
                return;
            }

            try {
                await $.ajax({
                    url: "/product/review/add",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        proId: proId,
                        rating: ratingValue,
                        comment: comment, // 코멘트 데이터 전송
                    }),
                });

                alert("리뷰가 추가되었습니다.");
                $("#rating-popup").addClass("hidden");

                // 새로운 리뷰 데이터를 다시 가져오고 페이지를 업데이트
                await getReviews(proId);

            } catch (error) {
                console.error("리뷰 추가 실패:", error);
                alert("리뷰 추가에 실패했습니다. 다시 시도해주세요.");
            }
        });

        // 별점 추가 팝업 열기 버튼 이벤트 리스너
        $('#open-rating-popup').on('click', function () {
            if (!loginId || loginId.trim() === '') { // 로그인 여부 확인
                alert('로그인 후 이용할 수 있습니다.'); // 경고 메시지 출력
            } else {
                $('#rating-popup').removeClass('hidden'); // 팝업 표시
            }
        });

        $("#close-popup").on("click", () => $("#rating-popup").addClass("hidden"));

        // 초기 실행
        getProductIdFromBackend();
    });

    //************************************************************//
    $(document).ready(function () {
        // 페이지네이션 클릭 이벤트 처리
        $('#inquiry-pagination').on('click', '.page-link', function (e) {
            e.preventDefault(); // 기본 링크 동작 방지
            const page = $(this).data('page'); // 클릭한 페이지 번호

            if (page) {
                loadInquiryList(page); // 해당 페이지 데이터를 비동기로 로드
            } else {
                console.error('Invalid page number:', page);
            }
        });

        // 문의 리스트 비동기 로드 함수
        function loadInquiryList(page) {
            $.ajax({
                url: `/product/inquiries?page=${page}&size=5`, // 비동기 요청 URL
                method: 'GET',
                success: function (data) {
                    setupInquiryList(data.content); // 테이블에 데이터 출력
                    setupPagination(data, page); // 페이지네이션 설정
                },
                error: function (error) {
                    console.error('Error loading inquiry list:', error);
                }
            });
        }

        // 테이블로 데이터를 출력하는 함수
        function setupInquiryList(content) {
            let html = "<table class='inquiry-table'>";
            html += "<tr><th>번호</th><th>제목</th><th>작성자</th></tr>";
            $.each(content, function (index, obj) {
                html += `<tr>
                <td>${obj.inquiryId}</td>
                <td>${obj.content}</td>
                <td>${obj.author}</td>
            </tr>`;
            });
            html += "</table>";
            $('#inquiry-list').html(html); // 테이블에 데이터 출력
        }

        // 페이지네이션 설정
        function setupPagination(data, currentPage) {
            const $pagination = $('#inquiry-pagination');
            $pagination.empty();

            let paginationHtml = '';
            if (currentPage > 1) {
                paginationHtml += `<span class="page-link" data-page="${currentPage - 1}">◀</span>`;
            }

            for (let i = 1; i <= data.totalPages; i++) {
                const activeClass = i === currentPage ? 'active' : '';
                paginationHtml += `<span class="page-link ${activeClass}" data-page="${i}">${i}</span>`;
            }

            if (currentPage < data.totalPages) {
                paginationHtml += `<span class="page-link" data-page="${currentPage + 1}">▶</span>`;
            }

            $pagination.html(paginationHtml); // 페이지네이션 출력
        }
    });

</script>
</body>
</html>