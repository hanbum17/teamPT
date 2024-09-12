<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/trip.css">

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>여행 목록</h2>
            <button id="addTripBtn" class="add-trip-btn">여행 계획 추가</button>
        </div>
        
        <!-- 여행 계획 목록 -->
        <div class="trip-list">
            <div id="tripPlanContainer">
                <c:forEach var="tripPlan" items="${tripPlans}">
                    <div class="trip-item">
                        <h4>${tripPlan.title}</h4>
                        <p>
                            <fmt:formatDate value="${tripPlan.startDate}" pattern="yyyy년 MM월 dd일" /> ~ 
                            <fmt:formatDate value="${tripPlan.endDate}" pattern="yyyy년 MM월 dd일" />
                        </p>
                        <a href="/user/trip/detail/${tripPlan.tripNo}" class="details-link">세부 계획 보기</a>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <!-- 모달 창: 여행 계획 추가 폼 -->
        <div id="tripModal" class="modal" style="display: none;">  <!-- 기본적으로 모달 숨기기 -->
            <div class="modal-content" onclick="event.stopPropagation()">
                <form id="tripForm" action="/user/trip/saveTripPlan" method="post">
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
    </div>
</main>

<script>
//모달 숨기기 상태 유지
var modal = document.getElementById("tripModal");
var btn = document.getElementById("addTripBtn");

// 버튼 클릭 시 모달 표시
btn.onclick = function() {
    modal.style.display = "block";
}

// 모달 외부 클릭 시 모달 숨기기
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
