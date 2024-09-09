<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 여행 계획 추가 버튼 및 목록 표시 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>여행 계획 목록</h2>
            <!-- 여행 계획 추가 버튼 -->
            <button id="addTripBtn" class="add-trip-btn">여행 계획 추가</button>
        </div>
        
        <!-- 여행 계획 목록 -->
        <div class="trip-list">
            <h3>나의 여행 계획</h3>
            <div id="tripPlanContainer">
                <c:forEach var="tripPlan" items="${tripPlans}">
                    <div class="trip-item">
                        <div class="trip-color-bar" style="background-color: ${tripPlan.color};"></div> 
                        <h4>${tripPlan.title}</h4>
                        <p>기간: ${tripPlan.startDate} ~ ${tripPlan.endDate}</p>
                        <a href="/user/tripDetail/${tripPlan.tripNo}" class="details-link">세부 계획 작성하기</a>
                        <div class="actions">
                            <button class="edit-btn" type="button">수정</button>
                            <button class="delete-btn" type="button">삭제</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- 모달 창: 여행 계획 추가 폼 -->
    <div id="tripModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="tripForm" action="/user/saveTripPlan" method="post">
                <label>여행 이름:</label>
                <input type="text" name="title" required>
                
                <label>여행 시작 날짜:</label>
                <input type="date" name="startDate" required>
                
                <label>여행 종료 날짜:</label>
                <input type="date" name="endDate" required>
                
                <button type="submit">저장</button>
            </form>
        </div>
    </div>
</main>

<script>
// 모달 기능
var modal = document.getElementById("tripModal");
var btn = document.getElementById("addTripBtn");
var span = document.getElementsByClassName("close")[0];

btn.onclick = function() {
    modal.style.display = "block";
}

span.onclick = function() {
    modal.style.display = "none";
}

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

// 수정, 삭제 버튼 이벤트 핸들링
document.querySelectorAll('.edit-btn').forEach(function(button) {
    button.addEventListener('click', function(event) {
        event.stopPropagation();
        // 수정 기능 로직 추가
    });
});

document.querySelectorAll('.delete-btn').forEach(function(button) {
    button.addEventListener('click', function(event) {
        event.stopPropagation();
        // 삭제 기능 로직 추가
    });
});
</script>
