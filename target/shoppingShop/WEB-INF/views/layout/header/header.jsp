<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션 사용 설정 -->

<c:set var="loginId" value="${pageContext.request.getSession(false) == null ? '' : pageContext.request.session.getAttribute('user') != null ? pageContext.request.getSession().getAttribute('user').userId : ''}"/>
<c:set var="loginOutLink" value="${loginId == '' ? '/login/login' : '/login/logout'}"/>
<c:set var="logout" value="${loginId == '' ? 'Login' : loginId}"/>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /*---------------header-----------*/

        .headerSidebar {
            list-style-type: none;
            height: 50px;
            background-color: #dedede;
            display: flex;
            justify-content: flex-end;
            padding-left: 0px;
            margin-top: 0;
        }

        .headerSidebar > li {
            color: black;
            height: 100%;
            width: 110px;
            display: flex;
            align-items: center;
        }

        .headerSidebar > li > a {
            color: black;
            margin: auto;
            padding: 10px;
            font-size: 15px;
            text-align: center;
        }

        .headerSidebar > li > a:hover {
            color: white;
            border-bottom: 3px solid rgb(209, 209, 209);
        }

        .sidebar {
            width: 100%;
            text-align: right; /* 리스트를 오른쪽으로 정렬 */
        }
    </style>

    <div class="sidebar">
        <ul class="headerSidebar">
            <li><a href="<c:url value='${loginOutLink}'/>">${logout}</a></li>
            <li><a href="<c:url value='/membership/register'/>">회원가입</a></li>
            <li><a>주문/배송조회</a></li>
            <li><a>1:1문의</a></li>
            <li><a>커뮤니티</a></li>
        </ul>
    </div>
</head>
</html>