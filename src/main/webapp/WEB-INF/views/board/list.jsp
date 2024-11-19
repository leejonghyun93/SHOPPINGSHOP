<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>--%>

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/>
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

        .pagination {
            text-align: center;
            margin-top: 10px;
        }

        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            color: #333;
        }

        .pagination strong {
            margin: 0 5px;
            font-weight: bold;
        }

        .pagination .disabled {
            color: #ccc;
            pointer-events: none;
            text-decoration: none;
        }
    </style>
</head>
<body>
<!-- 공통 헤더와 카테고리 바 포함 -->
<jsp:include page="/WEB-INF/views/layout/header/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" />

<div class="content">
    <h1>공지사항</h1>
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

    <!-- 페이징 네비게이션 -->
    <div class="pagination">
        <!-- 총 페이지 계산 -->
        <c:set var="totalPages" value="${(totalRecords + pageSize - 1) / pageSize}" />

        <!-- 이전 버튼 -->
        <c:if test="${pageNum > 1}">
            <a href="?pageNum=${pageNum - 1}&pageSize=${pageSize}">이전</a>
        </c:if>
        <c:if test="${pageNum <= 1}">
            <span class="disabled">이전</span>
        </c:if>

        <!-- 페이지 번호 -->
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

        <!-- 다음 버튼 -->
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
