<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
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

.section-header {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 10px;
}

.section-header h3 {
    margin-right: 20px;
}

.register-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    color: #fff;
    background-color: #28a745;
    cursor: pointer;
}

.register-btn:hover {
    opacity: 0.9;
}

.table-container {
    margin-top: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background-color: #f2f2f2;
}
</style>
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

window.onload = function() {
    showSection('faq'); // 기본적으로 FAQ 섹션을 보여줌
};
</script>
</head>
<body>
    <h1>고객센터</h1>
    <div>
        <button class="btnFAQ" onclick="showSection('faq')">자주 묻는 질문(FAQ)</button>
        <button class="btnFeedback" onclick="showSection('feedback')">고객의 소리(건의사항)</button>
        <button class="btnInquiry" onclick="showSection('inquiry')">1:1 문의</button>
    </div>

    <div id="faq" class="section">
        <div class="section-header">
            <h3>자주 묻는 질문 (FAQ)</h3>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=faq'">FAQ 등록</button>
        </div>
        <div class="table-container">
            <table>
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                </tr>
                <c:forEach items="${CsList}" var="cs">
                    <c:if test="${cs.faqdelflag == 1}">
                        <tr>
                            <td><c:out value="${cs.faqno}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${cs.faqdelflag == 0}">
                        <tr>
                            <td><c:out value="${cs.faqno}" /></td>
                            <td><c:out value="${cs.faqcategory}" /></td>
                            <td><c:out value="${cs.faqtitle}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    </div>

    <div id="feedback" class="section">
        <div class="section-header">
            <h3>고객의 소리</h3>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=feedback'">고객의 소리 등록</button>
        </div>
        <p>고객의 소리 내용을 여기에 작성합니다.</p>
    </div>

    <div id="inquiry" class="section">
        <div class="section-header">
            <h3>1:1 문의내역</h3>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=inquiry'">1:1 문의 등록</button>
        </div>
        <p>문의사항 내용을 여기에 작성합니다.</p>
    </div>
</body>
</html>
