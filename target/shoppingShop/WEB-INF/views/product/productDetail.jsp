<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!-- 세션 사용 설정 -->

<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId }"/>

<html lang="en">
<head>
    <title>상품 상세보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            height: 100vh;
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
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            padding: 20px;
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
    </style>
</head>

<body>

<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>

<div class="container">
    <!-- 상품 이미지 -->
    <div class="product-image">
        <img src="${pageContext.request.contextPath}/resources/img/shoes.JPG" class="productTitleImg" alt="상품 이미지">
    </div>

    <!-- 상품 정보 -->
    <div class="product-details">
        <h1 class="productTitle">상품 이름 : 버블</h1>
        <span class="productPrice">상품 가격 : 2000원</span>

        <h5 class="productDetail">
            상품 정보
            <button id="toggleButton" class="toggle-btn">+</button>
        </h5>

        <!-- 추가 정보 (토글로 표시) -->
        <ul class="additional-info" id="additionalInfo">
            <li>판매가: 2500원</li>
            <li>할인가: 2000원</li>
            <li>할인기간: 2024-10-30까지</li>
            <li>배송비: 무료</li>
        </ul>

        <!-- 색상 선택 버튼 -->
        <div class="option-section">
            <span class="option-label">색상</span>
            <div class="option-buttons" id="colorOptions">
                <div class="option-button" data-value="블랙">블랙</div>
                <div class="option-button" data-value="화이트">화이트</div>
                <div class="option-button" data-value="레드">레드</div>
            </div>
        </div>

        <!-- 사이즈 선택 버튼 (처음에는 비활성화) -->
        <div class="option-section">
            <span class="option-label">사이즈</span>
            <div class="option-buttons disabled" id="sizeOptions">
                <div class="option-button" data-value="250">250</div>
                <div class="option-button" data-value="260">260</div>
                <div class="option-button" data-value="270">270</div>
                <div class="option-button" data-value="280">280</div>
            </div>
        </div>

        <!-- 구매하기 버튼 -->
        <a href="#" class="buy-button">구매하기</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    // 색상 버튼 클릭 시 사이즈 선택 활성화 및 스타일 변경
    const colorButtons = document.querySelectorAll('#colorOptions .option-button');
    const sizeButtons = document.querySelectorAll('#sizeOptions .option-button');
    const sizeOptions = document.getElementById('sizeOptions');

    colorButtons.forEach(button => {
        button.addEventListener('click', function () {
            // 다른 색상 버튼의 활성화 상태 해제
            colorButtons.forEach(btn => btn.classList.remove('active'));
            // 클릭된 버튼 활성화
            this.classList.add('active');

            // 사이즈 선택 버튼 활성화
            sizeOptions.classList.remove('disabled');

            // 이전에 선택된 사이즈 초기화
            sizeButtons.forEach(btn => btn.classList.remove('active'));

            // 사이즈 버튼 클릭 시 활성화 스타일 적용
            sizeButtons.forEach(sizeBtn => {
                sizeBtn.addEventListener('click', function () {
                    // 다른 사이즈 버튼의 활성화 상태 해제
                    sizeButtons.forEach(btn => btn.classList.remove('active'));
                    // 클릭된 버튼 활성화
                    this.classList.add('active');
                });
            });
        });
    });

    // 추가 정보 토글 버튼 기능
    document.getElementById('toggleButton').addEventListener('click', function () {
        var additionalInfo = document.getElementById('additionalInfo');
        var isHidden = additionalInfo.style.display === 'none' || additionalInfo.style.display === '';

        if (isHidden) {
            additionalInfo.style.display = 'block';
            this.textContent = '-'; // 플러스 버튼을 마이너스로 변경
        } else {
            additionalInfo.style.display = 'none';
            this.textContent = '+'; // 마이너스 버튼을 다시 플러스로 변경
        }
    });
</script>

</body>
</html>
