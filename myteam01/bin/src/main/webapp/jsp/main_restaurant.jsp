<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Restaurant List</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            background-color: #f7f7f7;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        .container {
            display: flex;
            overflow-x: auto;
            white-space: nowrap;
            padding: 20px;
            box-sizing: border-box;
            background-color: #fff;
            width: 100%;
            height: 300px;
            align-items: center;
            position: fixed;
            bottom: 0;
        }

        .restaurant-card {
		    display: inline-block;
		    width: 200px; 
		    height: 280px;
		    margin-right: 20px;
		    background-color: #f0f0f0;
		    border-radius: 10px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    text-align: center;
		    padding: 10px;
		    box-sizing: border-box;
		    cursor: pointer;
		    flex-shrink: 0; 
		}


        .restaurant-card img {
            width: 100%;
            height: 60%;
            border-radius: 10px;
            object-fit: cover;
        }

        .restaurant-info {
            padding: 20px;
        }

        .restaurant-info h3 {
            margin: 1px 0;
            font-size: 18px;
        }

        .restaurant-info p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .panel {
            position: absolute;
            top: 50px;
            width: 28%;
            height: calc(100vh - 100px);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            background-color: #fff;
            padding: 20px;
            box-sizing: border-box;
            display: none;
        }

        .left-panel {
            left: 5%;
            border: 1px solid #ddd;
            padding: 20px;
            box-sizing: border-box;
        }

        .right-panel {
            right: 5%;
            border: 1px solid #ddd;
            padding: 20px;
            box-sizing: border-box;
        }

        .panel h2 {
            margin-bottom: 20px;
        }

        .panel p {
            margin-bottom: 10px;
        }

        .container::-webkit-scrollbar {
            display: none;
        }

        .container {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        .back-button {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container" id="restaurant-container">
    <!-- 레스토랑 카드 반복문으로 생성 -->
    <c:forEach var="restaurant" items="${restList}">
        <div class="restaurant-card" onclick="showDetailView(${restaurant.fno})">
            <img src="${contextPath}/images/bibimbab.jpg" alt="${restaurant.fname} Image">
            <div class="restaurant-info">
                <h3>${restaurant.fname}</h3>
                <p>Location: ${restaurant.faddress}</p>
                <p>Rating: ${restaurant.frating}</p>
            </div>
        </div>
    </c:forEach>

    <!-- 데이터가 없는 경우 표시할 카드 -->
    <c:if test="${empty restList}">
        <div class="restaurant-card">
            <img src="${contextPath}/images/bibimbab.jpg" alt="No Data Image">
            <div class="restaurant-info">
                <h3>No Restaurants Available</h3>
                <p>Location: N/A</p>
                <p>Rating: N/A</p>
            </div>
        </div>
    </c:if>
</div>

<!-- 왼쪽 패널: 식당 정보 -->
<div class="panel left-panel" id="left-panel">
    <img src="${contextPath}/images/bibimbab.jpg" alt="Detail Image" style="width: 100%; height: auto; border-radius: 10px; margin-bottom: 20px;">
    <p><strong>전주MZ비빔밥 홍대점</strong></p>
    <p><strong>4.3</strong>  ★★★★☆ </p>
    <p><strong>위치:</strong> 전라북도 전주시 가나동 16-53</p>
    <p><strong>운영시간:</strong> 오전 11시 ~ 오후 10시</p>
    <p><strong>비빔밥~ 츄베릅^^</p>
    <button class="back-button" onclick="goBack()">Back</button>
</div>

<!-- 오른쪽 패널: 리뷰/별점 -->
<div class="panel right-panel" id="right-panel">
    <!-- 별점 부분 -->
    <p><strong>4.3</strong>  ★★★★☆ </p>

    <!-- 리뷰 입력 버튼 -->
    <button id="review-button" onclick="toggleReviewForm()" style="display: block; width: 100%; padding: 10px; border: none; border-radius: 5px; background-color: #007bff; color: #fff; cursor: pointer;">
        리뷰 입력
    </button>

    <!-- 리뷰 입력 폼 (처음에는 숨겨짐) -->
    <div id="review-form" style="display: none; margin-top: 20px;">
        <textarea rows="4" cols="50" placeholder="리뷰를 입력하세요..." style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ddd;"></textarea>
        <button onclick="submitReview()" style="display: block; width: 100%; padding: 10px; border: none; border-radius: 5px; background-color: #28a745; color: #fff; cursor: pointer; margin-top: 10px;">
            리뷰 제출
        </button>
    </div>

    <!-- 공간을 분리하는 긴 줄 -->
    <hr style="margin: 20px 0; border: 1px solid #ddd;">

    <!-- 리뷰 목록 -->
    <div class="review">
        <p><strong>김민수</strong></p>
        <p style="font-weight: normal;">비빔밥 마쉿다~!</p>
        <hr style="border: 1px solid #ddd; margin: 10px 0;">
    </div>
    <div class="review">
        <p><strong>이지연</strong></p>
        <p style="font-weight: normal;">야채 비린맛 개심함 ㅡㅡ;</p>
        <hr style="border: 1px solid #ddd; margin: 10px 0;">
    </div>
    <div class="review">
        <p><strong>박태호</strong></p>
        <p style="font-weight: normal;">라떼 비빔밥 계란은 완숙이였는데...</p>
        <hr style="border: 1px solid #ddd; margin: 10px 0;">
    </div>
</div>

<script>
    function toggleReviewForm() {
        const reviewForm = document.getElementById('review-form');
        const reviewButton = document.getElementById('review-button');
        
        if (reviewForm.style.display === 'none') {
            reviewForm.style.display = 'block';
            reviewButton.style.display = 'none';
        } else {
            reviewForm.style.display = 'none';
            reviewButton.style.display = 'block';
        }
    }

    function submitReview() {
        alert('리뷰가 제출되었습니다!');
        toggleReviewForm(); // 리뷰 제출 후 폼 숨기고 입력 버튼 다시 표시
    }

    const container = document.getElementById('restaurant-container');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    // 레스토랑 세부 정보를 보여주는 함수
    function showDetailView(id) {
        container.style.display = 'none'; // 레스토랑 카드 컨테이너 숨기기
        leftPanel.style.display = 'block'; // 패널들 표시
        rightPanel.style.display = 'block';
    }

    // 레스토랑 목록으로 돌아가는 함수
    function goBack() {
        container.style.display = 'flex'; // 레스토랑 카드 컨테이너 표시
        leftPanel.style.display = 'none'; // 패널들 숨기기
        rightPanel.style.display = 'none';
    }

    // 수직 휠을 수평 스크롤로 변환
    container.addEventListener('wheel', (event) => {
        event.preventDefault();
        container.scrollLeft += event.deltaY;
    });
</script>

</body>
</html>


</script>

</body>
</html>

