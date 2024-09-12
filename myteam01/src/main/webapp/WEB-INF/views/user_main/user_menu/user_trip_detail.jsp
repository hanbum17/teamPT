<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/tripitem.css">

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>${tripPlan.title} 세부 계획</h2>
            <button id="openPlaceModalBtn" class="add-place-btn">장소 등록</button>
            <button id="backToListBtn" class="back-button">돌아가기</button>
        </div>
		<div class="content-body">
	        

			<!-- 모달 및 기타 내용 -->
			<div id="placeModal" class="modal" style="display: none;">
			    <div class="modal-content">
			        <h3>장소 등록</h3>
			        <form id="placeForm" action="/user/trip/addPlace" method="post">
			            <input type="hidden" name="tripNo" value="${tripPlan.tripNo}">
			            
			            <label>장소 이름:</label>
			            <input type="text" name="placeName" required>
			            
			            <label>주소:</label>
			            <input type="text" name="address" required>
			            
			            <button type="submit">장소 추가</button>
			        </form>
			        <h3>즐겨찾기 목록에서 장소 선택</h3>
	                <div id="favoritesContainer">
	                    <c:forEach var="favoriteItem" items="${favoriteItems}">
	                        <div class="favorite-item" data-id="${favoriteItem.id}" data-name="${favoriteItem.name}" data-address="${favoriteItem.address}">
	                            <p>${favoriteItem.name}</p>
	                            <p>${favoriteItem.address}</p>
	                            <button class="select-favorite">선택</button>
	                        </div>
	                    </c:forEach>
	                </div>
			    </div>
			</div>


	
	        <!-- 등록된 장소 목록 -->
	        <div class="place-list-header">
	        	<h3>등록된 장소</h3>
	        	<button id="activateDeleteMode" class="delete-mode-btn">지우기</button>
	        </div>
	        <div class="place-list">
	            <div id="placeContainer">
	                <c:forEach var="place" items="${places}">
	                    <div class="place-item" draggable="true" data-id="${place.id}">
	                        ${place.placeName}
	                    </div>
	                </c:forEach>
	            </div>
	        </div>
	
	        <!-- 여행 일정 공간 -->
	        <div class="scheduleContainer-header">
			    <h3>여행 일정</h3>
			    <div class="pagination">
				    <c:forEach var="day" begin="1" end="${tripPlan.tripDays}">
				        <a href="?day=${day}" class="${param.day == day ? 'active' : ''}">${day}</a>
				    </c:forEach>
				</div>
			</div>
	        <div id="scheduleContainer" style="border: 1px dashed #ccc; min-height: 300px; padding: 10px;">
	            <!-- 장소를 드래그 앤 드롭할 수 있는 공간 -->
	        </div>
	        
	        <button id="saveScheduleBtn">일정 저장</button>
	    </div>

</main>

<script>
document.getElementById('backToListBtn').addEventListener('click', function() {
    window.location.href = '/user/trip/list'; // 여행 계획 목록 페이지로 이동
});

//"장소 등록" 버튼을 눌렀을 때 모달을 표시
document.getElementById('openPlaceModalBtn').addEventListener('click', function() {
    document.getElementById('placeModal').style.display = 'block';
});



// 모달 외부를 클릭하면 모달을 닫기
window.addEventListener('click', function(event) {
    const modal = document.getElementById('placeModal');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
});


// 즐겨찾기에서 선택 버튼 클릭 시
document.querySelectorAll('.select-favorite').forEach(function(button) {
    button.addEventListener('click', function() {
        const item = button.closest('.favorite-item');
        const placeName = item.getAttribute('data-name');
        const placeAddress = item.getAttribute('data-address');
        
        // 폼에 즐겨찾기에서 선택한 값 자동 입력
        document.querySelector('input[name="placeName"]').value = placeName;
        document.querySelector('input[name="address"]').value = placeAddress;

        // 모달 창 닫기
        document.getElementById('favoritesModal').style.display = 'none';
    });
});


//------------------------------------------등록된 장소 삭제------------------------------------------
// 삭제 모드 활성화 여부
let deleteMode = false;

// 삭제 모드 버튼 클릭 시 모드 활성화/비활성화
document.getElementById('activateDeleteMode').addEventListener('click', function() {
    deleteMode = !deleteMode;  // 모드 토글
    if (deleteMode) {
        this.textContent = '지우기 활성화';
        this.style.backgroundColor = '#ff4d4d'; // 모드 활성화 시 버튼 색 변경
    } else {
        this.textContent = '지우기';
        this.style.backgroundColor = ''; // 모드 비활성화 시 원래 색으로
    }
});

// 장소 클릭 시 삭제 처리
document.querySelectorAll('.place-item').forEach(function(item) {
    item.addEventListener('click', function() {
        if (deleteMode) {
            const placeId = this.getAttribute('data-id');
            if (confirm('이 장소를 삭제하시겠습니까?')) {
                // 서버에 삭제 요청 전송
                $.ajax({
                    type: 'POST',
                    url: '/user/trip/deletePlace',  // 서버에서 삭제를 처리하는 URL
                    data: { placeId: placeId },
                    success: function(response) {
                        alert('장소가 삭제되었습니다.');
                        // 성공 시, 해당 장소 항목을 삭제
                        item.remove();
                    },
                    error: function() {
                        alert('장소 삭제에 실패했습니다.');
                    }
                });
            }
        }
    });
});




// 드래그 앤 드롭 기능
const placeItems = document.querySelectorAll('.place-item');
const scheduleContainer = document.getElementById('scheduleContainer');
const placeList = document.querySelector('.place-list');

placeList.addEventListener('wheel', function(event) {
    // 기본 휠 스크롤 방지
    event.preventDefault();

    // 휠의 수직 스크롤을 가로 스크롤로 변환
    placeList.scrollLeft += event.deltaY;
});

// 드래그 가능한 요소 설정
placeItems.forEach(item => {
    item.addEventListener('dragstart', (e) => {
        e.dataTransfer.setData('text/plain', item.getAttribute('data-id'));
    });
});

// 드롭 가능한 공간 설정
scheduleContainer.addEventListener('dragover', (e) => {
    e.preventDefault();
});

scheduleContainer.addEventListener('drop', (e) => {
    e.preventDefault();
    const placeId = e.dataTransfer.getData('text/plain');
    const placeElement = document.querySelector(`.place-item[data-id="${placeId}"]`);

    // 새로 추가된 장소 박스 생성
    const newPlaceBox = document.createElement('div');
    newPlaceBox.classList.add('dropped-place');
    newPlaceBox.style.border = "1px solid #ddd";
    newPlaceBox.style.margin = "10px";
    newPlaceBox.style.padding = "10px";

    newPlaceBox.innerHTML = 
        `<p><strong>장소:</strong> ${placeElement.innerHTML} </p>
        <label>시간 설정:</label>
        <input type='time' class='place-time' />`;

    scheduleContainer.appendChild(newPlaceBox);
    
    // 추가된 후 박스 높이 자동 조정
    scheduleContainer.style.height = 'auto';
});


//----------------------------------------------------------------------------------------

//---------------------일정 저장------------------------------

document.getElementById('saveScheduleBtn').addEventListener('click', function() {
    const schedule = [];
    document.querySelectorAll('.dropped-place').forEach((placeBox, index) => {
        const placeName = placeBox.querySelector('p strong').textContent;
        const placeTime = placeBox.querySelector('.place-time').value;

        schedule.push({
            placeName: placeName,
            time: placeTime,
            orderNum: index + 1
        });
    });

    // 서버로 일정 전송
    $.ajax({
        type: 'POST',
        url: '/user/trip/saveSchedule',
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
