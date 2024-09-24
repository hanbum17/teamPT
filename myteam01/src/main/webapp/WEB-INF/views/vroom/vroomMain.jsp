<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Vroom - Home</title>
    <%@ include file="../menu/nav.jsp"%>
    <%@ include file="../menu/footer.jsp"%>
    <link rel="stylesheet" type="text/css" href="/css/vroomMain.css"> 
    <style>
        /* 지도 스타일 추가 */
        #map {
            width: 100%;
            height: 100%;
            height: 500px;
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
            <button id="backButton" style="display:none;">뒤로가기</button>
        </div>
        <div class="message">
            떠나고자 하는 지역을 선택해주세요
        </div>
        
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc42aa044cb0d127af995d28498082d8"></script>
    <script>
 // 카카오 지도 API 로드 후 실행
    document.addEventListener('DOMContentLoaded', function () {
        const initialCenter = new kakao.maps.LatLng(36.591186820098365, 128.19210633207655);
        const initialLevel = 13; // 원래 확대 레벨

        // 서울시 영역 데이터를 가져옵니다
        fetch('/json/SIDO_MAP.json')
            .then(response => response.json())
            .then(data => {
                console.log(data); // 데이터 구조 확인

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

                        kakao.maps.event.addListener(polygon, 'mouseover', function (mouseEvent) {
                            polygon.setOptions({fillColor: '#09f'});

                            customOverlay.setContent('<div class="area">' + area.name + '</div>');
                            customOverlay.setPosition(mouseEvent.latLng);
                            customOverlay.setMap(map);
                        });

                        kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {
                            customOverlay.setPosition(mouseEvent.latLng);
                        });

                        kakao.maps.event.addListener(polygon, 'mouseout', function () {
                            if (highlightedPolygon !== polygon) {
                                polygon.setOptions({fillColor: '#fff'});
                            }
                            customOverlay.setMap(null);
                        });

                        kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {
                            var content = '<div class="info">' +
                                '   <div class="title">' + area.name + '</div>' +
                                '   <div class="size">총 면적 : 약 ' + Math.floor(polygon.getArea()) + ' m<sup>2</sup></div>' +
                                '</div>';

                            infowindow.setContent(content);
                            infowindow.setPosition(mouseEvent.latLng);
                            infowindow.setMap(map);

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

                            // 서울 클릭 시 구별 폴리곤 추가
                            if (area.name === 'Seoul') {
                                fetch('/json/GU_MAP.json')
                                    .then(response => response.json())
                                    .then(guData => {
                                        if (guData.features && Array.isArray(guData.features)) {
                                            var guAreas = guData.features.map(feature => ({
                                                name: feature.properties.name,
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

                            // 뒤로가기 버튼 표시
                            backButton.style.display = 'block'; // 폴리곤 클릭 시 뒤로가기 버튼 표시
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

                        kakao.maps.event.addListener(guPolygon, 'mouseover', function (mouseEvent) {
                            guPolygon.setOptions({fillColor: '#ff6666'});

                            customOverlay.setContent('<div class="area">' + guArea.name + '</div>');
                            customOverlay.setPosition(mouseEvent.latLng);
                            customOverlay.setMap(map);
                        });

                        kakao.maps.event.addListener(guPolygon, 'mousemove', function (mouseEvent) {
                            customOverlay.setPosition(mouseEvent.latLng);
                        });

                        kakao.maps.event.addListener(guPolygon, 'mouseout', function () {
                            guPolygon.setOptions({fillColor: '#ff0000'});
                            customOverlay.setMap(null);
                        });

                        kakao.maps.event.addListener(guPolygon, 'click', function () {
                            var guName = guArea.name; // 클릭한 구 이름
                            console.log("구 이름:", guName);
                            window.location.href = '/vroom/restaurant?guName=' + encodeURIComponent(guName);
                        });
                    }

                 // 뒤로가기 버튼 표시
                    backButton.style.display = 'block'; // 버튼을 보이도록 설정

                 // 뒤로가기 버튼 클릭 이벤트
                    backButton.addEventListener('click', function () {
                        backButton.style.display = 'none'; // 버튼 숨기기
                        polygons.forEach(p => p.setMap(map)); // 원래의 시도 폴리곤 다시 표시
                        map.setCenter(initialCenter); // 지도 원래 중심으로
                        map.setLevel(initialLevel); // 지도 원래 레벨로

                        if (highlightedPolygon) {
                            highlightedPolygon.setOptions({fillColor: '#fff'});
                            highlightedPolygon = null; // 강조된 폴리곤 초기화
                        }
                    });

                }
            })
            .catch(error => {
                console.error('Error loading JSON:', error);
                alert('데이터를 불러오는 중 오류가 발생했습니다.');
            });
    });


    </script>
</body>
</html>
