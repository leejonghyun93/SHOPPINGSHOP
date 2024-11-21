<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}"/>

<html>
<head>
    <title>공지사항</title>
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
            flex-direction: column;
            align-items: center;
            padding-bottom: 50px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        /* 검색 및 정렬 */
        .search-sort-form {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            width: 80%;
            margin-bottom: 20px;
        }

        .search-sort-form label {
            font-size: 14px;
            color: #333;
        }

        .search-sort-form select, .search-sort-form input {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 14px;
        }

        .search-sort-form button {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
            background-color: #f4f4f4;
            font-size: 14px;
            cursor: pointer;
            color: #333;
            transition: background-color 0.3s ease;
        }

        .search-sort-form button:hover {
            background-color: #ddd;
        }

        /* 테이블 */
        .board-table {
            width: 80%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .board-table th, .board-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .board-table th {
            background-color: #f4f4f4;
        }

        /* 페이징 */
        .pagination {
            text-align: center;
            margin-top: 10px;
        }

        .pagination a, .pagination strong {
            padding: 5px 10px;
            margin: 0 3px;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }

        .pagination a:hover {
            background-color: #f4f4f4;
        }

        .pagination strong {
            background-color: #ddd;
            color: #000;
        }

        .pagination .disabled {
            color: #ccc;
            border-color: #ccc;
            pointer-events: none;
        }
    </style>
</head>
<body>
<!-- 공통 헤더와 카테고리 바 포함 -->
<jsp:include page="/WEB-INF/views/layout/header/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" />

<div class="content">
    <h1>공지사항</h1>

    <!-- 검색 및 정렬 -->
    <form method="get" action="/board/list" class="search-sort-form">
        <div>
            <label for="sort">정렬:</label>
            <select name="sort" id="sort" onchange="this.form.submit()">
                <option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신순</option>
                <option value="oldest" ${param.sort == 'oldest' ? 'selected' : ''}>오래된순</option>
            </select>
        </div>
        <div>
            <label for="search">검색:</label>
            <input type="text" name="search" id="search" value="${param.search}" placeholder="제목 검색">
            <button type="submit">검색</button>
        </div>
        <input type="hidden" name="pageNum" value="${pageNum}" />
        <input type="hidden" name="pageSize" value="${pageSize}" />
    </form>

    <!-- 게시판 테이블 -->
    <table class="board-table">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="board" items="${boardList}">
            <tr>
                <td>${board.noticeId}</td>
                <td><a href="/board/view/${board.noticeId}">${board.title}</a></td>
                <td>${board.userId}</td>
                <td>${board.createdAt}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 페이징 -->
    <div class="pagination">
        <c:set var="totalPages" value="${(totalRecords + pageSize - 1) / pageSize}" />

        <c:if test="${pageNum > 1}">
            <a href="?pageNum=${pageNum - 1}&pageSize=${pageSize}">이전</a>
        </c:if>
        <c:if test="${pageNum <= 1}">
            <span class="disabled">이전</span>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == pageNum}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?pageNum=${i}&pageSize=${pageSize}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${pageNum < totalPages}">
            <a href="?pageNum=${pageNum + 1}&pageSize=${pageSize}">다음</a>
        </c:if>
        <c:if test="${pageNum >= totalPages}">
            <span class="disabled">다음</span>
        </c:if>
    </div>
</div>

<!-- 공통 푸터 포함 -->
<jsp:include page="/WEB-INF/views/layout/footer/footer.jsp" />
</body>
</html>
