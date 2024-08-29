<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>결제 내역</h2>
        </div>
        <div class="payment-history">
            <h3>내 결제 내역</h3>
            <ul>
                <c:forEach var="payment" items="${userPayments}">
                    <li>${payment.date} - ${payment.itemName} - 금액: ${payment.amount}원 - <a href="${payment.link}">상세보기</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>
</div>
</body>
</html>
