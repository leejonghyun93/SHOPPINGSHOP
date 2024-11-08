<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />
<html>
<head>
    <title>Title</title>
    <style>
        html, body {
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

        /* 제품 목록 전체 컨테이너 */
        .product-list-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 제품 리스트 */
        .product-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 상품이 4개씩 그리드 형태로 배치됨 */
            grid-gap: 20px; /* 상품들 사이에 여백 추가 */
            justify-items: center; /* 상품을 중앙에 정렬 */
            margin: 0 auto;
            padding: 20px 0;
        }

        .product-item {
            width: 100%;
            max-width: 300px; /* 각 상품의 최대 너비를 설정 */
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
            background-color: #fff;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .product-item img {
            width: 100%;
            height: auto; /* 이미지가 상품 영역에 맞게 크기 조절 */
            border-radius: 8px;
        }

        .product-item:hover {
            transform: scale(1.05); /* 마우스 오버 시 크기 커짐 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 마우스 오버 시 그림자 효과 */
        }

        /* 제품 이미지 */
        .product-image img {
            width: 100%;
            height: auto;
            max-width: 200px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        /* 제품 정보 */
        .product-info {
            text-align: center;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .product-stock {
            font-size: 12px;
            color: #999;
            margin-bottom: 15px;
        }

        /* 상품 보기 링크 */
        .product-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .product-link:hover {
            background-color: #0056b3;
        }

        /* 푸터 스타일 (필요시 수정) */
        footer {
            padding: 20px;
            background-color: #f1f1f1;
            text-align: center;
        }

    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="content">
    <!-- 제품 목록을 보여주는 영역 -->
    <div class="product-list">
        <c:forEach var="product" items="${productList}">
            <div class="product-item">
                <!-- productId에 따라 이미지 경로를 동적으로 설정 -->
                <img src="<c:url value='/resources/img/${product.imageUrl}'/>" alt="${product.proName} 이미지"/>
                <h3><a href="<c:url value='/product/detail/${product.proId}'/>">${product.proName}</a></h3>
                <p>가격: ${product.proPrice}원</p>
            </div>
        </c:forEach>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
