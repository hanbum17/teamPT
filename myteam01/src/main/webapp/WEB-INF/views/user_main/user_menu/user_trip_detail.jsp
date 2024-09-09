<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 세부 계획 페이지 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>${tripPlan.title}의 세부 여행 계획</h2>
        </div>
        
        <!-- 장소 등록 폼 -->
        <div class="place-registration">
            <h3>장소 등록</h3>
            <form id="placeForm" action="/user/addPlace" method="post">
                <label>장소 이름:</label>
                <input type="text" name="placeName" required>
                
                <label>주소:</label>
                <input type="text" name="address" required>
                
                <label>시작 시간:</label>
                <input type="datetime-local" name="startDate" required>
                
                <button type="submit">장소 추가</button>
            </form>
        </div>

        <!-- 등록된 장소 목록 -->
        <div class="place-list">
            <h3>등록된 장소</h3>
            <div id="placeContainer">
                <c:forEach var="place" items="${places}">
                    <div class="place-item" draggable="true" data-id="${place.id}">
                        ${place.placeName}
                        <div class="actions">
                            <button class="edit-place-btn" type="button">수정</button>
                            <button class="delete-place-btn" type="button">삭제</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 여행 일자에 맞게 드래그 앤 드롭할 수 있는 공간 -->
        <div id="scheduleContainer">
            <h3>여행 일정</h3>
            <c:forEach var="day" begin="1" end="${tripDays}">
                <div class="schedule-day" id="day-${day}">
                    <h4>Day ${day}</h4>
                    <div class="dropzone" data-day="${day}"></div>
                </div>
            </c:forEach>
        </div>
        
        <button id="saveScheduleBtn">일정 저장</button>
    </div>
</main>

<script>
// 드래그 앤 드롭 기능 구현
const placeItems = document.querySelectorAll('.place-item');
const dropzones = document.querySelectorAll('.dropzone');

placeItems.forEach(item => {
    item.addEventListener('dragstart', (e) => {
        e.dataTransfer.setData('text/plain', item.getAttribute('data-id'));
    });
});

dropzones.forEach(zone => {
    zone.addEventListener('dragover', (e) => {
        e.preventDefault();
    });

    zone.addEventListener('drop', (e) => {
        e.preventDefault();
        const placeId = e.dataTransfer.getData('text/plain');
        const placeElement = document.querySelector(`.place-item[data-id="${placeId}"]`);
        e.target.appendChild(placeElement.cloneNode(true));
    });
});

document.getElementById('saveScheduleBtn').addEventListener('click', function() {
    const schedule = [];
    dropzones.forEach(zone => {
        const day = zone.getAttribute('data-day');
        const places = [];
        zone.querySelectorAll('.place-item').forEach(place => {
            places.push(place.getAttribute('data-id'));
        });
        schedule.push({ day: day, places: places });
    });

    $.ajax({
        type: 'POST',
        url: '/user/saveSchedule',
        contentType: 'application/json',
        data: JSON.stringify(schedule),
        success: function(response) {
            alert('일정이 저장되었습니다.');
        },
        error: function() {
            alert('일정 저장에 실패했습니다.');
        }
    });
});
</script>
