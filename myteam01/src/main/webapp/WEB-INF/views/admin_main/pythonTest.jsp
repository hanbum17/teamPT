<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.teamproject.myteam01.domain.EventVO" %>
<%@ page import="com.teamproject.myteam01.domain.RestaurantVO" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script>
        function executePythonScripts() {
            document.getElementById('loading').style.display = 'block'; // 로딩 스피너 표시
            fetch('/executePythonScripts') // AJAX 요청
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
    <div id="loading" style="display:none;">로딩 중...</div>

    <h2>사용자 행사 추천목록 [<%= request.getAttribute("eRecoType") %>]</h2>
    <ul>
        <%
            @SuppressWarnings("unchecked")
            List<EventVO> eventList = (List<EventVO>) request.getAttribute("eventList");
            if (eventList != null && !eventList.isEmpty()) {
                for (EventVO event : eventList) {
        %>
        	<li><%= event.getEname() %></li> <!-- 이벤트 이름 출력 -->
        <%
                }
            } else {
        %>
            <li>추천된 행사가 없습니다.</li>
        <%
            }
        %>
    </ul>
    
    <h2>사용자 식당 추천목록 [<%= request.getAttribute("fRecoType") %>]</h2>
    <ul>
        <%
            @SuppressWarnings("unchecked")
            List<RestaurantVO> restList = (List<RestaurantVO>) request.getAttribute("restList");
            if (restList != null && !restList.isEmpty()) {
                for (RestaurantVO rest : restList) {
        %>
            <li><%= rest.getFname() %></li> <!-- 식당 이름 출력 -->
        <%
                }
            } else {
        %>
            <li>추천된 식당이 없습니다.</li>
        <%
            }
        %>
    </ul>

    <%
        // Python 스크립트 실행
        try {
            // 첫 번째 스크립트 실행
            ProcessBuilder pb1 = new ProcessBuilder("python", "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_식당추천.py");
            pb1.redirectErrorStream(true);
            Process process1 = pb1.start();
            BufferedReader reader1 = new BufferedReader(new InputStreamReader(process1.getInputStream()));
            String line;
            while ((line = reader1.readLine()) != null) {
                System.out.println(line); // 출력 (디버깅용)
            }
            process1.waitFor();

            // 두 번째 스크립트 실행
            ProcessBuilder pb2 = new ProcessBuilder("python", "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_행사추천.py");
            pb2.redirectErrorStream(true);
            Process process2 = pb2.start();
            BufferedReader reader2 = new BufferedReader(new InputStreamReader(process2.getInputStream()));
            while ((line = reader2.readLine()) != null) {
                System.out.println(line); // 출력 (디버깅용)
            }
            process2.waitFor();

        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

</body>
</html>
