<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/tripitem.css">

<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>${tripPlan.title} 세부 계획</h2>
                    <!-- 메시지가 있을 경우 알림 표시 -->
	        <c:if test="${not empty message}">
	            <script>
	                alert("${message}");
	            </script>
	        </c:if>
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
				    <c:if test="${empty places}">
					    <p>등록된 장소가 없습니다.</p>
					</c:if>
			        <c:forEach var="place" items="${places}">
			            <div class="place-item" draggable="true" data-id="${place.id}" data-address="${place.address}">
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
			            <a href="?day=${day}" class="${param.day == day || (param.day == null && day == 1) ? 'active' : ''}">
			                ${day}일
			            </a>
			        </c:forEach>
			    </div>
			</div>

			<div id="scheduleContainer" style="border: 1px dashed #ccc; min-height: 300px; padding: 10px;">
			    <c:if test="${daySpecificPlaces.isEmpty()}">
			        <p id="dragGuideText">등록된 장소를 드래그해주세요.</p>
			    </c:if>
			    <c:forEach var="place" items="${daySpecificPlaces}">
				    <div class="dropped-place" data-id="${place.id}" data-order="${place.orderNum}" data-tripNo="${tripPlan.tripNo}">
				        <div>
				            <p class="place-name">${place.placeName}</p>
				            <p class="place-address">${place.address}</p>
				        </div>
				        <div class="right-container">
				            <div class="place-time-container">
				                <input type="time" class="place-time" value="${place.startDate}">
				            </div>
				            <div>
				                <button class="exclude-btn">빼기</button>
				            </div>
				        </div>
				    </div>
				</c:forEach>
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


//---------------------------------------------------------------------------

const paginationContainer = document.querySelector('.pagination');

// 마우스 휠로 가로 스크롤이 가능하도록 이벤트 핸들러 추가
paginationContainer.addEventListener('wheel', (event) => {
    event.preventDefault();
    paginationContainer.scrollLeft += event.deltaY; // 수직 스크롤을 가로 스크롤로 변경
});

//---------------------------------------------------------------------




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

scheduleContainer.addEventListener('drop', function(e) {
    e.preventDefault();
    var placeId = e.dataTransfer.getData('text/plain');
    var placeElement = document.querySelector('.place-item[data-id="' + placeId + '"]');
    
    var registeredPlaceId = placeElement.getAttribute('data-id');

 	// 안내 문구 제거
    var dragGuideText = document.getElementById('dragGuideText');
    if (dragGuideText) {
        dragGuideText.remove();
    }
    
    
 	// 장소 이름 및 주소 가져오기
    const placeName = placeElement.innerText;
    const placeAddress = placeElement.getAttribute('data-address');
    
    // 새로 추가된 장소 박스 생성
    var newPlaceBox = document.createElement('div');
    newPlaceBox.classList.add('dropped-place');
    newPlaceBox.setAttribute('data-id', placeId);
    newPlaceBox.setAttribute('data-registered-place-id', registeredPlaceId); 

    // HTML을 일반 문자열로 추가
    newPlaceBox.innerHTML = 
        "<div>" +
            "<p class='place-name'>" + placeName + "</p>" +  // class 추가
            "<p class='place-address'>" + placeAddress + "</p>" +  // class 추가
        "</div>" +
        "<div>" +
            "<label>일정 시작 시간: </label>" +
            "<input type='time' class='place-time' />" +
        "</div>";

    scheduleContainer.appendChild(newPlaceBox);
    
    // 추가된 후 박스 높이 자동 조정
    scheduleContainer.style.height = 'auto';
});


//----------------------------------------------------------------------------------------

//---------------------일정 저장------------------------------

document.getElementById('saveScheduleBtn').addEventListener('click', function() {
    const schedule = [];
    const tripDay = getTripDay();
    const tripNo = document.querySelector('input[name="tripNo"]').value;

    document.querySelectorAll('.dropped-place').forEach((placeBox, index) => {
        const placeId = placeBox.getAttribute('data-id');
        const registeredPlaceId = placeBox.getAttribute('data-registered-place-id');
        const placeTime = placeBox.querySelector('.place-time').value;

        schedule.push({
            id: placeId,
            registeredPlaceId: registeredPlaceId,  // registeredPlaceId 추가
            tripNo: tripNo,  // tripNo 추가
            startDate: placeTime,
            tripDay: tripDay
        });
    });

    schedule.sort(function(a, b) {
        return new Date('1970/01/01 ' + a.startDate) - new Date('1970/01/01 ' + b.startDate);
    });

    schedule.forEach((item, index) => {
        item.orderNum = index + 1;
    });

    // 전송할 데이터 확인 (디버깅용)
    console.log(JSON.stringify(schedule));

    // 서버로 일정 전송 (Ajax)
    $.ajax({
        type: 'POST',
        url: '/user/trip/saveSchedule',
        contentType: 'application/json',
        data: JSON.stringify(schedule),
        success: function(response) {
            alert('일정이 저장되었습니다.');
            window.location.reload(); 
        },
        error: function(xhr, status, error) {
            console.error('Ajax error:', xhr.responseText);
            alert('일정 저장에 실패했습니다.');
        }
    });
});

function getTripDay() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('day') || 1;  // 'day' 파라미터가 없으면 기본값 1
}

//-------------------------일정 빼기-------------------------------------

document.querySelectorAll('.exclude-btn').forEach(button => {
    button.addEventListener('click', function() {
        const placeId = this.closest('.dropped-place').getAttribute('data-id');  // 일정 ID 가져오기
        const tripNo = this.closest('.dropped-place').getAttribute('data-tripNo');  // tripNo 가져오기
        const orderNum = this.closest('.dropped-place').getAttribute('data-order');  // orderNum 가져오기
        const tripDay = getTripDay();  // 현재 tripDay 가져오기

        if (confirm('이 일정을 삭제하시겠습니까?')) {
            $.ajax({
                type: 'POST',
                url: '/user/trip/deleteSchedule',  // 서버로 삭제 요청
                contentType: 'application/json',
                data: JSON.stringify({
                    tripPlaceId: placeId,
                    tripNo: tripNo,
                    orderNum: orderNum,
                    tripDay: tripDay
                }),
                success: function(response) {
                    alert('일정이 성공적으로 삭제되었습니다.');
                    location.reload();  // 성공 후 페이지를 새로고침하거나 일정을 갱신
                },
                error: function(xhr, status, error) {
                    console.error('Ajax Error:', xhr.responseText);
                    alert('일정 삭제에 실패했습니다.');
                }
            });
        }
    });
});





</script>
