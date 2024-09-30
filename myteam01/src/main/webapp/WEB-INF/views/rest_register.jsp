<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./menu/nav.jsp"%>
<%@ include file="./menu/footer.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>식당 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        var contextPath = "${contextPath}"; // contextPath 변수 설정
        console.log("Context Path: " + contextPath); // 로그로 확인
    </script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restaurant/rest_register.css">
</head>
<body>
    <div class="container">
        <h4 class="page-header">음식점 등록</h4>
        <form role="form" action="${contextPath}/restaurant/rest_register" method="post" id="frmRegister" enctype="multipart/form-data">
            <div class="form-group">
                <label for="fcategory">카테고리</label>
                <input type="text" class="form-control" id="fcategory" name="fcategory" placeholder="예: 한식, 중식 등">
            </div>
            <div class="form-group">
                <label for="fname">식당 이름</label>
                <input type="text" class="form-control" id="fname" name="fname" placeholder="식당 이름을 입력하세요">
            </div>
            <div class="form-group">
                <label for="faddress">식당 주소</label>
                <input type="text" class="form-control" id="faddress" name="faddress" placeholder="주소를 입력하세요">
            </div>
            <div class="form-group">
                <label for="frating">별점</label>
                <input type="number" class="form-control" id="frating" name="frating" placeholder="별점을 입력하세요 (0-5)" min="0" max="5" step="0.1">
            </div>
            <div id="map"></div>
    		<p><em>핀을 클릭하여 위치를 조정하세요.</em></p>
            <div class="form-group" style="display: none;">
                <label for="fxcoord">x좌표</label>

                <input type="text" class="form-control" id="fxcoord" name="fxcoord" placeholder="x좌표를 입력하세요" readonly>
            </div>
            <div class="form-group" style="display: none;">
                <label for="fycoord">y좌표</label>
                <input type="text" class="form-control" id="fycoord" name="fycoord" placeholder="y좌표를 입력하세요" readonly>

            </div>
            <div class="form-group">
                <label>등록 확인</label>
                <div class="radio-group">
                    <label><input type="radio" name="ftype" value="0" checked> 불허</label>
                    <label><input type="radio" name="ftype" value="1"> 확인</label>
                </div>
            </div>

            <!-- 파일 첨부 버튼 -->
            <div class="form-group uploadDiv">
                <label class="custom-file-upload">
                    파일 선택
                    <input type="file" class="fileInput" id="fileInput" name="fileInput" multiple="multiple">
                </label>
            </div>
            <div class="form-group fileUploadResult">
                <ul>
                    <%-- 업로드 후, 업로드 처리결과가 표시될 영역  --%>
                </ul>
            </div>

            <button type="button" class="btn" id="btnRegister">등록</button>
        </form>
    </div>
    

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a&libraries=services"></script>
    <script>
        // 카카오 지도 초기화
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(37.14146122533543, 127.06907845124624), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 생성
        var marker = new kakao.maps.Marker({
            position: map.getCenter(),
            draggable: true // 마커를 드래그 가능하게 설정
        });

        // 마커 표시
        marker.setMap(map);

        // 주소 입력 시 핀 위치 변경
        $("#faddress").on("change", function() {
            var address = $(this).val();
            var geocoder = new kakao.maps.services.Geocoder();

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch(address, function(result, status) {
                // 정상적으로 검색이 완료됐으면 
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    marker.setPosition(coords); // 마커 위치를 변경
                    map.setCenter(coords); // 지도 중심을 변경
                    $("#fxcoord").val(result[0].x); // x좌표 설정
                    $("#fycoord").val(result[0].y); // y좌표 설정
                } else {
                    alert("주소를 찾을 수 없습니다.");
                }
            });
        });

        // 지도 클릭 시 마커 위치 변경
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            var latlng = mouseEvent.latLng; // 클릭한 위치
            marker.setPosition(latlng); // 마커 위치 변경
            $("#fxcoord").val(latlng.getLng()); // x좌표 설정
            $("#fycoord").val(latlng.getLat()); // y좌표 설정
        });

        // 마커 드래그 시 좌표 업데이트
        kakao.maps.event.addListener(marker, 'dragend', function() {
            var latlng = marker.getPosition();
            $("#fxcoord").val(latlng.getLng()); // x좌표 설정
            $("#fycoord").val(latlng.getLat()); // y좌표 설정
        });

        // 파일 업로드 및 결과 표시
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

        function restaurantValue() {
            var fcategory = document.getElementById("fcategory").value;
            var fname = document.getElementById("fname").value;
            var faddress = document.getElementById("faddress").value;
            var frating = document.getElementById("frating").value; // 별점
            var fxcoord = document.getElementById("fxcoord").value; // x좌표
            var fycoord = document.getElementById("fycoord").value; // y좌표
            var ftype = document.querySelector('input[name="ftype"]:checked'); // 식당 타입
            
            var regExp = /^\s+$/;

            // 모든 필드 검증
            if (!fcategory || !fname || !faddress || !frating || !fxcoord || !fycoord || !ftype ||
                regExp.test(fcategory) || regExp.test(fname) || 
                regExp.test(faddress) || regExp.test(frating) ||
                regExp.test(fxcoord) || regExp.test(fycoord)) {
                return false;
            } else {
                return true;
            }
        }

        $("#btnRegister").on("click", function() {
            if (!restaurantValue()) {
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
    </script>

</body>
</html>
