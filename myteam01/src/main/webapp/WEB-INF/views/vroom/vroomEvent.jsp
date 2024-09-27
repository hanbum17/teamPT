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
            background-size: cover; /* 배경 이미지가 요소의 전체를 덮도록 설정 */
             background-position: center; /* 이미지의 위치를 중앙으로 설정 */
          background-repeat: no-repeat; /* 이미지 반복을 방지 */
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
        z-index: 0; /* 지도를 배경으로 만들기 위해 z-index를 음수로 설정 */
    }
        

        .container {
            display:  flex;
            overflow-x: auto;
            white-space: nowrap;
            padding: 20px;
            box-sizing: border-box;
            background-color: transparent;
            width: 100%;
            height: 300px;
            align-items: center;
            position: fixed;
            bottom: 0;
        }


        .event-card {
		  display: inline-block;
          width: 210px; /* 너비 */
          height: 290px; /* 높이 */
          margin-right: 20px;
          background-color: #f0f0f0;
          border-radius: 10px;
          box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          text-align: center;
          padding: 10px;
          box-sizing: border-box;
          cursor: pointer;
          flex-shrink: 0;
          overflow: hidden; /* 넘치는 내용 숨기기 */

		}

        .event-card img {
            width: 100%;
            height: 60%;
            border-radius: 10px;
            object-fit: cover;
        }

        .event-info {
          padding: 20px;
          overflow: hidden; /* 넘치는 내용 숨기기 */
          text-overflow: ellipsis; /* 넘치는 텍스트를 '...'로 표시 */
          white-space: nowrap; /* 텍스트를 한 줄로 표시 */
        }

        .event-info h3 {
           margin: 1px 0;
          font-size: 18px;
          word-break: break-word; /* 단어가 길 경우 줄바꿈 허용 */
          word-break: keep-all; /* 단어가 중간에 끊기지 않도록 설정 */s
          white-space: normal; /* 제목은 여러 줄로 표시 가능 */
        }

        .event-info p {
            margin: 5px 0;
          font-size: 14px;
          color: #555;
          overflow: hidden; /* 넘치는 내용 숨기기 */
          text-overflow: ellipsis; /* 넘치는 텍스트를 '...'로 표시 */
          white-space: nowrap; /* 텍스트를 한 줄로 표시 */
        }
        
        .container::-webkit-scrollbar {
            display: none;
        }
        
        .container {
            -ms-overflow-style: none;
            scrollbar-width: none;
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
	
	.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px; /* 패딩을 줄여서 내용이 위로 이동하도록 설정 */
    background-color: transparent; /* 상단 바 배경 제거 */
    color: #ffffff;
    border-bottom: none; /* 흰색 줄 제거 */
    height: 60px; /* 헤더의 높이를 적절히 설정 */
    position: fixed; /* 헤더를 페이지 상단에 고정 */
    width: 100%; /* 헤더가 전체 너비를 차지하도록 설정 */
    top: 0; /* 상단에 위치하도록 설정 */
    left: 0; /* 왼쪽에 위치하도록 설정 */
    z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
}

.header .logo {
       font-size: 30px; /* 글자 크기 2/3로 줄임 */
       font-weight: bold;
   }
   
   .header .nav {
       font-size: 20px; /* 글자 크기 2/3로 줄임 */
   }
   
   .header .nav a {
       color: #ffffff;
       text-decoration: none;
       margin: 0 15px; /* 글자 사이 간격 조정 */
   }
   
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
                 onclick="window.location.href='${contextPath}/vroom/event/details?eno=${event.eno}&lat=${event.excoord}&lng=${event.eycoord}'" >
                 
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
	const urlParams = new URLSearchParams(window.location.search); // URL 파라미터를 여기서 정의
    const guName = urlParams.get('guName'); 
    console.log(guName); 
    const targetUrl = '${contextPath}/vroom/restaurant?guName=' + guName;
    window.location.href = targetUrl; 
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



container.addEventListener('scroll', () => {
    if (container.scrollWidth - container.scrollLeft <= container.clientWidth + 50) {
        // Load more data when scrolling close to the end
        loadMoreRestaurants();
    }
});

container.addEventListener('wheel', (event) => {
    event.preventDefault();
    container.scrollLeft += event.deltaY;
});

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
