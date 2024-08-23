<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurant List</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            height: 100vh;
            box-sizing: border-box;
            background-color: #f7f7f7;
        }

        .container {
            display: flex;
            overflow-x: auto;
            white-space: nowrap;
            padding: 20px;
            box-sizing: border-box;
            background-color: #fff;
            position: fixed;
            bottom: 20px;
            width: 100%;
            height: 300px; /* 카드 높이에 맞게 조정 */
            align-items: center;
            transition: transform 0.3s ease;
        }

        .restaurant-card {
            display: inline-block;
            width: 250px;
            height: 280px; /* 카드의 높이 조정 */
            margin-right: 20px;
            background-color: #f0f0f0;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 10px;
            box-sizing: border-box;
            cursor: pointer;
        }

        .restaurant-card img {
            width: 100%;
            height: 60%; /* 카드 높이의 60%로 이미지 크기 조정 */
            border-radius: 10px;
            object-fit: cover;
        }

        .restaurant-info {
            padding: 20px; /* 내용 영역 패딩 조정 */
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
            display: none; /* Initially hidden */
        }

        .left-panel {
            left: 5%; /* 모서리 쪽으로 더 가까이 이동 */
            border: 1px solid #ddd;
            padding: 20px; /* 패딩 추가 */
            box-sizing: border-box;
        }

        .right-panel {
            right: 5%; /* 모서리 쪽으로 더 가까이 이동 */
            border: 1px solid #ddd;
            padding: 20px; /* 패딩 추가 */
            box-sizing: border-box;
        }

        .panel h2 {
            margin-bottom: 20px;
        }

        .panel p {
            margin-bottom: 10px;
        }

        /* .rating {
            display: flex;
            align-items: center;
            margin-bottom: 10px;  별점과 다른 요소 간의 간격 추가 
        }

        .rating span {
            font-size: 24px;
            color: #d3d3d3;  기본 별색: 회색 
            position: relative;
            display: inline-block;
        }

        .rating span::before {
            content: '★★★★★';  기본 별점 텍스트 
            color: #ffd700;  노란색 
            position: absolute;
            top: 0;
            left: 0;
            overflow: hidden;
            white-space: nowrap;
        }

        .rating span::after {
            content: '★★★★★';  기본 별점 텍스트 
            position: absolute;
            top: 0;
            left: 0;
            color: #d3d3d3;  회색으로 별점을 가려서 부분적으로 표시 
            width: 0;  채우기 비율에 따라 조절 
            overflow: hidden;
        }
 */
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

        .container::-webkit-scrollbar {
            display: none;
        }

        .container {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

    </style>
</head>
<body>

<div class="container" id="restaurant-container">
    <!-- 레스토랑 카드 반복문으로 생성 -->
    <c:forEach var="i" begin="1" end="8">
        <div class="restaurant-card" onclick="showDetailView(${i})">
            <img src="${contextPath}/images/bibimbab.jpg" alt="Restaurant ${i} Image">
            <div class="restaurant-info">
                <h3>Restaurant ${i}</h3>
                <p>Location: Example Location ${i}</p>
                <p>Open: 오전 11시 ~ 오후 10시</p>
            </div>
        </div>
    </c:forEach>
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

<div class="panel right-panel" id="right-panel">
    <!-- 별점 부분 -->
    <p><strong>4.3</strong>  ★★★★☆ </p>
    
    
    <!-- 리뷰 입력 버튼 -->
    <button onclick="openReviewForm()" style="display: block; width: 100%; padding: 10px; border: none; border-radius: 5px; background-color: #007bff; color: #fff; cursor: pointer;">
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
	function openReviewForm() {
	    document.getElementById('review-form').style.display = 'block';
	}
	
	function submitReview() {
	    // 리뷰 제출 처리 로직을 여기에 추가하세요
	    alert('리뷰가 제출되었습니다!');
}

    const container = document.getElementById('restaurant-container');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    let restaurantCount = 8; // 초기 레스토랑 카드 개수

    // 레스토랑 세부 정보를 보여주는 함수
    function showDetailView(id) {
        // 레스토랑 카드 컨테이너 숨기기
        container.style.display = 'none';
        
        // 패널들 표시
        leftPanel.style.display = 'block';
        rightPanel.style.display = 'block';
    }

    // 레스토랑 목록으로 돌아가는 함수
    function goBack() {
        // 레스토랑 카드 컨테이너 표시
        container.style.display = 'flex';
        
        // 패널들 숨기기
        leftPanel.style.display = 'none';
        rightPanel.style.display = 'none';
    }

    // 스크롤 이벤트 핸들러
    container.addEventListener('wheel', (event) => {
        event.preventDefault();

        // 수직 휠 움직임에 따라 수평 스크롤
        container.scrollLeft += event.deltaY;

        // 스크롤이 끝에 가까워지면 새 카드 추가
        if (container.scrollLeft + container.clientWidth >= container.scrollWidth - 5) {
            addNewRestaurantCard();
        }
    });

    // 새로운 레스토랑 카드를 추가하는 함수
    function addNewRestaurantCard() {
        restaurantCount++;

        const card = document.createElement('div');
        card.className = 'restaurant-card';
        card.setAttribute('onclick', `showDetailView(${restaurantCount})`);

        const img = document.createElement('img');
        img.src = `${contextPath}/images/bibimbab.jpg`; // 서버 경로 사용
        img.alt = `Restaurant ${restaurantCount}`;

        const info = document.createElement('div');
        info.className = 'restaurant-info';

        const name = document.createElement('h3');
        name.textContent = `Restaurant ${restaurantCount}`;

        const location = document.createElement('p');
        location.textContent = `Location: 남영동 ${restaurantCount}`;

        const hours = document.createElement('p');
        hours.textContent = 'Open: 오전 11시 ~ 오후 10시';

        info.appendChild(name);
        info.appendChild(location);
        info.appendChild(hours);

        card.appendChild(img);
        card.appendChild(info);

        container.appendChild(card);
    }
</script>

</body>
</html>
