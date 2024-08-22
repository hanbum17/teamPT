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
            overflow-x: hidden;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            height: 100vh;
            box-sizing: border-box;
        }

        .container {
            display: flex;
            overflow-x: scroll;
            white-space: nowrap;
            padding: 20px;
            box-sizing: border-box;
            background-color: #fff;
        }

        .restaurant-card {
            display: inline-block;
            width: 250px;
            height: 200px;
            margin-right: 20px;
            background-color: #f0f0f0;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 10px;
            box-sizing: border-box;
        }

        .restaurant-card img {
            width: 100%;
            height: 100px;
            border-radius: 10px;
            object-fit: cover;
        }

        .restaurant-info {
            padding: 10px;
        }

        .restaurant-info h3 {
            margin: 10px 0;
            font-size: 18px;
        }

        .restaurant-info p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        /* 스크롤 바 숨기기 */
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
    <!-- 초기 식당 카드 -->
    <div class="restaurant-card">
        <img src="${contextPath}/files/image/${uuid}" alt="Restaurant Image">
        <div class="restaurant-info">
            <h3>Restaurant 1</h3>
            <p>Location: 남영동 25-1</p>
            <p>Open: 오전 11시 ~ 오후 10시</p>
        </div>
    </div>
    <div class="restaurant-card">
        <img src="${contextPath}/files/image/${uuid}" alt="Restaurant Image">
        <div class="restaurant-info">
            <h3>Restaurant 2</h3>
            <p>Location: 남영동 25-2</p>
            <p>Open: 오전 11시 ~ 오후 10시</p>
        </div>
    </div>
    <div class="restaurant-card">
        <img src="${contextPath}/files/image/${uuid}" alt="Restaurant Image">
        <div class="restaurant-info">
            <h3>Restaurant 3</h3>
            <p>Location: 남영동 25-3</p>
            <p>Open: 오전 11시 ~ 오후 10시</p>
        </div>
    </div>
</div>

<script>
    const container = document.getElementById('restaurant-container');
    let restaurantCount = 3; // 이미 존재하는 초기 식당 수

    // 스크롤 시 새로운 카드 추가
    container.addEventListener('wheel', (event) => {
        event.preventDefault();
        container.scrollLeft += event.deltaY;

        // 스크롤이 거의 끝에 도달했을 때 새로운 카드를 추가
        if (container.scrollLeft + container.clientWidth >= container.scrollWidth - 5) {
            addNewRestaurantCard();
        }
    });

    // 새로운 레스토랑 카드를 추가하는 함수
    function addNewRestaurantCard() {
        restaurantCount++;
        
        const card = document.createElement('div');
        card.className = 'restaurant-card';
        
        const img = document.createElement('img');
        img.src = `file:///C:/Users/yourboot/Desktop/foodpicture/bibimbab.jpg`; // 이미지 경로
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
