<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 등록</title>
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

.btnFAQ {
    background-color: #28a745;
}

.btnFeedback {
    background-color: #007bff;
}

.btnInquiry {
    background-color: #dc3545;
}

button:hover {
    opacity: 0.9;
}

.section {
    display: none;
}

.section.active {
    display: block;
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
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function showSection(sectionId) {
    var sections = document.querySelectorAll('.section');
    sections.forEach(function(section) {
        section.classList.remove('active');
    });
    
    var selectedSection = document.getElementById(sectionId);
    if (selectedSection) {
        selectedSection.classList.add('active');
    }
}

function checkFormValues() {
    var category = document.getElementById("category").value;
    var title = document.getElementById("title").value;
    var content = document.getElementById("content").value;

    var regExp = /^\s+$/;

    if (!category || !title || !content ||
        regExp.test(category) || regExp.test(title) || 
        regExp.test(content)) {
        return false;
    } else {
        return true;
    }
}

$("#btnRegister").on("click", function() {
    if (!checkFormValues()) {
        alert("모든 필드를 유효한 값으로 입력해야 합니다.");
        return;
    }

    var frmRegister = $("#frmRegister");
    frmRegister.submit();
});

$(document).ready(function() {
    showSection('faqSection'); // 기본적으로 FAQ 섹션을 보여줌
});
</script>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin_main/header.jsp" %>
    <h1 style="text-align: center;">고객센터 등록</h1>
    <div>
        <button class="btnFAQ" onclick="showSection('faqSection')">자주 묻는 질문(FAQ)</button>
        <button class="btnFeedback" onclick="showSection('feedbackSection')">고객의 소리</button>
        <button class="btnInquiry" onclick="showSection('inquirySection')">문의사항</button>
    </div>

    <div id="faqSection" class="section">
        <h3 style="text-align: center;">FAQ 등록</h3>
        <form role="form" action="${contextPath}/cs/faq" method="post" id="frmRegister" enctype="multipart/form-data">
            <div class="form-group">
                <label>FAQ 카테고리</label>
                <input class="form-control" name="category" id="category">
            </div>

            <div class="form-group">
                <label>FAQ 제목(질문)</label>
                <textarea class="form-control" rows="3" name="title" id="title"></textarea>
            </div>

            <div class="form-group">
                <label>FAQ 내용(답변)</label>
                <textarea class="form-control" rows="10" name="content" id="content"></textarea>
            </div>

            <button type="button" class="btnRegister" id="btnRegister">등록</button>
            <button type="button" class="btnCancel" id="btnCancel" data-oper="list"
                    onclick="location.href='${contextPath}/cs/Center'">취소</button>
        </form>
    </div>

    <div id="feedbackSection" class="section">
        <h3 style="text-align: center;">고객의 소리 등록</h3>
        <form role="form" action="${contextPath}/cs/feedback" method="post" id="frmFeedbackRegister" enctype="multipart/form-data">
            <div class="form-group">
                <label>피드백 제목</label>
                <input class="form-control" name="title" id="feedbackTitle">
            </div>

            <div class="form-group">
                <label>피드백 내용</label>
                <textarea class="form-control" rows="10" name="content" id="feedbackContent"></textarea>
            </div>

            <button type="button" class="btnRegister" id="btnFeedbackRegister">등록</button>
            <button type="button" class="btnCancel" id="btnFeedbackCancel" data-oper="list"
                    onclick="location.href='${contextPath}/cs/Center'">취소</button>
        </form>
    </div>

    <div id="inquirySection" class="section">
        <h3 style="text-align: center;">문의사항 등록</h3>
        <form role="form" action="${contextPath}/cs/inquiry" method="post" id="frmInquiryRegister" enctype="multipart/form-data">
            <div class="form-group">
                <label>문의사항 제목</label>
                <input class="form-control" name="title" id="inquiryTitle">
            </div>

            <div class="form-group">
                <label>문의사항 내용</label>
                <textarea class="form-control" rows="10" name="content" id="inquiryContent"></textarea>
            </div>

            <button type="button" class="btnRegister" id="btnInquiryRegister">등록</button>
            <button type="button" class="btnCancel" id="btnInquiryCancel" data-oper="list"
                    onclick="location.href='${contextPath}/cs/Center'">취소</button>
        </form>
    </div>

    <%@ include file="/WEB-INF/views/admin_main/footer.jsp" %>
</body>
</html>
