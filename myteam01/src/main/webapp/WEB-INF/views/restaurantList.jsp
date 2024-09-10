<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
             background-image: url('/image/kakaoMAP.jpg');
            background-size: cover; /* 배경 이미지가 요소의 전체를 덮도록 설정 */
   			 background-position: center; /* 이미지의 위치를 중앙으로 설정 */
    		background-repeat: no-repeat; /* 이미지 반복을 방지 */
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }
        
         /* 지도와 컨테이너 스타일 */
        #map {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .container {
            display:  flex;
            overflow-x: auto;
            white-space: nowrap;
            padding: 20px;
            box-sizing: border-box;
            background-color: transparent;
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
	
	.event-search-btn {
	    position: absolute;
	    top: 700px; /* 컨테이너 상단과의 거리 */
	    right: 10px; /* 컨테이너 우측과의 거리 */
	    padding: 10px 20px;
	    background-color: #007bff;
	    color: #fff;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    z-index: 1000; /* 버튼이 다른 요소 위에 표시되도록 설정 */
	}

	.event-search-btn:hover {
    	background-color: #0056b3;
	}
	
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px; /* 패딩을 줄여서 내용이 위로 이동하도록 설정 */
    background-color: transparent; /* 상단 바 배경 제거 */
    color: #ffffff;
    border-bottom: none; /* 흰색 줄 제거 */
    height: 60px; /* 헤더의 높이를 적절히 설정 */
    position: fixed; /* 헤더를 페이지 상단에 고정 */
    width: 100%; /* 헤더가 전체 너비를 차지하도록 설정 */
    top: 0; /* 상단에 위치하도록 설정 */
    left: 0; /* 왼쪽에 위치하도록 설정 */
    z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
}



	.header .logo {
	    font-size: 30px; /* 글자 크기 2/3로 줄임 */
	    font-weight: bold;
	}
	
	.header .nav {
	    font-size: 20px; /* 글자 크기 2/3로 줄임 */
	}
	
	.header .nav a {
	    color: #ffffff;
	    text-decoration: none;
	    margin: 0 15px; /* 글자 사이 간격 조정 */
	}

    </style>
</head>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<div class="header">
    <div class="logo" id="goToMain">Vroom</div>
    <div class="nav">
        <a href="#about">ABOUT US</a>
        <a href="#" id="loginLink">${user != null ? "MYPAGE" : "LOGIN"}</a>
        <a href="/logout" id="logout">${user != null ? "LOGOUT" : ""}</a>
        <a href="#contact">CONTACT US</a>
    </div>
</div>


    <div style="position: absolute; top: 10px; left: 10px; font-size: 16px;">
        <c:if test="${not empty user}">
            현재 로그인: <strong>${user.userId}</strong>
        </c:if>
    </div>


<button class="event-search-btn" id="event-search-btn">행사 조회</button>

    <div class="container" id="restaurant-container">
        <!-- 레스토랑 카드 반복문으로 생성 -->        
        <div class="more-restaurant-card">
	        <c:forEach var="restaurant" items="${restList}">
	            <div class="restaurant-card" data-fno="${restaurant.fno}" onclick="window.location.href='${contextPath}/vroom/restaurant/details?fno=${restaurant.fno}'">
				    <img src="${contextPath}/images/bibimbab.jpg" alt="${restaurant.fname} Image">
				    <div class="restaurant-info">
				        <h3>${restaurant.fname}</h3>
				        <p>Location: ${restaurant.faddress}</p>
				        <p>Rating: ${restaurant.frating}</p>
				    </div>
				</div>
			</c:forEach> 
		</div>
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
    
    <div id="map"></div>

<div class="container" id="restaurant-container">
    <c:forEach var="restaurant" items="${restList}">
        <div class="restaurant-card" data-lat="${restaurant.lat}" data-lng="${restaurant.lng}">
            <img src="${contextPath}/images/${restaurant.attachFileList[0].fileName}" alt="${restaurant.fname} Image">
            <div class="restaurant-info">
                <h3>${restaurant.fname}</h3>
                <p>Location: ${restaurant.faddress}</p>
                <p>Rating: ${restaurant.frating}</p>
            </div>
        </div>
    </c:forEach>
</div>

<script>
$("#goToMain").on("click", function() {
    window.location.href = '${contextPath}/vroom/main';
});

document.getElementById('loginLink').addEventListener('click', function(event) {
    event.preventDefault(); // 링크의 기본 동작을 막습니다

    // 서버에서 `user` 값을 JSP로 전달했다고 가정합니다.
    // `user` 변수가 JSP에서 설정되어 있어야 합니다.
    var user = ${userBoolean}; // JSP에서 전달된 `user` 값

    if (user) {
        // `user` 값이 존재하면 MYPAGE로 이동
        window.location.href = '/user/user_detail';
    } else {
        // `user` 값이 없으면 LOGIN으로 이동
        window.location.href = '/user/login';
    }
});



let isLoading = false;
let restPage = 2; // 전역 변수로 설정
const restPageSize = 10;
const contextPath = "${contextPath}";


//브라우저 시작되고 반응형 스크립트
document.addEventListener('DOMContentLoaded', () => {
	
	
	 const restaurantButton = document.getElementById('event-search-btn');

	    restaurantButton.addEventListener('click', () => {
	        window.location.href = '${contextPath}/vroom/event';
	    });
	
    const container = document.getElementById('restaurant-container'); //추가할 컨테이너

    //레스토랑 추가 데이터 가져오는 스크립트 (드래그 시 10개씩 추가)
    function loadMoreRestaurants() {
        if (isLoading) return; // 중복 요청 방지
        isLoading = true;

        fetch("${contextPath}/api/restaurant?page="+restPage+"&pageSize="+restPageSize)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.length > 0) {
                    appendRestaurants(data);
                    restPage++; // Increment restPage here
                }
                isLoading = false;
            })
            .catch(error => {
                console.error('Error fetching data:', error);
                isLoading = false;
            });
    }
    
    
    	

    
    //레스토랑 리스트 추가
    function appendRestaurants(restaurants) {
    restaurants.forEach(restaurant => {
        const restaurantCard = document.createElement('div');
        restaurantCard.className = 'restaurant-card'; // 스타일 적용
        restaurantCard.dataset.fno = restaurant.fno;
        restaurantCard.onclick = () => {
            window.location.href = contextPath + '/vroom/restaurant/details?fno=' + restaurant.fno;
        };

        restaurantCard.innerHTML = 
            "<img src='" + contextPath + "/images/bibimbab.jpg' alt='" + restaurant.fname + " Image'>" +
            "<div class='restaurant-info'>" +
            "    <h3>" + restaurant.fname + "</h3>" +
            "    <p>Location: " + restaurant.faddress + "</p>" +
            "    <p>Rating: " + restaurant.frating + "</p>" +
            "</div>";

        container.appendChild(restaurantCard);
    });
}



    container.addEventListener('scroll', () => {
        if (container.scrollWidth - container.scrollLeft <= container.clientWidth + 50) {
            // Load more data when scrolling close to the end
            loadMoreRestaurants();
        }
    });

    container.addEventListener('wheel', (event) => {
        event.preventDefault();
        container.scrollLeft += event.deltaY;
    });

    // Initial data load
    loadMoreRestaurants();

    /* const loadMoreBtn = document.getElementById('load-more-btn');
    if (loadMoreBtn) {
        loadMoreBtn.addEventListener('click', loadMoreReviews);
    } */
});




</script>
</body>
</html>
