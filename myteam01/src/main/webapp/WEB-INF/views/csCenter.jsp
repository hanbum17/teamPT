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
                        <tr onclick="showDetail('feedback', '${feeb.fbno}', '${feeb.fbtitle}', '${feeb.fbRegDate}', '${feeb.fbcontent}')">
                            <td><c:out value="${feeb.fbno}" /></td>
                            <td><c:out value="${feeb.fbtitle}" /></td>
                            <td><fmt:formatDate pattern="yyyy/MM/dd" value="${feeb.fbRegDate}" />
                            	${feeb.fbRegDate}
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

                        <tr>
                            <td style="cursor: pointer;" onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}', '${inq.iresponse}')">
                                <c:out value="${inq.ino}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}', '${inq.iresponse}')">
                                <c:out value="${inq.icategory}" />
                            </td>
                            <td style="cursor: pointer;" onclick="showDetail('inquiry', '${inq.ino}', '${inq.ititle}', '${inq.icategory}', '${inq.icontent}', '${inq.iresponse}')">
                                <c:out value="${inq.ititle}" />
                            </td>

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
        // 페이지가 처음 로드될 때 FAQ 섹션만 보이도록 설정
        showSection('faq');
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

                document.getElementById('faq-title').innerText = title;
                document.getElementById('faq-category').innerText = category;
                document.getElementById('faq-content').innerHTML = content.replace(/\n/g, '<br>');

                document.querySelector('.edit-btn').setAttribute('data-faqno', no);
                document.querySelector('.delete-btn').setAttribute('data-faqno', no);
                
            } else if (type === 'inquiry') {
                detailSection = document.getElementById('inquiry-detail');
                detailSection.style.display = 'block';

                document.getElementById('inquiry-title').innerText = title;
                document.getElementById('inquiry-category').innerText = category;
                document.getElementById('inquiry-content').innerHTML = content.replace(/\n/g, '<br>');
                document.getElementById('inquiry-response').innerHTML = response.replace(/\n/g, '<br>');
                
                document.querySelector('.edit-btn').setAttribute('data-ino', no);
                document.querySelector('.delete-btn').setAttribute('data-ino', no);
            }
            else{
                detailSection = document.getElementById('feedback-detail');
                detailSection.style.display = 'block';

                document.getElementById('feedback-title').innerText = title;
                document.getElementById('feedback-regdate').innerText = regdate; 
               
                document.getElementById('feedback-content').innerHTML = content.replace(/\n/g, '<br>');

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

       
        
        function confirmDelete(type, no) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                // 컨트롤러로 바로 POST 요청 보내기
                console.log("삭제 요청 데이터:", type, no); // 전달 데이터 로그 출력

                fetch(`${contextPath}/cs/deleteProc`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams({
                        type: type,
                        no: no // 'no' 대신에 삭제할 항목의 정확한 이름을 사용해야 함
                    })
                })
                .then(response => {
                    if (response.ok) {
                        alert("삭제되었습니다.");
                        location.reload();  // 페이지 새로고침으로 목록 갱신
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error("삭제 요청 중 오류 발생:", error);
                    alert("삭제 요청 중 오류가 발생했습니다.");
                });
            }
        }

    </script>

   


</body>
</html>
