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
            width: 100%; /* 부모 요소인 box의 너비에 맞추기 */
            height: 100%; /* 부모 요소인 box의 높이에 맞추기 */
            position: relative; /* 지도의 위치 설정 */
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">Vroom</div>
        <div class="nav">
            <a href="#about">ABOUT US</a>
            <a href="#login">LOGIN</a>
            <a href="#contact">CONTACT US</a>
        </div>
    </div>

    <div class="container">
        <div class="box">
            <div id="map"></div>
        </div>
        <div class="message">
            떠나고자 하는 지역을 선택해주세요
        </div>
        <button id="backButton" style="display:none;">뒤로가기</button> <!-- 뒤로가기 버튼 추가 -->
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
    document.addEventListener('DOMContentLoaded', function () {
        // 지도 초기 상태를 저장할 변수
        var initialCenter = new kakao.maps.LatLng(36.591186820098365, 128.19210633207655);
        var initialLevel = 13;

        // 뒤로가기 버튼
        var backButton = document.getElementById('backButton');

        fetch('/json/SIDO_MAP.json')
            .then(response => response.json())
            .then(data => {
                if (data.features && Array.isArray(data.features)) {
                    var areas = data.features.map(feature => ({
                        name: feature.properties.CTP_ENG_NM,
                        path: feature.geometry.coordinates[0].map(coord => {
                            const lat = coord[1];
                            const lng = coord[0];
                            return new kakao.maps.LatLng(lat, lng);
                        })
                    }));

                    var mapContainer = document.getElementById('map');
                    var mapOption = { 
                        center: initialCenter,
                        level: initialLevel,
                        draggable: false,
                        scrollwheel: false,
                        disableDoubleClickZoom: true
                    };

                    var map = new kakao.maps.Map(mapContainer, mapOption),
                        customOverlay = new kakao.maps.CustomOverlay({}),
                        infowindow = new kakao.maps.InfoWindow({removable: true}),
                        highlightedPolygon = null;

                    var polygons = [];

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

                        polygons.push(polygon);

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
                            if (highlightedPolygon !== polygon) {
                                polygon.setOptions({fillColor: '#fff'});
                            }
                            customOverlay.setMap(null);
                        });

                        kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
                            var bounds = new kakao.maps.LatLngBounds();
                            area.path.forEach(coord => bounds.extend(coord));
                            map.setBounds(bounds);
                            map.setLevel(9);

                            if (highlightedPolygon) {
                                highlightedPolygon.setOptions({fillColor: '#fff'});
                            }
                            highlightedPolygon = polygon;
                            polygon.setOptions({fillColor: '#09f'});

                            polygons.forEach(p => p.setMap(null));

                            // 뒤로가기 버튼 표시
                            backButton.style.display = 'block';

                            // 서울 클릭 시 구별 폴리곤 추가
                            if (area.name === 'Seoul') {
                                fetch('/json/GU_MAP.json')
                                    .then(response => response.json())
                                    .then(guData => {
                                        if (guData.features && Array.isArray(guData.features)) {
                                            var guAreas = guData.features.map(feature => ({
                                                name: feature.properties.name, // 'GU_NAME'을 'name'으로 수정
                                                path: feature.geometry.coordinates[0].map(coord => {
                                                    const lat = coord[1];
                                                    const lng = coord[0];
                                                    return new kakao.maps.LatLng(lat, lng);
                                                })
                                            }));
                                            guAreas.forEach(guArea => displayGuArea(guArea));
                                        }
                                    })
                                    .catch(error => console.error('Error loading GU_MAP.json:', error));
                            }
                        });
                    }

                    function displayGuArea(guArea) {
                        var guPolygon = new kakao.maps.Polygon({
                            map: map,
                            path: guArea.path,
                            strokeWeight: 2,
                            strokeColor: '#ff0000',
                            strokeOpacity: 0.8,
                            fillColor: '#ff0000',
                            fillOpacity: 0.4 
                        });

                        kakao.maps.event.addListener(guPolygon, 'mouseover', function(mouseEvent) {
                            guPolygon.setOptions({fillColor: '#ff6666'});

                            customOverlay.setContent('<div class="area">' + guArea.name + '</div>');
                            customOverlay.setPosition(mouseEvent.latLng); 
                            customOverlay.setMap(map);
                        });

                        kakao.maps.event.addListener(guPolygon, 'mousemove', function(mouseEvent) {
                            customOverlay.setPosition(mouseEvent.latLng); 
                        });

                        kakao.maps.event.addListener(guPolygon, 'mouseout', function() {
                            guPolygon.setOptions({fillColor: '#ff0000'});
                            customOverlay.setMap(null);
                        });

                        kakao.maps.event.addListener(guPolygon, 'click', function() {
                            var guName = guArea.name; // 클릭한 구 이름
                            console.log("구 이름:", guName); // 구 이름 확인
                            window.location.href = '/vroom/restaurant?guName=' + encodeURIComponent(guName); // 링크로 이동
                        });
                    }

                    // 뒤로가기 버튼 클릭 이벤트
                    backButton.addEventListener('click', function() {
                        backButton.style.display = 'none'; // 뒤로가기 버튼 숨기기
                        polygons.forEach(p => p.setMap(map)); // 원래의 구역 다시 표시
                        map.setCenter(initialCenter);
                        map.setLevel(initialLevel);
                        if (highlightedPolygon) {
                            highlightedPolygon.setOptions({fillColor: '#fff'});
                            highlightedPolygon = null;
                        }
                    });
                }
            })
            .catch(error => console.error('Error loading SIDO_MAP.json:', error));
    });
    </script>
</body>
</html>
