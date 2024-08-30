<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 (FAQ)</title>
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
<h3 style="text-align: center;">FAQ 등록</h3>
<form role="form" action="${contextPath}/cs/faq" method="post" id="frmRegister" enctype="multipart/form-data">
    <div class="form-group">
        <label>FAQ 카테고리</label>
        <input class="form-control" name="faqcategory" id="faqcategory">
    </div>
    
    <div class="form-group">
        <label>FAQ 제목(질문)</label>
        <textarea class="form-control" rows="3" name="faqtitle" id="faqtitle"></textarea>
    </div>
    
    <div class="form-group">
        <label>FAQ 내용(답변)</label>
        <textarea class="form-control" rows="10" name="faqcontent" id="faqcontent"></textarea>
    </div>
    

    

    
<!--     파일 첨부 버튼
    <label class="custom-file-upload">
        파일 선택
        <input type="file" class="fileInput" id="fileInput" name="fileInput" multiple="multiple">
    </label>
    <div class="form-group fileUploadResult">
        <ul>
        </ul>
    </div> -->

    <button type="submit" class="btnRegister" id="btnRegister">등록</button>
    <button type="button" class="btnCancel" id="btnCancel" data-oper="list"
             onclick="location.href='${contextPath}/cs/Center'">취소</button>
</form>

<script>
/* function checkUploadFile(fileName, fileSize) {
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
} */

function checkFAQValue() {
    var faqcategory = document.getElementById("faqcategory").value;
    var faqtitle = document.getElementById("faqtitle").value;
    var faqcontent = document.getElementById("faqcontent").value;

    var regExp = /^\s+$/;

    if (!faqcategory || !faqtitle || !faqcontent ||
        regExp.test(faqcategory) || regExp.test(faqtitle) || 
        regExp.test(faqcontent)) {
        return false;
    } else {
        return true;
    }
}

$("#btnRegister").on("click", function() {
    if (!checkFAQValue()) {
        alert("모든 필드를 유효한 값으로 입력해야 합니다.");
        return;
    }

    var frmRegister = $("#frmRegister");
/*     var attachFileInputHTML = "";

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
 */
    frmRegister.submit();
});

/* //파일 첨부 시 선택된 파일 이름 표시
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
}); */
</script>

<%@ include file="/WEB-INF/views/admin_main/footer.jsp" %>
</body>

</script>
</html>