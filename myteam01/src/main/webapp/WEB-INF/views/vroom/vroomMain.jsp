<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Vroom - Home</title>
    <link rel="stylesheet" type="text/css" href="/css/vroomMain.css"> <!-- CSS 파일 링크 -->
    <style>
	    .footer {
		    text-align: center; /* 가운데 정렬 */
		    margin-top: 20px; /* 위쪽 여백 */
		}
		
		.footer hr {
		    border: 1px solid #ccc; /* 연한 회색 줄 */
		    margin: 10px 0; /* 상하 여백 */
		}
		
		.footer-info {
		    font-size: 12px; /* 글자 크기 */
		    color: #aaa; /* 연한 회색 */
		}
		
		.footer-info a {
		    color: #aaa; /* 연한 회색 링크 */
		    text-decoration: none; /* 밑줄 제거 */
		}
		
		.footer-info a:hover {
		    text-decoration: underline; /* hover 시 밑줄 */
		}
        .area {
            position: absolute;
            background: #fff;
            border: 1px solid #888;
            border-radius: 3px;
            font-size: 12px;
            top: -5px;
            left: 15px;
            padding: 2px;
        }
        .info {
            font-size: 12px;
            padding: 5px;
        }
        .info .title {
            font-weight: bold;
        }
        /* 지도 스타일 추가 */
        #map {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<div class="ty"></div>

<div class="background-video">
    <video autoplay muted loop id="video-background">
        <source src="/image/airplain.mp4" type="video/mp4">
    </video>
</div>

<div class="header">
    <div class="logo">Vroom</div>
    <div class="nav">
        <a href="#about">ABOUT US</a>
        <a href="#" id="loginLink">${user != null ? "MYPAGE" : "LOGIN"}</a>
        <a href="/logout" id="logout">${user != null ? "LOGOUT" : ""}</a>
        <a href="#contact">CONTACT US</a>
    </div>
</div>

<div class="container">
    <div class="box">
        <div id="map">
        	 <img src="/image/map.jpg" alt="Map Image" style="width: 100%; height: 100%; object-fit: cover;">
        </div>
    </div>
    <div class="message">
        떠나고자 하는 지역을 선택해주세요
    </div>
</div>

<div class="footer">
    <a href="/vroom/policy?section=terms">이용약관</a>
    <a href="/vroom/policy?section=privacy">개인정보 취급방침</a>
    <a href="/vroom/policy?section=cookiePolicy">쿠키정책</a>
    <a href="/vroom/policy?section=youthUsagePolicy">청소년 보호정책</a>
    <a href="/vroom/policy">사이트 운영방식</a>
    <a href="/cs/Center">고객센터</a>
      <hr> <!-- 가로 줄 추가 -->
    <div class="footer-info">
        <p>© 2024 Vroom. All Rights Reserved</p>
        <p>VroomCompany | 서울특별시 종로구 종로12길 15, 9층 902호</p>
        <p>사업자등록번호 111-22-33333 | 고객 문의 02-2222-3333 | <a href="#">사업자정보 확인</a></p>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc42aa044cb0d127af995d28498082d8"></script>
<script>

document.getElementById('loginLink').addEventListener('click', function(event) {
    event.preventDefault(); // 링크의 기본 동작을 막습니다

    // 서버에서 `user` 값을 JSP로 전달했다고 가정합니다.
    // `user` 변수가 JSP에서 설정되어 있어야 합니다.
    var user = ${user}; // JSP에서 전달된 `user` 값

    if (user) {
        // `user` 값이 존재하면 MYPAGE로 이동
        window.location.href = '/user/user_detail';
    } else {
        // `user` 값이 없으면 LOGIN으로 이동
        window.location.href = '/user/login';
    }
});

$(".box").on("click",function(){
	 window.location.href = '${contextPath}/vroom/event';
});

// JSON 데이터 파일을 서버에서 가져옵니다
/* fetch('/json/map.json')
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        return response.json();
    })
    .then(data => {
        console.log(data); // 데이터 구조를 확인합니다

        if (data.features && Array.isArray(data.features)) {
            // 지도에 폴리곤으로 표시할 영역데이터 배열입니다
            var areas = data.features.map(feature => ({
                name: feature.properties.CTP_ENG_NM,
                path: feature.geometry.coordinates[0].map(coord => {
                    // 위도와 경도를 kakao.maps.LatLng 객체로 변환
                    const lat = coord[1];
                    const lng = coord[0];
                    return new kakao.maps.LatLng(lat, lng);
                })
            }));

            var mapContainer = document.getElementById('map'),
                mapOption = { 
                    center: new kakao.maps.LatLng(37.566826, 126.9786567),
                    level: 13
                };

            var map = new kakao.maps.Map(mapContainer, mapOption),
                customOverlay = new kakao.maps.CustomOverlay({}),
                infowindow = new kakao.maps.InfoWindow({removable: true});

            // 지도에 영역데이터를 폴리곤으로 표시합니다
            areas.forEach(area => displayArea(area));

            function displayArea(area) {
                var polygon = new kakao.maps.Polygon({
                    map: map,
                    path: area.path,
                    strokeWeight: 2,
                    strokeColor: '#004c80',
                    strokeOpacity: 0.8,
                    fillColor: '#fff',
                    fillOpacity: 0.7 
                });

                kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
                    polygon.setOptions({fillColor: '#09f'});

                    customOverlay.setContent('<div class="area">' + area.name + '</div>');
                    customOverlay.setPosition(mouseEvent.latLng); 
                    customOverlay.setMap(map);
                });

                kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                    customOverlay.setPosition(mouseEvent.latLng); 
                });

                kakao.maps.event.addListener(polygon, 'mouseout', function() {
                    polygon.setOptions({fillColor: '#fff'});
                    customOverlay.setMap(null);
                });

                kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
                    var content = '<div class="info">' + 
                                '   <div class="title">' + area.name + '</div>' +
                                '   <div class="size">총 면적 : 약 ' + Math.floor(polygon.getArea()) + ' m<sup>2</sup></div>' +
                                '</div>';

                    infowindow.setContent(content); 
                    infowindow.setPosition(mouseEvent.latLng); 
                    infowindow.setMap(map);
                });
            }
        } else {
            throw new Error('Unexpected data format.');
        }
    })
    .catch(error => console.error('Error loading JSON:', error)); */
</script>
</body>
</html>
