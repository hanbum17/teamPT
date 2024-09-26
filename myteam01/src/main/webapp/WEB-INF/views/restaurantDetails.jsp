
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
      body, html {
           margin: 0;
           padding: 0;
           height: 100%;
           width: 100%;
           overflow: hidden; /* 스크롤바가 안 나타나도록 설정 */
       }
   
       #map {
          position: fixed; /* position을 fixed로 변경 */
          top: 0;
          left: 0;
          width: 100%;
          height: 100%; /* 전체 화면을 차지하도록 설정 */
          z-index: 0;
      }

    .panel {
        position: absolute;
        top: 50px;
        width: 28%;
        height: calc(100vh - 100px); /* 패널 높이 */
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        background-color: #fff;
        padding: 20px;
        box-sizing: border-box;
        display: block; /* 패널이 보이도록 설정 */
        z-index: 10; /* 지도 위에 오도록 설정 */
        overflow: hidden;
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
        overflow-y: auto;
    }

    .panel h2 {
        margin-bottom: 20px;
    }

    .panel p {
        margin-bottom: 10px;
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
        font-size: 0.8em;
        color: #555;
        margin-left: 5px;
    }

    #reviews-container {
        max-height: calc(100vh - 250px);
        overflow-y: auto;
        padding: 10px;
        border: 0.5px solid #ddd;
        border-radius: 10px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    #reviews-container::-webkit-scrollbar {
        width: 0;
        background: transparent;
    }

    .load-more-btn {
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
        margin-top: 20px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 10px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .review_ul {
        list-style-type: none;
        padding: 0;
    }
</style>

</head>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe9306b4adbbf3249d28d6b7a2c37c0a&libraries=services"></script>
   <div id="map" style="width: 100%; height: 100vh;"></div>

    <div style="position: absolute; top: 10px; left: 10px; font-size: 16px;">
        <c:if test="${not empty user}">
            현재 로그인: <strong>${user.userId}</strong>
        </c:if>
    </div>
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
    <div class="panel right-panel" id="right-panel">
        <p>
            <strong>Rating:</strong>
            <span id="panel-rating"></span>
            <span id="rating-extra" class="small-text"></span>
        </p>
        <button id="review-button" onclick="toggleReviewForm()" style="display: block; width: 100%; padding: 10px; border: none; border-radius: 5px; background-color: #007bff; color: #fff; cursor: pointer;">
            리뷰 입력
        </button>
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
        <div id="editReviewForm" style="display:none;">
            <form id="reviewEditForm" action="${contextPath}/vroom/updateReview" method="post">
                <input type="hidden" id="editFrno" name="frno">
                <input type="text" id="editFrtitle" name="frtitle" placeholder="제목"><br>
                <textarea id="editFrcontent" name="frcontent" placeholder="내용"></textarea><br>
                <button type="button" onclick="submitEditReview()">수정 완료</button>
            </form>
        </div>
        <div id="reviews-container"></div>
    </div>

    <script>
       /* const urlParams = new URLSearchParams(window.location.search);
       const lat = parseFloat(urlParams.get('lat'));
       const lng = parseFloat(urlParams.get('lng')); */
       
       var mapContainer = document.getElementById('map'), // 지도를 표시할 div
          mapOption = {
              center: new kakao.maps.LatLng(37.566826004661, 126.978652258309), // 기본 중심 좌표 (서울시청)
              level: 3 // 지도 확대 레벨
          };
   
      var map = new kakao.maps.Map(mapContainer, mapOption);
   
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
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    document.getElementById('editReviewForm').style.display = 'none';
                    showDetailView(document.getElementById('fno').value); 
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
                        document.getElementById('panel-image').src = `/images/bibimbab.jpg`;
                        document.getElementById('panel-name').textContent = data.fname;
                        document.getElementById('panel-category').textContent = data.fcategory;
                        document.getElementById('panel-location').textContent = data.faddress;
                        document.getElementById('fno').value = fno;
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
            let newReviewsHTML = '';
            if (reviews.length === 0) {
                if (reviewsContainer.childElementCount === 0) {
                    reviewsContainer.innerHTML = '<p>리뷰가 없습니다.</p>';
                }
                return;
            }

            reviews.forEach(review => {
                document.getElementById('panel-rating').textContent = review.ratingAverage;
                document.querySelector('#right-panel #panel-rating').textContent = review.ratingAverage;
                document.querySelector('#rating-extra').textContent = "(" + review.frCount + ")";
                document.querySelector('#right-panel #rating-extra').textContent = "(" + review.frCount + ")";

                const formattedDate = review.frregDate.split('T')[0];
                const reviewDiv = document.createElement('div');
                reviewDiv.className = 'review_div';

                reviewDiv.innerHTML +=
                    "<div class='review_div'>"
                    + "<ul class='review_ul' data-frno="+review.frno+" data-uno="+review.uno+" data-fno="+review.fno+">"
                        + "<li>제목: "+review.frtitle+"</li>"
                        + "<li>내용: "+review.frcontent+"</li>"
                        + "<li>작성자: "+review.frwriter+"</li>"
                        + "<li>등록일: "+formattedDate+"</li>" 
                        + "<li>별점: "+review.frrating+"</li>"
                        + "<li>" 
                            + (currentUserId === review.frwriter ? "<button onclick=\"editReview('" + review.frno + "', '" + review.frtitle + "', '" + review.frcontent + "')\">수정</button>" : "")
                            + (currentUserId === review.frwriter ? "<button onclick=\"deleteReview('" + review.frno + "')\">삭제</button>" : "")
                        + "</li>"
                    + "</ul>"
                + "</div>";
          reviewsContainer.appendChild(reviewDiv);
            });
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
                reviewButton.style.display = 'none';  
            } else {
                reviewForm.style.display = 'none';
                reviewButton.style.display = 'block'; 
                resetReviewForm(); 
            }
        }
        function goBack() {
            const urlParams = new URLSearchParams(window.location.search);
            const guName = urlParams.get('guName');
            const lat = parseFloat(urlParams.get('lat'));
            const lng = parseFloat(urlParams.get('lng'));
            
            const mapContainer = document.getElementById('map');
            const mapOption = {
                center: new kakao.maps.LatLng(lat, lng), // 전달받은 좌표로 설정
                level: 3
            };
            
            const map = new kakao.maps.Map(mapContainer, mapOption);

         // 마커 추가
            const marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(lat, lng),
                map: map
             
            });

            if (guName) {
                window.location.href = `${contextPath}/vroom/restaurant?guName=${guName}`;
            } else {
                window.location.href = `${contextPath}/vroom/restaurant`; 
            }
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
                    document.getElementById('reviews_wrap').style.display = 'none'; 
                    document.getElementById('review-button').style.display = 'block'; 
                    showDetailView(document.getElementById('fno').value); 
                    resetReviewForm(); 
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
            document.getElementById('reviewForm').reset(); 
        }

        function loadMoreReviews() {
               if (!currentFno) return;
               page++;
               fetch('/api/getRestaurantReviews?fno='+currentFno+'&page='+page+'&pageSize='+pageSize)
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
    </script>
</body>
</html>
