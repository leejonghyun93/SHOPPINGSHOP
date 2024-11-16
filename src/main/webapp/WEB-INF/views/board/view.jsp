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

    h1 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }

    .info {
      margin-bottom: 20px;
    }

    .info div {
      margin-bottom: 10px;
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
  </style>
</head>
<body>
<!-- 공통 헤더와 카테고리 바 포함 -->
<jsp:include page="/WEB-INF/views/layout/header/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" />

<div class="content">
  <h1>${notice.title}</h1>
  <div class="info">
    <div><strong>작성자:</strong> ${notice.userId}</div>
    <div><strong>작성일:</strong> ${notice.createdAt}</div>
    <div><strong>수정일:</strong> ${notice.updatedAt}</div>
  </div>
  <div class="content-body">
    <p>${notice.content}</p>
  </div>
  <a href="/board/list" class="back-button">목록으로 돌아가기</a>
</div>

<!-- 공통 푸터 포함 -->
<jsp:include page="/WEB-INF/views/layout/footer/footer.jsp" />
</body>
</html>
