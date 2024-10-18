<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /*---------------footer-----------*/
        .footerSidebar {
            list-style-type: none;
            width: 100%;
            height: 50px;
            background-color: #dedede;
            display: flex;
            padding-left: 0px; /* 항목을 오른쪽으로 정렬 */

        }

        .footerSidebar > li {
            color: black;
            height: 100%;
            width: 150px;
            display: flex;
            align-items: center;
        }

        .footerSidebar > li > a {
            color: black;
            margin: auto;
            padding: 10px;
            font-size: 15px;
            text-align: center;
        }

        .footerSidebar > li > a:hover {
            color: white;
            border-bottom: 3px solid rgb(209, 209, 209);
        }

        .footerSidebars {
            position: fixed; /* 푸터를 화면 하단에 고정 */
            bottom: 0; /* 하단에 위치시킴 */
            width: 100%; /* 화면의 전체 너비 */
            background-color: #dedede; /* 부모 요소에 배경색 설정 */
            text-align: left; /* 리스트를 왼쪽으로 정렬 */
            display: flex;
            flex-direction: column; /* 세로 정렬 */
            justify-content: center;
        }

        .logFooter {
            margin-left: 47px;
            margin-top: 5px;
        }
    </style>
    <div class="footerSidebars">
        <h1 class="logFooter">shoppingShop</h1>
        <ul class="footerSidebar">
            <li><a>이용안내</a></li>
            <li><a>이용약관</a></li>
            <li><a>개인정보처리방침</a></li>
        </ul>
    </div>
</head>
</html>
