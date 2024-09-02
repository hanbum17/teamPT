// 서버에서 이벤트 데이터를 받아오는 함수
function fetchEvents() {
    // 서버의 이벤트 API를 호출하여 데이터를 받아옴
    fetch('/vroom/api/events')
        .then(response => response.json()) // 응답을 JSON 형식으로 파싱
        .then(data => {
            initializeEvents(data); // 데이터를 사용하여 이벤트 초기화
        })
        .catch(error => {
            console.error('Error fetching events:', error); // 에러 발생 시 콘솔에 로그 출력
        });
}

// 이벤트의 상세 정보를 가져오는 함수
function fetchEventDetails(eno) {
    // 특정 이벤트의 상세 정보를 가져오는 API를 호출
    return fetch(`/vroom/api/events/${eno}`)
        .then(response => response.json()) // 응답을 JSON 형식으로 파싱
        .catch(error => {
            console.error('Error fetching event details:', error); // 에러 발생 시 콘솔에 로그 출력
        });
}

// 이벤트의 리뷰를 가져오는 함수
function fetchEventReviews(eno) {
    // 특정 이벤트의 리뷰를 가져오는 API를 호출
    return fetch(`/vroom/api/events/${eno}/reviews`)
        .then(response => response.json()) // 응답을 JSON 형식으로 파싱
        .catch(error => {
            console.error('Error fetching event reviews:', error); // 에러 발생 시 콘솔에 로그 출력
        });
}

// 페이지가 로드될 때 이벤트 데이터 가져오기
document.addEventListener('DOMContentLoaded', () => {
    fetchEvents(); // 페이지 로드 후 이벤트 데이터를 가져옴
});

// 이벤트 데이터를 초기화하는 함수
function initializeEvents(data) {
    console.log('Initializing events with data:', data); // 데이터를 콘솔에 출력

    // 이벤트 데이터를 왼쪽과 오른쪽에 표시할 항목으로 분리
    const leftEvents = data.slice(0, 5);
    const rightEvents = data.slice(5, 10);

    // 기본 이미지 URL
    const defaultImage = '/image/event.jpg';

    // 이벤트를 렌더링하는 함수
    function renderEvents() {
        const leftContainer = document.getElementById('left'); // 왼쪽 컨테이너 요소
        const rightContainer = document.getElementById('right'); // 오른쪽 컨테이너 요소

        leftContainer.innerHTML = ''; // 왼쪽 컨테이너 초기화
        rightContainer.innerHTML = ''; // 오른쪽 컨테이너 초기화

        // 왼쪽 이벤트 항목 렌더링
        leftEvents.forEach(event => {
            const imageUrl = event.img ? event.img : defaultImage; // 이벤트 이미지 또는 기본 이미지 사용
            leftContainer.innerHTML += `
                <div class="box" data-id="${event.eno}">
                    <img src="${imageUrl}" alt="${event.ename}">
                    <div class="text-container">
                        <h3>${event.ename}</h3>
                        <div>위치: ${event.eaddress}</div>
                        <div>기간: ${event.eperiod}</div>
                    </div>
                </div>
            `;
        });

        // 오른쪽 이벤트 항목 렌더링
        rightEvents.forEach(event => {
            const imageUrl = event.img ? event.img : defaultImage; // 이벤트 이미지 또는 기본 이미지 사용
            rightContainer.innerHTML += `
                <div class="box" data-id="${event.eno}">
                    <img src="${imageUrl}" alt="${event.ename}">
                    <div class="text-container">
                        <h3>${event.ename}</h3>
                        <div>위치: ${event.eaddress}</div>
                        <div>기간: ${event.eperiod}</div>
                    </div>
                </div>
            `;
        });
    }

    // 이벤트 세부 정보를 표시하는 함수
    function showDetails(eno) {
        // 상세 정보와 리뷰를 비동기로 가져옴
        Promise.all([
            fetchEventDetails(eno),
            fetchEventReviews(eno)
        ]).then(([event, reviews]) => {
            const leftDetail = document.getElementById('left-detail'); // 왼쪽 상세 보기 요소
            const rightDetail = document.getElementById('right-detail'); // 오른쪽 상세 보기 요소

            // 이벤트 상세 정보 렌더링
            leftDetail.innerHTML = `
                <img src="${event.img || defaultImage}" alt="${event.ename}">
                <h2>${event.ename}</h2>
                <p>위치: ${event.eaddress}</p>
                <p>기간: ${event.eperiod}</p>
                <p>Rating: ${event.erating}</p>
                <p>Comments: <span>${reviews.length}</span></p>
                <button>Favorite</button>
                <p>Description: ${event.econtent}</p>
                <p>Location: ${event.eplace || 'N/A'}</p>
                <p>Operating Hours: N/A</p>
                <p>Phone: N/A</p>
                <p>Parking: N/A</p>
            `;

            // 리뷰 요약과 리스트 렌더링
            rightDetail.innerHTML = `
                <h2>Reviews for ${event.ename}</h2>
                <div id="review-summary"></div>
                <div id="review-list"></div>
            `;

            updateReviewSection(event, reviews); // 리뷰 섹션 업데이트

            // 상세 보기 모드로 전환
            document.getElementById('left').style.display = 'none';
            document.getElementById('right').style.display = 'none';
            document.getElementById('detail-view').style.display = 'flex';
        });
    }

    // 이벤트 목록을 다시 표시하는 함수
    function showEvents() {
        document.getElementById('left').style.display = 'flex'; // 왼쪽 컨테이너 표시
        document.getElementById('right').style.display = 'flex'; // 오른쪽 컨테이너 표시
        document.getElementById('detail-view').style.display = 'none'; // 상세 보기 숨김
    }

    // 클릭 이벤트 핸들러
    function handleClick(e) {
        const box = e.target.closest('.box'); // 클릭한 요소의 가장 가까운 '.box' 클래스 찾기
        if (box) {
            const eno = parseInt(box.dataset.id, 10); // 데이터에서 이벤트 ID 추출
            showDetails(eno); // 이벤트 상세 정보 표시
        }
    }

    // 뒤로 가기 버튼 클릭 이벤트 핸들러
    function handleBackButtonClick() {
        showEvents(); // 이벤트 목록 표시
    }

    // 이벤트 리스너 추가
    document.getElementById('left').addEventListener('click', handleClick);
    document.getElementById('right').addEventListener('click', handleClick);
    document.getElementById('back-button').addEventListener('click', handleBackButtonClick);

    renderEvents(); // 이벤트 렌더링 호출
}

// 리뷰 섹션을 업데이트하는 함수
function updateReviewSection(event, reviews) {
    const rightDetail = document.getElementById('right-detail');
    if (!rightDetail) {
        console.error('Element with id "right-detail" not found.');
        return;
    }

    const ratingValue = document.getElementById('rating-value');
    const starsDisplay = document.getElementById('stars-display');
    const totalReviews = document.getElementById('total-reviews');
    const ratingDistribution = document.getElementById('rating-distribution');
    const reviewList = document.getElementById('review-list');

    if (!ratingValue || !starsDisplay || !totalReviews || !ratingDistribution || !reviewList) {
        console.error('One or more review section elements are missing.');
        return;
    }

    const rating = event.erating || 0;

    // Update rating value
    ratingValue.textContent = rating.toFixed(1);

    // Update stars display
    const stars = starsDisplay.getElementsByClassName('star');
    for (let i = 0; i < stars.length; i++) {
        stars[i].style.color = i < Math.round(rating) ? 'gold' : 'lightgray';
    }

    // Update total reviews count
    totalReviews.textContent = reviews.length;

    // Update rating distribution
    const distribution = [0, 0, 0, 0, 0];
    reviews.forEach(review => {
        if (review.errating >= 1 && review.errating <= 5) {
            distribution[5 - review.errating]++;
        }
    });

    const bars = ratingDistribution.getElementsByClassName('bar');
    distribution.forEach((count, index) => {
        bars[index].style.width = (count * 20) + '%';
    });

    // Update review list
    reviewList.innerHTML = '';
    reviews.forEach(review => {
        reviewList.innerHTML += `
            <div class="review-item">
                <p><strong>${review.erwriter}</strong> - ${review.errating} stars</p>
                <p>${review.ercontent}</p>
                <p><small>${new Date(review.erregDate).toLocaleDateString()}</small></p>
                <hr>
            </div>
        `;
    });

    // Handle review form visibility
    const writeReviewButton = document.getElementById('write-review-button');
    const reviewForm = document.getElementById('review-form');

    if (writeReviewButton && reviewForm) {
        writeReviewButton.addEventListener('click', () => {
            reviewForm.classList.toggle('hidden');
        });

        const submitReviewButton = document.getElementById('submit-review-button');
        if (submitReviewButton) {
            submitReviewButton.addEventListener('click', () => {
                const reviewText = document.getElementById('review-text').value;
                if (reviewText) {
                    console.log('Review submitted:', reviewText);
                    document.getElementById('review-text').value = '';
                    reviewForm.classList.add('hidden');
                }
            });
        }
    } else {
        console.error('Review form elements are missing.');
    }
}


