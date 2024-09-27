<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.teamproject.myteam01.domain.EventVO" %>
<%@ page import="com.teamproject.myteam01.domain.RestaurantVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/recommend.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 목록 페이지</title>
<script>
    function executePythonScripts() {
        fetch('${pageContext.request.contextPath}/executePythonScripts', {
            method: 'POST' // POST 요청
        }).then(() => {
            // Python 스크립트 실행 후 페이지 새로고침
            location.reload();
        }).catch(error => {
            console.error('Error:', error);
        });
    }

    window.onload = function() {
        executePythonScripts(); // 초기 로딩 시 Python 스크립트 실행
    };
</script>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f9f9f9;
    }
    .recommendation {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        background-color: #fff;
    }
    h2 {
        color: #333;
    }
    .event, .restaurant {
        margin: 10px 0;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f1f1f1;
    }
    .refresh-button {
        margin: 20px 0;
        padding: 10px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .refresh-button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>

<main class="content-box">
    <div class="recommendation">
        <h2>행사 추천</h2>
        <% 
            @SuppressWarnings("unchecked")
            List<EventVO> eventList = (List<EventVO>) request.getAttribute("eventList");
            if (eventList != null && !eventList.isEmpty()) {
                for (EventVO event : eventList) { %>
                    <div class="event">
                        <strong>이벤트 이름:</strong> <%= event.getEname() %><br>
                        <strong>주소:</strong> <%= event.getEaddress() %><br>
                        <strong>기간:</strong> <%= event.getEperiod() %><br>
                        <strong>비용:</strong> <%= event.getEcost() %>
                    </div>
        <%
                }
            } else {
        %>
            <div class="event">추천된 행사가 없습니다.</div>
        <%
            }
        %>
    </div>

    <!-- 식당 추천 섹션 -->
    <div class="recommendation">
        <h2>식당 추천</h2>
        <%
            @SuppressWarnings("unchecked")
            List<RestaurantVO> restList = (List<RestaurantVO>) request.getAttribute("restList");
            if (restList != null && !restList.isEmpty()) {
                for (RestaurantVO rest : restList) { %>
                    <div class="restaurant">
                        <strong>식당 이름:</strong> <%= rest.getFname() %><br>
                        <strong>주소:</strong> <%= rest.getFaddress() %><br>
                        <strong>카테고리:</strong> <%= rest.getFcategory() %>
                    </div>
        <%
                }
            } else {
        %>
            <div class="restaurant">추천된 식당이 없습니다.</div>
        <%
            }
        %>
    </div>
    <button class="refresh-button" onclick="executePythonScripts()">추천 최신화</button>
</main>
</body>
</html>
