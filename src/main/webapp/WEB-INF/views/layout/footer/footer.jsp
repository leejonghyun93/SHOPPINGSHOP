<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /*---------------footer-----------*/
        /* 푸터 스타일 */
        .footerSidebar {
            list-style-type: none;
            width: 100%;
            height: 50px;
            background-color: #dedede;
            display: flex;
            justify-content: center;
            padding-left: 0px;
            margin: 0;
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
            width: 100%;
            background-color: #dedede;
            text-align: left;
            display: flex;
            flex-direction: column;
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
