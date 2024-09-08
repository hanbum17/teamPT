<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>event List</title>
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

    <div class="container" id="event-container">
        <!-- 레스토랑 카드 반복문으로 생성 -->
        
        <div class="more-event-card">
	        <c:forEach var="event" items="${eventList}">
	            <div class="event-card" data-eno="${event.eno}" onclick="window.location.href='${contextPath}/vroom/event/details?eno=${event.eno}'">
				    <img src="${contextPath}/images/event.jpg" alt="${event.ename} Image">
				    <div class="event-info">
				        <h3>${event.ename}</h3>
				        <p>Location: ${event.eaddress}</p>
				        <p>Rating: ${event.erating}</p>
				    </div>
				</div>
			</c:forEach> 
		</div>
        <!-- 데이터가 없는 경우 표시할 카드 -->
        <c:if test="${empty eventList}">
            <div class="event-card">
                <img src="${contextPath}/images/event.jpg" alt="No Data Image">
                <div class="event-info">
                    <h3>No events Available</h3>
                    <p>Location: N/A</p>
                    <p>Rating: N/A</p>
                </div>
            </div>
        </c:if>
    </div>
</body>
<script>
let isLoading = false;
let restPage = 2; // 전역 변수로 설정
const restPageSize = 10;
const contextPath = "${contextPath}";


//브라우저 시작되고 반응형 스크립트
document.addEventListener('DOMContentLoaded', () => {
	
    const container = document.getElementById('event-container'); //추가할 컨테이너

    //레스토랑 추가 데이터 가져오는 스크립트 (드래그 시 10개씩 추가)
    function loadMoreEvents() {
        if (isLoading) return; // 중복 요청 방지
        isLoading = true;

        fetch("${contextPath}/api/event?page="+restPage+"&pageSize="+restPageSize)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.length > 0) {
                    appendevents(data);
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
    function appendevents(events) {
    events.forEach(event => {
        const eventCard = document.createElement('div');
        eventCard.className = 'event-card'; // 스타일 적용
        eventCard.dataset.eno = event.eno;
        eventCard.onclick = () => {
            window.location.href = contextPath + '/vroom/event/details?eno=' + event.eno;
        };

        eventCard.innerHTML = 
            "<img src='" + contextPath + "/images/event.jpg' alt='" + event.ename + " Image'>" +
            "<div class='event-info'>" +
            "    <h3>" + event.ename + "</h3>" +
            "    <p>Location: " + event.eaddress + "</p>" +
            "    <p>Rating: " + event.erating + "</p>" +
            "</div>";

        container.appendChild(eventCard);
    });
}



    container.addEventListener('scroll', () => {
        if (container.scrollWidth - container.scrollLeft <= container.clientWidth + 50) {
            // Load more data when scrolling close to the end
            loadMoreEvents();
        }
    });

    container.addEventListener('wheel', (event) => {
        event.preventDefault();
        container.scrollLeft += event.deltaY;
    });

    // Initial data load
    loadMoreEvents();

    /* const loadMoreBtn = document.getElementById('load-more-btn');
    if (loadMoreBtn) {
        loadMoreBtn.addEventListener('click', loadMoreReviews);
    } */
});




</script>
</html>
