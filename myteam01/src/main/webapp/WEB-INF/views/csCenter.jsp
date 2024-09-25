<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ include file="./menu/nav.jsp"%>
    <%@ include file="./menu/footer.jsp"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객센터</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/csCenter/center.css">
</head>
<body>

<main>
    <h1>고객센터</h1>

    <!-- Section Buttons -->
    <div class="btn-container">
    	<button class="btnNotice" onclick="showSection('notice')">공지사항</button>
        <button class="btnCsEvent" onclick="showSection('csevent')">이벤트</button>
        <button class="btnFAQ" onclick="showSection('faq')">자주 묻는 질문(FAQ)</button>
        <button class="btnFeedback" onclick="showSection('feedback')">고객의 소리(건의사항)</button>
        <button class="btnInquiry" onclick="showSection('inquiry')">1:1 문의</button>
    </div>

	<!-- Notice Section -->
    <div id="Notice" class="section active">
        <div class="section-header">
            <h3>공지사항</h3>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=notice'">공지사항 등록</button>
        </div>
        <div class="table-container">
            <table>
                <tr>
                    <th>제목</th>
                    <th>등록일</th>
                </tr>
                <c:forEach items="${notice}" var="nc">
                    <c:if test="${nc.notice_delflag == 1}">
                        <tr>
                            <td><c:out value="${nc.notice_num}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${nc.notice_delflag == 0}">
                        <tr onclick="showDetail('notice', '${nc.notice_num}', '${nc.notice_title}', '${nc.notice_content}', '${nc.notice_moddate}')">
                            <td><c:out value="${nc.notice_title}" /></td>
                            <td><c:out value="${nc.notice_moddate}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
	</div>
	
    <!-- FAQ Section -->
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
                <c:forEach items="${FAQList}" var="cs">
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
            <button class="edit-btn" onclick="editDetail('faq')">수정</button>
            <button class="delete-btn" onclick="confirmDelete('faq', ${cs.faqno})">삭제</button>
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
                    <th>등록일</th>
                </tr>
                <c:forEach items="${feedbackList}" var="feeb">
                    <c:if test="${feeb.fbdelflag == 1}">
                        <tr>
                            <td><c:out value="${feeb.fbno}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${feeb.fbdelflag == 0}">
                        <tr onclick="showDetail('feedback', '${feeb.fbno}', '${feeb.fbtitle}', '', '${feeb.fbcontent}', '', '${feeb.fbRegDate}', )">
                            <td><c:out value="${feeb.fbno}" /></td>
                            <td><c:out value="${feeb.fbtitle}" /></td>
                            <td><fmt:formatDate pattern="yyyy/MM/dd" value="${feeb.fbRegDate}" />
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>


        <!-- 고객의소리 상세정보 표시할 공간 -->
        <div id="feedback-detail" class="feedback-detail" style="display: none; margin-top: 20px;">
			<h3>고객의 소리 상세보기</h3>
            <table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
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
            <button class="edit-btn" onclick="editDetail('feedback')">수정</button>
            <button class="delete-btn" onclick="confirmDelete('feedback', ${feeb.fbno})">삭제</button>


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
                        <tr onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}', '${inq.iresponse}')">
                            <td> <c:out value="${inq.ino}" /></td>
                            <td> <c:out value="${inq.icategory}" /></td>
                            <td> <c:out value="${inq.ititle}" /></td>
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
                <tr>
				    <th style="width: 15%; text-align: Center; padding: 10px; border-bottom: 1px solid #ddd;">답변</th>
				    <td colspan="3" id="inquiry-response" style="padding: 10px; border-bottom: 1px solid #ddd; white-space: pre-wrap;"></td>
				</tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail('inquiry')">수정</button>
            <button class="delete-btn" onclick="confirmDelete('inquiry', ${inq.ino})">삭제</button>

        </div>
    </div>
</main>


 <script>
    window.onload = function() {
        // 페이지가 처음 로드될 때 notice 섹션만 보이도록 설정
        showSection('notice');
    };
    
    function showSection(sectionId) {
        // 모든 섹션 숨기기
        var sections = document.querySelectorAll('.section');
        sections.forEach(function(section) {
            section.classList.remove('active');
            section.style.display = 'none';
        });

        // 선택된 섹션 보이기
        var selectedSection = document.getElementById(sectionId);
        if (selectedSection) {
            selectedSection.classList.add('active');
            selectedSection.style.display = 'block';
        }

        // 상세 보기 닫기 (초기화)
        hideDetail();  // 상세 보기 창이 열려 있으면 닫음
    }

        function showDetail(type, no, title, category, content, response, regdate) {
            // 모든 테이블 숨기기
            var allTables = document.querySelectorAll('.table-container');
            allTables.forEach(function(table) {
                table.style.display = 'none';
            });

            var detailSection;

            if (type === 'faq') {
                detailSection = document.getElementById('faq-detail');
                detailSection.style.display = 'block';

                document.getElementById('faq-title').innerText = decodeURIComponent(title);
                document.getElementById('faq-category').innerText = decodeURIComponent(category);
                document.getElementById('faq-content').innerHTML = decodeURIComponent(content).replace(/\n/g, '<br>');

                document.querySelector('.edit-btn').setAttribute('data-faqno', no);
                document.querySelector('.delete-btn').setAttribute('data-faqno', no);
                
            } else if (type === 'inquiry') {
                detailSection = document.getElementById('inquiry-detail');
                detailSection.style.display = 'block';

                document.getElementById('inquiry-title').innerText = decodeURIComponent(title);
                document.getElementById('inquiry-category').innerText = decodeURIComponent(category);
                document.getElementById('inquiry-content').innerHTML = decodeURIComponent(content).replace(/\n/g, '<br>');
                document.getElementById('inquiry-response').innerHTML = decodeURIComponent(response).replace(/\n/g, '<br>');
                
                document.querySelector('.edit-btn').setAttribute('data-ino', no);
                document.querySelector('.delete-btn').setAttribute('data-ino', no);
            }
            else{
                detailSection = document.getElementById('feedback-detail');
                detailSection.style.display = 'block';

                document.getElementById('feedback-title').innerText = decodeURIComponent(title);
                document.getElementById('feedback-regdate').innerText = decodeURIComponent(regdate);
                document.getElementById('feedback-content').innerHTML = decodeURIComponent(content).replace(/\n/g, '<br>');

                document.querySelector('.edit-btn').setAttribute('data-fbno', no);
                document.querySelector('.delete-btn').setAttribute('data-fbno', no);
            }

        }
   



        function hideDetail() {
            // 테이블 다시 보이기
            var allTables = document.querySelectorAll('.table-container');
            allTables.forEach(function(table) {
                table.style.display = 'block';
            });

            document.getElementById('faq-detail').style.display = 'none';
            document.getElementById('inquiry-detail').style.display = 'none';
            document.getElementById('feedback-detail').style.display = 'none';
        }
        
        function editDetail(type) {
            var faqno = document.querySelector('.edit-btn').getAttribute('data-faqno');
            var ino = document.querySelector('.edit-btn').getAttribute('data-ino');
            var fbno = document.querySelector('.edit-btn').getAttribute('data-fbno');
            
            if (faqno) {
                window.location.href = '${contextPath}/cs/edit?faqno=' + faqno + '&type=faq';
            } else if (ino) {
                window.location.href = '${contextPath}/cs/edit?ino=' + ino + '&type=inquiry';
            } else if (fbno) {
                window.location.href = '${contextPath}/cs/edit?fbno=' + fbno + '&type=feedback';
            }
        }


        function confirmDelete(type) {
            var faqno = document.querySelector('.delete-btn').getAttribute('data-faqno');
            var ino = document.querySelector('.delete-btn').getAttribute('data-ino');
            var fbno = document.querySelector('.delete-btn').getAttribute('data-fbno');
            
            if (confirm("정말로 삭제하시겠습니까?")) {
                let deleteUrl = `${contextPath}/cs/deleteProc`;

                if (faqno) {
                    fetch(deleteUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: new URLSearchParams({
                            type: 'faq',
                            no: faqno
                        })
                    })
                    .then(response => {
                        if (response.ok) {
                            alert("삭제되었습니다.");
                            location.reload();
                        } else {
                            alert("삭제에 실패했습니다.");
                        }
                    })
                    .catch(error => {
                        console.error("FAQ 삭제 중 오류 발생:", error);
                        alert("삭제에 실패했습니다.");
                    });
                } else if (ino) {
                    fetch(deleteUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: new URLSearchParams({
                            type: 'inquiry',
                            no: ino
                        })
                    })
                    .then(response => {
                        if (response.ok) {
                            alert("삭제되었습니다.");
                            location.reload();
                        } else {
                            alert("삭제에 실패했습니다.");
                        }
                    })
                    .catch(error => {
                        console.error("1:1 문의 삭제 중 오류 발생:", error);
                        alert("삭제에 실패했습니다.");
                    });
                } else if (fbno) {
                    fetch(deleteUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: new URLSearchParams({
                            type: 'feedback',
                            no: fbno
                        })
                    })
                    .then(response => {
                        if (response.ok) {
                            alert("삭제되었습니다.");
                            location.reload();
                        } else {
                            alert("삭제에 실패했습니다.");
                        }
                    })
                    .catch(error => {
                        console.error("고객의 소리 삭제 중 오류 발생:", error);
                        alert("삭제에 실패했습니다.");
                    });
                }
            }
        }



    

   

</script>
</body>
</html>
