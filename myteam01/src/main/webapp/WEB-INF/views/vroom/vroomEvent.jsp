<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menu/nav.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Event List</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            background-color: #f7f7f7;
            background-image: url('/image/kakaoMAP.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        #map {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .container {
		    display: flex;
		    overflow-x: auto; /* 수평 스크롤 허용 */
		    white-space: nowrap;
		    padding: 20px;
		    box-sizing: border-box;
		    background-color: transparent;
		    width: 100%;
		    height: 300px; /* 높이 유지 */
		    align-items: center;
		    position: fixed; /* 맨 아래 고정 */
		    bottom: 0; /* 아래 고정 */
		    z-index: 1; /* 다른 요소 위에 보이도록 설정 */
		}

        .event-card {
		    display: inline-block; /* 카드가 수평으로 나열됨 */
		    width: 200px;
		    height: 280px;
		    margin-right: 20px;
		    background-color: #f0f0f0;
		    border-radius: 10px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    text-align: center;
		    padding: 10px;
		    box-sizing: border-box;
		    cursor: pointer;
		    flex-shrink: 0; /* 크기 축소 방지 */
		}

        .event-card img {
            width: 100%;
            height: 60%;
            border-radius: 10px;
            object-fit: cover;
        }

        .event-info {
            padding: 20px;
        }

        .event-info h3 {
            margin: 1px 0;
            font-size: 18px;
        }

        .event-info p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .panel {
            position: absolute;
            top: 50px;
            width: 28%;
            height: calc(100vh - 100px);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            background-color: #fff;
            padding: 20px;
            box-sizing: border-box;
            display: none;
        }

        .restaurant-search-btn {
	    position: absolute;
	    top: 700px; /* 컨테이너 상단과의 거리 */
	    right: 10px; /* 컨테이너 우측과의 거리 */
	    padding: 10px 20px;
	    background-color: #007bff;
	    color: #fff;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    z-index: 1000; /* 버튼이 다른 요소 위에 표시되도록 설정 */
	}

	.restaurant-search-btn:hover {
    	background-color: #0056b3;
	}

    </style>
</head>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<div id="map"></div>

<div class="header">
    <div class="logo" id="goToMain">Vroom</div>
    <div class="nav">
        <a href="#about">ABOUT US</a>
        <a href="#" id="loginLink">${user != null ? "MYPAGE" : "LOGIN"}</a>
        <a href="/logout" id="logout">${user != null ? "LOGOUT" : ""}</a>
        <a href="#contact">CONTACT US</a>
    </div>
</div>

<div style="position: absolute; top: 10px; left: 10px; font-size: 16px;">
        <c:if test="${not empty user}">
            현재 로그인: <strong>${user.userId}</strong>
        </c:if>
    </div>

<button class="restaurant-search-btn" id="restaurant-search-btn">식당 조회</button>

<div class="container" id="event-container">
    <!-- 이벤트 카드 반복문으로 생성 -->
    <div class="more-event-card">
        <c:forEach var="event" items="${eventList}">
            <div class="event-card" 
                 data-eno="${event.eno}" 
                 data-excoord="${event.excoord}" 
                 data-eycoord="${event.eycoord}" 
                 onclick="window.location.href='${contextPath}/vroom/event/details?eno=${event.eno}'">
                <img src="${contextPath}/images/event.jpg" alt="${event.ename} Image">
                <div class="event-info">
                    <h3>${event.ename}</h3>
                    <p>${event.eaddress}</p>
                    <p>${event.erating}</p>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- 데이터가 없는 경우 표시할 카드 -->
    <c:if test="${empty eventList}">
        <div class="event-card">
            <img src="${contextPath}/images/event.jpg" alt="No Data Image">
            <div class="event-info">
                <h3>No Events Available</h3>
                <p>Location: N/A</p>
                <p>Rating: N/A</p>
            </div>
        </div>
    </c:if>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a&libraries=services"></script>
<script>
// 식당 조회 버튼 클릭 이벤트 처리
document.getElementById('restaurant-search-btn').addEventListener('click', () => {
    window.location.href = '${contextPath}/vroom/restaurant';
});

// 카카오 지도 초기화
var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(37.566826004661, 126.978652258309), // 기본 중심 좌표 (서울시청)
        level: 3 // 지도 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

// 기본 마커 생성
var marker = new kakao.maps.Marker({
    position: map.getCenter(),
    draggable: true // 마커를 드래그 가능하게 설정
});

marker.setMap(map);

let markers = [];

// 마커 생성 함수
function setMarker(lng, lat) {
    // 기존 마커 삭제
    markers.forEach(marker => marker.setMap(null));
    markers = []; // markers 배열 비우기

    // 새로운 마커 추가
    var newMarker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(lat, lng),
        map: map
    });

    // 새 마커를 배열에 추가하고 지도의 중심을 새 마커의 위치로 설정
    markers.push(newMarker);
    map.setCenter(new kakao.maps.LatLng(lat, lng));

    console.log('setMarker 함수: lat ' + lat + ', lng ' + lng);
    console.log('지도 중심:', map.getCenter());
    console.log('마커 배열:', markers);
}

// 마우스 오버 리스너 추가
function addMouseOverListenerToCards() {
    const eventCards = document.querySelectorAll('.event-card');
    eventCards.forEach(card => {
        card.addEventListener('mouseover', function() {
            const lat = parseFloat(card.dataset.excoord); // 이벤트의 위도
            const lng = parseFloat(card.dataset.eycoord); // 이벤트의 경도

            if (!isNaN(lat) && !isNaN(lng)) {
                setMarker(lat, lng);
                console.log('Mouse over at card: Latitude ' + lat + ', Longitude ' + lng);
            } else {
                console.error('Invalid lat or lng values:', lat, lng);
            }
        });
    });
}

// 페이지 로드 후 리스너 추가
document.addEventListener('DOMContentLoaded', () => {
    addMouseOverListenerToCards();
});


//드래그 관련 변수
let isDragging = false;
let startX;
let scrollLeft;

const container = document.getElementById('event-container');



//드래그 시작
container.addEventListener('mousedown', (e) => {
    isDragging = true;
    startX = e.pageX - container.offsetLeft;
    scrollLeft = container.scrollLeft;
});

// 드래그 중
container.addEventListener('mousemove', (e) => {
    if (!isDragging) return; // 드래그 중이 아닐 때는 무시
    const x = e.pageX - container.offsetLeft;
    const walk = (x - startX) * 2; // 드래그 이동량을 조절 (속도 조정)
    container.scrollLeft = scrollLeft - walk;
});

// 드래그 종료
container.addEventListener('mouseup', () => {
    isDragging = false;
});

// 드래그 중 다른 요소에서 마우스 버튼이 떼어질 경우
container.addEventListener('mouseleave', () => {
    isDragging = false;
});

</script>
</body>
</html>
