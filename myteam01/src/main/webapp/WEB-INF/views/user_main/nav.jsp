<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VROOM Navigation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nav.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <!-- NAVIGATION BAR -->
    <nav class="navbar">
        <a href="#" class="logo">VROOM</a>
        <ul class="nav-menu">
            <!-- 공지사항 메뉴 -->
            <li class="nav-item">
                <a href="#">공지사항</a>
                <ul class="dropdown">
                    <li><a href="#">공지</a></li>
                    <li><a href="#">이벤트</a></li>
                </ul>
            </li>
            <!-- 여행 메뉴 -->
            <li class="nav-item">
                <a href="#">여행</a>
                <ul class="dropdown">
                    <li><a href="#">행사찾기</a></li>
                    <li><a href="#">행사등록</a></li>
                </ul>
            </li>
            <!-- 운행 메뉴 -->
            <li class="nav-item">
                <a href="#">운행</a>
                <ul class="dropdown">
                    <li><a href="#">버스</a>
                        <ul class="sub-dropdown">
                            <li><a href="#">버스 신청</a></li>
                            <li><a href="#">버스 등록</a></li>
                        </ul>
                    </li>
                    <li><a href="#">렌터카</a>
                        <ul class="sub-dropdown">
                            <li><a href="#">렌터카 찾기</a></li>
                            <li><a href="#">렌터카 등록</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
            <!-- 고객센터 메뉴 -->
            <li class="nav-item">
                <a href="#">고객센터</a>
                <ul class="dropdown">
                    <li><a href="#">문의</a></li>
                    <li><a href="#">Q&A</a></li>
                    <li><a href="#">피드백</a></li>
                </ul>
            </li>
        </ul>

        <!-- USER SECTION -->
        <div class="nav-right">
            <span class="username">유저이름</span>
            <a href="/chat/chatPage" class="myChat">나의 채팅방</a>
            <a href="#" class="mypage">마이페이지</a>
            <a href="#" class="login">로그인</a>
            <a href="#" class="logout">로그아웃</a>
        </div>
    </nav>
</body>
</html>
