<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
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
        .btnFAQ { background-color: #28a745; }
        .btnFeedback { background-color: #007bff; }
        .btnInquiry { background-color: #dc3545; }
        button:hover { opacity: 0.9; }
        .section { display: none; }
        .section.active { display: block; }
        .section-header {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
        }
        .section-header h3 { margin-right: 20px; }
        .register-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            color: #fff;
            background-color: #28a745;
            cursor: pointer;
        }
        .register-btn:hover { opacity: 0.9; }
        .table-container { margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; table-layout: fixed; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #f2f2f2; }
        th:nth-child(1), td:nth-child(1) { width: 5%; }
        th:nth-child(2), td:nth-child(2) { width: 10%; }
        th:nth-child(3), td:nth-child(3) { width: 56.67%; }
        .faq-detail, .inquiry-detail, .feedback-detail {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .faq-detail h3, .inquiry-detail h3, .feedback-detail h3 { margin-top: 0; }
        .faq-detail button, .inquiry-detail button, .feedback-detail button {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }
        .faq-detail .edit-btn, .inquiry-detail .edit-btn, .feedback-detail .edit-btn { background-color: #28a745; }
        .faq-detail .delete-btn, .inquiry-detail .delete-btn, .feedback-detail .delete-btn { background-color: #dc3545; }
        .faq-detail .back-btn, .inquiry-detail .back-btn, .feedback-detail .back-btn { background-color: #007bff; }
    </style>

</head>
<body>
    <h1>고객센터</h1>
    <div>
        <button class="btnFAQ" onclick="showSection('faq')">자주 묻는 질문(FAQ)</button>
        <button class="btnFeedback" onclick="showSection('feedback')">고객의 소리(건의사항)</button>
        <button class="btnInquiry" onclick="showSection('inquiry')">1:1 문의</button>
        <a href="http://195.168.9.110:8080/chat/adminChat">관리자와 실시간 채팅</a>
    </div>

    <!-- FAQ 섹션 -->
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
                        <tr>
                            <td style="cursor: pointer;" onclick="showDetail('faq', '${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                                <c:out value="${cs.faqno}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('faq', '${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                                <c:out value="${cs.faqcategory}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('faq', '${cs.faqno}', '${cs.faqtitle}', '${cs.faqcategory}', '${cs.faqcontent}')">
                                <c:out value="${cs.faqtitle}" />
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- FAQ 상세 정보를 표시할 공간 -->
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
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
        </div>
    </div>

    <!-- 고객의 소리 섹션 -->
    <div id="feedback" class="section active">
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
                <c:forEach items="${feedbackList}" var="feeb" >
                    <c:if test="${feeb.fbdelflag == 1}">
                        <tr>
                            <td><c:out value="${feeb.fbno}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${feeb.fbdelflag == 0}">
                        <tr>
                            <td style="cursor: pointer;" onclick="showDetail('feedback', '${feeb.fbno}', '${feeb.fbtitle}', '${feeb.fbRegDate}', '${feeb.fbcontent}')">
                                <c:out value="${feeb.fbno}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('feedback', '${feeb.fbno}', '${feeb.fbtitle}', '${feeb.fbRegDate}', '${feeb.fbcontent}')">
                                <c:out value="${feeb.fbtitle}" />
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    
    
        <!-- 고객의소리 상세정보 표시할 공간 -->
        <div id="feedback-detail" class="feedback-detail" style="display: none; margin-top: 20px;">
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">제목</th>
                    <td id="feedback-title" style="width: 35%; padding: 10px; border-bottom: 1px solid #ddd;"></td>
               
		            <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">등록일</th>
		            <td id="feedback-regdate" style="width: 35%; padding: 10px; border-bottom: 1px solid #ddd;"></td>
        		</tr>
                <tr>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">내용</th>
                    <td colspan="3" id="feedback-content" style="padding: 10px; border-bottom: 1px solid #ddd; white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
        </div>
  </div>

    <!-- 1:1 문의 내역 섹션 -->
    <div id="inquiry" class="section active">
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
                <c:forEach items="${inquiryList}" var="inq" >
                    <c:if test="${inq.idelflag == 1}">
                        <tr>
                            <td><c:out value="${inq.ino}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${inq.idelflag == 0}">
                        <tr>
                            <td style="cursor: pointer;" onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}')">
                                <c:out value="${inq.ino}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}')">
                                <c:out value="${inq.icategory}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}')">
                                <c:out value="${inq.ititle}" />
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- 1:1 문의 상세 정보를 표시할 공간 -->
        <div id="inquiry-detail" class="inquiry-detail" style="display: none; margin-top: 20px;">
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">제목</th>
                    <td id="inquiry-title" style="width: 35%; padding: 10px; border-bottom: 1px solid #ddd;"></td>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">카테고리</th>
                    <td id="inquiry-category" style="width: 35%; padding: 10px; border-bottom: 1px solid #ddd;"></td>
                </tr>
                <tr>
                    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">내용</th>
                    <td colspan="3" id="inquiry-content" style="padding: 10px; border-bottom: 1px solid #ddd; white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail()">수정</button>
            <button class="delete-btn" onclick="confirmDelete()">삭제</button>
        </div>
    </div>

    <script>
        function showSection(sectionId) {
            var sections = document.querySelectorAll('.section');
            sections.forEach(function(section) {
                section.classList.remove('active');
                section.style.display = 'none';
            });

            var selectedSection = document.getElementById(sectionId);
            if (selectedSection) {
                selectedSection.classList.add('active');
                selectedSection.style.display = 'block';
            }
        }

        window.onload = function() {
            showSection('faq'); // 기본적으로 FAQ 섹션을 보여줌
        };

        function showDetail(type, no, title, category, content, regdate) {
            // 글 목록을 숨기고 상세 페이지를 보여줌
            //document.querySelector('.table-container').style.display = 'none';
            var detailSection;

            if (type === 'faq') {
                detailSection = document.getElementById('faq-detail');
                detailSection.style.display = 'block';

                // 상세 정보 설정
                document.getElementById('faq-title').innerText = title;
                document.getElementById('faq-category').innerText = category;
                var formattedContent = content.replace(/\n/g, '<br>');
                document.getElementById('faq-content').innerHTML = formattedContent;

                // 수정 및 삭제 버튼에 게시글 번호 설정
                document.querySelector('.edit-btn').setAttribute('data-faqno', no);
                document.querySelector('.delete-btn').setAttribute('data-faqno', no);
                
            } else if (type === 'inquiry') {
                detailSection = document.getElementById('inquiry-detail');
                detailSection.style.display = 'block';

                // 상세 정보 설정
                document.getElementById('inquiry-title').innerText = title;
                document.getElementById('inquiry-category').innerText = category;
                var formattedContent = content.replace(/\n/g, '<br>');
                document.getElementById('inquiry-content').innerHTML = formattedContent;

                // 수정 및 삭제 버튼에 게시글 번호 설정
                document.querySelector('.edit-btn').setAttribute('data-ino', no);
                document.querySelector('.delete-btn').setAttribute('data-ino', no);
            }
            else{
                detailSection = document.getElementById('feedback-detail');
                detailSection.style.display = 'block';

                // 상세 정보 설정
                document.getElementById('feedback-title').innerText = title;
                document.getElementById('feedback-regdate').innerText = regdate; 
               
                var formattedContent = content.replace(/\n/g, '<br>');
                document.getElementById('feedback-content').innerHTML = formattedContent;

                // 수정 및 삭제 버튼에 게시글 번호 설정
                document.querySelector('.edit-btn').setAttribute('data-fbno', no);
                document.querySelector('.delete-btn').setAttribute('data-fbno', no);
            }
        }

        function hideDetail() {
            // 상세 페이지를 숨기고 글 목록을 다시 보여줌
            document.querySelector('.table-container').style.display = 'block';
            document.getElementById('faq-detail').style.display = 'none';
            document.getElementById('inquiry-detail').style.display = 'none';
            document.getElementById('feedback-detail').style.display = 'none';
        }

        function editDetail() {
            // 수정 버튼 클릭 시 수정 페이지로 이동
            var faqno = document.querySelector('.edit-btn').getAttribute('data-faqno');
            var ino = document.querySelector('.edit-btn').getAttribute('data-ino');
            var fbno = document.querySelector('.edit-btn').getAttribute('data-fbno');
            if (faqno) {
                window.location.href = '${contextPath}/cs/edit?faqno=' + faqno;
            }else if (ino) {
            	window.location.href = '${contextPath}/cs/edit?ino=' + ino;
            }else if (fbno) {
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
