<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Display</title>
    <link rel="stylesheet" href="/css/vroomEvent.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <div id="container">
        <div id="left">
            <!-- Left section for events -->
        </div>
        <div id="right">
            <!-- Right section for events -->
        </div>
    </div>

    <div id="detail-view" class="hidden">
        <button id="back-button">Back</button>
        <div id="left-detail" class="detail-box">
            <!-- Left detail box -->
        </div>
        <div id="right-detail" class="detail-box">
            <!-- Right detail box -->
            <h2>Reviews for ${event.ename}</h2>
            <div id="review-summary">
                <div id="rating-display">
                    <span id="rating-value">4.7</span> <!-- 별점 값 -->
                </div>
                <div id="stars-display">
                    <span class="star">&#9733;</span>
                    <span class="star">&#9733;</span>
                    <span class="star">&#9733;</span>
                    <span class="star">&#9733;</span>
                    <span class="star">&#9733;</span>
                </div>
                <div id="review-count">
                    <p>Total Reviews: <span id="total-reviews">0</span></p>
                </div>
                <div id="rating-distribution">
                    <div class="rating-bar">
                        <span class="rating-label">5</span>
                        <div class="bar"></div>
                    </div>
                    <div class="rating-bar">
                        <span class="rating-label">4</span>
                        <div class="bar"></div>
                    </div>
                    <div class="rating-bar">
                        <span class="rating-label">3</span>
                        <div class="bar"></div>
                    </div>
                    <div class="rating-bar">
                        <span class="rating-label">2</span>
                        <div class="bar"></div>
                    </div>
                    <div class="rating-bar">
                        <span class="rating-label">1</span>
                        <div class="bar"></div>
                    </div>
                </div>
                <button id="write-review-button">Write a Review</button>
                <div id="review-form" class="hidden">
                    <textarea id="review-text" placeholder="Write your review here..."></textarea>
                    <button id="submit-review-button">Submit Review</button>
                </div>
            </div>
            <div id="review-list">
                <!-- Review items will be appended here -->
            </div>
        </div>
    </div>

    <script>
    // 서버에서 전달한 JSON 데이터
    const eventData = JSON.parse('${fn:escapeXml(eventsJson)}');
    console.log('Parsed Event Data:', eventData); // JSON으로 변환된 데이터 로그

    if (eventData) {
        try {
            // 데이터 초기화
            initializeEvents(eventData);
        } catch (error) {
            console.error('Error initializing events:', error); // 데이터 초기화 오류 로그
        }
    } else {
        console.error('Event data is empty or undefined.');
    }
    </script>

    <script src="/js/vroomEvent.js"></script>
</body>
</html>
