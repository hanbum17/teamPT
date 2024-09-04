<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/review.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<main class="content-box">
    <div class="content">
        <div class="content-header fixed-header">
            <h2>내가 작성한 리뷰</h2>
            <div class="review-toggle-buttons">
                <button onclick="showSection('event-reviews', this)" class="toggle-button active">행사 리뷰</button>
                <button onclick="showSection('restaurant-reviews', this)" class="toggle-button">음식점 리뷰</button>
            </div>
        </div>

        <!-- Event Reviews Section -->
        <div id="event-reviews" class="review-section">
            <ul>
                <c:forEach var="review" items="${eventReviews}">
                    <li class="review-item" data-type="EVENT">
                        <div class="review-header">
                            <h4>${review.ITEMNAME}</h4>
                        </div>
                        <div class="review-body">
                            <div class="review-info">
                                <p class="review-date">리뷰 등록일: ${review.REVIEWDATE}</p>
                                <p class="review-rating">
                                    등록한 평점:
                                    <c:forEach var="i" begin="1" end="${review.REVIEWRATING}">
                                        <i class="fa fa-star"></i>
                                    </c:forEach>
                                    <c:forEach var="i" begin="${review.REVIEWRATING + 1}" end="5">
                                        <i class="fa fa-star-o"></i>
                                    </c:forEach>
                                </p>
                                <p class="review-content">${review.REVIEWCONTENT}</p>
                            </div>
                            <div class="review-image">
                                <c:if test="${not empty review.REVIEWIMAGE}">
                                    <img src="${review.REVIEWIMAGE}" alt="리뷰 이미지" />
                                </c:if>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <!-- Restaurant Reviews Section -->
        <div id="restaurant-reviews" class="review-section" style="display: none;">
            <ul>
                <c:forEach var="review" items="${restaurantReviews}">
                    <li class="review-item" data-type="RESTAURANT">
                        <div class="review-header">
                            <h4>${review.ITEMNAME}</h4>
                        </div>
                        <div class="review-body">
                            <div class="review-info">
                                <p class="review-date">리뷰 등록일: ${review.REVIEWDATE}</p>
                                <p class="review-rating">
                                    등록한 평점:
                                    <c:forEach var="i" begin="1" end="${review.REVIEWRATING}">
                                        <i class="fa fa-star"></i>
                                    </c:forEach>
                                    <c:forEach var="i" begin="${review.REVIEWRATING + 1}" end="5">
                                        <i class="fa fa-star-o"></i>
                                    </c:forEach>
                                </p>
                                <p class="review-content">${review.REVIEWCONTENT}</p>
                            </div>
                            <div class="review-image">
                                <c:if test="${not empty review.REVIEWIMAGE}">
                                    <img src="${review.REVIEWIMAGE}" alt="리뷰 이미지" />
                                </c:if>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</main>

<script>
    function showSection(sectionId, button) {
        // Hide both sections
        document.getElementById('event-reviews').style.display = 'none';
        document.getElementById('restaurant-reviews').style.display = 'none';
        
        // Remove active class from all buttons
        var buttons = document.getElementsByClassName('toggle-button');
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].classList.remove('active');
        }

        // Show the selected section
        document.getElementById(sectionId).style.display = 'block';

        // Add active class to the clicked button
        button.classList.add('active');
    }
</script>

</body>
</html>
