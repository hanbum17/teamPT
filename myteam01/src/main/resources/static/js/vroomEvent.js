// 서버에서 이벤트 데이터를 받아오는 함수
function fetchEvents() {
    fetch('/vroom/api/events')
        .then(response => response.json())
        .then(data => {
            initializeEvents(data);
        })
        .catch(error => {
            console.error('Error fetching events:', error);
        });
}

// 이벤트의 상세 정보를 가져오는 함수
function fetchEventDetails(eventId) {
    return fetch(`/vroom/api/events/${eventId}`)
        .then(response => response.json())
        .catch(error => {
            console.error('Error fetching event details:', error);
        });
}

// 이벤트의 리뷰를 가져오는 함수
function fetchEventReviews(eventId) {
    return fetch(`/vroom/api/events/${eventId}/reviews`)
        .then(response => response.json())
        .catch(error => {
            console.error('Error fetching event reviews:', error);
        });
}

// 페이지가 로드될 때 이벤트 데이터 가져오기
document.addEventListener('DOMContentLoaded', () => {
    fetchEvents();
});

// 이벤트 데이터를 초기화하는 함수
function initializeEvents(data) {
    console.log('Initializing events with data:', data);

    const leftEvents = data.slice(0, 5);
    const rightEvents = data.slice(5, 10);

    const defaultImage = '/image/event.jpg';

    function renderEvents() {
        const leftContainer = document.getElementById('left');
        const rightContainer = document.getElementById('right');

        leftContainer.innerHTML = '';
        rightContainer.innerHTML = '';

        leftEvents.forEach(event => {
            const imageUrl = event.img ? event.img : defaultImage;
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

        rightEvents.forEach(event => {
            const imageUrl = event.img ? event.img : defaultImage;
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

    function showDetails(eventId) {
        Promise.all([
            fetchEventDetails(eventId),
            fetchEventReviews(eventId)
        ]).then(([event, reviews]) => {
            const leftDetail = document.getElementById('left-detail');
            const rightDetail = document.getElementById('right-detail');

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

            rightDetail.innerHTML = `
                <h2>Reviews for ${event.ename}</h2>
                <div id="review-summary"></div>
                <div id="review-list"></div>
            `;

            updateReviewSection(event, reviews);

            document.getElementById('left').style.display = 'none';
            document.getElementById('right').style.display = 'none';
            document.getElementById('detail-view').style.display = 'flex';
        });
    }

    function showEvents() {
        document.getElementById('left').style.display = 'flex';
        document.getElementById('right').style.display = 'flex';
        document.getElementById('detail-view').style.display = 'none';
    }

    function handleClick(e) {
        const box = e.target.closest('.box');
        if (box) {
            const eventId = parseInt(box.dataset.id, 10);
            showDetails(eventId);
        }
    }

    function handleBackButtonClick() {
        showEvents();
    }

    document.getElementById('left').addEventListener('click', handleClick);
    document.getElementById('right').addEventListener('click', handleClick);
    document.getElementById('back-button').addEventListener('click', handleBackButtonClick);

    renderEvents();
}

function updateReviewSection(event, reviews) {
    const rightDetail = document.getElementById('right-detail');
    const ratingValue = document.getElementById('rating-value');
    const starsDisplay = document.getElementById('stars-display');
    const totalReviews = document.getElementById('total-reviews');
    const ratingDistribution = document.getElementById('rating-distribution');
    const reviewList = document.getElementById('review-list');

    const rating = event.erating || 0;
    ratingValue.textContent = rating.toFixed(1);

    const stars = starsDisplay.getElementsByClassName('star');
    for (let i = 0; i < stars.length; i++) {
        stars[i].style.color = i < Math.round(rating) ? 'gold' : 'lightgray';
    }

    totalReviews.textContent = reviews.length;

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

    const writeReviewButton = document.getElementById('write-review-button');
    const reviewForm = document.getElementById('review-form');

    writeReviewButton.addEventListener('click', () => {
        reviewForm.classList.toggle('hidden');
    });

    const submitReviewButton = document.getElementById('submit-review-button');
    submitReviewButton.addEventListener('click', () => {
        const reviewText = document.getElementById('review-text').value;
        if (reviewText) {
            // Add review submission logic here
            console.log('Review submitted:', reviewText);
            reviewText.value = '';
            reviewForm.classList.add('hidden');
        }
    });
}
