<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>문의 내역</h2>
        </div>
        <div class="inquiry-history">
            <h3>나의 문의 내역</h3>
            <ul>
                <c:forEach var="inquiry" items="${userInquiries}">
                    <li>${inquiry.date} - ${inquiry.subject} - <a href="${inquiry.link}">답변 보기</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>
</div>
</body>
</html>
