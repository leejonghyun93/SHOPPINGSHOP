<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!-- 세션 사용 설정 -->

<c:set var="loginId"
       value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId }"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<h1 class="title">shoppingShop</h1>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<h1>${subCategoryName}</h1>
<c:forEach var="product" items="${productList}">

</c:forEach>


<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
