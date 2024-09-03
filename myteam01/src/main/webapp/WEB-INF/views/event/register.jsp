<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 등록 페이지</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    overflow-x: hidden;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
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
<%@ include file="/WEB-INF/views/admin_main/header.jsp" %>
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
        <input type="hidden" class="form-control" name="eaddress" id="eaddress">
        <input type="button" class="btnRegister" onclick="sample4_execDaumPostcode()" value="주소검색"><br>
        <input type="text" class="form-control" id="sample4_roadAddress" placeholder="주소 검색 버튼을 눌러 입력, 도로명 주소로 입력됩니다." readonly oninput="combineAddress()">   
        <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소 입력" oninput="combineAddress()">
        <input type="hidden" class="form-control" id="sample4_extraAddress" placeholder="참고항목" readonly oninput="combineAddress()">
    </div>
    
	<div class="form-group">
	    <label>지도</label>
	    <div id="map" style="width:100%;height:350px;"></div>
	    <p><em>지도 중심좌표가 변경되면 지도 정보가 표출됩니다</em></p>
	    <p id="result"></p>
	</div>
		
    <div class="form-group">
        <label>행사 장소</label>
        <input class="form-control" name="eplace" id="eplace">
    </div>
    
    <div class="form-group">
        <label>행사 사이트</label>
        <input class="form-control" name="esite" id="esite">
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
        <!-- <label>행사 y좌표</label> -->
        <input type="hidden" class="form-control" name="eycoord" id="eycoord" readonly>
    </div>
    
    <div class="form-group">
        <!--  <label>행사 x좌표</label> -->
        <input type="hidden" class="form-control" name="excoord" id="excoord" readonly>
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
//파일 업로드 및 결과 표시
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

function showUploadResult(uploadResult) {
    var fileUploadResultUL = $(".fileUploadResult ul");
    var htmlStr = "";

    $(uploadResult).each(function(i, attachFile) {
        var fullFileName = encodeURI(attachFile.repoPath + "/" +
                                     attachFile.uploadPath + "/" +
                                     attachFile.uuid + "_" +
                                     attachFile.fileName);
        htmlStr += "<li data-repopath='" + attachFile.repoPath + "'"  
                  + " data-uploadpath='" + attachFile.uploadPath + "'"
                  + " data-uuid='" + attachFile.uuid + "'"
                  + " data-filename='" + attachFile.fileName + "'"
                  + " data-filetype='I'>"
                  + "   " + attachFile.fileName
                  + "   <span class='custom-delete'>삭제</span>"
                  + "</li>";
    });
    fileUploadResultUL.append(htmlStr);
}

var cloneFileInput = $(".uploadDiv").clone();

$(".uploadDiv").on("change", "input[type='file']", function() {
    var fileInputs = $("input[name='fileInput']");
    var uploadFiles = fileInputs[0].files;
    var formData = new FormData();
    
    for (var i = 0; i < uploadFiles.length; i++) {
        if (!checkUploadFile(uploadFiles[i].name, uploadFiles[i].size)) {
            $("#fileInput").val("");
            return;
        }
        formData.append("uploadFiles", uploadFiles[i]);
    }
    
    $.ajax({
        type: "post",
        url: "${contextPath}/doFileUploadByAjax",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(uploadResult, status) {
            $(".uploadDiv").html(cloneFileInput.html());
            showUploadResult(uploadResult);
        }
    });
});

$(".fileUploadResult ul").on("click", ".custom-delete", function() {
    var fileLi = $(this).closest('li'); // 부모 li 요소 선택
    var fileName = fileLi.data("repopath") + "/" + 
                   fileLi.data("uploadpath") + "/" +
                   fileLi.data("uuid") + "_" +
                   fileLi.data("filename");
    var fileType = 'I'; 

    $.ajax({
        type: "post",
        url: "${contextPath}/deleteFile",
        data: {fileName: fileName, fileType: fileType},
        dataType: "text",
        success: function(result) { 
            if (result == "DelSuccess") {
                alert("파일이 삭제되었습니다.");
                fileLi.remove();
            } else {
                if (confirm("파일이 존재하지 않습니다. 해당 항목을 삭제하시겠습니까?")) {
                    fileLi.remove();
                }
            } 
        }
    });
});


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
        += "<input type='hidden' name='attachFileList[" + i + "].repoPath' value='" + attachLi.data("repoPath") + "'>"
        + "<input type='hidden' name='attachFileList[" + i + "].uuid' value='" + attachLi.data("uuid") + "'>"
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

<%@ include file="/WEB-INF/views/admin_main/footer.jsp" %>
</body>
<!-- <input type="text" placeholder="주소입력" id="address"> -->



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a&libraries=services"></script> <!-- 지도생성 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소검색api -->
<script>

// 지도를 생성하는 코드
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new kakao.maps.LatLng(37.5693656626833, 126.986022414113), // 지도의 초기 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: map.getCenter() // 마커의 초기 위치는 지도 중심으로 설정합니다
});

// 마커를 지도에 표시합니다
marker.setMap(map);

// 도로명 주소 입력 시 지도 중심을 해당 주소로 이동하고 좌표를 업데이트하는 함수
function updateMapWithAddress(address) {
    var geocoder = new kakao.maps.services.Geocoder();
    
    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            
            // 지도의 중심을 해당 좌표로 이동합니다
            map.setCenter(coords);
            // 마커 위치를 업데이트합니다
            marker.setPosition(coords);

            // 좌표를 eycoord와 excoord 필드에 설정합니다
            document.getElementById('eycoord').value = result[0].y;
            document.getElementById('excoord').value = result[0].x;
        } else {
            console.error('Geocode was not successful for the following reason: ' + status);
        }
    });
}

// 도로명 주소 입력 필드의 값이 변경될 때마다 호출되는 이벤트 핸들러
document.getElementById('sample4_roadAddress').addEventListener('input', function() {
    var address = this.value.trim();
    if (address) {
        updateMapWithAddress(address);
    }
});

// 주소 검색 함수
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_extraAddress").value = extraRoadAddr || '';

            // 입력된 도로명 주소로 지도와 좌표를 업데이트합니다
            updateMapWithAddress(roadAddr);
        }
    }).open();
}

// 주소 입력 함수 = 도로명주소 + 상세주소 + 참고주소
function combineAddress() {
    var roadAddress = document.getElementById("sample4_roadAddress").value;
    var detailAddress = document.getElementById("sample4_detailAddress").value;
    var extraAddress = document.getElementById("sample4_extraAddress").value;

    var fullAddress = roadAddress + ' ' + detailAddress + ' ' + extraAddress;

    document.getElementById("eaddress").value = fullAddress.trim();
}

</script>
</html>