<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> <!-- 필요한 import 추가 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
</head>
<body>

<%
    // 1. Python 스크립트 실행 (식당 추천)
    try {
        ProcessBuilder pb = new ProcessBuilder("python", "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_식당추천.py");
        pb.redirectErrorStream(true);
        Process process = pb.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line); // 출력 (디버깅용)
        }
        process.waitFor();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 2. Python 스크립트 실행 (행사 추천)
    try {
        ProcessBuilder pb = new ProcessBuilder("python", "C:/myPython/PyvirtualEnvs/PyWebCrawlingEnv/crawling/yourpro01/사용자_행사추천.py");
        pb.redirectErrorStream(true);
        Process process = pb.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line); // 출력 (디버깅용)
        }
        process.waitFor();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 3. 데이터베이스 연결 및 추천 항목 가져오기
    String jdbcUrl = "jdbc:oracle:thin:@195.168.9.58:1521:xe";
    String username = "teampj";
    String password = "teampj";
    String userName = (String) request.getAttribute("userName"); // 모델에서 userName 가져오기

    try {
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
        Statement statement = connection.createStatement();
        
        // 사용자 식당 추천 쿼리
        String restaurantQuery = "SELECT * FROM user_recommendations WHERE userid = '" + userName + "'";
        ResultSet restaurantResultSet = statement.executeQuery(restaurantQuery);

        out.println("<h2>식당 추천 항목</h2>");
        out.println("<table border='1'><tr><th>추천 번호</th><th>식당 번호</th><th>유형</th></tr>");

        boolean hasRestaurantData = false; // 식당 데이터 존재 여부 체크
        while (restaurantResultSet.next()) {
            hasRestaurantData = true; // 데이터가 있을 경우 true로 변경
            int recoNo = restaurantResultSet.getInt("recoNo");
            String fno = restaurantResultSet.getString("fno");
            String type = restaurantResultSet.getString("type");
            out.println("<tr><td>" + recoNo + "</td><td>" + fno + "</td><td>" + type + "</td></tr>");
        }
        out.println("</table>");

        if (!hasRestaurantData) { // 데이터가 없을 경우 메시지 출력
            out.println("<p>즐겨찾기 정보가 필요합니다.</p>");
        }

        // 사용자 행사 추천 쿼리
        String eventQuery = "SELECT * FROM USER_RECOMMENDATIONS WHERE userid = '" + userName + "'";
        ResultSet eventResultSet = statement.executeQuery(eventQuery);

        out.println("<h2>행사 추천 항목</h2>");
        out.println("<table border='1'><tr><th>추천 번호</th><th>행사 번호</th><th>유형</th></tr>");

        boolean hasEventData = false; // 행사 데이터 존재 여부 체크
        while (eventResultSet.next()) {
            hasEventData = true; // 데이터가 있을 경우 true로 변경
            int recoNo = eventResultSet.getInt("recoNo");
            String eno = eventResultSet.getString("eno");
            String type = eventResultSet.getString("type");
            out.println("<tr><td>" + recoNo + "</td><td>" + eno + "</td><td>" + type + "</td></tr>");
        }
        out.println("</table>");

        if (!hasEventData) { // 데이터가 없을 경우 메시지 출력
            out.println("<p>추천할 행사 정보가 필요합니다.</p>");
        }

        restaurantResultSet.close();
        eventResultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
