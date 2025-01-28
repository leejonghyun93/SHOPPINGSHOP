<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<jsp:include page="/WEB-INF/views/layout/header/header.jsp"/>
<jsp:include page="/WEB-INF/views/layout/categoryBar/categoryBar.jsp"/>

<div class="content">
    <!-- 공지사항 페이지 제목 -->
    <h1>공지사항</h1>

    <!-- 검색 및 정렬 폼 -->
    <form method="get" action="/board/list" class="search-sort-form">
        <div>
            <!-- 정렬 옵션 선택 -->
            <label for="sort">정렬:</label>
            <select name="sort" id="sort" onchange="this.form.submit()">
                <!-- 최신순 정렬 옵션 -->
                <option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신순</option>
                <!-- 오래된순 정렬 옵션 -->
                <option value="oldest" ${param.sort == 'oldest' ? 'selected' : ''}>오래된순</option>
            </select>
        </div>
        <div>
            <!-- 검색어 입력 필드 -->
            <label for="search">검색:</label>
            <input type="text" name="search" id="search" value="${param.search}" placeholder="제목 검색">
            <!-- 검색 버튼 -->
            <button type="submit">검색</button>
        </div>
        <!-- 현재 페이지 번호와 페이지 크기를 hidden 필드로 전달 -->
        <input type="hidden" name="pageNum" value="${pageNum}"/>
        <input type="hidden" name="pageSize" value="${pageSize}"/>
    </form>

    <!-- 총 게시글 수 표시 -->
    <div class="total-count">
        <p>게시글 총 건수: ${totalRecords}</p>
    </div>

    <!-- 게시글 목록 테이블 -->
    <table class="board-table">
        <thead>
        <tr>
            <!-- 테이블 헤더: 번호, 제목, 작성자, 작성일 -->
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <!-- 게시글 리스트를 반복하며 테이블 행 생성 -->
        <c:forEach var="board" items="${boardList}">
            <tr>
                <!-- 게시글 번호 -->
                <td>${board.noticeId}</td>
                <!-- 게시글 제목 (클릭 시 상세보기 페이지로 이동) -->
                <td><a href="/board/view/${board.noticeId}">${board.title}</a></td>
                <!-- 게시글 작성자 -->
                <td>${board.userId}</td>
                <!-- 게시글 작성일 (yyyy-MM-dd 형식) -->
                <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <!-- 총 페이지 수 계산 -->
        <c:set var="totalPages" value="${(totalRecords + pageSize - 1) / pageSize}"/>

        <!-- 이전 페이지 링크 -->
        <c:if test="${pageNum > 1}">
            <a href="?pageNum=${pageNum - 1}&pageSize=${pageSize}">이전</a>
        </c:if>
        <c:if test="${pageNum <= 1}">
            <span class="disabled">이전</span>
        </c:if>

        <!-- 페이지 번호 반복 출력 -->
        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <!-- 현재 페이지 번호 강조 표시 -->
                <c:when test="${i == pageNum}">
                    <strong>${i}</strong>
                </c:when>
                <!-- 다른 페이지 번호는 링크로 표시 -->
                <c:otherwise>
                    <a href="?pageNum=${i}&pageSize=${pageSize}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- 다음 페이지 링크 -->
        <c:if test="${pageNum < totalPages}">
            <a href="?pageNum=${pageNum + 1}&pageSize=${pageSize}">다음</a>
        </c:if>
        <c:if test="${pageNum >= totalPages}">
            <span class="disabled">다음</span>
        </c:if>

        <!-- 게시글이 없을 경우 메시지 표시 -->
        <c:if test="${empty boardList}">
            <p>게시글이 없습니다.</p>
        </c:if>
    </div>
</div>


<jsp:include page="/WEB-INF/views/layout/footer/footer.jsp"/>
</body>
</html>
