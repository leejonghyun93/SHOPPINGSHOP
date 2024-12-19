<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            display: none; /* 초기에는 모든 콘텐츠를 숨김 */
        }

        .tab-content.active {
            display: block; /* 활성 탭의 콘텐츠만 표시 */
        }

        #rating-bars {
            margin-top: 20px;
        }

        .rating-item {
            display: flex; /* 가로 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
            justify-content: space-between; /* 요소 간 간격 조절 */
            margin-bottom: 10px;
        }

        .rating-item label {
            width: 100px; /* 라벨의 고정 너비 */
            text-align: right; /* 라벨 정렬 */
            margin-right: 10px;
        }

        .bar {
            width: 100%; /* 막대가 가로로 꽉 채워지도록 */
            background-color: #ddd; /* 기본 배경색 */
        }

        .progress {
            width: 0%; /* 초기 막대의 길이 */
            height: 20px; /* 막대 높이 */
            background-color: #4caf50; /* 녹색으로 막대 스타일링 */
        }
        .rating-item span {
            width: 50px; /* 점수 표시 고정 너비 */
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
            <div id="reviews-tab" class="tab active" onclick="showTab('reviews')">상품 후기</div>
            <div id="details-tab" class="tab" onclick="showTab('details')">상세 정보</div>
            <div id="inquiry-tab" class="tab" onclick="showTab('inquiry')">상품 문의</div>
            <div id="guide-tab" class="tab" onclick="showTab('guide')">구매 안내</div>
        </div>
        <div id="reviews" class="tab-content active">
            <h2>상품 후기</h2>
            <div id="total-rating">
                <h3>총 별점: <span id="average-rating">0.0</span> / 5</h3>
            </div>
            <div id="rating-bars">
                <div class="rating-item">
                    <label>아주좋아요</label>
                    <div class="bar">
                        <div class="progress" id="excellent-bar"></div>
                    </div>
                    <span id="excellent-score">0</span>
                </div>
                <div class="rating-item">
                    <label>맘에 들어요</label>
                    <div class="bar">
                        <div class="progress" id="good-bar"></div>
                    </div>
                    <span id="good-score">0</span>
                </div>
                <div class="rating-item">
                    <label>보통이에요</label>
                    <div class="bar">
                        <div class="progress" id="average-bar"></div>
                    </div>
                    <span id="average-score">0</span>
                </div>
                <div class="rating-item">
                    <label>그냥그래요</label>
                    <div class="bar">
                        <div class="progress" id="poor-bar"></div>
                    </div>
                    <span id="poor-score">0</span>
                </div>
                <div class="rating-item">
                    <label>별로에요</label>
                    <div class="bar">
                        <div class="progress" id="terrible-bar"></div>
                    </div>
                    <span id="terrible-score">0</span>
                </div>
            </div>
            <button id="open-rating-popup">별점 추가</button>

            <!-- 별점 팝업 -->
            <div id="rating-popup" class="hidden">
                <h3>별점을 선택해주세요</h3>
                <div>
                    <input type="radio" id="excellent" name="rating" value="excellent">
                    <label for="excellent">아주좋아요</label><br>
                    <input type="radio" id="good" name="rating" value="good">
                    <label for="good">맘에 들어요</label><br>
                    <input type="radio" id="average" name="rating" value="average">
                    <label for="average">보통이에요</label><br>
                    <input type="radio" id="poor" name="rating" value="poor">
                    <label for="poor">그냥그래요</label><br>
                    <input type="radio" id="terrible" name="rating" value="terrible">
                    <label for="terrible">별로에요</label><br>
                </div>
                <button id="submitRating">평점 추가</button>
                <button id="close-popup">닫기</button>
            </div>
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
            totalPrice: "${productDetail.totalPrice}"
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
                    return response.text().then(text => {
                        throw new Error(text);
                    });
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
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.tab-content');

        // 모든 탭과 콘텐츠 비활성화
        tabs.forEach(tab => tab.classList.remove('active'));
        contents.forEach(content => content.classList.remove('active'));

        // 선택한 탭과 콘텐츠 활성화
        document.getElementById(tabId + '-tab').classList.add('active'); // 탭 활성화
        document.getElementById(tabId).classList.add('active'); // 콘텐츠 활성화
    }
    document.getElementById("open-rating-popup").addEventListener("click", function() {
        // 별점 추가 로직
        fetch("your-server-endpoint-for-reviews") // 서버에서 데이터를 받아옵니다.
            .then(response => response.json())
            .then(reviews => {
                const ratingsData = calculateRatings(reviews);
                updateRatingsOnPage(ratingsData);
            });
    });
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
                if (!response || !Array.isArray(response) || response.length === 0) {
                    throw new Error("리뷰 데이터가 비어 있습니다.");
                }

                const calculatedData = calculateRatings(response); // 평점 데이터 계산
                updateRatingsOnPage(calculatedData); // 평점 업데이트
            } catch (error) {
                console.error("리뷰 데이터 가져오기 실패:", error);
                alert("리뷰 데이터를 가져오는 데 실패했습니다.");
            }
        }
        function calculateRatings(reviews) {
            if (reviews.length === 0) {
                return { excellent: 0, good: 0, average: 0, poor: 0, terrible: 0 };
            }

            let counts = { excellent: 0, good: 0, average: 0, poor: 0, terrible: 0 };

            reviews.forEach(review => {
                switch (review.rating) {
                    case 5: counts.excellent++; break;
                    case 4: counts.good++; break;
                    case 3: counts.average++; break;
                    case 2: counts.poor++; break;
                    case 1: counts.terrible++; break;
                }
            });

            return counts;
        }

        function updateRatingsOnPage(data) {
            console.log(data);
            const { excellent, good, average, poor, terrible } = data;

            const totalRatings = Number(excellent) + Number(good) + Number(average) + Number(poor) + Number(terrible);

            if (totalRatings > 0) {
                const calculateWidth = (value) => `${(value / totalRatings) * 100}%`;

                document.getElementById("excellent-bar").style.width = calculateWidth(excellent);
                document.getElementById("good-bar").style.width = calculateWidth(good);
                document.getElementById("average-bar").style.width = calculateWidth(average);
                document.getElementById("poor-bar").style.width = calculateWidth(poor);
                document.getElementById("terrible-bar").style.width = calculateWidth(terrible);
            } else {
                document.getElementById("excellent-bar").style.width = '0%';
                document.getElementById("good-bar").style.width = '0%';
                document.getElementById("average-bar").style.width = '0%';
                document.getElementById("poor-bar").style.width = '0%';
                document.getElementById("terrible-bar").style.width = '0%';
            }

            const weightedSum =
                Number(excellent) * 5 + Number(good) * 4 + Number(average) * 3 + Number(poor) * 2 + Number(terrible) * 1;
            const averageRating = totalRatings > 0 ? weightedSum / totalRatings : 0;

            document.getElementById("average-rating").innerText = averageRating.toFixed(1);

            document.getElementById("excellent-score").innerText = excellent;
            document.getElementById("good-score").innerText = good;
            document.getElementById("average-score").innerText = average;
            document.getElementById("poor-score").innerText = poor;
            document.getElementById("terrible-score").innerText = terrible;
        }
        function updateProgressBar(score, total) {
            const percentage = (score / total) * 100;
            return percentage.toFixed(1); // 소수점 1자리로 나타내기
        }

// 데이터 업데이트
        document.getElementById('excellent-bar').style.width = updateProgressBar(excellentCount, totalRating) + '%';
        document.getElementById('excellent-score').innerText = excellentCount;

        console.log('updateRatingsOnPage called');

        function handleServerResponse(response) {
            if (Array.isArray(response) && response.length > 0) {
                updateRatingsOnPage({
                    excellent: Number(response[0].excellent || 0),
                    good: Number(response[0].good || 0),
                    average: Number(response[0].average || 0),
                    poor: Number(response[0].poor || 0),
                    terrible: Number(response[0].terrible || 0),
                });
            } else {
                console.error("Invalid response format:", response);
            }
        }

        const totalRatings =
            Number(excellent) + Number(good) + Number(average) + Number(poor) + Number(terrible);

        function handleServerResponse(response) {
            console.log("Response from server:", response); // 서버 응답 확인

            if (Array.isArray(response) && response.length > 0) {
                const data = response[0];
                updateRatingsOnPage({
                    excellent: Number(data.excellent || 0),
                    good: Number(data.good || 0),
                    average: Number(data.average || 0),
                    poor: Number(data.poor || 0),
                    terrible: Number(data.terrible || 0),
                });
            } else {
                console.error("Invalid response format:", response);
            }
        }



        // 초기 로드시 상품 ID 가져오기
        getProductIdFromBackend();

        $("#open-rating-popup").on("click", function () {
            $("#rating-popup").removeClass("hidden");
        });

        $("#close-popup").on("click", function () {
            $("#rating-popup").addClass("hidden");
        });

        $("#submitRating").on("click", async function () {
            const ratingValueElem = $("input[name='rating']:checked");

            if (ratingValueElem.length === 0) {
                alert("별점을 선택해주세요.");
                return;
            }

            const ratingValue = ratingValueElem.val(); // 체크된 라디오 버튼의 value
            const comment = $("#review-comment").val(); // 추가된 리뷰 내용

            try {
                const response = await $.post("/product/review/add", {
                    proId: proId, // 프로덕트 ID
                    rating: ratingValue, // 선택된 평점 값
                    comment: comment, // 추가된 리뷰
                });

                if (!response) {
                    throw new Error("평점 추가 실패");
                }

                const updatedData = calculateRatings(response); // 리뷰 업데이트 데이터 계산
                updateRatingsOnPage(updatedData); // 평점 갱신
                $("#rating-popup").addClass("hidden"); // 팝업 숨기기
            } catch (error) {
                console.error("평점 추가 실패:", error);
                alert("평점 추가에 실패했습니다. 다시 시도해주세요.");
            }
        });
    });


</script>
</body>
</html>