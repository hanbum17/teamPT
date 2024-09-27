<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VROOM Navigation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nav.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <!-- NAVIGATION BAR -->
    <nav class="navbar">
    
    	<!-- ADMIN 권한-->
        <sec:authorize access="hasRole('ADMIN')">
            <a href="${pageContext.request.contextPath}/admin/main" class="logo">
	    		<img src="${pageContext.request.contextPath}/images/car.png" alt="Car Image" style="height: 25px;">
	            VROOM_ADMIN
	        </a>
        </sec:authorize>
        <!-- 일반 유저 -->
        <sec:authorize access="!hasRole('ADMIN')">
            <a href="${pageContext.request.contextPath}/vroom/main" class="logo">
	    		<img src="${pageContext.request.contextPath}/images/car.png" alt="Car Image" style="height: 25px;">
	            VROOM
	        </a>
        </sec:authorize>
        
    	
        <ul class="nav-menu">
            <!-- 공지사항 메뉴 -->
            <li class="nav-item">
                <a href="/cs/Center?type=notice">공지사항</a>
                <ul class="dropdown">
                    <li><a href="/cs/Center?type=notice">공지</a></li>
                    <li><a href="/cs/Center?type=event">이벤트</a></li>
                </ul>
            </li>
            <sec:authorize access="hasAnyRole('ADMIN')">
            	<li class="nav-item">
	                <a href="/list">글관리</a>
	            </li>
				<li class="nav-item">
	                <a href="/admin/manage/adminUserManage">사용자관리</a>
	            </li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
	            <!-- 여행 메뉴 -->
	            <li class="nav-item">
	                <a href="#">등록</a>
	                <ul class="dropdown">
	                    <li><a href="/event/register">행사</a></li>
	                    <li><a href="/restaurant/rest_register">음식점</a></li>
	                </ul>
	            </li>
            </sec:authorize>
        </ul>

        <!-- USER SECTION -->
        <div class="nav-right">
		    <sec:authorize access="isAuthenticated()">
		        <a id="chat_room" href="#">단체채팅방</a>
		        <span class="username"><sec:authentication property="name" /></span>
		        
		        <!-- ADMIN 권한이 있는 경우 어드민 페이지로 이동 -->
		        <sec:authorize access="hasRole('ADMIN')">
		            <a href="${pageContext.request.contextPath}/admin/main" class="adminpage">어드민페이지</a>
		        </sec:authorize>
		        
		        <!-- 일반 유저인 경우 마이페이지로 이동 -->
		        <sec:authorize access="!hasRole('ADMIN')">
		            <a href="${pageContext.request.contextPath}/user/main" class="mypage">마이페이지</a>
		        </sec:authorize>
		        
		        <a href="${pageContext.request.contextPath}/logout" class="logout">로그아웃</a>
		    </sec:authorize>
		
		    <sec:authorize access="!isAuthenticated()">
		        <a href="${pageContext.request.contextPath}/user/login" class="login">로그인</a>
		    </sec:authorize>
		</div>
    </nav>

    <script>
	$("#chat_room").on("click", function(){
		window.open("http://195.168.9.110:8080/chat/chat", "_blank", "width=500, height=500");
	});

    // 관리자 로그인 시 배경을 변경
    <sec:authorize access="hasRole('ADMIN')">
        $('html, body, .navbar').addClass('admin-mode');
    </sec:authorize>
	</script>
</body>
</html>
