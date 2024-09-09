<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- SweetAlert2와 jQuery CDN 추가 -->


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

		
        
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
let currentFno = null;
let page = 1;
const pageSize = 5;

//___________________________________상세화면 송출___________________________________//
function showDetailView(fno) {
    currentFno = fno;
    page = 1; // 페이지 초기화

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

                document.getElementById('restaurant-container').style.display = 'none';
                document.getElementById('left-panel').style.display = 'block';
                document.getElementById('right-panel').style.display = 'block';

                // 리뷰 정보 가져오기
                return fetch('${contextPath}/api/getRestaurantReviews?fno=' + fno + '&page='+page+'&pageSize='+pageSize);
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
    fetch('${contextPath}/api/getRestaurantReviews?fno='+currentFno+'&page='+page+'&pageSize='+pageSize)
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
    const reviewWrap = document.getElementById('reviews_wrap');
    reviewWrap.style.display = (reviewWrap.style.display === 'none' || reviewWrap.style.display === '') ? 'block' : 'none';
}

//___________________________________뒤로가기 버튼___________________________________//
function goBack() {
    const container = document.getElementById('restaurant-container');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    container.style.display = 'block';
    leftPanel.style.display = 'none';
    rightPanel.style.display = 'none';
    minSize = 0;
    maxSize = 5;
}

//___________________________________더보기 버튼 클릭시 리뷰추가___________________________________//
document.addEventListener('DOMContentLoaded', () => {
    const loadMoreBtn = document.getElementById('load-more-btn');
    if (loadMoreBtn) {
        loadMoreBtn.addEventListener('click', loadMoreReviews);
    }
});
    
//...................즐찾....................................................//
document.addEventListener('DOMContentLoaded', function() {
    // 즐겨찾기 버튼이 로드되었는지 콘솔에서 확인
    console.log('DOM fully loaded and parsed');
    
    // jQuery 및 SweetAlert이 로드되었는지 확인
    console.log('jQuery version:', $.fn.jquery);
    console.log('SweetAlert2 loaded:', typeof Swal !== 'undefined');

    // ID가 정확한지 확인하고 이벤트 리스너 추가
    const addFavoriteBtn = document.getElementById('addFavoriteBtn');
    
    if (addFavoriteBtn) {  // 버튼이 존재할 경우에만 이벤트 추가
        console.log('addFavoriteBtn found, adding click event.');
        
        addFavoriteBtn.onclick = function() {
            // 즐겨찾기 목록을 불러오기 위한 Ajax 호출
            $.ajax({
                url: '/user/getFavoriteLists', // 사용자 즐겨찾기 목록을 불러오는 API 엔드포인트
                method: 'GET',
                success: function(favoriteLists) {
                    let optionsHtml = '';

                    // 즐겨찾기 목록을 option으로 구성
                    favoriteLists.forEach(list => {
                        optionsHtml += `<option value="${list.listId}">${list.listName}</option>`;
                    });

                    Swal.fire({
                        title: '즐겨찾기 목록 선택',
                        html: `
                            <label>즐겨찾기 목록:</label>
                            <select id="favoriteListSelect" class="swal2-input">
                                ${optionsHtml}
                            </select>
                            <input type="text" id="itemName" class="swal2-input" placeholder="항목 이름" required>
                            <button type="button" id="addNewListBtn" class="swal2-confirm swal2-styled" style="margin-top: 10px;">새 목록 추가</button>
                        `,
                        showCancelButton: true,
                        confirmButtonText: '저장',
                        cancelButtonText: '취소',
                        preConfirm: () => {
                            const listId = Swal.getPopup().querySelector('#favoriteListSelect').value;
                            const itemName = Swal.getPopup().querySelector('#itemName').value;
                            const pageUrl = window.location.href; // 현재 페이지 URL
                            const eno = urlParams.get('eno'); // URL에서 eno 추출
                            const fno = urlParams.get('fno'); // URL에서 fno 추출
                            const date = new Date().toISOString().slice(0, 10); // 오늘 날짜

                            if (!itemName || !listId) {
                                Swal.showValidationMessage('모든 필드를 입력해주세요.');
                            }

                            return { listId, itemName, pageUrl, eno, fno, date };
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // 서버로 전송하기 위한 POST 요청 생성
                            const { listId, itemName, pageUrl, eno, fno, date } = result.value;
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '/user/addFavoriteItem'; // 서버로 전송할 URL

                            const inputListId = document.createElement('input');
                            inputListId.type = 'hidden';
                            inputListId.name = 'listId';
                            inputListId.value = listId;

                            const inputItemName = document.createElement('input');
                            inputItemName.type = 'hidden';
                            inputItemName.name = 'itemName';
                            inputItemName.value = itemName;

                            const inputLink = document.createElement('input');
                            inputLink.type = 'hidden';
                            inputLink.name = 'link';
                            inputLink.value = pageUrl;

                            const inputEno = document.createElement('input');
                            inputEno.type = 'hidden';
                            inputEno.name = 'eno';
                            inputEno.value = eno || ''; // 행사 ID가 있으면 사용, 없으면 빈 문자열

                            const inputFno = document.createElement('input');
                            inputFno.type = 'hidden';
                            inputFno.name = 'fno';
                            inputFno.value = fno || ''; // 음식점 ID가 있으면 사용, 없으면 빈 문자열

                            const inputDate = document.createElement('input');
                            inputDate.type = 'hidden';
                            inputDate.name = 'createdDate';
                            inputDate.value = date;

                            form.appendChild(inputListId);
                            form.appendChild(inputItemName);
                            form.appendChild(inputLink);
                            form.appendChild(inputEno);
                            form.appendChild(inputFno);
                            form.appendChild(inputDate);

                            document.body.appendChild(form);
                            form.submit();
                        }
                    });

                    // **새 목록 추가 버튼**의 이벤트 리스너는 모달 내에서 별도로 다시 바인딩해야 함
                    $(document).on('click', '#addNewListBtn', function() {
                        Swal.fire({
                            title: '새 즐겨찾기 목록 추가',
                            html: `<input type="text" id="newListName" class="swal2-input" placeholder="목록 이름">`,
                            confirmButtonText: '추가',
                            showCancelButton: true,
                            preConfirm: () => {
                                const newListName = Swal.getPopup().querySelector('#newListName').value;
                                if (!newListName) {
                                    Swal.showValidationMessage('목록 이름을 입력해주세요.');
                                }
                                return { newListName };
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // 새로운 목록 추가 요청을 서버에 보냄
                                $.ajax({
                                    url: '/user/addFavoriteList',
                                    method: 'POST',
                                    data: { listName: result.value.newListName },
                                    success: function(response) {
                                        // 추가된 목록을 선택 가능한 목록에 추가
                                        const newOption = `<option value="${response.listId}">${response.listName}</option>`;
                                        $('#favoriteListSelect').append(newOption).val(response.listId);
                                    }
                                });
                            }
                        });
                    });
                }
            });
        };
    } else {
        console.log('addFavoriteBtn not found');
    }
});

// URL에서 query parameter 추출
const urlParams = new URLSearchParams(window.location.search);
</script>
</body>
</html>