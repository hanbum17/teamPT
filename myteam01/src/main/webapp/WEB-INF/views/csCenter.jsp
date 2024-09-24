<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ include file="./menu/nav.jsp"%>
    <%@ include file="./menu/footer.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>고객센터</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;

        }

        main {
            max-width: 1200px;
            margin: 100px auto 0 ;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-bottom: 100px;
        }

        h1 {
            text-align: center;
            font-size: 26px;
            color: #333;
            margin-bottom: 20px;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        button {
            padding: 12px 25px;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btnFAQ { background-color: #28a745; }
        .btnFeedback { background-color: #007bff; }
        .btnInquiry { background-color: #dc3545; }

        button:hover { opacity: 0.9; }

        .section {
            display: none;
        }

        .section.active {
            display: block;
            margin-top: 20px;
            
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .section-header h3 {
            font-size: 20px;
            color: #333;
        }

        .register-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            color: #fff;
            background-color: #28a745;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .register-btn:hover { background-color: #218838; }

        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 14px;
        }

        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        td {
            cursor: pointer;
        }

        /* FAQ, Inquiry, Feedback Detail View */
        .detail-view {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 20px;
            
        }

        .detail-view h3 {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .detail-view button {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .back-btn { background-color: #007bff; }
        .edit-btn { background-color: #28a745; }
        .delete-btn { background-color: #dc3545; }

        .back-btn:hover { background-color: #0069d9; }
        .edit-btn:hover { background-color: #218838; }
        .delete-btn:hover { background-color: #c82333; }

        /* Media Queries for Responsive Design */
        @media (max-width: 768px) {
            .btn-container {
                flex-direction: column;
                gap: 10px;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px;
            }
        }

    </style>

</head>
<body>

<main>
    <h1>고객센터</h1>

    <!-- Section Buttons -->
    <div class="btn-container">
        <button class="btnFAQ" onclick="showSection('faq')">자주 묻는 질문(FAQ)</button>
        <button class="btnFeedback" onclick="showSection('feedback')">고객의 소리(건의사항)</button>
        <button class="btnInquiry" onclick="showSection('inquiry')">1:1 문의</button>
    </div>

    <!-- FAQ Section -->
    <div id="faq" class="section active">
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
                        <tr onclick="showDetail('faq', '${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                            <td><c:out value="${cs.faqno}" /></td>
                            <td><c:out value="${cs.faqcategory}" /></td>
                            <td><c:out value="${cs.faqtitle}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- FAQ Detail Section -->
        <div id="faq-detail" class="detail-view" style="display: none;">
            <h3>FAQ 상세보기</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%;">제목</th>
                    <td id="faq-title"></td>
                    <th style="width: 15%;">카테고리</th>
                    <td id="faq-category"></td>
                </tr>
                <tr>
                    <th style="width: 15%;">내용</th>
                    <td colspan="3" id="faq-content" style="white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
        </div>
    </div>

    <!-- Feedback Section -->
    <div id="feedback" class="section">
        <div class="section-header">
            <h3>고객의 소리</h3>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=feedback'">고객의 소리 등록</button>
        </div>
        <div class="table-container">
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                </tr>
                <c:forEach items="${feedbackList}" var="feeb">
                    <c:if test="${feeb.fbdelflag == 1}">
                        <tr>
                            <td><c:out value="${feeb.fbno}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${feeb.fbdelflag == 0}">
                        <tr onclick="showDetail('feedback', '${feeb.fbno}', '${feeb.fbtitle}', '${feeb.fbRegDate}', '${feeb.fbcontent}')">
                            <td><c:out value="${feeb.fbno}" /></td>
                            <td><c:out value="${feeb.fbtitle}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- Feedback Detail Section -->
        <div id="feedback-detail" class="detail-view" style="display: none;">
            <h3>고객의 소리 상세보기</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%;">제목</th>
                    <td id="feedback-title"></td>
                    <th style="width: 15%;">등록일</th>
                    <td id="feedback-regdate"></td>
                </tr>
                <tr>
                    <th style="width: 15%;">내용</th>
                    <td colspan="3" id="feedback-content" style="white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
        </div>
    </div>

    <!-- Inquiry Section -->
    <div id="inquiry" class="section">
        <div class="section-header">
            <h3>1:1 문의 내역</h3>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=inquiry'">1:1 문의 등록</button>
        </div>
        <div class="table-container">
            <table>
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                </tr>
                <c:forEach items="${inquiryList}" var="inq">
                    <c:if test="${inq.idelflag == 1}">
                        <tr>
                            <td><c:out value="${inq.ino}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${inq.idelflag == 0}">
                        <tr onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}')">
                            <td><c:out value="${inq.ino}" /></td>
                            <td><c:out value="${inq.icategory}" /></td>
                            <td><c:out value="${inq.ititle}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- Inquiry Detail Section -->
        <div id="inquiry-detail" class="detail-view" style="display: none;">
            <h3>1:1 문의 상세보기</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%;">제목</th>
                    <td id="inquiry-title"></td>
                    <th style="width: 15%;">카테고리</th>
                    <td id="inquiry-category"></td>
                </tr>
                <tr>
                    <th style="width: 15%;">내용</th>
                    <td colspan="3" id="inquiry-content" style="white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
        </div>
    </div>
</main>

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

    function showDetail(type, no, title, category, content, regdate) {
        var detailSection;
        if (type === 'faq') {
            detailSection = document.getElementById('faq-detail');
            document.getElementById('faq-title').innerText = title;
            document.getElementById('faq-category').innerText = category;
            document.getElementById('faq-content').innerHTML = content.replace(/\n/g, '<br>');
        } else if (type === 'inquiry') {
            detailSection = document.getElementById('inquiry-detail');
            document.getElementById('inquiry-title').innerText = title;
            document.getElementById('inquiry-category').innerText = category;
            document.getElementById('inquiry-content').innerHTML = content.replace(/\n/g, '<br>');
        } else {
            detailSection = document.getElementById('feedback-detail');
            document.getElementById('feedback-title').innerText = title;
            document.getElementById('feedback-regdate').innerText = regdate;
            document.getElementById('feedback-content').innerHTML = content.replace(/\n/g, '<br>');
        }
        detailSection.style.display = 'block';
    }

    function hideDetail() {
        document.getElementById('faq-detail').style.display = 'none';
        document.getElementById('feedback-detail').style.display = 'none';
        document.getElementById('inquiry-detail').style.display = 'none';
    }

    function editDetail() {
        var faqno = document.querySelector('.edit-btn').getAttribute('data-faqno');
        var ino = document.querySelector('.edit-btn').getAttribute('data-ino');
        var fbno = document.querySelector('.edit-btn').getAttribute('data-fbno');
        if (faqno) {
            window.location.href = '${contextPath}/cs/edit?faqno=' + faqno;
        } else if (ino) {
            window.location.href = '${contextPath}/cs/edit?ino=' + ino;
        } else if (fbno) {
            window.location.href = '${contextPath}/cs/edit?fbno=' + fbno;
        }
    }

    function confirmDelete() {
        var faqno = document.querySelector('.delete-btn').getAttribute('data-faqno');
        var ino = document.querySelector('.delete-btn').getAttribute('data-inqno');
        var fbno = document.querySelector('.delete-btn').getAttribute('data-fbno');

        var deleteUrl;
        if (faqno) {
            deleteUrl = '${contextPath}/cs/deleteFAQ?faqno=' + faqno;
        } else if (ino) {
            deleteUrl = '${contextPath}/cs/deleteInquiry?ino=' + ino;
        } else if (fbno) {
            deleteUrl = '${contextPath}/cs/deleteFeedback?fbno=' + fbno;
        }

        if (confirm("정말로 삭제하시겠습니까?")) {
            window.location.href = deleteUrl;
        }
    }
</script>

</body>
</html>
