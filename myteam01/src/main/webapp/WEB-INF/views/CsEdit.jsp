<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.xml" prefix="x" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 수정 페이지</title>
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
    <%@ include file="/WEB-INF/views/admin_main/header.jsp" %>
    <h1 style="text-align: center;">FAQ 수정 페이지</h1>

    <form id="frmEdit" name="frmEdit" method="post" action="${contextPath}/cs/editProc">
        <input type="hidden" name="faqno" value="${faq.faqno}"/>
        <div class="form-group">
            <label>카테고리</label>
            <select name="faqcategory" id="faqcategory" class="form-control">
                <option value="일반" ${faq.faqcategory == '일반' ? 'selected' : ''}>일반</option>
                <option value="결제" ${faq.faqcategory == '결제' ? 'selected' : ''}>결제</option>
                <option value="서비스" ${faq.faqcategory == '서비스' ? 'selected' : ''}>서비스</option>
                <option value="기타" ${faq.faqcategory == '기타' ? 'selected' : ''}>기타</option>
            </select>
        </div>
        <div class="form-group">
            <label>질문 제목</label>
            <input type="text" id="faqtitle" name="faqtitle" class="form-control" value="${faq.faqtitle}" />
        </div>
        <div class="form-group">
            <label>답변 내용</label>
            <textarea id="faqcontent" name="faqcontent" rows="5" class="form-control">${faq.faqcontent}</textarea>
        </div>

        <button type="submit" id="btnSave" class="btnSave">저장</button>
        <button type="button" class="btnCancel" onclick="history.back();">취소</button>
    </form>

    <%@ include file="/WEB-INF/views/admin_main/footer.jsp" %>
</body>
</html>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function convertNewlinesToBr(text) {
    return text.replace(/\n/g, '<br>');
}

function checkFormValues() {
    var title = $("#faqtitle").val();
    var content = $("#faqcontent").val();
    var regExp = /^\s+$/;
    
    // Form validation logic
    var isValid = title && content && !regExp.test(title) && !regExp.test(content);
    
    // Convert newlines to <br> for FAQ content
    $("#faqcontent").val(convertNewlinesToBr(content));
    
    return isValid;
}

$("#frmEdit").on("submit", function(event) {
    if (!checkFormValues()) {
        alert("모든 내용은 필수 작성입니다!");
        event.preventDefault(); // Prevent form submission if validation fails
        return;
    }
});
</script>
