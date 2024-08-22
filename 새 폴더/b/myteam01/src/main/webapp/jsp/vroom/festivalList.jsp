<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Festival List</title>
<link rel="stylesheet" type="text/css" href="/css/vroomMain.css"> <!-- CSS 파일 링크 -->

</head>
<body>
    <div class="header">
        <div class="logo">Vroom</div>
        <div class="nav">
            <a href="#about">ABOUT US</a>
            <a href="#login">LOGIN</a>
            <a href="#contact">CONTACT US</a>
        </div>
    </div>

    <div class="container">
        <div class="left-column">
            <!-- 왼쪽 열 상자들 -->
        </div>
        <div class="right-column">
            <!-- 오른쪽 열 상자들 -->
        </div>
    </div>

    <div class="additional-boxes">
        <!-- 추가 상자들 -->
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const leftColumn = document.querySelector('.left-column');
            const rightColumn = document.querySelector('.right-column');
            const additionalBoxes = document.querySelector('.additional-boxes');

            // 행사 데이터 생성
			const events = [];
			for (let i = 1; i <= 10; i++) {
    			events.push(`행사`+i);
			}
			console.log(events);
            // 현재 표시할 행사 인덱스
            let currentIndex = 0;
            const visibleCount = 6;

            // 상자 생성 함수
            function createBox(event) {
                const box = document.createElement('div');
                box.className = 'box draggable';
                box.innerText = event; // 박스에 행사 정보 추가
                return box;
            }

            // 박스 배치 함수
            function placeBoxes() {
                leftColumn.innerHTML = '';
                rightColumn.innerHTML = '';

                const visibleEvents = events.slice(currentIndex, currentIndex + visibleCount);
                visibleEvents.forEach((event, index) => {
                    const box = createBox(event);
                    if (index < 3) {
                        leftColumn.appendChild(box);
                    } else {
                        rightColumn.appendChild(box);
                    }
                });

                // 추가 상자 영역에 나머지 상자 추가
                additionalBoxes.innerHTML = '';
                for (let i = 6; i < events.length; i++) {
                    const box = createBox(events[i]);
                    additionalBoxes.appendChild(box);
                }
            }

            // 드래그를 통한 추가 상자 표시
            function setupDrag() {
                let dragging = false;
                let startX, startIndex;

                document.addEventListener('mousedown', (e) => {
                    if (e.target.classList.contains('draggable')) {
                        dragging = true;
                        startX = e.pageX;
                        startIndex = currentIndex;
                    }
                });

                document.addEventListener('mouseup', (e) => {
                    if (dragging) {
                        dragging = false;
                        const diff = e.pageX - startX;
                        const direction = diff > 0 ? 1 : -1;
                        currentIndex = Math.max(0, Math.min(events.length - visibleCount, startIndex + direction * 1));
                        placeBoxes();
                    }
                });

                document.addEventListener('mousemove', (e) => {
                    if (dragging) {
                        // 현재 드래그 상태에서의 추가적인 처리가 필요할 경우 여기에 추가
                    }
                });
            }

            placeBoxes();
            setupDrag();
        });
    </script>
</body>
</html>
