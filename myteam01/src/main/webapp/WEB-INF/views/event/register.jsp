<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../menu/nav.jsp"%>
<%@ include file="../menu/footer.jsp"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 등록 페이지</title>
<link rel="stylesheet" href="${contextPath}/resources/css/event/event_register.css">
</head>
<body>

<div class="container">
    <h3 style="text-align: center;">행사 등록</h3>
    <form role="form" action="${contextPath}/event/register" method="post" id="frmRegister" enctype="multipart/form-data">
        <div class="form-group">
            <label for="ename">행사 이름</label>
            <input class="form-control" name="ename" id="ename" placeholder="행사 이름을 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="eperiod">행사 기간</label>
            <input class="form-control" name="eperiod" id="eperiod" placeholder="행사 기간을 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="ecost">행사 비용</label>
            <input class="form-control" name="ecost" id="ecost" placeholder="행사 비용을 입력하세요">
        </div>
        
        <div class="form-group">
            <label>행사 주소</label>
            <input type="hidden" class="form-control" name="eaddress" id="eaddress">
            <input type="button" class="btnRegister" onclick="sample4_execDaumPostcode()" value="주소검색"><br>
            <input type="text" class="form-control" id="sample4_roadAddress" placeholder="주소 검색 버튼을 눌러 입력됩니다." readonly oninput="combineAddress()">
            <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세 주소를 입력하세요" oninput="combineAddress()">
            <input type="hidden" class="form-control" id="sample4_extraAddress" placeholder="참고 항목" readonly oninput="combineAddress()">
        </div>
        
        <div class="form-group">
            <label for="map">지도</label>
            <div id="map" style="width:100%;height:350px;"></div>
            <p id="result"></p>
        </div>
        
        <div class="form-group">
            <label for="eplace">행사 장소</label>
            <input class="form-control" name="eplace" id="eplace" placeholder="행사 장소를 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="esite">행사 사이트</label>
            <input class="form-control" name="esite" id="esite" placeholder="행사 사이트를 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="ehost">행사 주최</label>
            <input class="form-control" name="ehost" id="ehost" placeholder="행사 주최를 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="econtent">행사 내용</label>
            <textarea class="form-control" rows="3" name="econtent" id="econtent" placeholder="행사 내용을 입력하세요"></textarea>
        </div>
        
        <input type="hidden" class="form-control" name="eycoord" id="eycoord" readonly>
        <input type="hidden" class="form-control" name="excoord" id="excoord" readonly>
        
        <div class="form-group">
            <label class="custom-file-upload">
                파일 선택
                <input type="file" class="fileInput" id="fileInput" name="fileInput" multiple="multiple">
            </label>
        </div>
        
        <div class="form-group fileUploadResult">
            <ul></ul>
        </div>

        <button type="submit" class="btnRegister" id="btnRegister">등록</button>
        <button type="button" class="btnCancel" id="btnCancel" onclick="location.href='${contextPath}/event/list'">취소</button>
    </form>
</div>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 지도 생성 및 마커 표시
var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(37.5693656626833, 126.986022414113),
        level: 3
    },
    map = new kakao.maps.Map(mapContainer, mapOption),
    marker = new kakao.maps.Marker({
        position: map.getCenter()
    });

marker.setMap(map);

// 주소 검색 API 및 지도 업데이트
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress;
            var extraRoadAddr = data.bname !== '' && /[동|로|가]$/g.test(data.bname) ? data.bname : '';
            extraRoadAddr += data.buildingName !== '' && data.apartment === 'Y' ? (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName) : '';

            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_extraAddress").value = extraRoadAddr || '';
            updateMapWithAddress(roadAddr);
        }
    }).open();
}

// 지도 중심 좌표 변경 함수
function updateMapWithAddress(address) {
    var geocoder = new kakao.maps.services.Geocoder();
    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            map.setCenter(coords);
            marker.setPosition(coords);
            document.getElementById('eycoord').value = result[0].y;
            document.getElementById('excoord').value = result[0].x;
        }
    });
}

// 주소 입력 및 조합 함수
function combineAddress() {
    var roadAddress = document.getElementById("sample4_roadAddress").value;
    var detailAddress = document.getElementById("sample4_detailAddress").value;
    var extraAddress = document.getElementById("sample4_extraAddress").value;
    var fullAddress = roadAddress + ' ' + detailAddress + ' ' + extraAddress;
    document.getElementById("eaddress").value = fullAddress.trim();
}
</script>

</body>
</html>
