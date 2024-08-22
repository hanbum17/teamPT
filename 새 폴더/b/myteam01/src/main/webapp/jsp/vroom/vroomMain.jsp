<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Vroom - Home</title>
    <link rel="stylesheet" type="text/css" href="/css/vroomMain.css"> <!-- CSS 파일 링크 -->
    <style>
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
    </div>

    <div class="footer">
        <a href="#terms">이용약관</a>
        <a href="#privacy">개인정보 취급방침</a>
        <a href="#cookies">쿠키정책</a>
        <a href="#cookie-consent">쿠키동의</a>
        <a href="#site">사이트 운영방식</a>
        <a href="#support">고객센터</a>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc42aa044cb0d127af995d28498082d8"></script>
    <script>
        // JSON 데이터 파일을 서버에서 가져옵니다
        fetch('/json/map.json')
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
            .catch(error => console.error('Error loading JSON:', error));
    </script>

</body>
</html>
