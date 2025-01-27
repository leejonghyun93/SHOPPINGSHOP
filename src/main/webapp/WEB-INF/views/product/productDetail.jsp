<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

        #guide {
            text-align: center;
        }

        /* 모달 배경 */
        /* 글쓰기 버튼 */
        .write-btn {
            background-color: #4CAF50; /* 초록색 버튼 */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .write-btn:hover {
            background-color: #45a049;
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
        }

        .write-btn:active {
            background-color: #3e8e41;
            box-shadow: 0 3px 4px rgba(0, 0, 0, 0.2);
            transform: translateY(1px);
        }

        /* 모달 배경 */
        .modal {
            display: none;
            position: fixed;
            z-index: 10;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background: rgba(0, 0, 0, 0.7); /* 배경 투명도 증가 */
            backdrop-filter: blur(5px); /* 배경 흐림 효과 */
        }

        /* 모달 컨텐츠 */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 30px;
            border: none;
            width: 40%;
            border-radius: 12px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
            animation: slideIn 0.3s ease-out;
        }

        /* 모달 애니메이션 */
        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* 닫기 버튼 */
        .close-btn {
            color: #666;
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s;
        }

        .close-btn:hover {
            color: #000;
        }

        /* 입력 필드 */
        #writeForm input[type="text"],
        #writeForm textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        #writeForm input[type="text"]:focus,
        #writeForm textarea:focus {
            border-color: #4CAF50;
            outline: none;
        }

        /* 등록 버튼 */
        #writeForm button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        #writeForm button[type="submit"]:hover {
            background-color: #45a049;
        }

        #writeForm button[type="submit"]:active {
            background-color: #3e8e41;
            transform: scale(0.98);
        }

        /* 모달 제목 스타일 */
        .modal-content h2 {
            text-align: center;
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        #detail-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            width: 400px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            border-radius: 8px;
        }

        #modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .close-detail-btn {
            cursor: pointer;
            float: right;
            font-size: 20px;
            color: gray;
        }

        .detail-content {
            padding: 10px;
            border-radius: 4px;
        }

        #detail-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 50%;
            max-width: 500px;
        }
        #modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        .close-detail-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }
        .fixed-table {
            table-layout: fixed; /* 테이블 레이아웃 고정 */
            width: 100%; /* 테이블 전체 너비 */
            border-collapse: collapse; /* 테이블 경계선 합치기 */
        }

        .fixed-table th, .fixed-table td {
            padding: 8px; /* 셀 여백 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .fixed-table th {
            background-color: #f4f4f4; /* 헤더 배경색 */
            font-weight: bold; /* 헤더 글씨 굵게 */
        }

        .fixed-table th:nth-child(1) {
            width: 10%; /* 번호 */
        }

        .fixed-table th:nth-child(2) {
            width: 50%; /* 제목 */
        }

        .fixed-table th:nth-child(3) {
            width: 20%; /* 작성자 */
        }

        .fixed-table th:nth-child(4) {
            width: 20%; /* 날짜 */
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
            <table class="inquiry-table fixed-table">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>날짜</th>
                </tr>
                <c:forEach var="inquiry" items="${inquiries}">
                    <tr class="inquiry-row">
                        <td>${inquiry.inquiryId}</td>
                        <td>
                            <a href="#" class="view-inquiry" data-inquiry-id="${inquiry.inquiryId}">
                                    ${inquiry.title}
                            </a>
                        </td>
                        <td>${inquiry.author}</td>
                        <td><fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy-MM-dd" /></td>
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

        <!-- 글쓰기 버튼 -->
        <button id="write-btn" class="write-btn">글쓰기</button>

        <!-- 글쓰기 모달 -->
        <div id="write-modal" class="modal">
            <div class="modal-content">
                <span class="close-btn">&times;</span>
                <h2>문의 글쓰기</h2>
                <form id="writeForm">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>

                    <label for="content">내용</label>
                    <textarea id="content" name="content" rows="5" required></textarea>

                    <button type="submit">등록</button>
                </form>
            </div>
        </div>

        <!-- 상세보기 모달 -->
        <div id="detail-modal">
            <div id="modal-content">
                <span class="close-detail-btn">&times;</span>
                <div id="detail-container">
                    <p><strong>제목:</strong> <span id="detail-title">제목 없음</span></p>
                    <p><strong>내용:</strong> <span id="detail-content-text">내용 없음</span></p>
                    <p><strong>작성자:</strong> <span id="detail-author">작성자 없음</span></p>
                    <p><strong>작성일:</strong> <span id="detail-date">작성일 없음</span></p>
                </div>
            </div>
        </div>

        <!-- 모달 배경 -->
        <div id="modal-overlay"></div>

    </div>

    <div class="tab-content" id="guide">
        <h3>구매 안내</h3>
        <p>배송, 교환, 환불 정책에 대한 안내가 표시됩니다.</p>
    </div>
</div>


<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>


<script>
    // 색상 버튼과 사이즈 버튼 요소를 모두 선택
    const colorButtons = document.querySelectorAll('.color-button');
    const sizeButtons = document.querySelectorAll('.size-button');

    // 선택된 색상과 사이즈를 표시할 HTML 요소 선택
    const selectedColorElement = document.getElementById('selectedColor');
    const selectedSizeElement = document.getElementById('selectedSize');

    // 선택된 상품 정보와 총 가격을 표시할 요소 선택
    const selectedProductInfo = document.getElementById('selectedProductInfo');
    const totalPriceElement = document.getElementById('totalPrice');

    // 상품의 개별 가격을 설정 (백틱으로 변수를 JS에 주입)
    const pricePerItem = ${productDetail.proPrice};

    // 선택된 색상과 사이즈를 저장할 변수 초기화
    let selectedColor = '';
    let selectedSize = '';

    // 사용자 로그인 ID 저장
    const loginId = "${loginId}";

    // 색상 버튼에 클릭 이벤트 추가
    colorButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedColor = button.dataset.value; // 클릭된 버튼의 색상 값 저장
            selectedColorElement.textContent = selectedColor; // 선택된 색상을 화면에 표시

            // 모든 버튼의 'active' 클래스 제거 후 클릭된 버튼에만 추가
            colorButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
        });
    });

    // 사이즈 버튼에 클릭 이벤트 추가
    sizeButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedSize = button.dataset.value; // 클릭된 버튼의 사이즈 값 저장
            selectedSizeElement.textContent = selectedSize; // 선택된 사이즈를 화면에 표시

            // 모든 버튼의 'active' 클래스 제거 후 클릭된 버튼에만 추가
            sizeButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            // 색상과 사이즈가 모두 선택되었을 때만 상품 정보를 표시
            if (selectedColor && selectedSize) {
                selectedProductInfo.style.display = 'block'; // 선택된 상품 정보 영역 표시
                totalPriceElement.textContent = pricePerItem; // 상품 가격을 화면에 표시
            }
        });
    });

    // 장바구니에 상품을 추가하는 함수
    function addToCart() {
        // 색상과 사이즈가 선택되지 않은 경우 경고 메시지 표시
        if (!selectedColor || !selectedSize) {
            alert("색상과 사이즈를 모두 선택해주세요.");
            return;
        }

        // 장바구니에 추가할 상품 데이터를 객체로 생성
        const cartData = {
            proId: "${productDetail.proId}",
            proColor: selectedColor,
            proSize: selectedSize,
            proName: "${productDetail.proName}",
            quantity: 1, // 기본 수량 1
            totalPrice: parseInt(totalPriceElement.textContent) || 0 // 총 가격 계산
        };

        // 장바구니에 상품이 이미 있는지 서버에 요청
        fetch('/cart/checkCartItem', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(cartData) // JSON 형식으로 데이터 전송
        })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.message); // 장바구니에 이미 있을 경우 에러 메시지 추출
                    });
                }
                return response.json(); // 성공적인 응답 처리
            })
            .then(data => {
                // 상품을 장바구니에 추가하는 요청 전송
                return fetch('/cart/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(cartData) // JSON 형식으로 데이터 전송
                });
            })
            .then(response => response.json())
            .then(data => {
                alert('장바구니에 상품이 추가되었습니다.'); // 성공 메시지 표시
                window.location.assign('/cart/cart'); // 장바구니 페이지로 이동
            })
            .catch(error => {
                alert(error.message); // 에러 메시지 출력 (예: 이미 장바구니에 존재)
            });
    }

    // 탭을 전환하는 함수
    function showTab(tabId) {
        // 모든 탭 콘텐츠를 숨김
        const allTabs = document.querySelectorAll('.tab-content');
        allTabs.forEach(tab => {
            tab.classList.remove('active');
            tab.style.display = 'none'; // 탭 콘텐츠 숨김
        });

        // 모든 탭 버튼에서 'active' 클래스 제거
        const allTabButtons = document.querySelectorAll('.tab');
        allTabButtons.forEach(tabButton => {
            tabButton.classList.remove('active');
        });

        // 선택된 탭 버튼에 'active' 클래스 추가
        const selectedTabButton = document.querySelector(`[onclick="showTab('${tabId}')"]`);
        if (selectedTabButton) {
            selectedTabButton.classList.add('active');
        }

        // 선택된 탭 콘텐츠 표시
        const selectedTabContent = document.getElementById(tabId);
        if (selectedTabContent) {
            selectedTabContent.classList.add('active');
            selectedTabContent.style.display = ''; // 콘텐츠 다시 표시
        }
    }


    //************************** 리뷰 **********************************//
    $(document).ready(function () {
        let proId; // 상품 ID를 저장할 변수를 선언합니다.

        // 백엔드에서 현재 상품 ID를 가져오는 비동기 함수
        async function getProductIdFromBackend() {
            try {
                // 서버에 현재 상품 ID를 요청합니다.
                const response = await $.get(`/product/current?proId=${proId}`);
                if (!response || !response.proId) {
                    throw new Error("상품 ID 가져오기 실패"); // 실패 시 예외를 던집니다.
                }
                proId = response.proId; // 서버로부터 받은 상품 ID를 설정합니다.

                await getReviews(proId); // 해당 상품 ID로 리뷰 데이터를 가져옵니다.
            } catch (error) {
                // 에러 유형에 따라 다른 메시지를 출력합니다.
                if (error.status === 404) {
                    alert("해당 상품이 존재하지 않습니다. 다시 시도해주세요."); // 404 에러 처리
                } else {
                    alert("프로덕트 ID를 가져오는 데 실패했습니다. 다시 시도해주세요."); // 일반 에러 처리
                }
            }
        }

        // 주어진 상품 ID로 리뷰 데이터를 가져오는 비동기 함수
        async function getReviews(proId) {
            try {
                // 서버로부터 리뷰 데이터를 가져옵니다.
                const response = await $.get(`/product/review/getByProductId/${proId}`);

                const calculatedData = calculateRatings(response); // 평점 데이터를 계산합니다.
                updateRatingsOnPage(calculatedData); // 계산된 데이터를 페이지에 반영합니다.
            } catch (error) {
                alert("리뷰 데이터를 가져오는 데 실패했습니다."); // 리뷰 가져오기 실패 시 메시지 출력
            }
        }

        // 리뷰 데이터에서 평점별 개수를 계산하는 함수
        function calculateRatings(reviews) {
            // 평점별로 초기 개수를 0으로 설정합니다.
            let counts = {excellent: 0, good: 0, average: 0, poor: 0, terrible: 0};

            // 각 리뷰 데이터를 순회하며 평점별로 개수를 카운트합니다.
            reviews.forEach(review => {
                const rating = parseInt(review.rating, 10); // 문자열 평점을 숫자로 변환
                switch (rating) {
                    case 5:
                        counts.excellent++; // 평점 5
                        break;
                    case 4:
                        counts.good++; // 평점 4
                        break;
                    case 3:
                        counts.average++; // 평점 3
                        break;
                    case 2:
                        counts.poor++; // 평점 2
                        break;
                    case 1:
                        counts.terrible++; // 평점 1
                        break;
                }
            });

            return counts; // 계산된 평점 데이터를 반환합니다.
        }

        // 계산된 평점 데이터를 페이지에 반영하는 함수
        function updateRatingsOnPage(data) {
            const {excellent, good, average, poor, terrible} = data; // 평점 데이터를 구조 분해 할당
            const totalRatings = excellent + good + average + poor + terrible; // 총 평점 개수를 계산

            if (totalRatings === 0) {
                return; // 평점 데이터가 없으면 종료
            }

            // 각 평점의 비율을 계산하는 함수
            const calculateWidth = (value) => {
                if (totalRatings === 0) return '0%'; // 평점 데이터가 없으면 0%
                const percentage = ((value / totalRatings) * 100).toFixed(2); // 백분율 계산
                return `${percentage}%`;
            };

            // 막대 그래프의 너비를 업데이트
            $("#excellent-bar").css("width", calculateWidth(excellent));
            $("#good-bar").css("width", calculateWidth(good));
            $("#average-bar").css("width", calculateWidth(average));
            $("#poor-bar").css("width", calculateWidth(poor));
            $("#terrible-bar").css("width", calculateWidth(terrible));

            // 평균 평점 및 평점 개수를 업데이트
            $("#average-rating").text(
                totalRatings > 0
                    ? ((5 * excellent + 4 * good + 3 * average + 2 * poor + terrible) / totalRatings).toFixed(1)
                    : "0.0" // 총 평점이 0일 경우
            );
            $("#excellent-score").text(excellent);
            $("#good-score").text(good);
            $("#average-score").text(average);
            $("#poor-score").text(poor);
            $("#terrible-score").text(terrible);
        }

        // 리뷰를 추가하는 버튼 클릭 이벤트 핸들러
        $("#submitRating").on("click", async function () {
            const ratingValue = $("input[name='rating']:checked").val(); // 선택한 평점 값을 가져옵니다.
            const comment = $("#reviewComment").val(); // 입력된 리뷰 코멘트를 가져옵니다.

            if (!ratingValue) {
                alert("별점을 선택해주세요."); // 평점이 선택되지 않으면 경고 메시지를 출력
                return;
            }

            try {
                // 서버에 리뷰를 추가 요청
                await $.ajax({
                    url: "/product/review/add",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        proId: proId,
                        rating: ratingValue,
                        comment: comment, // 코멘트 데이터 포함
                    }),
                });

                alert("리뷰가 추가되었습니다."); // 성공 메시지
                $("#rating-popup").addClass("hidden"); // 팝업 닫기

                // 리뷰 데이터를 다시 가져와서 업데이트
                await getReviews(proId);

            } catch (error) {
                alert("리뷰 추가에 실패했습니다. 다시 시도해주세요."); // 실패 시 메시지 출력
            }
        });

        // 별점 추가 팝업 열기 버튼 클릭 이벤트 핸들러
        $('#open-rating-popup').on('click', function () {
            if (!loginId || loginId.trim() === '') { // 로그인 여부 확인
                alert('로그인 후 이용할 수 있습니다.'); // 경고 메시지 출력
            } else {
                $('#rating-popup').removeClass('hidden'); // 팝업 표시
            }
        });

        // 팝업 닫기 버튼 이벤트 핸들러
        $("#close-popup").on("click", () => $("#rating-popup").addClass("hidden"));

        // 페이지 로드 시 초기 실행
        getProductIdFromBackend();
    });


    //**************************상품문의**********************************//
    $(document).ready(function () {
        // 페이지가 로드되면 실행될 함수 정의

        // 페이지네이션 클릭 이벤트 처리
        $('#inquiry-pagination').on('click', '.page-link', function (e) {
            e.preventDefault(); // 기본 링크 동작 방지
            const page = $(this).data('page'); // 클릭한 페이지 번호를 가져옴

            if (page) {
                loadInquiryList(page); // 해당 페이지의 데이터를 비동기로 로드
            } else {
                // 페이지 번호가 없을 경우 처리 (현재 비어 있음)
            }
        });

        // 문의 리스트 비동기 로드 함수
        function loadInquiryList(page) {
            $.ajax({
                url: `/product/inquiries?page=${page}&size=5`, // 서버에 비동기 요청을 보낼 URL
                method: 'GET', // HTTP GET 요청
                success: function (data) {
                    setupInquiryList(data.content); // 응답 데이터를 테이블로 출력
                    setupPagination(data, page); // 페이지네이션 설정
                },
                error: function (error) {
                    // 요청 실패 시 처리 (현재 비어 있음)
                }
            });
        }

        // 테이블로 데이터를 출력하는 함수
        function setupInquiryList(content) {
            let html = "<table class='inquiry-table'>"; // 테이블 시작 태그 생성
            html += "<tr><th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>상세보기</th></tr>"; // 테이블 헤더 추가

            // 서버로부터 받은 데이터를 테이블 행으로 추가
            $.each(content, function (index, obj) {
                html += `<tr>
                <td>${obj.inquiryId}</td>
                <td>${obj.title}</td>
                <td>${obj.author}</td>
                <td>${obj.createdAt}</td>
                <td><button class="view-inquiry" data-inquiry-id="${obj.inquiryId}">상세보기</button></td>
            </tr>`;
            });

            html += "</table>"; // 테이블 닫는 태그 추가
            $('#inquiry-list').html(html); // 완성된 테이블을 HTML 요소에 추가
        }

        // 페이지네이션 설정
        function setupPagination(data, currentPage) {
            const $pagination = $('#inquiry-pagination'); // 페이지네이션 요소를 가져옴
            $pagination.empty(); // 기존 페이지네이션을 초기화

            let paginationHtml = ''; // 페이지네이션 HTML을 담을 변수

            // 이전 페이지 버튼 추가
            if (currentPage > 1) {
                paginationHtml += `<span class="page-link" data-page="${currentPage - 1}">◀</span>`;
            }

            // 각 페이지 번호 버튼 추가
            for (let i = 1; i <= data.totalPages; i++) {
                const activeClass = i === currentPage ? 'active' : ''; // 현재 페이지는 활성화 표시
                paginationHtml += `<span class="page-link ${activeClass}" data-page="${i}">${i}</span>`;
            }

            // 다음 페이지 버튼 추가
            if (currentPage < data.totalPages) {
                paginationHtml += `<span class="page-link" data-page="${currentPage + 1}">▶</span>`;
            }

            $pagination.html(paginationHtml); // 페이지네이션 요소에 HTML 추가
        }

        // 상세보기 클릭 이벤트 처리
        $(document).on('click', '.view-inquiry', function (event) {
            event.preventDefault(); // 기본 동작 방지

            const inquiryId = $(this).data('inquiry-id'); // 클릭한 문의 ID를 가져옴
            const currentRow = $(this).closest('tr'); // 클릭한 버튼의 부모 행을 가져옴
            const nextRow = currentRow.next('.detail-row'); // 상세보기 행이 이미 있는지 확인

            if (nextRow.length > 0) {
                nextRow.remove(); // 상세보기 행이 열려 있다면 닫음
                return; // 이후 로직 실행 중단
            }

            $('.detail-row').remove(); // 기존에 열려 있는 모든 상세보기 행 제거

            // 서버로 상세보기 데이터 요청
            $.ajax({
                url: `/product/inquiry/detail/` + inquiryId, // 상세보기 데이터 요청 URL
                method: 'GET', // HTTP GET 요청
                success: function (data) {
                    if (data.success && data.inquiry) {
                        // 데이터가 성공적으로 반환되었을 때 처리
                        const inquiry = data.inquiry;
                        const title = inquiry.title || '제목 없음';
                        const content = inquiry.content || '내용 없음';
                        const author = inquiry.author || '작성자 없음';

                        let detailContent = ''; // 상세보기 내용 HTML 생성
                        detailContent += '<tr class="detail-row">';
                        detailContent += '    <td colspan="4">';
                        detailContent += '        <div class="detail-content">';
                        detailContent += '            <p><strong>제목:</strong> ' + title + '</p>';
                        detailContent += '            <p><strong>내용:</strong> '  + content + '</p>';
                        detailContent += '            <p><strong>작성자:</strong> '  + author + '</p>';
                        detailContent += '        </div>';
                        detailContent += '    </td>';
                        detailContent += '</tr>';

                        currentRow.after(detailContent); // 상세보기 행을 테이블에 추가
                    } else {
                        alert('문의 데이터를 가져오지 못했습니다.'); // 데이터가 없을 경우 경고
                    }
                },
                error: function (error) {
                    alert('오류가 발생했습니다. 다시 시도해주세요.'); // 요청 실패 시 경고
                }
            });
        });

        // 글쓰기 모달 관련 코드
        const writeBtn = document.getElementById('write-btn'); // 글쓰기 버튼 요소
        const modal = document.getElementById('write-modal'); // 모달 요소
        const closeBtn = document.querySelector('.close-btn'); // 모달 닫기 버튼
        const writeForm = document.getElementById('writeForm'); // 글쓰기 폼 요소

        const proId = writeBtn.getAttribute('data-pro-id'); // 상품 번호 가져오기

        // 모달 열기 이벤트
        writeBtn.addEventListener('click', () => {
            modal.style.display = 'block';
        });

        // 모달 닫기 이벤트
        closeBtn.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // 글쓰기 폼 제출 이벤트 처리
        writeForm.addEventListener('submit', (event) => {
            event.preventDefault(); // 기본 폼 제출 동작 방지

            const title = document.getElementById('title').value; // 제목 값 가져오기
            const content = document.getElementById('content').value; // 내용 값 가져오기

            // 서버에 데이터 전송
            fetch(`/product/inquiry/write?proId=${proId}`, {
                method: 'POST', // HTTP POST 요청
                headers: {
                    'Content-Type': 'application/json', // 요청 데이터 타입 지정
                },
                body: JSON.stringify({ title, content }), // 요청 본문에 JSON 데이터 포함
            })
                .then((response) => response.json()) // 응답 데이터를 JSON으로 변환
                .then((data) => {
                    if (data.success) {
                        alert('문의가 등록되었습니다.'); // 성공 메시지 출력
                        modal.style.display = 'none'; // 모달 닫기
                        loadInquiryList(1); // 첫 페이지로 리스트 다시 로드
                    } else {
                        alert('등록에 실패했습니다.'); // 실패 메시지 출력
                    }
                })
                .catch((error) => {
                    alert('오류가 발생했습니다.'); // 네트워크 오류 메시지 출력
                });
        });

        loadInquiryList(1); // 페이지가 처음 로드되면 첫 페이지 데이터 로드
    });


</script>
</body>
</html>