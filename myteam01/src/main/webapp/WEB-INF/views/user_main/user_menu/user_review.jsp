<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../userSide.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/user_menu/review.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<main class="content-box">
	<div class="content">
		<div class="content-header fixed-header">
			<h2>내가 작성한 리뷰</h2>
			<div class="review-toggle-buttons">
			    <button onclick="showSection('event-reviews', this)" 
			            class="toggle-button active" data-section="event">행사 리뷰</button>
			    <button onclick="showSection('restaurant-reviews', this)" 
			            class="toggle-button" data-section="restaurant">음식점 리뷰</button>
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
										<i class="fa-regular fa-star"></i>
									</c:forEach>
								</p>
								<p class="review-content">${review.REVIEWCONTENT}</p>
								<button class="more-btn" style="display: none;"
									onclick="toggleReviewContent(this)">더보기</button>
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
		<div id="restaurant-reviews" class="review-section"
			style="display: none;">
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
										<i class="fa-regular fa-star"></i>
									</c:forEach>
								</p>
								<p class="review-content">${review.REVIEWCONTENT}</p>
								<button class="more-btn" style="display: none;"
									onclick="toggleReviewContent(this)">더보기</button>
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

	// 리뷰 텍스트가 일정 높이를 넘으면 더보기 버튼을 표시하는 함수
    function checkReviewTextHeight() {
        document.querySelectorAll('.review-item').forEach(function(item) {
            const content = item.querySelector('.review-content');
            const moreBtn = item.querySelector('.more-btn');

            // 이미 확장된 리뷰는 더보기 버튼을 숨김
            if (item.classList.contains('expanded')) {
                moreBtn.style.display = 'none';  // 더보기 버튼 숨김
                content.style.maxHeight = 'none';  // 텍스트 전체 표시
            } else {
                // 텍스트 높이가 100px을 넘으면 더보기 버튼을 표시
                if (content.scrollHeight > 100) {
                    moreBtn.style.display = 'inline';
                } else {
                    moreBtn.style.display = 'none';
                }
            }
        });
    }

    // 더보기 버튼 클릭 시 내용을 전체 표시하고 더보기 버튼 숨김, expanded 플래그 설정
    function toggleReviewContent(button) {
        const reviewItem = button.closest('.review-item');
        const content = reviewItem.querySelector('.review-content');

        // 클릭 시 내용을 모두 표시하고 더보기 버튼 숨김
        content.style.maxHeight = 'none';
        button.style.display = 'none';

        // expanded 플래그 설정하여 더이상 더보기 버튼이 나타나지 않도록 함
        reviewItem.classList.add('expanded');
    }

    // 섹션이 변경될 때마다 호출되는 함수
    function showSection(sectionId, button) {
        // 모든 섹션 숨기기
        document.getElementById('event-reviews').style.display = 'none';
        document.getElementById('restaurant-reviews').style.display = 'none';

        // 모든 버튼의 active 클래스 제거
        var buttons = document.getElementsByClassName('toggle-button');
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].classList.remove('active');
        }

        // 선택된 섹션만 보이게 설정
        document.getElementById(sectionId).style.display = 'block';
        button.classList.add('active');

        // 섹션 전환 후 텍스트 높이 확인하여 더보기 버튼 표시
        checkReviewTextHeight();
    }

    // 페이지 로드 후 텍스트 높이 확인
    window.onload = function() {
        // 페이지 로드 후에 리뷰 텍스트 높이를 확인하여 더보기 버튼 표시
        checkReviewTextHeight();
    };

    // 페이지 로드 후, 특정 섹션이 보일 때마다 높이 체크를 계속 수행
    document.addEventListener('DOMContentLoaded', function() {
        checkReviewTextHeight(); // DOM이 완전히 로드되면 실행
    });
</script>

</body>
</html>
