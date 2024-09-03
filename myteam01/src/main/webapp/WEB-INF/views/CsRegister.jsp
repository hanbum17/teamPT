<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 등록 페이지</title>
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

.btnRegister {
    background-color: #28a745;
}

.btnCancel {
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

.btnRegister:hover, .btnCancel:hover {
    opacity: 0.9;
}

.btnCancel {
    margin-left: 10px;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin_main/header.jsp" %>
    <h1 style="text-align: center;">고객센터 통합 등록</h1>

    <form id="frmRegister" name="frmRegister" method="post" action="${contextPath}/cs/registerProc">
        <div id="faqSection" class="section">
            <div class="form-group">
                <label>카테고리</label>
                <select name="faqcategory" id="faqcategory" class="form-control">
                    <option value="일반">일반</option>
                    <option value="결제">결제</option>
                    <option value="서비스">서비스</option>
                    <option value="기타">기타</option>
                </select>
            </div>
            <div class="form-group">
                <label>질문 제목</label>
                <input type="text" id="faqtitle" name="faqtitle" class="form-control" />
            </div>
            <div class="form-group">
                <label>답변 내용</label>
                <textarea id="faqcontent" name="faqcontent" rows="5" class="form-control"></textarea>
            </div>
        </div>

        <div id="feedbackSection" class="section">
            <div class="form-group">
                <label for="feedbackTitle">건의 제목</label>
                <input type="text" id="feedbackTitle" name="feedbackTitle" class="form-control" />
            </div>
            <div class="form-group">
                <label for="feedbackContent">건의 내용</label>
                <textarea id="feedbackContent" name="feedbackContent" rows="5" class="form-control"></textarea>
            </div>
        </div>

        <div id="inquirySection" class="section">
            <div class="form-group">
                <label for="inquiryTitle">문의 제목</label>
                <input type="text" id="inquiryTitle" name="inquiryTitle" class="form-control" />
            </div>
            <div class="form-group">
                <label for="inquiryContent">문의 내용</label>
                <textarea id="inquiryContent" name="inquiryContent" rows="5" class="form-control"></textarea>
            </div>
        </div>

        <button type="submit" id="btnRegister" class="btnRegister">등록</button>
        <button type="button" class="btnCancel" onclick="history.back();">취소</button>
    </form>

    <%@ include file="/WEB-INF/views/admin_main/footer.jsp" %>
</body>

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
    var type = "${param.type}";
    var isValid = false;
    if (type === "faq") {
        var category = document.getElementById("faqcategory").value;
        var title = document.getElementById("faqtitle").value;
        var content = document.getElementById("faqcontent").value;
        //var regExp = /^\s+$/;
        isValid = true;
        //isValid = category && title && content && !regExp.test(category) && !regExp.test(title) && !regExp.test(content);
    } else if (type === "feedback") {
        var feedbackTitle = document.getElementById("feedbackTitle").value;
        var feedbackContent = document.getElementById("feedbackContent").value;

        var regExp = /^\s+$/;
        isValid = feedbackTitle && feedbackContent && !regExp.test(feedbackTitle) && !regExp.test(feedbackContent);
    } else if (type === "inquiry") {
        var inquiryTitle = document.getElementById("inquiryTitle").value;
        var inquiryContent = document.getElementById("inquiryContent").value;

        var regExp = /^\s+$/;
        isValid = inquiryTitle && inquiryContent && !regExp.test(inquiryTitle) && !regExp.test(inquiryContent);
    }

    return isValid;
}

$("#btnRegister").on("click", function(event) {
    if (!checkFormValues()) {
        alert("모든 내용은 필수 작성입니다!");
        event.preventDefault(); // 기본 폼 제출 방지\
       
        return;
    }
   
    var frmRegister = $("#frmRegister");
    frmRegister.submit();
    
});

$(document).ready(function() {
    var type = "${param.type}";
    if (type === "faq") {
        showSection('faqSection');
    } else if (type === "feedback") {
        showSection('feedbackSection');
    } else if (type === "inquiry") {
        showSection('inquirySection');
    }
});
</script>
</html>
