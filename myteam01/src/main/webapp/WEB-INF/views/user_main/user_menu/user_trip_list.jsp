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
                        <div class="trip-item-text">
					        <h4>${tripPlan.title}</h4>
					        <p>
					            <fmt:formatDate value="${tripPlan.startDate}" pattern="yyyy년 MM월 dd일" /> ~ 
					            <fmt:formatDate value="${tripPlan.endDate}" pattern="MM월 dd일" />
					        </p>
					        <a href="/user/trip/detail/${tripPlan.tripNo}" class="details-link">세부 계획 보기</a>
					    </div>
                        <div class="trip-item-buttons">
					        <button class="edit-trip-btn" data-id="${tripPlan.tripNo}" data-title="${tripPlan.title}" >수정</button>
					        <button class="delete-trip-btn" onclick="deleteTripPlan(${tripPlan.tripNo})">삭제</button>
					    </div>
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

//--------------------여행계획삭제--------------------------------------------------------
function deleteTripPlan(tripNo) {
    if (confirm("정말로 이 여행 계획을 삭제하시겠습니까?")) {
        $.ajax({
            url: '/user/trip/delete/' + tripNo,
            type: 'POST',
            success: function(response) {
                alert(response);
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                alert('여행 계획 삭제에 실패했습니다.');
                console.error(xhr.responseText);
            }
        });
    }
}



//-------여행 계획 수정------------------------------------------------------------------------------
document.querySelectorAll('.edit-trip-btn').forEach(button => {
    button.addEventListener('click', function() {
        const tripNo = this.getAttribute('data-id');
        const tripTitle = this.getAttribute('data-title');


        // 모달창에 기존 데이터를 채워넣기
        document.querySelector('input[name="title"]').value = tripTitle;


        document.getElementById('tripModal').style.display = "block";

        // 저장 버튼 클릭 시 수정 처리
        document.getElementById('tripForm').onsubmit = function(event) {
            event.preventDefault();
            const updatedTitle = document.querySelector('input[name="title"]').value;
            const updatedStart = document.querySelector('input[name="startDate"]').value;
            const updatedEnd = document.querySelector('input[name="endDate"]').value;

            // AJAX를 사용한 POST 요청
            $.ajax({
                url: "/user/trip/update/" + tripNo,  // 서버의 업데이트 경로
                type: 'POST',  // POST 요청 사용
                contentType: 'application/json',
                data: JSON.stringify({
                    title: updatedTitle,
                    startDate: updatedStart,
                    endDate: updatedEnd
                }),
                success: function(response) {
                    alert('여행 계획이 수정되었습니다.');
                    location.reload();  // 성공 시 페이지 새로고침
                },
                error: function(xhr, status, error) {
                    console.error('수정 실패:', xhr.responseText);
                    alert('수정에 실패했습니다. 서버 메시지: ' + xhr.responseText);
                }
            });
        };
    });
});


</script>
