<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Restaurant Details</title>
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
            display:  flex;
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
          max-height: 640px; /* 상자의 최대 높이 설정 */
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
      .load-more-btn{
         width: 100%;
         padding: 10px;
         border: none;
         border-radius: 5px;
         background-color: #007bff;
         color: #fff;
         cursor: pointer;
      }

      #editReviewForm {
		    display: none;
		    margin-top: 20px; /* 위치 조정 */
		    padding: 10px;
		    border: 1px solid #ddd;
		    border-radius: 10px;
		    background-color: #fff;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}

	 .review_ul {
	            list-style-type: none; /* 리스트의 기본 점을 제거합니다 */
	            padding: 0;
	        }


    </style>
</head>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <div style="position: absolute; top: 10px; left: 10px; font-size: 16px;">
        <c:if test="${not empty user}">
            현재 로그인: <strong>${user.userId}</strong>
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
            <form action="/vroom/restregisterReview" method="post">
                <input type="text" id="frtitle" name="frtitle" placeholder="제목"><br>
                <textarea id="frcontent" name="frcontent" placeholder="내용"></textarea><br>
                <input type="text" id="frwriter" name="frwriter" placeholder="작성자" readonly><br>
                <input type="text" id="frrating" name="frrating" placeholder="별점 0~5"><br>
                <input type="text" id="fno" name="fno" readonly> <!-- 여기에 fno를 동적으로 설정 -->
                <button id="review_register_btn" type="submit">리뷰등록</button>
            </form>
        </div>

        <!-- 리뷰 수정 폼 -->
        <div id="editReviewForm" style="display:none;">
            <form id="reviewEditForm" action="${contextPath}/vroom/updateReview" method="post">
                <input type="hidden" id="editFrno" name="frno">
                <input type="text" id="editFrtitle" name="frtitle" placeholder="제목"><br>
                <textarea id="editFrcontent" name="frcontent" placeholder="내용"></textarea><br>
                <button type="button" onclick="submitEditReview()">수정 완료</button>
            </form>
        </div>

        <!-- 기존 리뷰 목록 -->
        <div id="reviews-container"></div>
    </div>

    <script>
        const contextPath = "${contextPath}";
        const currentUserId = "${user.userId}";
        const isAdmin = "${isAdmin}";
        let currentFno = new URLSearchParams(window.location.search).get('fno');
        let page = 1;
        const pageSize = 5;

        function submitEditReview() {
            const form = document.getElementById('reviewEditForm');
            const formData = new FormData(form);

            fetch(`${contextPath}/vroom/updateReview`, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    showDetailView(currentFno); // 패널 업데이트
                } else {
                    alert(result.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('리뷰 수정 중 오류가 발생했습니다.');
            });
        }

        function showDetailView(fno) {
            page = 1; // 페이지 초기화

            fetch(`/vroom/getRestaurantDetails?fno=` + fno)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    const reviewsContainer = document.getElementById('reviews-container');
                    reviewsContainer.innerHTML = ''; // 기존 내용 지우기
                    if (data) {
                        // 왼쪽 패널 설정
                        document.getElementById('panel-image').src = `/images/bibimbab.jpg`;
                        document.getElementById('panel-name').textContent = data.fname;
                        document.getElementById('panel-category').textContent = data.fcategory;
                        document.getElementById('panel-location').textContent = data.faddress;
                        document.getElementById('fno').value = fno;

                        document.getElementById('restaurant-container').style.display = 'none';
                        document.getElementById('left-panel').style.display = 'block';
                        document.getElementById('right-panel').style.display = 'block';

                        // 리뷰 정보 가져오기
                        return fetch('/api/getRestaurantReviews?fno=' + fno + '&page='+page+'&pageSize='+pageSize);
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
                .then(reviewData => {
                    if (reviewData && reviewData.reviews) {
                        reviewData.reviews.forEach(review => {
                            const reviewElement = document.createElement('div');
                            reviewElement.innerHTML = `
                                <p><strong>Title:</strong> ${review.frtitle}</p>
                                <p><strong>Content:</strong> ${review.frcontent}</p>
                                <p><strong>Rating:</strong> ${review.frrating}</p>
                                <p><strong>Writer:</strong> ${review.frwriter}</p>
                                ${isAdmin ? `<button onclick="editReview(${review.frno}, '${review.frtitle}', '${review.frcontent}')">Edit</button>` : ''}
                                <hr>
                            `;
                            reviewsContainer.appendChild(reviewElement);
                        });
                    } else {
                        reviewsContainer.innerHTML = '<p>No reviews found.</p>';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('리뷰를 불러오는 중 오류가 발생했습니다.');
                });
        }

        function editReview(frno, title, content) {
            document.getElementById('editFrno').value = frno;
            document.getElementById('editFrtitle').value = title;
            document.getElementById('editFrcontent').value = content;
            document.getElementById('editReviewForm').style.display = 'block';
        }

        function toggleReviewForm() {
            const reviewForm = document.getElementById('reviews_wrap');
            reviewForm.style.display = reviewForm.style.display === 'none' ? 'block' : 'none';
        }

        function goBack() {
            document.getElementById('restaurant-container').style.display = 'block';
            document.getElementById('left-panel').style.display = 'none';
            document.getElementById('right-panel').style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function() {
            if (currentFno) {
                showDetailView(currentFno);
            }
        });
    </script>
</body>
</html>
