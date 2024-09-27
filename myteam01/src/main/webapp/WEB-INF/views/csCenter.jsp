<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%@ include file="./menu/nav.jsp"%>
    <%@ include file="./menu/footer.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

		.btnNotice { background-color: red; }
		.btnCsEvent {background-color: black; }
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


    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/csCenter/center.css">

</head>
<body>

<main>
    <h1>고객센터</h1>

    <!-- Section Buttons -->
    <div class="btn-container">
    	<button class="btnNotice" onclick="showSection('notice')">공지사항</button>
		<button class="btnCsEvent" onclick="showSection('event')">이벤트</button>
        <button class="btnFAQ" onclick="showSection('faq')">자주 묻는 질문(FAQ)</button>
        <button class="btnFeedback" onclick="showSection('feedback')">고객의 소리(건의사항)</button>
        <button class="btnInquiry" onclick="showSection('inquiry')">1:1 문의</button>
    </div>


	 <!-- Notice Section -->
    <div id="notice" class="section active">
        <div class="section-header">
            <h3>공지사항</h3>
            <button type="button" class="register-btn" onclick="location.href='${contextPath}/cs/register?type=notice'">공지사항 등록</button>
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
                        <tr onclick="showDetail('notice', '${nc.notice_num}', '${nc.notice_title}',' ', '${nc.notice_content}', '','${nc.notice_regdate}')">
                            <td><c:out value="${nc.notice_title}" /></td>
                            <td> <fmt:formatDate pattern="yyyy/MM/dd" value="${nc.notice_regdate}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- notice Detail Section -->
        <div id="notice-detail" class="detail-view" style="display: none;">
            <h3>공지사항 상세보기</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%;">제목</th>
                    <td id="notice-title"></td>
                    <th style="width: 15%;">등록일</th>
                    <td id="notice-regdate"></td>
                </tr>
                <tr>
                    <th style="width: 15%;">내용</th>
                    <td colspan="3" id="notice-content" style="white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail('notice')">수정</button>
            <button class="delete-btn" onclick="confirmDelete('notice', ${nc.notice_num})">삭제</button>
        </div>
    </div>
    
    <div id="event" class="section active">
        <div class="section-header">
            <h3>행사</h3>
            <button type="button" class="register-btn" onclick="location.href='${contextPath}/cs/register?type=event'">행사 등록</button>
        </div>
        <div class="table-container">
            <table>
                <tr>
                    <th>제목</th>
                    <th>등록일</th>
                </tr>
                <c:forEach items="${event}" var="ev">
                    <c:if test="${ev.event_delflag == 1}">
                        <tr>
                            <td><c:out value="${ev.event_num}" /></td>
                            <td colspan="2"><em>삭제된 게시글입니다.</em></td>
                        </tr>
                    </c:if>
                    <c:if test="${ev.event_delflag == 0}">
                        <tr onclick="showDetail('event', '${ev.event_num}', '${ev.event_title}',' ', '${ev.event_content}', '','${ev.event_regdate}')">
                            <td><c:out value="${ev.event_title}" /></td>
                            <td> <fmt:formatDate pattern="yyyy/MM/dd" value="${ev.event_regdate}" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>

        <!-- notice Detail Section -->
        <div id="event-detail" class="detail-view" style="display: none;">
            <h3>행사 상세보기</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th style="width: 15%;">제목</th>
                    <td id="event-title"></td>
                    <th style="width: 15%;">등록일</th>
                    <td id="event-regdate"></td>
                </tr>
                <tr>
                    <th style="width: 15%;">내용</th>
                    <td colspan="3" id="event-content" style="white-space: pre-wrap;"></td>
                </tr>
            </table>
            <button class="back-btn" onclick="hideDetail()">닫기</button>
            <button class="edit-btn" onclick="editDetail('event')">수정</button>
            <button class="delete-btn" onclick="confirmDelete('notice', ${ev.event_num})">삭제</button>
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
                    <th>날짜</th>
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
        
    	// 현재 페이지의 URL을 가져옵니다.
    	const urlParams = new URLSearchParams(window.location.search);
    	
    	// 'type' 파라미터의 값을 가져옵니다.
    	const type = urlParams.get('type');
    	
    	// 페이지가 처음 로드될 때 notice 섹션만 보이도록 설정
    	if(!type){
    		showSection('notice')
    	} else {
        	showSection(type);
    	}
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

        // 각 타입별 상세 보기 처리
        if (type === 'faq') {
            detailSection = document.getElementById('faq-detail');
            detailSection.style.display = 'block';

            document.getElementById('faq-title').innerText = decodeURIComponent(title || '');
            document.getElementById('faq-category').innerText = decodeURIComponent(category || '');
            document.getElementById('faq-content').innerHTML = decodeURIComponent(content || '').replace(/\n/g, '<br>');

            document.querySelector('.edit-btn').setAttribute('data-faqno', no);
            document.querySelector('.delete-btn').setAttribute('data-faqno', no);
            
        } else if (type === 'inquiry') {
            detailSection = document.getElementById('inquiry-detail');
            detailSection.style.display = 'block';

            document.getElementById('inquiry-title').innerText = decodeURIComponent(title || '');
            document.getElementById('inquiry-category').innerText = decodeURIComponent(category || '');
            document.getElementById('inquiry-content').innerHTML = decodeURIComponent(content || '').replace(/\n/g, '<br>');
            document.getElementById('inquiry-response').innerHTML = decodeURIComponent(response || '').replace(/\n/g, '<br>');
            
            document.querySelector('.edit-btn').setAttribute('data-ino', no);
            document.querySelector('.delete-btn').setAttribute('data-ino', no);
        } else if (type === 'feedback') {
            detailSection = document.getElementById('feedback-detail');
            detailSection.style.display = 'block';

            document.getElementById('feedback-title').innerText = decodeURIComponent(title || '');
            document.getElementById('feedback-regdate').innerText = decodeURIComponent(regdate || '');
            document.getElementById('feedback-content').innerHTML = decodeURIComponent(content || '').replace(/\n/g, '<br>');

            document.querySelector('.edit-btn').setAttribute('data-fbno', no);
            document.querySelector('.delete-btn').setAttribute('data-fbno', no);
        } else if (type === 'notice') {
            detailSection = document.getElementById('notice-detail');
            detailSection.style.display = 'block';

            document.getElementById('notice-title').innerText = title || '';
            document.getElementById('notice-regdate').innerText = regdate || '';
            document.getElementById('notice-content').innerHTML = content.replace(/\n/g, '<br>');

            document.querySelector('.edit-btn').setAttribute('data-notice_num', no);
            document.querySelector('.delete-btn').setAttribute('data-notice_num', no);
        } else if (type === 'event') {
            detailSection = document.getElementById('event-detail');
            detailSection.style.display = 'block';

            document.getElementById('event-title').innerText = title || '';
            document.getElementById('event-regdate').innerText = regdate || '';
            document.getElementById('event-content').innerHTML = content.replace(/\n/g, '<br>');

            document.querySelector('.edit-btn').setAttribute('data-event_num', no);
            document.querySelector('.delete-btn').setAttribute('data-event_num', no);
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
        document.getElementById('notice-detail').style.display = 'none';
        document.getElementById('event-detail').style.display = 'none';
    }

    function editDetail() {
        var faqno = document.querySelector('.edit-btn')?.getAttribute('data-faqno');
        var ino = document.querySelector('.edit-btn')?.getAttribute('data-ino');
        var fbno = document.querySelector('.edit-btn')?.getAttribute('data-fbno');
        var notice_num = document.querySelector('.edit-btn')?.getAttribute('data-notice_num');
        var event_num = document.querySelector('.edit-btn')?.getAttribute('data-event_num');

        if (faqno) {
            window.location.href = `${contextPath}/cs/edit?faqno=${faqno}&type=faq`;
        } else if (ino) {
            window.location.href = `${contextPath}/cs/edit?ino=${ino}&type=inquiry`;
        } else if (fbno) {
            window.location.href = `${contextPath}/cs/edit?fbno=${fbno}&type=feedback`;
        } else if (notice_num) {
            window.location.href = `${contextPath}/cs/edit?notice_num=${notice_num}&type=notice`;
        } else if (event_num) {
            window.location.href = `${contextPath}/cs/edit?event_num=${event_num}&type=event`;
        }
    }

    function confirmDelete() {
        var faqno = document.querySelector('.delete-btn')?.getAttribute('data-faqno');
        var ino = document.querySelector('.delete-btn')?.getAttribute('data-ino');
        var fbno = document.querySelector('.delete-btn')?.getAttribute('data-fbno');
        var notice_num = document.querySelector('.delete-btn')?.getAttribute('data-notice_num');
        var event_num = document.querySelector('.delete-btn')?.getAttribute('data-event_num');

        if (confirm("정말로 삭제하시겠습니까?")) {
            let deleteUrl = `${contextPath}/cs/deleteProc`;

            let params;
            if (faqno) {
                params = { type: 'faq', no: faqno };
            } else if (ino) {
                params = { type: 'inquiry', no: ino };
            } else if (fbno) {
                params = { type: 'feedback', no: fbno };
            } else if (notice_num) {
                params = { type: 'notice', no: notice_num };
            } else if (event_num) {
                params = { type: 'event', no: event_num };
            }

            if (params) {
                fetch(deleteUrl, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams(params)
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
                    console.error("삭제 중 오류 발생:", error);
                    alert("삭제에 실패했습니다.");
                });
            }
        }
    }
</script>

</body>
</html>
