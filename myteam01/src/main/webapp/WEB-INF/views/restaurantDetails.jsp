<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <meta charset="UTF-8">
    <title>Restaurant Details</title>
   <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            background-color: #f7f7f7;
             /* background-image: url('/image/kakaoMAP.jpg'); */
            /* background-size: cover; /* 배경 이미지가 요소의 전체를 덮도록 설정 */
   			/* background-position: center; /* 이미지의 위치를 중앙으로 설정 */
    		/* background-repeat: no-repeat; /* 이미지 반복을 방지 */
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }
#map {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 0; /* 지도를 배경으로 만들기 위해 z-index 설정 */
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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <div style="position: absolute; top: 10px; left: 10px; font-size: 16px;">
        <c:if test="${not empty user}">
            현재 로그인: <strong>${user.userId}</strong>
        </c:if>
    </div>
 <!-- 지도를 표시할 div -->
    <div id="map"></div>
    
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
        <button id="addFavoriteBtn" class="add-fav-btn">즐겨찾기 추가</button>
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
              <input type="text" id="frtitle" name="frtitle" placeholder="제목"><br>
              <textarea id="frcontent" name="frcontent" placeholder="내용"></textarea><br>
              <input type="text" id="frwriter" name="frwriter" placeholder="작성자" readonly><br>
              <input type="text" id="frrating" name="frrating" placeholder="별점 0~5"><br>
              <input type="text" id="fno" name="fno" readonly> <!-- 여기에 fno를 동적으로 설정 -->
              <button id="review_register_btn" type="button" onclick="submitReview()">리뷰등록</button>
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
        const reviewsContainer = document.getElementById('reviews-container');
        const contextPath = "${contextPath}";
        const currentUserId = "${user.userId}"
        const isAdmin = "${isAdmin}";
        let currentFno = new URLSearchParams(window.location.search).get('fno');
        let page = 1;
        const pageSize = 5;

        function submitEditReview() {

           reviewsContainer.innerHTML = '';
            const form = document.getElementById('reviewEditForm');
            const formData = new FormData(form);

            fetch(`${contextPath}/vroom/updateReview`, {
                method: 'POST',
                body: formData
            })
            // 기존 리뷰를 지웁니다.
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    document.getElementById('editReviewForm').style.display = 'none'; // 폼 숨기기
                    showDetailView(document.getElementById('fno').value); // 패널 업데이트
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

            fetch(`${contextPath}/vroom/getRestaurantDetails?fno=` + fno)
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    if (data) {
                        // 왼쪽 패널 설정
                        document.getElementById('panel-image').src = `/images/bibimbab.jpg`;
                        document.getElementById('panel-name').textContent = data.fname;
                        document.getElementById('panel-category').textContent = data.fcategory;
                        document.getElementById('panel-location').textContent = data.faddress;
                        document.getElementById('fno').value = fno;

                        // 패널 표시
                        const restaurantContainer = document.getElementById('restaurant-container');
                        const leftPanel = document.getElementById('left-panel');
                        const rightPanel = document.getElementById('right-panel');

                        if (restaurantContainer) {
                            restaurantContainer.style.display = 'none';
                        }
                        if (leftPanel) {
                            leftPanel.style.display = 'block';
                        }
                        if (rightPanel) {
                            rightPanel.style.display = 'block';
                        }

                        // 리뷰 정보 가져오기
                        return fetch(`${contextPath}/api/getRestaurantReviews?fno=` + fno + '&page=' + page + '&pageSize=' + pageSize);
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
                    alert('데이터를 가져오는 데 실패했습니다.');
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
                document.querySelector('#rating-extra').textContent = "(" + review.frCount + ")";
                // 오른쪽 패널의 리뷰 개수 표시
                document.querySelector('#right-panel #rating-extra').textContent = "(" + review.frCount + ")";

                // 날짜형식 전환
                const formattedDate = review.frregDate.split('T')[0];
                // 동적 HTML 추가
                const reviewDiv = document.createElement('div');
                reviewDiv.className = 'review_div';

                reviewDiv.innerHTML +=
                    "<div class='review_div'>"
                    + "<ul class='review_ul' data-frno="+review.frno+" data-uno="+review.uno+" data-fno="+review.fno+">"
                        + "<li>제목: "+review.frtitle+"</li>"
                        + "<li>내용: "+review.frcontent+"</li>"
                        + "<li>작성자: "+review.frwriter+"</li>"
                        + "<li>등록일: "+formattedDate+"</li>" // 날짜 부분만 출력
                        + "<li>별점: "+review.frrating+"</li>"
                        + "<li>" 
                            + (currentUserId === review.frwriter ? "<button onclick=\"editReview('" + review.frno + "', '" + review.frtitle + "', '" + review.frcontent + "')\">수정</button>" : "")
                            + (currentUserId === review.frwriter ? "<button onclick=\"deleteReview('" + review.frno + "')\">삭제</button>" : "")
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







        function editReview(frno, title, content) {
            document.getElementById('editFrno').value = frno;
            document.getElementById('editFrtitle').value = title;
            document.getElementById('editFrcontent').value = content;
            document.getElementById('editReviewForm').style.display = 'block';
        }
        
        function deleteReview(frno) {
        	reviewsContainer.innerHTML = '';
            if (confirm("정말로 이 리뷰를 삭제하시겠습니까?")) {
                fetch(`${contextPath}/vroom/deleteReview`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        'frno': frno
                    })
                })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        alert("리뷰가 삭제되었습니다.");
                        showDetailView(document.getElementById('fno').value); // 패널 업데이트
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
            const writerField = document.getElementById('frwriter');

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
            window.location.href = '/vroom/restaurant';  
        }

        document.addEventListener('DOMContentLoaded', function() {
            if (currentFno) {
                showDetailView(currentFno);
            }
        });
        
        function submitReview() {

           reviewsContainer.innerHTML = '';
            const form = document.getElementById('reviewForm');
            const formData = new FormData(form);

            fetch(`${contextPath}/vroom/restregisterReview`, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    document.getElementById('reviews_wrap').style.display = 'none'; // 폼 숨기기
                    document.getElementById('review-button').style.display = 'block'; // 버튼 보이기
                    showDetailView(document.getElementById('fno').value); // 패널 업데이트
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
               if (!currentFno) return;
              //전역함수인 page를 하나씩 더해줌. (기존 5개씩 보여줌)
               page++;
              //서버에 리뷰를 가져오기 위한 요청 보냄
               fetch('/api/getRestaurantReviews?fno='+currentFno+'&page='+page+'&pageSize='+pageSize)
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
                       alert('데이터를 가져오는 데 실패했습니다.1');
                   });

           }
        
        
      //-------즐찾
        <c:set var="contextPath" value="${pageContext.request.contextPath }"/>


           document.addEventListener('DOMContentLoaded', function() {
               const addFavoriteBtn = document.getElementById('addFavoriteBtn');

               if (addFavoriteBtn) {
                   addFavoriteBtn.onclick = function() {
                       $.ajax({
                           url: '/user/getFavoriteLists',  // 즐겨찾기 목록을 가져오는 API 엔드포인트
                           method: 'GET',
                           success: function(favoriteLists) {
                               let optionsHtml = '';

                               if (favoriteLists.length === 0) {
                                   optionsHtml = "<option value=''>목록이 없습니다. 새로 추가해주세요.</option>";
                               } else {
                                   favoriteLists.forEach(list => {
                                       // 문자열 연결 방식을 사용하여 <option> 태그를 생성
                                       optionsHtml += "<option value=" + list.listId + ">" + list.listName + "</option>";
                                   });
                               }

                               Swal.fire({
                                   title: '즐겨찾기 목록 선택',
                                   html: 
                                       "<label>즐겨찾기 목록 : </label>" +
                                       "<select id='favoriteListSelect' class='swal2-input'>" +
                                       optionsHtml +
                                       "</select>" +
                                       "<button type='button' id='addNewListBtn' class='swal2-confirm swal2-styled' style='margin-top: 10px;'>새 목록 추가</button>",
                                   showCancelButton: true,
                                   confirmButtonText: '저장',
                                   cancelButtonText: '취소',
                                   preConfirm: () => {
                                       const listId = Swal.getPopup().querySelector('#favoriteListSelect').value;
                                       const pageUrl = window.location.href; // 현재 페이지 URL을 즐겨찾기 링크로 사용
                                       const eno = urlParams.get('eno');
                                       const fno = urlParams.get('fno');
                                       const date = new Date().toISOString().slice(0, 10);

                                       if (!listId) {
                                           Swal.showValidationMessage('목록을 선택해주세요.');
                                       }

                                       return { listId, pageUrl, eno, fno, date };
                                   }
                               }).then((result) => {
                                   if (result.isConfirmed) {
                                       const { listId, pageUrl, eno, fno, date } = result.value;
                                       const form = document.createElement('form');
                                       form.method = 'POST';
                                       form.action = '/user/addFavoriteItem';

                                       form.appendChild(createHiddenInput('listId', listId));
                                       form.appendChild(createHiddenInput('link', pageUrl));
                                       form.appendChild(createHiddenInput('eno', eno || ''));
                                       form.appendChild(createHiddenInput('fno', fno || ''));
                                       form.appendChild(createHiddenInput('createdDate', date));

                                       document.body.appendChild(form);
                                       form.submit();
                                   }
                               });


                               $(document).on('click', '#addNewListBtn', function() {
                                  Swal.fire({
                                      title: '새 즐겨찾기 목록 추가',
                                      html: 
                                          '<input type="text" id="newListName" class="swal2-input" placeholder="목록 이름" required>' +
                                          '<div style="display: flex; flex-direction: column; align-items: center;">' +
                                          '<label for="listColor" style="margin-top: 10px;">목록 색상:</label>' +
                                          '<input type="color" id="listColor" class="swal2-input" style="width: 280px; margin-top: 5px;" value="#007bff">' +
                                          '</div>',
                                      confirmButtonText: '추가',
                                      showCancelButton: true,
                                      preConfirm: () => {
                                          const newListName = Swal.getPopup().querySelector('#newListName').value;
                                          const listColor = Swal.getPopup().querySelector('#listColor').value;

                                          if (!newListName || !listColor) {
                                              Swal.showValidationMessage('목록 이름과 색상을 입력해주세요.');
                                          }

                                          return { newListName, listColor };
                                      }
                                  }).then((result) => {
                                       if (result.isConfirmed) {
                                           const { newListName, listColor } = result.value;

                                           $.ajax({
                                               url: '/user/addFavoriteList',
                                               method: 'POST',
                                               data: {
                                                   listName: newListName,
                                                   listColor: listColor
                                               },
                                               success: function(response) {
                                                   const newOption = "<option value=" + response.listId + ">" + response.listName + "</option>";
                                                   $('#favoriteListSelect').append(newOption).val(response.listId);
                                               },
                                               error: function(error) {
                                                   Swal.fire('오류', '새 목록 추가 중 문제가 발생했습니다.', 'error');
                                               }
                                           });
                                       }
                                   });
                               });
                           },
                           error: function(xhr, status, error) {
                               console.error('Error fetching favorite lists:', xhr.responseText);
                               Swal.fire('오류', '즐겨찾기 목록을 불러오는 중 오류가 발생했습니다.', 'error');
                           }
                       });
                   };
               }
           });

           const urlParams = new URLSearchParams(window.location.search);

           function createHiddenInput(name, value) {
               const input = document.createElement('input');
               input.type = 'hidden';
               input.name = name;
               input.value = value;
               return input;
           }
           
           <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY&libraries=services"></script>
           <script>
               // URL 파라미터에서 lat과 lng 값을 가져옵니다.
               const urlParams = new URLSearchParams(window.location.search);
               let lat = urlParams.get('lat');
               let lng = urlParams.get('lng');

               // 만약 lat과 lng가 없으면 기본값으로 서울의 좌표를 사용합니다.
               if (!lat || !lng) {
                   lat = 37.5665;  // 서울의 위도
                   lng = 126.9780; // 서울의 경도
               }

               // 카카오 지도 초기화
               var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                   mapOption = {
                       center: new kakao.maps.LatLng(lat, lng), // 전달받은 좌표로 중심 설정
                       level: 3 // 확대 레벨
                   };

               var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성

               var markerPosition  = new kakao.maps.LatLng(lat, lng); // 마커 위치를 설정

               // 마커를 생성합니다
               var marker = new kakao.maps.Marker({
                   position: markerPosition
               });

               // 마커를 지도에 표시합니다
               marker.setMap(map);

               console.log(`지도 초기화 완료 - 위도: ${lat}, 경도: ${lng}`);
    </script>
</body>
</html>
