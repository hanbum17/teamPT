<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<title>Test</title>
	<meta charset="UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<input type="text" placeholder="주소입력" id="address">

<div id="map" style="width:100%;height:350px;"></div>
<p><em>지도 중심좌표가 변경되면 지도 정보가 표출됩니다</em></p>
<p id="result"></p>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a&libraries=services"></script>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.14146122533543, 127.06907845124624), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);
var address = "의정부시 장곡로 240";
//결과값으로 받은 위치를 마커로 표시합니다

//마커생성
var marker = new kakao.maps.Marker({
	//마커위치설정
    position: map.getCenter()
});

//마커표시
marker.setMap(map);

var geocoder ;
var list = [];
$(document).ready(function(){
	$.ajax({
		type: "get",
		url: "/event/ehost",
		success: function(hostList) {
            console.log(hostList); // result = ehost List
            for (var i = 0; i < hostList.length; i++) {
                (function(i) {
                    geocoder = new kakao.maps.services.Geocoder();
                    geocoder.addressSearch(hostList[i], function(result, status) { // result = x,y
                        if (status === kakao.maps.services.Status.OK) {
                            //console.log(hostList[i] + " y좌표: " + result[0].y + " x좌표: " + result[0].x);
                       		list.push({"ehost": hostList[i], "excoord": result[0].x, "eycoord": result[0].y});
                        }
                    });
                })(i);
            }//for end
            
            
             $.ajax({
            	type: "POST",
            	url: "/event/updateEventCoord",
            	data: JSON.stringify(list),
            	contentType: "application/json",
            	success: function(result){
            		console.log("success");
            	}
            });//ajax end
            
            
            console.log(list);
        } // success end
	});
});




<!-- 인풋창 입력시 중심좌표 이동 -->
$("#address").on("change", function(){
	address = $("#address").val();
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			console.log("y좌표: " + result[0].y + " x좌표: " + result[0].x);
			
	        marker.setPosition(coords);

	        /* // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
	        });
	        infowindow.open(map, marker); */

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	        map.setLevel(4);
	    } 
	});    
});
    /* x
: 
127.06907845124624
y
: 
37.14146122533543 */
//지도에 클릭 이벤트를 등록합니다
//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
 
 // 클릭한 위도, 경도 정보를 가져옵니다 
 var latlng = mouseEvent.latLng; 
 
 // 마커 위치를 클릭한 위치로 옮깁니다
 marker.setPosition(latlng);
 console.log("좌표 " + latlng[0]);
 console.log(typeof("(123.123,234.234)"));
});



</script>

<!-- TM좌표를 WSG84좌표로 변환하는 스크립트 -->
<script>
//6b861044f2ac4d9e31f7e31184ac5a2b
var x = 206067.040577222 ;
var y = 404408.638877875 ;
var input_coord = "TM" ;
var output_coord = "WGS84" ;
var data = {x: x, y: y, input_coord: input_coord, output_coord: output_coord} ;

$(document).ready(function(){
	$.ajax({
		type: "get",
		url: "https://dapi.kakao.com/v2/local/geo/transcoord.json",
		data: data,
		beforeSend: function (xhr) {
	        xhr.setRequestHeader("Authorization","KakaoAK 6b861044f2ac4d9e31f7e31184ac5a2b");
	    },
		success: function(result){
			console.log(result);
		}
	});
})
</script>
</body>
</html>
