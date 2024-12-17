<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : ''}" />
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}" />
<html>
<head>
    <title>주문내역</title>
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

        .orders-title {
            text-align: center;
            margin: 20px 0;
            font-size: 28px;
            font-weight: bold;
            color: #333;
        }

        .orders-container {
            width: 90%;
            margin: 0 auto;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .orders-date-group {
            margin-bottom: 30px;
        }

        .date-header {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
            color: #444;
            border-bottom: 2px solid #ddd;
            padding-bottom: 5px;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .orders-table th, .orders-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        .orders-table th {
            background-color: #f7f7f7;
            font-weight: bold;
            color: #555;
        }

        .orders-table tr:hover {
            background-color: #f2f2f2;
        }

        .empty-message {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 16px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header/header.jsp" %>
<%@ include file="/WEB-INF/views/layout/categoryBar/categoryBar.jsp" %>
<div class="content">
    <div class="orders-container">
        <h2 class="orders-title">My Orders</h2>

        <c:if test="${!hasOrders}">
            <div class="empty-message">
                아직 주문 내역이 없습니다.
            </div>
        </c:if>

        <c:if test="${hasOrders}">
            <c:forEach var="date" items="${ordersByDate.keySet()}">
                <div class="orders-date-group">
                    <!-- 날짜 출력 -->
                    <div class="date-header">${date}</div>
                    <table class="orders-table">
                        <thead>
                        <tr>
                            <th>주문 ID</th>
                            <th>상품 이름</th>
                            <th>색상</th>
                            <th>사이즈</th>
                            <th>수량</th>
                            <th>총 가격</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="order" items="${ordersByDate[date]}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.proName}</td>
                                <td>${order.proColor}</td>
                                <td>${order.proSize}</td>
                                <td>${order.quantity}</td>
                                <td>${order.odTotalPrice}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer/footer.jsp" %>
</body>
</html>
