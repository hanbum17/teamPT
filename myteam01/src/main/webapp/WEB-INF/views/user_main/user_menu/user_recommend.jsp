<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.teamproject.myteam01.domain.EventVO" %>
<%@ page import="com.teamproject.myteam01.domain.RestaurantVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/detail.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 목록 페이지</title>
<script>
    function refreshRecommendations() {
        document.getElementById('loading').style.display = 'block'; // 로딩 스피너 표시
        fetch('${pageContext.request.contextPath}/executePythonScripts') // AJAX 요청
            .then(response => response.json()) // JSON 응답을 예상
            .then(data => {
                console.log('Python scripts executed:', data);
                document.getElementById('loading').style.display = 'none'; // 로딩 스피너 숨기기
                // 여기서 eventList와 restList를 업데이트하는 추가 코드를 작성할 수 있습니다.
                // 예를 들어, `data.eventList`와 `data.restList`를 사용하여 UI를 업데이트합니다.
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('loading').style.display = 'none'; // 오류 시에도 숨기기
            });
    }

    window.onload = function() {
        refreshRecommendations(); // 초기 로딩 시 실행하는 코드
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
    #loading {
        display: none;
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
        <h2>행사 추천 
            <% if (request.getAttribute("eRecoType") != null && !((String)request.getAttribute("eRecoType")).isEmpty()) { %>
                [<%= request.getAttribute("eRecoType") %>]
            <% } %>
        </h2>
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

    <div class="recommendation">
        <h2>식당 추천 
            <% if (request.getAttribute("fRecoType") != null && !((String)request.getAttribute("fRecoType")).isEmpty()) { %>
                [<%= request.getAttribute("fRecoType") %>]
            <% } %>
        </h2>
        <%
            @SuppressWarnings("unchecked")
            List<RestaurantVO> restList = (List<RestaurantVO>) request.getAttribute("restList");
            if (restList != null && !restList.isEmpty()) {
                for (RestaurantVO rest : restList) {
        %>
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

    <button class="refresh-button" onclick="refreshRecommendations()">추천 최신화</button>
    <div id="loading">로딩 중...</div> <!-- 로딩 스피너 -->
</main>

<%
    // AJAX 요청에 따라 Python 스크립트 실행
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getRequestURI().endsWith("/executePythonScripts")) {
        try {
            // 첫 번째 스크립트 실행
            ProcessBuilder processBuilder1 = new ProcessBuilder("C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/Scripts/python.exe", 
                                                                "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_행사추천.py");
            processBuilder1.redirectErrorStream(true);
            processBuilder1.redirectOutput(new File("C:/path/to/logfile1.txt")); // 로그 파일 경로 설정
            Process process1 = processBuilder1.start();
            process1.waitFor(); // 첫 번째 프로세스 종료 대기

            // 두 번째 스크립트 실행
            ProcessBuilder processBuilder2 = new ProcessBuilder("C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/Scripts/python.exe", 
                                                                "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_식당추천.py");
            processBuilder2.redirectErrorStream(true);
            processBuilder2.redirectOutput(new File("C:/path/to/logfile2.txt")); // 로그 파일 경로 설정
            Process process2 = processBuilder2.start();
            process2.waitFor(); // 두 번째 프로세스 종료 대기

            // 스크립트 실행 후 추천 목록을 다시 가져와서 JSON 형태로 응답
            List<EventVO> updatedEventList = // ... 이벤트 목록 업데이트 로직
            List<RestaurantVO> updatedRestList = // ... 식당 목록 업데이트 로직

            request.setAttribute("eventList", updatedEventList);
            request.setAttribute("restList", updatedRestList);
            response.setContentType("application/json");
            out.print("{ \"eventList\": " + new Gson().toJson(updatedEventList) + ", \"restList\": " + new Gson().toJson(updatedRestList) + " }");
        } catch (Exception e) {
            out.print("{ \"error\": \"" + e.getMessage() + "\" }");
        }
    }
%>
</body>
</html>
