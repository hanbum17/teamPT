<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>예약 내역</h2>
        </div>
        <div class="reservation-history">
            <h3>내 예약 내역</h3>
            <ul>
                <c:forEach var="reservation" items="${userReservations}">
                    <li>${reservation.date} - ${reservation.itemName} - 상태: ${reservation.status} - <a href="${reservation.link}">상세보기</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>
</div>
</body>
</html>
