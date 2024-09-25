<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./menu/nav.jsp"%>
<%@ include file="./menu/footer.jsp"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 등록 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/csCenter/regist&edit.css">
</head>
<body>

    <h1 style="text-align: center;">고객센터 통합 등록</h1>

    <form id="frmRegister" name="frmRegister" method="post" action="${contextPath}/cs/registerProc">
        <input type="hidden" name="type" value="${param.type}" />
        
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

		<div id="noticeSection" class="section">
			<div class="form-group">
			 	<label for="noticeTitle">공지사항 제목</label>
                <input type="text" id="noticeTitle" name="nctitle" class="form-control" />
			</div>
			<div class="form-group">
                <label for="noticeContent">공지사항 내용</label>
                <textarea id="noticeContent" name="nccontent" rows="5" class="form-control"></textarea>
            </div>
		</div>

        <div id="feedbackSection" class="section">

            <div class="form-group">
                <label for="feedbackTitle">건의 제목</label>
                <input type="text" id="feedbackTitle" name="fbtitle" class="form-control" />
            </div>
            <div class="form-group">
                <label for="feedbackContent">건의 내용</label>
                <textarea id="feedbackContent" name="fbcontent" rows="5" class="form-control"></textarea>
            </div>
        </div>

        <div id="inquirySection" class="section">
        	<div class="form-group">
                <label>카테고리</label>
                <select name="icategory" id="inquirycategory" class="form-control">
                    <option value="일반">일반</option>
                    <option value="결제">결제</option>
                    <option value="서비스">서비스</option>
                    <option value="기타">기타</option>
                </select>
	        </div>
            <div class="form-group">
                <label for="inquiryTitle">문의 제목</label>
                <input type="text" id="inquiryTitle" name="ititle" class="form-control" />
            </div>
            <div class="form-group">
                <label for="inquiryContent">문의 내용</label>
                <textarea id="inquiryContent" name="icontent" rows="5" class="form-control"></textarea>
            </div>
        </div>

        <button type="submit" id="btnRegister" class="btnRegister">등록</button>
        <button type="button" class="btnCancel" onclick="history.back();">취소</button>
    </form>

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
function convertNewlinesToBr(text) {
    return text.replace(/\n/g, '<br>');
}

function checkFormValues() {
    var type = "${param.type}";
    var isValid = false;
    if (type === "faq") {
        var faqcategory = document.getElementById("faqcategory").value;
        var faqtitle = document.getElementById("faqtitle").value;
        var faqcontent = convertNewlinesToBr(document.getElementById("faqcontent").value);
        isValid = category && title && content;
        document.getElementById("faqcontent").value = content;
        
    } else if (type === "feedback") {
    	
        var fbtitle = document.getElementById("fbtitle").value;
        var fbcontent = convertNewlinesToBr(document.getElementById("fbcontent").value);
        var regExp = /^\s+$/;
        isValid = feedbackTitle && feedbackContent && !regExp.test(feedbackTitle) && !regExp.test(feedbackContent);
        document.getElementById("fbcontent").value = feedbackContent;
        
    } else if (type === "inquiry") {
    	var icategory = document.getElementById("icategory").value;
        var ititle = document.getElementById("ititle").value;
        var icontent = convertNewlinesToBr(document.getElementById("icontent").value);
        var regExp = /^\s+$/;
        isValid = inquiryTitle && inquiryContent && !regExp.test(inquiryTitle) && !regExp.test(inquiryContent);
        document.getElementById("inquiryContent").value = inquiryContent;
    } else if (type === "notice"){
    	var nctitle = document.getElementById("nctitle").value;
    	var nccontent = convertNewlinesToBr(document.getElementById("nccontent").value);
    	var regExp = /^\s+$/;
    	isValid = noticeTitle && noticeContent && !regExp.test(noticeTitle) && !regExp.test(noticeContent);
        document.getElementById("noticeContent").value = noticeContent;
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
    $('input[name="type"]').val(type); // hidden input에 type 설정
    
    if (type === "faq") {
        showSection('faqSection');
    } else if (type === "feedback") {
        showSection('feedbackSection');
    } else if (type === "inquiry") {
        showSection('inquirySection');
    } else if (type === "notice") {
    	showSection('noticeSection');
    }
});
</script>
</html>
