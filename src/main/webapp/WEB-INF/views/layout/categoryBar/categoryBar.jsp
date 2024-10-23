<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <style>
        /*.category-container {*/
        /*    !*width: 80%; *!*/
        /*}*/

        /*.main-category-list {*/
        /*    list-style-type: none;*/
        /*    width: 100%;*/
        /*    height: 25px;*/
        /*    padding: 0;*/
        /*    margin-top: 0;*/
        /*    margin-bottom: 15px;*/
        /*    display: flex; !* 가로로 나열 *!*/
        /*    justify-content: center; !* 중앙 정렬 *!*/
        /*    flex-wrap: wrap; !* 줄 바꿈 *!*/
        /*    font-size: 15px;*/
        /*}*/

        /*.main-category-item {*/
        /*    font-weight: bold;*/
        /*    margin: 10px 20px;*/
        /*    position: relative; !* 자식 요소의 절대 위치를 위해 relative *!*/
        /*    cursor: pointer; !* 클릭할 수 있는 스타일 *!*/
        /*}*/

        /*.sub-category-list {*/
        /*    display: none; !* 기본적으로 숨김 *!*/
        /*    flex-wrap: nowrap; !* 줄 바꿈 방지 *!*/
        /*    list-style-type: none;*/
        /*    position: absolute; !* 절대 위치 *!*/
        /*    top: 100%; !* 대분류 하단에 위치 *!*/
        /*    left: 0; !* 대분류의 왼쪽에 위치 *!*/
        /*    margin: 0;*/
        /*    padding: 0;*/
        /*    background-color: white; !* 배경색 *!*/
        /*    border: 1px solid #ccc; !* 테두리 *!*/
        /*    z-index: 1; !* 다른 요소 위에 위치 *!*/
        /*}*/

        /*.sub-category-item {*/
        /*    margin: 0; !* 간격 제거 *!*/
        /*    padding: 5px 10px; !* 패딩 추가 *!*/
        /*    cursor: pointer; !* 클릭할 수 있는 스타일 *!*/
        /*    white-space: nowrap; !* 텍스트 줄바꿈 방지 *!*/
        /*}*/

        /*!* 대분류 마우스 오버 시 중분류 보이도록 *!*/
        /*.main-category-item:hover .sub-category-list {*/
        /*    display: flex; !* 마우스가 올라갔을 때 가로로 나열하여 보이기 *!*/
        /*}*/
    </style>
</head>
<body>
<%--<div class="category-container">--%>
<%--    <ul class="main-category-list">--%>
<%--        <c:forEach var="category" items="${mainCategories}">--%>
<%--            <li class="main-category-item">--%>
<%--                    ${category.categoryName}--%>
<%--                <ul class="sub-category-list">--%>
<%--                    <c:forEach var="subCategory" items="${category.subCategories}">--%>
<%--                        <li class="sub-category-item" onclick="location.href='/subCategoryId/${subCategory.subCategoryId}'">--%>
<%--                                ${subCategory.subCategoryName}--%>
<%--                        </li>--%>
<%--                    </c:forEach>--%>
<%--                </ul>--%>
<%--            </li>--%>
<%--        </c:forEach>--%>
<%--    </ul>--%>
<%--</div>--%>
</body>
</html>
