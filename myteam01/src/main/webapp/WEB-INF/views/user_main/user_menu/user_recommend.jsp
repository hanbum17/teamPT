<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.teamproject.myteam01.domain.EventVO" %>
<%@ page import="com.teamproject.myteam01.domain.RestaurantVO" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
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
        document.getElementById('loading').style.display = 'block'; // 로딩 스피너 표시
        fetch('/api/executePythonScripts') // AJAX 요청
            .then(response => response.json())
            .then(data => {
                console.log('Python scripts executed:', data);
                document.getElementById('loading').style.display = 'none'; // 로딩 스피너 숨기기
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('loading').style.display = 'none'; // 오류 시에도 숨기기
            });
    }

    window.onload = executePythonScripts; // 페이지 로드 시 스크립트 실행
</script>

</head>
<body>

<main class="content-box">
    <!-- 행사 추천 섹션 -->
    <div class="recommendation">
        <h2>행사 추천
            <% if (request.getAttribute("eRecoType") != null && !((String)request.getAttribute("eRecoType")).isEmpty()) { %>
                [<%= request.getAttribute("eRecoType") %>]
            <% } %>
        </h2>
        <% @SuppressWarnings("unchecked")
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
        <h2>식당 추천
            <% if (request.getAttribute("fRecoType") != null && !((String)request.getAttribute("fRecoType")).isEmpty()) { %>
                [<%= request.getAttribute("fRecoType") %>]
            <% } %>
        </h2>
        <% @SuppressWarnings("unchecked")
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

    <!-- 로딩 스피너 -->
    <div id="loading">
        <img src="/resources/images/spinner.gif" alt="Loading...">
    </div>
</main>


</body>
</html>