<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}"/>

<html>
<head>
  <title>공지사항 상세보기</title>
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

    .notice-table {
      width: 80%;
      margin: 20px auto;
      border-collapse: collapse;
      font-family: Arial, sans-serif;
    }

    .notice-title {
      background-color: #f4f4f4;
      font-size: 24px;
      text-align: left;
      padding: 15px;
      color: #333;
      border: 1px solid #ddd;
    }

    .notice-table th, .notice-table td {
      padding: 10px;
      border: 1px solid #ddd;
      color: #333;
      vertical-align: top;
    }

    .notice-table th:first-child {
      width: 10%;
      text-align: left;
      background-color: #007bff;
      color: white;
    }

    .notice-table th[colspan="2"] {
      width: 90%;
      text-align: left;
    }

    .notice-table tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    .navigation {
      display: flex;
      justify-content: space-between;
      width: 80%;
      margin: 20px auto;
    }

    .back-button {
      display: block;
      margin: 20px auto;
      padding: 10px 20px;
      text-align: center;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 4px;
    }

    .back-button:hover {
      background-color: #0056b3;
    }
    .notice-content {
      height: 200px; /* 원하는 세로 크기 */
      vertical-align: top; /* 내용 정렬 설정 */
    }
  </style>
</head>
<body>
<!-- 공통 헤더와 카테고리 바 포함 -->
<jsp:include page="/WEB-INF/views/layout/header/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" />

<div class="content">
  <!-- 공지사항 테이블 -->
  <table class="notice-table">
    <thead>
    <tr>
      <th>제목</th>
      <th colspan="2" class="notice-title">${notice.title}</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="3" class="notice-content">${notice.content}</td>
    </tr>
    </tbody>
  </table>

  <!-- 이전글, 다음글 링크 -->
  <div class="navigation">
    <c:if test="${previousNotice != null}">
      <a href="/board/view/${previousNotice.noticeId}">이전글: ${previousNotice.title}</a>
    </c:if>
    <c:if test="${previousNotice == null}">
      <span>이전글 없음</span>
    </c:if>

    <c:if test="${nextNotice != null}">
      <a href="/board/view/${nextNotice.noticeId}">다음글: ${nextNotice.title}</a>
    </c:if>
    <c:if test="${nextNotice == null}">
      <span>다음글 없음</span>
    </c:if>
  </div>

  <a href="/board/list" class="back-button">목록으로 돌아가기</a>
</div>

<!-- 공통 푸터 포함 -->
<jsp:include page="/WEB-INF/views/layout/footer/footer.jsp" />
</body>
</html>
