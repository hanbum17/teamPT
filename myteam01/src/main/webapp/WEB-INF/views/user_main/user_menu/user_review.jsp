<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>등록한 리뷰 내역</h2>
        </div>
        <div class="review-history">
            <h3>나의 리뷰</h3>
            <ul>
                <c:forEach var="review" items="${userReviews}">
                    <li>${review.date} - ${review.itemName} - 평점: ${review.rating} - <a href="${review.link}">리뷰 보기</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>
</div>
</body>
</html>
