<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./menu/nav.jsp"%>
<%@ include file="./menu/footer.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 수정 페이지</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    overflow-x: hidden;
}
button {
    padding: 10px 20px;
    margin: 5px;
    border: none;
    border-radius: 4px;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
}
.btnSave {
    background-color: #007bff;
}
.btnCancel {
    background-color: #dc3545;
}
button:hover {
    opacity: 0.9;
}
form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
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
</style>
</head>
<body>

<h1 style="text-align: center;">고객센터 통합 수정</h1>

<form id="frmEdit" name="frmEdit" method="post" action="${contextPath}/cs/editProc">
    <input type="hidden" name="type" value="${param.type}" />
    
<!-- FAQ 섹션 -->
<div id="faqSection" class="section" style="${param.type != 'faq' ? 'display:none;' : ''}">
    <input type="hidden" name="faqno" value="${cs.faqno != null ? cs.faqno : ''}" />
    <div class="form-group">
        <label>카테고리</label>
        <select name="faqcategory" id="faqcategory" class="form-control">
            <option value="일반" ${cs.faqcategory == '일반' ? 'selected' : ''}>일반</option>
            <option value="결제" ${cs.faqcategory == '결제' ? 'selected' : ''}>결제</option>
            <option value="서비스" ${cs.faqcategory == '서비스' ? 'selected' : ''}>서비스</option>
            <option value="기타" ${cs.faqcategory == '기타' ? 'selected' : ''}>기타</option>
        </select>
    </div>
    <div class="form-group">
        <label>질문 제목</label>
        <input type="text" id="faqtitle" name="faqtitle" class="form-control" value="${cs.faqtitle != null ? cs.faqtitle : ''}" />
    </div>
    <div class="form-group">
        <label>답변 내용</label>
        <textarea id="faqcontent" name="faqcontent" rows="5" class="form-control">${cs.faqcontent != null ? cs.faqcontent : ''}</textarea>
    </div>
</div>

<!-- 고객의 소리 (Feedback) 섹션 -->
<div id="feedbackSection" class="section" style="${param.type != 'feedback' ? 'display:none;' : ''}">
    <input type="hidden" name="fbno" value="${cs.fbno != null ? cs.fbno : ''}" />
    <div class="form-group">
        <label for="feedbackTitle">건의 제목</label>
        <input type="text" id="feedbackTitle" name="fbtitle" class="form-control" value="${cs.fbtitle != null ? cs.fbtitle : ''}" />
    </div>
    <div class="form-group">
        <label for="feedbackContent">건의 내용</label>
        <textarea id="feedbackContent" name="fbcontent" rows="5" class="form-control">${cs.fbcontent != null ? cs.fbcontent : ''}</textarea>
    </div>
</div>

<!-- 1:1 문의 (Inquiry) 섹션 -->
<div id="inquirySection" class="section" style="${param.type != 'inquiry' ? 'display:none;' : ''}">
    <input type="hidden" name="ino" value="${cs.ino != null ? cs.ino : ''}" />
    <div class="form-group">
        <label>카테고리</label>
        <select name="icategory" id="inquirycategory" class="form-control">
            <option value="일반" ${cs.icategory == '일반' ? 'selected' : ''}>일반</option>
            <option value="결제" ${cs.icategory == '결제' ? 'selected' : ''}>결제</option>
            <option value="서비스" ${cs.icategory == '서비스' ? 'selected' : ''}>서비스</option>
            <option value="기타" ${cs.icategory == '기타' ? 'selected' : ''}>기타</option>
        </select>
    </div>
    <div class="form-group">
        <label for="inquiryTitle">문의 제목</label>
        <input type="text" id="inquiryTitle" name="ititle" class="form-control" value="${cs.ititle != null ? cs.ititle : ''}" />
    </div>
    <div class="form-group">
        <label for="inquiryContent">문의 내용</label>
        <textarea id="inquiryContent" name="icontent" rows="5" class="form-control">${cs.icontent != null ? cs.icontent : ''}</textarea>
    </div>
    <div class="form-group">
        <label for="inquiryResponse">문의 답변</label>
        <textarea id="inquiryResponse" name="iresponse" rows="5" class="form-control">${cs.iresponse != null ? cs.iresponse : ''}</textarea>
    </div>
</div>

    <button type="submit" id="btnSave" class="btnSave">저장</button>
    <button type="button" class="btnCancel" onclick="history.back();">취소</button>
</form>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    
    $("#frmEdit").on("submit", function(event) {
        // 섹션별로 보여지는 필드의 required 속성을 설정
        if ($("#faqSection").is(":visible")) {
            $("#faqtitle").prop("required", true);
        } else {
            $("#faqtitle").prop("required", false);
        }

        if ($("#feedbackSection").is(":visible")) {
            $("#feedbackTitle").prop("required", true);
        } else {
            $("#feedbackTitle").prop("required", false);
        }

        if ($("#inquirySection").is(":visible")) {
            $("#inquiryTitle").prop("required", true);
        } else {
            $("#inquiryTitle").prop("required", false);
        }

        // 유효성 검사 함수가 제대로 동작하는지 확인
        if (!checkFormValues()) {
            event.preventDefault(); // 제출 방지
        }
    });

</script>
</html>


