<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />
<html>
<head>
    <title>메인페이지</title>
    <style>
        body {
            margin: 0 auto;
        }


        /* 슬라이드 컨테이너 스타일 */
        .slideshow-container {
            position: relative;
            width: 100%;
            overflow: hidden;
        }

        /* 각 슬라이드 이미지 스타일 */
        .mySlides {
            display: none;
        }

        /* 슬라이드 이미지 스타일 */
        .mySlides img {
            width: 100%;
            height: 500px;
            /* 모든 이미지 높이 고정 */
            display: block;
            /* 이미지 주변의 공백 제거 */
        }

        /* 이전/다음 버튼 스타일 */
        .prev,
        .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            background-color: rgba(0, 0, 0, 0.5);
            font-weight: bold;
            font-size: 18px;
            border-radius: 3px;
            user-select: none;
        }

        /* 오른쪽 버튼 위치 */
        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

        /* 슬라이드 점 스타일 */
        .dot {
            cursor: pointer;
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }

        .active,
        .dot:hover {
            background-color: #717171;
        }

        /* 상품 리스트 스타일 */
        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 20px;
        }

        .product-item {
            width: 23%;
            /* 4개 상품을 가로로 나열 */
            margin-bottom: 20px;
            text-align: center;
        }

        .product-item img {
            width: 80%;
            height: 300px;
            /* 비율에 맞게 높이 자동 조정 */
        }

        .product-item h3 {
            margin: 10px 0;
        }

        .product-item p {
            color: #777;
        }

        .bestSelling {
            text-align: center;
            color: blue;
        }

        .bestText {
            text-align: center;
            color: #bbb;
            margin-bottom: 50px;
        }
    </style>
</head>

<body>


<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="slideshow-container">
    <div class="mySlides">
        <img src="<c:url value='/resources/img/pants.JPG'/>" alt="Slide 1">
    </div>

    <div class="mySlides">
        <img src="<c:url value='/resources/img/shoes.JPG'/>" alt="Slide 2">
    </div>

    <div class="mySlides">
        <img src="<c:url value='/resources/img/top.JPG'/>" alt="Slide 3">
    </div>


    <!-- 이전 및 다음 버튼 -->
    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>

<br>

<!-- 슬라이드 점 -->
<div style="text-align:center">
    <span class="dot" onclick="currentSlide(1)"></span>
    <span class="dot" onclick="currentSlide(2)"></span>
    <span class="dot" onclick="currentSlide(3)"></span>
</div>
<div>
    <h1 class="bestSelling">Big Item</h1>
    <h4 class="bestText">금주 가장 많이 팔린 옷</h4>
</div>
<!-- 상품 리스트 -->
<div class="product-list">
    <c:forEach var="product" items="${productList}">
        <div class="product-item">
            <img src="<c:url value='/resources/img/${product.imageUrl}'/>" alt="${product.proName} 이미지"/>
            <h3><a href="<c:url value='/product/detail/${product.proId}'/>">${product.proName}</a></h3>
            <p>가격: ${product.proPrice}원</p>
        </div>
    </c:forEach>
    <div class="product-item">
        <img src="<c:url value='/resources/img/shoes.JPG'/>" alt="Product 2">
        <h3><a href="<c:url value='/product/detail/2'/>">상품명 2</a></h3>
        <p>가격: 20,000원</p>
    </div>
    <div class="product-item">
        <img src="<c:url value='/resources/img/top.JPG'/>" alt="Product 3">
        <h3><a href="<c:url value='/product/detail/3'/>">상품명 3</a></h3>
        <p>가격: 30,000원</p>
    </div>
    <div class="product-item">
        <img src="<c:url value='/resources/img/pants.JPG'/>" alt="Product 4">
        <h3><a href="<c:url value='/product/detail/4'/>">상품명 4</a></h3>
        <p>가격: 40,000원</p>
    </div>
    <div class="product-item">
        <img src="<c:url value='/resources/img/shoes.JPG'/>" alt="Product 5">
        <h3><a href="<c:url value='/product/detail/5'/>">상품명 5</a></h3>
        <p>가격: 50,000원</p>
    </div>
    <div class="product-item">
        <img src="<c:url value='/resources/img/top.JPG'/>" alt="Product 6">
        <h3><a href="<c:url value='/product/detail/6'/>">상품명 6</a></h3>
        <p>가격: 60,000원</p>
    </div>
    <div class="product-item">
        <img src="<c:url value='/resources/img/top.JPG'/>" alt="Product 7">
        <h3><a href="<c:url value='/product/detail/7'/>">상품명 7</a></h3>
        <p>가격: 70,000원</p>
    </div>
    <div class="product-item">
        <img src="<c:url value='/resources/img/top.JPG'/>" alt="Product 8">
        <h3><a href="<c:url value='/product/detail/8'/>">상품명 8</a></h3>
        <p>가격: 80,000원</p>
    </div>
</div>


<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>

<script>
    let slideIndex = 1;
    showSlides(slideIndex);

    // 자동 슬라이드 기능
    setInterval(function () {
        plusSlides(1);
    }, 3000); // 3초마다 슬라이드 전환

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("mySlides");
        let dots = document.getElementsByClassName("dot");
        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex - 1].style.display = "block";
        dots[slideIndex - 1].className += " active";
    }
</script>

</body>

</html>
