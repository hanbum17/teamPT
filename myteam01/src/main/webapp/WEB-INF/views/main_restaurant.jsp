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
            margin-top: 20px;
        }
        
        .small-text {
          font-size: 0.8em; /* 작은 글씨 크기 */
          color: #555; /* 원하는 색상 */
            margin-left: 5px; /* 레이아웃에 맞게 여백 조절 */
      	}
      	
      	#reviews-container {
          max-height: 400px; /* 상자의 최대 높이 설정 */
          overflow-y: scroll; /* 세로 스크롤 추가 */
          padding: 10px; /* 여백 추가 */
          border: 0.5px solid #ddd; /* 상자 테두리 */
          border-radius: 10px; /* 상자 모서리 둥글게 */
          background-color: #fff; /* 상자 배경색 */
          box-shadow: 0 0 10px rgba(0, 0, 0, 0); /* 상자 그림자 */
      }

      /* 웹킷 기반 브라우저에서 스크롤바 숨기기 */
      #reviews-container::-webkit-scrollbar {
          width: 0; /* 스크롤바의 너비를 0으로 설정하여 숨김 */
          background: transparent; /* 스크롤바의 배경색을 투명하게 설정 */
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
    <p>
       <strong>Rating:</strong> 
       <span id="panel-rating"></span>
       <span id="rating-extra" class="small-text"></span>
    </p>

    <p><strong>Category:</strong> <span id="panel-category"></span></p>
    <p><strong>Location:</strong> <span id="panel-location"></span></p>
    <button class="back-button" onclick="goBack()">Back</button>
</div>

<!-- 오른쪽 패널: 리뷰/별점 -->
<div class="panel right-panel" id="right-panel">
    <!-- 별점 부분 -->
   <p>
       <strong>Rating:</strong> 
       <span id="panel-rating"></span>
       <span id="rating-extra" class="small-text"></span>
    </p>


    <!-- 리뷰 입력 버튼 -->
    <button id="review-button" onclick="toggleReviewForm()" style="display: block; width: 100%; padding: 10px; border: none; border-radius: 5px; background-color: #007bff; color: #fff; cursor: pointer;">
        리뷰 입력
    </button>

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
    </div>
    
    <!-- 기존 리뷰 목록 -->
    <div id="reviews-container">
    </div>
</div>

<script>
    const contextPath = "${contextPath}";

    function toggleReviewForm() {
        const reviewButton = document.getElementById('review-button');
        const reviewsWrap = document.getElementById('reviews_wrap');

        if (reviewsWrap.style.display === 'none' || reviewsWrap.style.display === '') {
            reviewsWrap.style.display = 'block'; // reviews_wrap을 표시
            reviewButton.style.display = 'none'; // 리뷰 입력 버튼 숨기기
        } else {
            reviewsWrap.style.display = 'none'; // reviews_wrap을 숨김
            reviewButton.style.display = 'block'; // 리뷰 입력 버튼 표시
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
              // 왼쪽 패널 설정
              document.getElementById('panel-image').src = `${contextPath}/images/bibimbab.jpg`;
              document.getElementById('panel-name').textContent = data.fname;
              document.getElementById('panel-category').textContent = data.fcategory;
              document.getElementById('panel-location').textContent = data.faddress;
      
              
      
              document.getElementById('fno').value = fno;
      
              container.style.display = 'none';
              leftPanel.style.display = 'block';
              rightPanel.style.display = 'block';
      
              // 리뷰 정보 가져오기
              return fetch(`${contextPath}/vroom/getRestaurantReviews?fno=` + fno);
          } else {
              alert('식당 정보를 찾을 수 없습니다.');
              throw new Error('No restaurant data');
          }
      })

            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(reviews => {
       const reviewsContainer = document.getElementById('reviews-container');
       reviewsContainer.innerHTML = ''; // 기존 내용 지우기
   
       if (reviews.length === 0) {
           reviewsContainer.innerHTML = '<p>No reviews available.</p>';
       } else {
           reviews.forEach(review => {
               console.log(review.frno);
               // 왼쪽 패널의 Rating 값을 설정합니다.
               document.getElementById('panel-rating').textContent = review.ratingAverage;
               // 오른쪽 패널의 Rating 값을 설정합니다.
               document.querySelector('#right-panel #panel-rating').textContent =review.ratingAverage;
               // 왼쪽 패널의 리뷰 개수 표시
               document.querySelector('#rating-extra').textContent ="("+review.frCount+")";
               // 오른쪽 패널의 리뷰 개수 표시
               document.querySelector('#right-panel #rating-extra').textContent ="("+review.frCount+")";

              
               
               // frregDate에서 날짜 부분만 추출
               const formattedDate = review.frregDate.split('T')[0];
   
               const reviewElement = document.createElement('div');
               reviewElement.className = 'review_div';
               reviewElement.innerHTML = 
                   "<ul class='review_ul' data-frno="+review.frno+" data-uno="+review.uno+" data-fno="+review.fno+">"
                      + "<li>frtitle: "+review.frtitle+"</li>"
                      + "<li>frcontent: "+review.frcontent+"</li>"
                      + "<li>frwriter: "+review.frwriter+"</li>"
                      + "<li>frregDate: "+formattedDate+"</li>" // 여기서 날짜 부분만 출력
                      + "<li>frrating: "+review.frrating+"</li>"
                  + "</ul>"
               ; 
               reviewsContainer.appendChild(reviewElement);
           });
       }
   })
            .catch(error => {
                console.error('Error fetching data:', error);
                alert('데이터를 가져오는 데 실패했습니다.');
            });
    }

    function goBack() {
        container.style.display = 'flex';
        leftPanel.style.display = 'none';
        rightPanel.style.display = 'none';

        // 리뷰 입력 버튼을 보이게 하고, 리뷰 등록 폼을 숨깁니다.
        document.getElementById('review-button').style.display = 'block';
        document.getElementById('reviews_wrap').style.display = 'none';
    }

    container.addEventListener('wheel', (event) => {
        event.preventDefault();
        container.scrollLeft += event.deltaY;
    });
</script>

</body>
</html>