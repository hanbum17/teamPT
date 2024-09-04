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
    <div id="reviews-container">

    </div>
</div>

<script>

const contextPath = "${contextPath}";
const currentUserId = "${user.userId}";
const isAdmin = "${isAdmin}";
let currentFno = null;
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
                // 수정된 리뷰가 속한 식당의 패널 업데이트
                showDetailView(document.getElementById('fno').value);
                // 수정 후에도 패널 유지
            } else {
                alert(result.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('리뷰 수정 중 오류가 발생했습니다.');
        });
    }





//___________________________________상세화면 송출___________________________________//
function showDetailView(fno) {
    currentFno = fno;
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
        .then(reviews => {
            displayReviews(reviews);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
              alert(error);
            alert('데이터를 가져오는 데 실패했습니다.2');
        });
}



//___________________________________더보기 클릭시 추가 리뷰 가져오기___________________________________//
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


//___________________________________리뷰 화면___________________________________//
function displayReviews(reviews) {
    const reviewsContainer = document.getElementById('reviews-container');

    // 기존 리뷰가 없을 때는 비워주기
    if (reviewsContainer.innerHTML.trim() === '') {
        reviewsContainer.innerHTML = '';
    }

    if (reviews.length === 0) {
        if (reviewsContainer.innerHTML.trim() === '') {
            reviewsContainer.innerHTML = '<p>리뷰가 없습니다.</p>';
        }
        return; // 리뷰가 없는 경우 더 이상 처리하지 않음
    }

    // 새로 추가된 리뷰를 저장할 배열
    let newReviewsHTML = '';

    reviews.forEach(review => {

        // 왼쪽 패널의 Rating 값을 설정합니다.
        document.getElementById('panel-rating').textContent = review.ratingAverage;
        // 오른쪽 패널의 Rating 값을 설정합니다.
        document.querySelector('#right-panel #panel-rating').textContent =review.ratingAverage;
        // 왼쪽 패널의 리뷰 개수 표시
        document.querySelector('#rating-extra').textContent ="("+review.frCount+")";
        // 오른쪽 패널의 리뷰 개수 표시
        document.querySelector('#right-panel #rating-extra').textContent ="("+review.frCount+")";

        // 날짜형식 전환
        const formattedDate = review.frregDate.split('T')[0];
        // 동적 HTML 추가
        newReviewsHTML +=
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
	});
    // 새로 추가된 리뷰들을 컨테이너에 추가
    reviewsContainer.innerHTML += newReviewsHTML;

    // 기존 더보기 버튼이 있으면 제거
    const existingMoreButton = document.getElementById('load-more-btn');
    if (existingMoreButton) {
        existingMoreButton.parentElement.removeChild(existingMoreButton);
    }

    // 리뷰의 길이가 pageSize보다 크거나 같을 때만 '더보기' 버튼 표시
    if (reviews.length >= pageSize) {
        const seeMoreElement = document.createElement('div');
        seeMoreElement.className = 'more-review-btn';
        seeMoreElement.innerHTML =
            "<button id='load-more-btn' style='display: block;'>더보기</button>";
        reviewsContainer.appendChild(seeMoreElement);

        const loadMoreBtn = document.getElementById('load-more-btn');
        if (loadMoreBtn) {
            loadMoreBtn.onclick = loadMoreReviews;
        }
    }
}



//___________________________________리뷰 입력 화면 나타내기, 숨김___________________________________//
    function toggleReviewForm() {
        const reviewButton = document.getElementById('review-button');
        const reviewsWrap = document.getElementById('reviews_wrap');
        const frwriterField = document.getElementById('frwriter');

        if (reviewsWrap.style.display === 'none' || reviewsWrap.style.display === '') {
            reviewsWrap.style.display = 'block'; // reviews_wrap을 표시
            reviewButton.style.display = 'none'; // 리뷰 입력 버튼 숨기기
            frwriterField.value = currentUserId; // frwriter에 현재 로그인 사용자 ID를 설정
        } else {
            reviewsWrap.style.display = 'none'; // reviews_wrap을 숨김
            reviewButton.style.display = 'block'; // 리뷰 입력 버튼 표시
        }
    }


//___________________________________뒤로가기 버튼___________________________________//
function goBack() {
    const container = document.getElementById('restaurant-container');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    container.style.display = 'block';
    leftPanel.style.display = 'none';
    rightPanel.style.display = 'none';

}

//___________________________________더보기 버튼 클릭시 리뷰추가___________________________________//
document.addEventListener('DOMContentLoaded', () => {
    const loadMoreBtn = document.getElementById('load-more-btn');
    if (loadMoreBtn) {
        loadMoreBtn.addEventListener('click', loadMoreReviews);
    }
});

const container = document.getElementById('restaurant-container');

container.addEventListener('wheel', (event) => {
       event.preventDefault();
       container.scrollLeft += event.deltaY;
   });

function editReview(frno, frtitle, frcontent) {
        // 폼을 표시하고 기존 리뷰 데이터를 폼에 설정
    	 document.getElementById('editFrno').value = frno;
    	 document.getElementById('editFrtitle').value = frtitle;
    	 document.getElementById('editFrcontent').value = frcontent;
    	 document.getElementById('editReviewForm').style.display = 'block'
    }

function deleteReview(frno) {
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
                // 삭제 후 패널 업데이트
                showDetailView(document.getElementById('fno').value);
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





</script>

</body>
</html>