<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

        #reviews_wrap {
            display: none;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container" id="restaurant-container">
    <!-- 레스토랑 카드 반복문으로 생성 -->
    <c:forEach var="restaurant" items="${restList}">
        <div class="restaurant-card" data-fno="${restaurant.fno}" onclick="showDetailView(this.dataset.fno)">
            <img src="${contextPath}/images/bibimbab.jpg" alt="${restaurant.fname} Image">
            <div class="restaurant-info">
            	<h3>${restaurant.fno}</h3>
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
    <img id="panel-image" src="" alt="Detail Image" style="width: 100%; height: auto; border-radius: 10px; margin-bottom: 20px;">
    <p><strong id="panel-name"></strong></p>
    <p><strong>Rating:</strong> <span id="panel-rating"></span></p>
    <p><strong>Category:</strong> <span id="panel-category"></span></p>
    <p><strong>Location:</strong> <span id="panel-location"></span></p>
    <button class="back-button" onclick="goBack()">Back</button>
</div>

<!-- 오른쪽 패널: 리뷰/별점 -->
<div class="panel right-panel" id="right-panel">
    <!-- 별점 부분 -->
    <p><strong>Rating:</strong> <span id="panel-rating"></span></p>

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

    <!-- 리뷰 등록 폼 -->
    <div id="reviews_wrap" style="display: none; margin-top: 20px;">
        <form action="${contextPath }/vroom/restregisterReview" method="post">
            <input type="text" id="frtitle" name="frtitle" placeholder="제목"><br>
            <textarea id="frcontent" name="frcontent" placeholder="내용"></textarea><br>
            <input type="text" id="frwriter" name="frwriter" placeholder="작성자"><br>
            <input type="text" id="frrating" name="frrating" placeholder="별점 0~5"><br>
            <input type="text" id="fno" name="fno" readonly> <!-- 여기에 fno를 동적으로 설정 -->
            <button id="review_register_btn" type="submit">리뷰등록</button>
        </form>
        
        <!-- 기존 리뷰 목록 -->
        <c:forEach items="${Reviews }" var="review">
            <div class="review_div">
                <ul class="review_ul" data-frno="${review.frno }" data-uno="${review.uno }" data-fno="${review.fno }">
                    <li>frno: ${review.frno }</li>
                    <li>frtitle: ${review.frtitle }</li>
                    <li>frcontent: ${review.frcontent }</li>
                    <li>frwriter: ${review.frwriter }</li>
                    <li>frregDate: ${review.frregDate }</li>
                    <li>frrating: ${review.frrating }</li>
                    <li>uno: ${review.uno }</li>
                    <li>fno: ${review.fno }</li>
                </ul>
                <button class="review_blind_btn">블라인드처리</button>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    const contextPath = "${contextPath}";

    function toggleReviewForm() {
        const reviewForm = document.getElementById('review-form');
        const reviewButton = document.getElementById('review-button');
        const reviewsWrap = document.getElementById('reviews_wrap');

        if (reviewForm.style.display === 'none') {
            reviewForm.style.display = 'none';
            reviewButton.style.display = 'none';
            reviewsWrap.style.display = 'block'; // reviews_wrap을 표시
        } else {
            reviewForm.style.display = 'block';
            reviewButton.style.display = 'block';
            reviewsWrap.style.display = 'none'; // reviews_wrap을 숨김
        }
    }

    function submitReview() {
        const form = document.querySelector('#reviews_wrap form');
        if (form) {
            form.submit(); // 폼 제출
        }
    }

    const container = document.getElementById('restaurant-container');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    function showDetailView(fno) {
        fetch(`${contextPath}/vroom/getRestaurantDetails?fno=` + fno)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data) {
                    document.getElementById('panel-image').src = contextPath + "/images/bibimbab.jpg";
                    document.getElementById('panel-name').textContent = data.fname;
                    document.getElementById('panel-rating').textContent = data.frating;
                    document.getElementById('panel-category').textContent = data.fcategory;
                    document.getElementById('panel-location').textContent = data.faddress;

                    // fno 값을 리뷰 등록 폼에 설정
                    document.getElementById('fno').value = fno;

                    container.style.display = 'none';
                    leftPanel.style.display = 'block';
                    rightPanel.style.display = 'block';
                } else {
                    alert('식당 정보를 찾을 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('Error fetching restaurant data:', error);
                alert('식당 정보를 가져오는 데 실패했습니다.');
            });
    }

    function goBack() {
        container.style.display = 'flex';
        leftPanel.style.display = 'none';
        rightPanel.style.display = 'none';
    }

    container.addEventListener('wheel', (event) => {
        event.preventDefault();
        container.scrollLeft += event.deltaY;
    });
</script>

</body>
</html>
ㄴ