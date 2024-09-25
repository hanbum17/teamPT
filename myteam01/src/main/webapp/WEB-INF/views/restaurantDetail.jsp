<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Restaurant Detail</title>
    <style>
        /* 기존 CSS와 같은 스타일 */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            background-color: #f7f7f7;
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
            display: block; /* 기본적으로 보이게 변경 */
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
        #reviews-container {
            max-height: 640px;
            overflow-y: scroll;
            padding: 10px;
            border: 0.5px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0);
        }
        #reviews-container::-webkit-scrollbar {
            width: 0;
            background: transparent;
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
        #editReviewForm {
            display: block; /* 기본적으로 보이게 변경 */
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div id="left-panel" class="panel left-panel">
    <img id="panel-image" src="" alt="Detail Image" style="width: 100%; height: auto; border-radius: 10px; margin-bottom: 20px;">
    <p><strong id="panel-name"></strong></p>
    <p><strong>Rating:</strong> <span id="panel-rating"></span> <span id="rating-extra" class="small-text"></span></p>
    <p><strong>Category:</strong> <span id="panel-category"></span></p>
    <p><strong>Location:</strong> <span id="panel-location"></span></p>
    <button class="back-button" onclick="goBack()">Back</button>
</div>

<div id="right-panel" class="panel right-panel">
    <p><strong>Rating:</strong> <span id="panel-rating"></span> <span id="rating-extra" class="small-text"></span></p>
    <button id="review-button" onclick="toggleReviewForm()" style="display: block; width: 100%; padding: 10px; border: none; border-radius: 5px; background-color: #007bff; color: #fff; cursor: pointer;">리뷰 입력</button>
    <div id="reviews_wrap" style="display: block; margin-top: 20px;">
        <form action="/vroom/restregisterReview" method="post">
            <input type="text" id="frtitle" name="frtitle" placeholder="제목"><br>
            <textarea id="frcontent" name="frcontent" placeholder="내용"></textarea><br>
            <input type="text" id="frwriter" name="frwriter" placeholder="작성자" readonly><br>
            <input type="text" id="frrating" name="frrating" placeholder="별점"><br>
            <input type="hidden" id="fno" name="fno">
            <button type="submit" style="padding: 10px 20px; border: none; border-radius: 5px; background-color: #007bff; color: #fff; cursor: pointer;">리뷰 등록</button>
        </form>
        <div id="reviews-container"></div>
    </div>
    <button class="back-button" onclick="goBack()">Back</button>
</div>

<script>
    function toggleReviewForm() {
        var form = document.getElementById('editReviewForm');
        var display = form.style.display === 'none' ? 'block' : 'none';
        form.style.display = display;
    }
    function goBack() {
        window.history.back();
    }
    document.addEventListener('DOMContentLoaded', function() {
        var urlParams = new URLSearchParams(window.location.search);
        var fno = urlParams.get('fno');
        if (fno) {
            // AJAX를 사용하여 상세 데이터 로드
            fetch(`/restaurantDetailData?fno=${fno}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('panel-image').src = data.image;
                    document.getElementById('panel-name').textContent = data.fname;
                    document.getElementById('panel-category').textContent = data.fcategory;
                    document.getElementById('panel-location').textContent = data.faddress;
                    document.getElementById('fno').value = data.fno;

                    var reviewsContainer = document.getElementById('reviews-container');
                    reviewsContainer.innerHTML = '';
                    data.reviews.forEach(review => {
                        var reviewElement = document.createElement('div');
                        reviewElement.className = 'review';
                        reviewElement.innerHTML = 
                            '<p><strong>' + review.title + '</strong></p>'
                            + '<p>' + review.content + '</p>'
                            + '<p><em>' + review.writer + '</em></p>'
                            + '<p><strong>Rating:</strong>' + review.rating + '</p>' ;
                        reviewsContainer.appendChild(reviewElement);
                    });
                });
        }
    });
</script>
</body>
</html>
