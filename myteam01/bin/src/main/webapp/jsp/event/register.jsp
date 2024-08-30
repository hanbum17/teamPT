<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>행사 등록 페이지</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    /* 사이드바가 중앙에 위치하므로, body의 flex 스타일을 제거합니다 */
    margin: 0; /* 기본 여백 제거 */
    overflow-x: hidden; /* 사이드바가 화면 밖으로 이동하지 않도록 설정 */
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    /* 중앙에 배치하려면 display flex와 함께 부모 요소에서 정렬해야 합니다 */
    margin: 0 auto; /* form을 중앙 정렬 */
    position: relative; /* form이 사이드바의 위에 보일 수 있도록 설정 */
    z-index: 1; /* 사이드바 위에 위치하도록 설정 */
}

.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-control {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.fileUploadResult ul {
    list-style: none;
    padding: 0;
}

.fileUploadResult li {
    margin: 5px 0;
}

.btnRegister, .btnCancel {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
}

.btnRegister {
    background-color: #28a745;
}

.btnCancel {
    background-color: #dc3545;
}

.btnRegister:hover, .btnCancel:hover {
    opacity: 0.9;
}

.btnCancel {
    margin-left: 10px;
}

#map {
    margin-top: 20px;
    width: 100%;
    height: 350px;
}

</style>
</head>
<body>
<%-- <%@ include file="/jsp/admin_main/header.jsp" %> --%>
<h3 style="text-align: center;">행사 등록</h3>
<form role="form" action="${contextPath}/event/register" method="post" id="frmRegister" enctype="multipart/form-data">
    <div class="form-group">
        <label>행사 이름</label>
        <input class="form-control" name="ename" id="ename">
    </div>
    
    <div class="form-group">
        <label>행사 기간</label>
        <input class="form-control" name="eperiod" id="eperiod">
    </div>
    
    <div class="form-group">
        <label>행사 비용</label>
        <input class="form-control" name="ecost" id="ecost">
    </div>
    
    <div class="form-group">
        <label>행사 주소</label>
        <textarea class="form-control" name="eaddress" id="eaddress"></textarea>
    </div>
    
    <div class="form-group">
        <label>행사 장소</label>
        <input class="form-control" name="eplace" id="eplace">
    </div>
    
    <div class="form-group">
        <label>행사 사이트</label>
        <textarea class="form-control" rows="3" name="esite" id="esite"></textarea>
    </div>
    
    <div class="form-group">
        <label>행사 주최</label>
        <input class="form-control" name="ehost" id="ehost">
    </div>
    
    <div class="form-group">
        <label>행사 내용</label>
        <textarea class="form-control" rows="3" name="econtent" id="econtent"></textarea>
    </div>
    
    <div class="form-group">
        <label>행사 y좌표</label>
        <input class="form-control" name="eycoord" id="eycoord" readonly>
    </div>
    
    <div class="form-group">
        <label>행사 x좌표</label>
        <input class="form-control" name="excoord" id="excoord" readonly>
    </div>
    
    <!-- 파일 첨부 버튼 -->
    <label class="custom-file-upload">
        파일 선택
        <input type="file" class="fileInput" id="fileInput" name="fileInput" multiple="multiple">
    </label>
    <div class="form-group fileUploadResult">
        <ul>
            <%-- 업로드 후, 업로드 처리결과가 표시될 영역  --%>
        </ul>
    </div>

    <button type="submit" class="btnRegister" id="btnRegister">등록</button>
    <button type="button" class="btnCancel" id="btnCancel" data-oper="list"
             onclick="location.href='${contextPath}/event/list'">취소</button>
</form>

<script>
function checkUploadFile(fileName, fileSize) {
    var allowedMaxSize = 1048576; // 1MB
    var regExpForbiddenFileExtension = /((\.(exe|dll|sh|c|zip|alz|tar)$)|^[^.]+$|(^\.[^.]{1,}$))/i;

    if (fileSize > allowedMaxSize) {
        alert("업로드 파일의 크기는 1MB 보다 작아야 합니다.");
        return false;
    }

    if (regExpForbiddenFileExtension.test(fileName)) {
        alert("선택하신 파일은 업로드 하실 수 없는 유형입니다.");
        return false;
    }
    return true;
}

function checkEventValue() {
    var ename = document.getElementById("ename").value;
    var eperiod = document.getElementById("eperiod").value;
    var ecost = document.getElementById("ecost").value;
    var eaddress = document.getElementById("eaddress").value;
    var eplace = document.getElementById("eplace").value;
    var esite = document.getElementById("esite").value;
    var ehost = document.getElementById("ehost").value;
    var econtent = document.getElementById("econtent").value;
    
    var regExp = /^\s+$/;

    if (!ename || !eperiod || !ecost || !eaddress || !eplace || !esite || !ehost || !econtent ||
        regExp.test(ename) || regExp.test(eperiod) || 
        regExp.test(ecost) || regExp.test(eaddress) ||
        regExp.test(eplace) || regExp.test(esite) ||
        regExp.test(ehost) || regExp.test(econtent)) {
        return false;
    } else {
        return true;
    }
}

$("#btnRegister").on("click", function() {
    if (!checkEventValue()) {
        alert("모든 필드를 유효한 값으로 입력해야 합니다.");
        return;
    }

    var frmRegister = $("#frmRegister");
    var attachFileInputHTML = "";

    $("div.fileUploadResult ul li").each(function(i, objLi) { 
        var attachLi = $(objLi);

        attachFileInputHTML
            += "<input type='hidden' name='attachFileList[" + i + "].uuid' value='" + attachLi.data("uuid") + "'>"
            + "<input type='hidden' name='attachFileList[" + i + "].uploadPath' value='" + attachLi.data("uploadpath") + "'>"
            + "<input type='hidden' name='attachFileList[" + i + "].fileName' value='" + attachLi.data("filename") + "'>"
            + "<input type='hidden' name='attachFileList[" + i + "].fileType' value='" + attachLi.data("filetype") + "'>";
    });

    if (attachFileInputHTML) {
        frmRegister.append(attachFileInputHTML);
    }

    frmRegister.submit();
});

//파일 첨부 시 선택된 파일 이름 표시
$('#fileInput').on('change', function() {
    var files = $(this).prop('files');
    var validFiles = true;

    $('.fileUploadResult ul').empty(); // 기존 목록 초기화

    $.each(files, function(i, file) {
        if (!checkUploadFile(file.name, file.size)) {
            validFiles = false;
            return false; // 루프 중단
        }
        $('.fileUploadResult ul').append('<li>' + file.name + '</li>'); // 파일 목록에 추가
    });

    if (!validFiles) {
        $(this).val(''); // 입력 필드 초기화
    }
});
</script>

<%-- <%@ include file="/jsp/admin_main/footer.jsp" %> --%>
</body>
<input type="text" placeholder="주소입력" id="address">

<div id="map"></div>

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

//마커 생성
var marker = new kakao.maps.Marker({
    position: map.getCenter()
});

//마커 표시
marker.setMap(map);

// 인풋창 입력 시 중심좌표 이동
$("#address").on("change", function() {
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

           // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
           map.setCenter(coords);
           map.setLevel(4);
       } 
   });    
});

// 지도에 클릭 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
  // 클릭한 위도, 경도 정보를 가져옵니다 
  var latlng = mouseEvent.latLng; 

  // 마커 위치를 클릭한 위치로 옮깁니다
  marker.setPosition(latlng);
  console.log("y좌표: " + latlng.getLat() + ", x좌표: " + latlng.getLng());

  // y좌표와 x좌표를 각각 입력 필드에 설정합니다
  document.getElementById('eycoord').value = latlng.getLat(); // y좌표 설정
  document.getElementById('excoord').value = latlng.getLng(); // x좌표 설정
});
</script>

</html>
