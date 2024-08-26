<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    var contextPath = "${contextPath}"; // contextPath 변수 설정
    console.log("Context Path: " + contextPath); // 로그로 확인
</script>
<head>
    <meta charset="UTF-8">
    <title>식당 등록</title>
    <style>
        body {
            background-color: #f0f2f5; /* 부드러운 배경색 */
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #ffffff; /* 흰색 배경 */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .page-header {
            margin-bottom: 30px;
            color: #333; /* 헤더 색상 */
            text-align: center;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #555;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9; /* 입력 필드 배경색 */
            color: #333;
            font-size: 16px;
            box-sizing: border-box; /* 박스 사이징 수정 */
        }
        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background-color: #f7a14a; /* 버튼 배경색 */
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #218838; /* 버튼 호버 색상 */
        }
        .radio-group {
            display: flex;
            justify-content: flex-start; /* 왼쪽 정렬 */
            margin-top: 10px;
        }
        .radio-group label {
            font-weight: normal;
            color: #555;
            margin-right: 20px; /* 라디오 버튼 간격 */
        }
        .fileUploadResult ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            color: #555;
        }

        /* 파일 첨부 버튼 스타일 */
        .fileInput {
            display: none; /* 파일 입력 필드 숨기기 */
        }

        .custom-file-upload {
            display: inline-block;
            padding: 10px 20px;
            cursor: pointer;
            border: 1px solid #ccc; /* 테두리 색상 */
            border-radius: 5px;
            background-color: #d3d3d3; /* 회색 배경색 */
            color: black; /* 텍스트 색상 */
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .custom-file-upload:hover {
            background-color: #a9a9a9; /* 호버 시 색상 (어두운 회색) */
        }
        .custom-delete {
            color: red;
            cursor: pointer;
            margin-left: 10px;
            font-weight: bold;
            text-decoration: underline; /* 밑줄 추가 */
        }
        .custom-delete:hover {
            color: darkred; /* 호버 시 색상 변경 */
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/admin_main/header.jsp" %>
    <div class="container">
        <h4 class="page-header">식당 등록</h4>
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
            <div class="form-group">
                <label for="fxcoord">x좌표</label>
                <input type="text" class="form-control" id="fxcoord" name="fxcoord" placeholder="x좌표를 입력하세요">
            </div>
            <div class="form-group">
                <label for="fycoord">y좌표</label>
                <input type="text" class="form-control" id="fycoord" name="fycoord" placeholder="y좌표를 입력하세요">
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

function showUploadResult(uploadResult) {
    var fileUploadResultUL = $(".fileUploadResult ul");
    var htmlStr = "";
    
    $(uploadResult).each(function(i, attachFile) {
        var fullFileName = encodeURI(attachFile.repoPath + "/" +
                                     attachFile.uploadPath + "/" +
                                     attachFile.uuid + "_" +
                                     attachFile.fileName);
        var thumbnail = encodeURI(attachFile.repoPath + "/" +
                                  attachFile.uploadPath + "/s_" +
                                  attachFile.uuid + "_" +
                                  attachFile.fileName);
        htmlStr += "<li data-uploadpath='" + attachFile.uploadPath + "'"
                  + " data-uuid='" + attachFile.uuid + "'"
                  + " data-filename='" + attachFile.fileName + "'"
                  + " data-filetype='I'>"
                  + "   <img src='" + contextPath + "/displayThumbnail?fileName=" + thumbnail + "' alt='thumbnail'>"
                  + "   &emsp;" + attachFile.fileName
                  + "   <span class='custom-delete'>삭제</span>"
                  + "</li>";
    });
    fileUploadResultUL.append(htmlStr);
}

var cloneFileInput = $(".uploadDiv").clone();
console.log(cloneFileInput.html());

$(".uploadDiv").on("change", "input[type='file']", function() {
    var fileInputs = $("input[name='fileInput']");
    var uploadFiles = fileInputs[0].files;
    var formData = new FormData();
    
    for (var i = 0; i < uploadFiles.length; i++) {
        if (!checkUploadFile(uploadFiles[i].name, uploadFiles[i].size)) {
            console.log("파일 이름: " + uploadFiles[i].name);
            console.log("파일 크기: " + uploadFiles[i].size);
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
            console.log(uploadResult);
            $(".uploadDiv").html(cloneFileInput.html());
            showUploadResult(uploadResult);
        }
    });
});

$(".fileUploadResult ul").on("click", ".custom-delete", function() {
    var fileLi = $(this).parent();
    var fileName = fileLi.data("repoPath")+"/"+
    			   fileLi.data("uploadpath") + "/" +
    			   fileLi.data("uuid") + "_" +
    			   fileLi.data("filename");
    var fileType = 'I'; // 적절한 파일 타입 설정

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
<%@ include file="/WEB-INF/views/admin_main/footer.jsp" %>
</script>
</body>
</html>
