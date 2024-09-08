<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>event Details</title>
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

        .event-card {
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

        .event-card img {
            width: 100%;
            height: 60%;
            border-radius: 10px;
            object-fit: cover;
        }

        .event-info {
            padding: 20px;
        }

        .event-info h3 {
            margin: 1px 0;
            font-size: 18px;
        }

        .event-info p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .panel {
		    position: absolute;
		    top: 50px;
		    width: 28%;
		    height: calc(100vh - 100px); /* 패널의 높이 설정 */
		    border-radius: 10px;
		    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
		    background-color: #fff;
		    padding: 20px;
		    box-sizing: border-box;
		    display: none;
		    overflow: hidden; /* 패널 내부 콘텐츠가 넘칠 경우 숨기기 */
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
		    overflow-y: auto; /* 스크롤 활성화 */
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
        .small-text {
          font-size: 0.8em; /* 작은 글씨 크기 */
          color: #555; /* 원하는 색상 */
            margin-left: 5px; /* 레이아웃에 맞게 여백 조절 */
        }
        #reviews-container {
		    max-height: calc(100vh - 250px); /* 패널 높이에 따라 조정 */
		    overflow-y: auto; /* 스크롤 추가 */
		    padding: 10px;
		    border: 0.5px solid #ddd;
		    border-radius: 10px;
		    background-color: #fff;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0);
		}

      /* 웹킷 기반 브라우저에서 스크롤바 숨기기 */
      	#reviews-container::-webkit-scrollbar {
		    width: 0; /* 스크롤바 숨기기 */
		    background: transparent;
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
		    <form id="reviewForm">
		        <input type="text" id="ertitle" name="ertitle" placeholder="제목"><br>
		        <textarea id="ercontent" name="ercontent" placeholder="내용"></textarea><br>
		        <input type="text" id="erwriter" name="erwriter" placeholder="작성자" readonly><br>
		        <input type="text" id="errating" name="errating" placeholder="별점 0~5"><br>
		        <input type="text" id="eno" name="eno" readonly> <!-- 여기에 fno를 동적으로 설정 -->
		        <button id="review_register_btn" type="button" onclick="submitReview()">리뷰등록</button>
		    </form>
		</div>

        <!-- 리뷰 수정 폼 -->
        <div id="editReviewForm" style="display:none;">
            <form id="reviewEditForm" action="${contextPath}/vroom/updateReviewEvent" method="post">
                <input type="hidden" id="editErno" name="erno">
                <input type="text" id="editErtitle" name="ertitle" placeholder="제목"><br>
                <textarea id="editErcontent" name="ercontent" placeholder="내용"></textarea><br>
                <button type="button" onclick="submitEditReview()">수정 완료</button>
            </form>
        </div>

        <!-- 기존 리뷰 목록 -->
        <div id="reviews-container"></div>
    </div>

    <script>
        const reviewsContainer = document.getElementById('reviews-container');
        const contextPath = "${contextPath}";
        const currentUserId = "${user.userId}"
        const isAdmin = "${isAdmin}";
        let currentEno = new URLSearchParams(window.location.search).get('eno');
        let page = 1;
        const pageSize = 5;

        function submitEditReview() {
        	reviewsContainer.innerHTML = '';
            const form = document.getElementById('reviewEditForm');
            const formData = new FormData(form);

            fetch(`${contextPath}/vroom/updateReviewEvent`, {
                method: 'POST',
                body: formData
            })
            // 기존 리뷰를 지웁니다.
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    document.getElementById('editReviewForm').style.display = 'none'; // 폼 숨기기
                    showDetailView(document.getElementById('eno').value); // 패널 업데이트
                } else {
                    alert(result.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('리뷰 수정 중 오류가 발생했습니다.');
            });
        }


        function showDetailView(eno) {
            page = 1; // 페이지 초기화

            fetch(`${contextPath}/vroom/getEventDetails?eno=` + eno)
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    if (data) {
                        // 왼쪽 패널 설정
                        document.getElementById('panel-image').src = `/images/event.jpg`;
                        document.getElementById('panel-name').textContent = data.ename;
                        //document.getElementById('panel-category').textContent = data.ecategory;
                        document.getElementById('panel-location').textContent = data.eaddress;
                        document.getElementById('eno').value = eno;

                        // 패널 표시
                        const eventContainer = document.getElementById('event-container');
                        const leftPanel = document.getElementById('left-panel');
                        const rightPanel = document.getElementById('right-panel');

                        if (eventContainer) {
                            eventContainer.style.display = 'none';
                        }
                        if (leftPanel) {
                            leftPanel.style.display = 'block';
                        }
                        if (rightPanel) {
                            rightPanel.style.display = 'block';
                        }

                        // 리뷰 정보 가져오기
                        return fetch(`${contextPath}/api/getEventReviews?eno=` + eno + '&page=' + page + '&pageSize=' + pageSize);
                    } else {
                        alert('식당 정보를 찾을 수 없습니다.');
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(reviews => {
                    displayReviews(reviews);
                })
                .catch(error => {
                	
                    console.error('Error fetching data:', error);
                    alert('데이터를 가져오는 데 실패했습니다.1');
                });
        }

        
        function displayReviews(reviews) {
            //const reviewsContainer = document.getElementById('reviews-container');

            // 새로 추가된 리뷰를 저장할 배열
            let newReviewsHTML = '';

            if (reviews.length === 0) {
                if (reviewsContainer.childElementCount === 0) {
                    reviewsContainer.innerHTML = '<p>리뷰가 없습니다.</p>';
                }
                return;
            }

            reviews.forEach(review => {
                // 왼쪽 패널의 Rating 값을 설정합니다.
                document.getElementById('panel-rating').textContent = review.ratingAverage;
                // 오른쪽 패널의 Rating 값을 설정합니다.
                document.querySelector('#right-panel #panel-rating').textContent = review.ratingAverage;
                // 왼쪽 패널의 리뷰 개수 표시
                document.querySelector('#rating-extra').textContent = "(" + review.erCount + ")";
                // 오른쪽 패널의 리뷰 개수 표시
                document.querySelector('#right-panel #rating-extra').textContent = "(" + review.erCount + ")";

                // 날짜형식 전환
                const formattedDate = review.erregDate.split('T')[0];
                // 동적 HTML 추가
                const reviewDiv = document.createElement('div');
                reviewDiv.className = 'review_div';

                reviewDiv.innerHTML +=
                    "<div class='review_div'>"
                    + "<ul class='review_ul' data-erno="+review.erno+" data-uno="+review.uno+" data-eno="+review.eno+">"
                        + "<li>제목: "+review.ertitle+"</li>"
                        + "<li>내용: "+review.ercontent+"</li>"
                        + "<li>작성자: "+review.erwriter+"</li>"
                        + "<li>등록일: "+formattedDate+"</li>" // 날짜 부분만 출력
                        + "<li>별점: "+review.errating+"</li>"
                        + "<li>" 
                            + (currentUserId === review.erwriter ? "<button onclick=\"editReview('" + review.erno + "', '" + review.ertitle + "', '" + review.ercontent + "')\">수정</button>" : "")
                            + (currentUserId === review.erwriter ? "<button onclick=\"deleteReview('" + review.erno + "')\">삭제</button>" : "")
                        + "</li>"
                    + "</ul>"
                + "</div>";
            
			 reviewsContainer.appendChild(reviewDiv);
            });
            // 더보기 버튼 처리
            const existingMoreButton = document.getElementById('load-more-btn');
            if (existingMoreButton) {
                existingMoreButton.parentElement.removeChild(existingMoreButton);
            }
            if (reviews.length >= pageSize) {
                const seeMoreElement = document.createElement('div');
                seeMoreElement.className = 'more-review-btn';
                seeMoreElement.innerHTML = `<button id='load-more-btn' style='display: block;'>더보기</button>`;
                reviewsContainer.appendChild(seeMoreElement);

                const loadMoreBtn = document.getElementById('load-more-btn');
                if (loadMoreBtn) {
                    loadMoreBtn.onclick = loadMoreReviews;
                }
            }
        }







        function editReview(erno, title, content) {
            document.getElementById('editErno').value = erno;
            document.getElementById('editErtitle').value = title;
            document.getElementById('editErcontent').value = content;
            document.getElementById('editReviewForm').style.display = 'block';
        }
        
        function deleteReview(erno) {
            if (confirm("정말로 이 리뷰를 삭제하시겠습니까?")) {
                fetch(`${contextPath}/vroom/deleteReviewEvent`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        'erno': erno
                    })
                })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        alert("리뷰가 삭제되었습니다.");
                        showDetailView(document.getElementById('eno').value); // 패널 업데이트
                    } else {
                        alert("리뷰 삭제에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('리뷰 삭제 중 오류가 발생했습니다.');
                });
            }
        }

        function toggleReviewForm() {
            const reviewForm = document.getElementById('reviews_wrap');
            const reviewButton = document.getElementById('review-button');
            const writerField = document.getElementById('erwriter');

            if (reviewForm.style.display === 'none') {
                reviewForm.style.display = 'block';
                writerField.value = currentUserId; 
                reviewButton.style.display = 'none';  // 버튼 숨기기
            } else {
                reviewForm.style.display = 'none';
                reviewButton.style.display = 'block'; // 버튼 보이기
                resetReviewForm(); // 폼 필드 초기화
            }
        }


        function goBack() {
            window.location.href = '/vroom/event';  
        }

        document.addEventListener('DOMContentLoaded', function() {
            if (currentEno) {
                showDetailView(currentEno);
            }
        });
        
        function submitReview() {
        	reviewsContainer.innerHTML = '';
            const form = document.getElementById('reviewForm');
            const formData = new FormData(form);

            fetch(`${contextPath}/vroom/eventregisterReview`, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    document.getElementById('reviews_wrap').style.display = 'none'; // 폼 숨기기
                    document.getElementById('review-button').style.display = 'block'; // 버튼 보이기
                    showDetailView(document.getElementById('eno').value); // 패널 업데이트
                    resetReviewForm(); // 폼 필드 초기화
                } else {
                    alert(result.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('리뷰 등록 중 오류가 발생했습니다.');
            });
        }

        
        function resetReviewForm() {
            document.getElementById('reviewForm').reset(); // Clears the form fields
        }

        function loadMoreReviews() {
        	   //fno가 없으면 리턴
        	    if (!currentEno) return;
        	   //전역함수인 page를 하나씩 더해줌. (기존 5개씩 보여줌)
        	    page++;
        	   //서버에 리뷰를 가져오기 위한 요청 보냄
        	    fetch('/api/getEventReviews?eno='+currentEno+'&page='+page+'&pageSize='+pageSize)
        	      //응답상태 확인. 응답이 실패시 에러문구 표시해주는 용도
        	        .then(response => {
        	            if (!response.ok) {
        	                throw new Error('Network response was not ok');
        	            }
        	            //응답이 성공적일 시 json으로 받은걸 가져옴
        	            return response.json();
        	        })
        	        //리뷰 처리
        	        .then(reviews => {
        	           //리뷰 처리 함수 실행(json으로 가져온 reviews를 함수로 넘겨줌)
        	           displayReviews(reviews);

        	        })
        	        //에러 캐치
        	        .catch(error => {
        	            console.error('Error fetching data:', error);
        	            alert('데이터를 가져오는 데 실패했습니다.11');
        	        });

        	}
        
    </script>
</body>
</html>
