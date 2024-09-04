<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>여행계획 세우기</h2>
        </div>
        <div class="trip-planner">
            <h3>나의 여행 계획</h3>
            <form action="/user/saveTripPlan" method="post">
                <label>목적지: <input type="text" name="destination"></label>
                <label>여행 날짜: <input type="date" name="tripDate"></label>
                <label>메모: <textarea name="notes"></textarea></label>
                <button type="submit">계획 저장</button>
            </form>
        </div>
    </div>
</main>
</div>
</body>
</html>
