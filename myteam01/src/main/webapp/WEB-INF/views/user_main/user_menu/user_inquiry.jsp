<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/user_menu/inquiry.css">
    
<!-- DataTables CSS -->
<link rel="stylesheet"
    href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
	<div class="content-header">
            <h2>문의 내역</h2>
            <button class="register-btn" onclick="location.href='${contextPath}/cs/register?type=inquiry'">1대1 문의 등록하기</button>
		</div>

    <div class="content-container">
        <!-- 테이블 영역 -->
        <div class="table-container">
            
            <table id="inquiryTable">
                <thead>
                    <tr>
                        <th>날짜</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>내용</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="inquiry" items="${inquiries}">
                        <tr
                            onclick="toggleResponse('${inquiry.iresponse}')">
                            <td>${inquiry.iregdate}</td>
                            <td>${inquiry.icategory}</td>
                            <td>${inquiry.ititle}</td>
                            <td>${inquiry.icontent}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 답변 박스 -->
        <div class="response-box" id="response-box">
            <h4>답변 내용</h4>
            <p id="response-content">여기에 답변 내용이 표시됩니다.</p>
        </div>
    </div>
</main>

<!-- DataTables JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>

<script>
    // DataTables 초기화 (페이징 기능 포함)
    $(document).ready(function () {
        $('#inquiryTable').DataTable({
            "pageLength": 5, // 한 페이지에 3개의 항목 표시
            "lengthChange": false, // 페이지당 항목 수 변경 옵션 숨김
            "language": {
                "paginate": {
                    "previous": "이전",
                    "next": "다음"
                }
            }
        });
    });

    // 답변 표시 함수
    function toggleResponse(response) {
        const responseBox = document.getElementById('response-box');
        const responseContent = document.getElementById('response-content');
        
        // 답변 내용 설정
        responseContent.innerText = response;

        // 답변 박스를 표시
        responseBox.style.display = 'block';
    }
</script>