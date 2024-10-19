<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <style>
        .category-container {
            width: 80%;
            margin: 0 auto;
        }

        .main-category-list {
            list-style-type: none;
            padding: 0;
            margin: 20px 0;
        }

        .main-category-item {
            font-weight: bold;
            margin: 10px 0;
        }

        .sub-category-list {
            list-style-type: none;
            margin-left: 20px;
            padding: 0;
        }

        .sub-category-item {
            margin: 5px 0;
        }

    </style>
</head>
<body>
<div class="category-container">
    <h2>카테고리</h2>
    <ul class="main-category-list">
        <c:forEach var="category" items="${mainCategories}">
            <li class="main-category-item">${category.categoryName}
                <ul class="sub-category-list">
                    <c:forEach var="subCategory" items="${category.subCategories}">
                        <li class="sub-category-item">${subCategory.subCategoryName}</li>
                    </c:forEach>
                </ul>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>