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
    table-layout: fixed; /* 열 너비를 고정 */
}

th, td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background-color: #f2f2f2;
}

/* 열 너비 설정 */
th:nth-child(1), td:nth-child(1) {
    width: 5%;
}

th:nth-child(2), td:nth-child(2) {
    width: 10%;
}

th:nth-child(3), td:nth-child(3) {
    width: 56.67%;
}

.faq-detail {
    background-color: #fff;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.faq-detail h3 {
    margin-top: 0;
}

.faq-detail button {
    margin-top: 20px;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    color: #fff;
    cursor: pointer;
}

.faq-detail .edit-btn {
    background-color: #28a745;
    margin-top: 10px;
}

.faq-detail .edit-btn:hover {
    opacity: 0.9;
}

.faq-detail .delete-btn {
    background-color: #dc3545;
    margin-top: 10px;
}

.faq-detail .delete-btn:hover {
    opacity: 0.9;
}

/* 목록으로 돌아가기 버튼 스타일 */
.faq-detail .back-btn {
    background-color: #007bff; /* 고객의 소리 버튼과 동일한 색상 */
    margin-top: 10px;
}

.faq-detail .back-btn:hover {
    opacity: 0.9;
}
</style>
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
                            <td style="cursor: pointer;" onclick="showDetail('${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                                <c:out value="${cs.faqno}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                                <c:out value="${cs.faqcategory}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                                <c:out value="${cs.faqtitle}" />
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
        
        <!-- 상세 정보를 표시할 공간 -->
        <div id="faq-detail" class="faq-detail" style="display: none; margin-top: 20px;">
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">제목</th>
                    <td id="faq-title" style="width: 35%; padding: 10px; border-bottom: 1px solid #ddd;"></td>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">카테고리</th>
                    <td id="faq-category" style="width: 35%; padding: 10px; border-bottom: 1px solid #ddd;"></td>
                </tr>
                <tr>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">내용</th>
                    <td colspan="3" id="faq-content" style="padding: 10px; border-bottom: 1px solid #ddd; white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">목록으로</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
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

function showDetail(faqno, faqtitle, faqcategory, faqcontent) {
    // 글 목록을 숨기고 상세 페이지를 보여줌
    document.querySelector('.table-container').style.display = 'none';
    var detailSection = document.getElementById('faq-detail');
    detailSection.style.display = 'block';
    
    // 상세 정보 설정
    document.getElementById('faq-title').innerText = faqtitle;
    document.getElementById('faq-category').innerText = faqcategory;
    
    var formattedContent = faqcontent.replace(/\n/g, '<br>');
    document.getElementById('faq-content').innerHTML = formattedContent;
    
    // 수정 및 삭제 버튼에 게시글 번호 설정
    var editButton = document.querySelector('.edit-btn');
    var deleteButton = document.querySelector('.delete-btn');
    if (editButton && deleteButton) {
        editButton.setAttribute('data-faqno', faqno);
        deleteButton.setAttribute('data-faqno', faqno);
    }
}

function hideDetail() {
    // 상세 페이지를 숨기고 글 목록을 다시 보여줌
    document.querySelector('.table-container').style.display = 'block';
    document.getElementById('faq-detail').style.display = 'none';
}

function editDetail() {
    // 수정 버튼 클릭 시 수정 페이지로 이동
    var faqno = document.querySelector('.edit-btn').getAttribute('data-faqno');
    if (faqno) {
        window.location.href = '${contextPath}/cs/edit?faqno=' + faqno;
    }
}

</script>
</html>
