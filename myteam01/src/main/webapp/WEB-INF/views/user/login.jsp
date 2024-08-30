<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?v=1.0">
    <title>Login</title>
    <%@ include file="../user_main/nav.jsp" %>
</head>
<body class="flex-center">
    <div class="container">
        <!-- Photo Area with Slideshow -->
        <div class="photo-area">
            <div id="overlay" class="overlay"></div>
            <img id="slideshow" src="${pageContext.request.contextPath}/resources/img/여행1.jpg" alt="Slideshow Image" class="photo">
        </div>
        <!-- Login Area -->
        <div class="login-container">
            <div class="flex-center logo-wrapper">
                <span class="logo-text">Vroom</span>
            </div>
            <div class="input-wrapper">
                <form action="/login" method="post">
                    <div class="login-wrapper flex-center">
                        <input
                            class="login-input"
                            type="text"
                            id="userId"
                            name="userId"
                            placeholder="사용자 아이디"
                            required />
                    </div>
                    <div class="login-wrapper flex-center">
                        <input
                            class="login-input"
                            type="password"
                            id="password"
                            name="password"
                            placeholder="비밀번호"
                            required />
                    </div>
                    <div class="flex-center button-wrapper">
                        <button class="login-button" type="submit">로그인</button>
                        <div id="loading-spinner" class="loading-spinner" style="display:none;"></div>
                    </div>
                </form>
                <!-- Options below the login button -->
                <div class="options-container flex-center">
                    <div class="login-options">
					    <input type="checkbox" id="remember-me" name="remember-me">
					    <label for="remember-me">로그인 유지</label>
					</div>
                    <div class="signup-wrapper">
                        <!-- 회원가입 버튼 클릭 시 registerSelect.jsp로 이동 -->
                        <form action="${pageContext.request.contextPath}/user/registerSelect" method="get">
                            <button class="signup-link" type="submit">회원가입</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="flex-center findpass">
                <a>비밀번호를 잊으셨나요?</a>
            </div>
        </div>
    </div>

    <script>
	    document.addEventListener("DOMContentLoaded", function() {
	        const userIdInput = document.getElementById("userId");
	        const passwordInput = document.getElementById("password");
	        const loginButton = document.querySelector(".login-button");
	
	        function updateButtonState() {
	            if (userIdInput.value.trim() !== "" && passwordInput.value.trim() !== "") {
	                loginButton.style.backgroundColor = "rgba(0, 162, 255, 1)"; // 진한 파란색
	                loginButton.style.cursor = "pointer"; // 클릭 가능한 커서
	            } else {
	                loginButton.style.backgroundColor = "rgba(0, 162, 255, 0.3)"; // 기존 연한 파란색
	                loginButton.style.cursor = "not-allowed"; // 비활성화된 커서
	            }
	        }
	
	        // 입력 필드 값이 변경될 때마다 버튼 상태 업데이트
	        userIdInput.addEventListener("input", updateButtonState);
	        passwordInput.addEventListener("input", updateButtonState);
	    });
    
        const images = [
            "${pageContext.request.contextPath}/resources/img/여행1.jpg",
            "${pageContext.request.contextPath}/resources/img/여행2.jpg",
            "${pageContext.request.contextPath}/resources/img/여행3.jpg"
        ];
        let currentIndex = 0;
        let slideshow = document.getElementById('slideshow');
        let overlay = document.getElementById('overlay');

        function changeImage() {
            // 화면을 잠시 하얗게 전환
            overlay.style.opacity = 1;
            
            setTimeout(() => {
                slideshow.classList.remove('fade');
                
                // 이미지 전환
                currentIndex = (currentIndex + 1) % images.length;
                slideshow.src = images[currentIndex];
                
                // 이미지가 바뀐 후 페이드 효과와 함께 다시 표시
                slideshow.classList.add('fade');
                overlay.style.opacity = 0;
            }, 400); // 0.4초 후 이미지 변경
        }

        setInterval(changeImage, 6000);
    </script>
</body>
</html>
