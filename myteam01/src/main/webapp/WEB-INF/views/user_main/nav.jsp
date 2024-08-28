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

</head>
<body>
    <!-- NAVIGATION BAR -->
    <nav class="navbar">
    	<a href="#" class="logo">
    		<img src="${pageContext.request.contextPath}/images/car.png" alt="Car Image" style="height: 25px;">
            VROOM
        </a>
        <ul class="nav-menu">
            <!-- 공지사항 메뉴 -->
            <li class="nav-item">
                <a href="#">공지사항</a>
                <ul class="dropdown">
                    <li><a href="#">공지</a></li>
                    <li><a href="#">이벤트</a></li>
                </ul>
            </li>
            <sec:authorize access="isAuthenticated()">
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
	                            <sec:authorize access="hasAnyRole('ADMIN', 'BUSINESS')">
	                            	<li><a href="#">버스 등록</a></li>
                            	</sec:authorize>
	                        </ul>
	                    </li>
	                    <li><a href="#">렌터카</a>
	                        <ul class="sub-dropdown">
	                            <li><a href="#">렌터카 찾기</a></li>
	                            <sec:authorize access="hasAnyRole('ADMIN', 'BUSINESS')">
	                            	<li><a href="#">렌터카 등록</a></li>
                            	</sec:authorize>
	                        </ul>
	                    </li>
	                </ul>
	            </li>
            </sec:authorize>
            <!-- 고객센터 메뉴 -->
            <li class="nav-item">
                <a href="#">고객센터</a>
                <ul class="dropdown">
                    <li><a href="#">문의</a></li>
                    <li><a href="#">Q&A</a></li>
                    <sec:authorize access="isAuthenticated()">
                    	<li><a href="#">피드백</a></li>
                    </sec:authorize>
                </ul>
            </li>
        </ul>

        <!-- USER SECTION -->
        <div class="nav-right">

            <sec:authorize access="isAuthenticated()">
                <span class="username"><sec:authentication property="name" /></span>
                <a href="${pageContext.request.contextPath}/user/userPage" class="mypage">마이페이지</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout">로그아웃</a>
            </sec:authorize>
            <sec:authorize access="!isAuthenticated()">
                <a href="${pageContext.request.contextPath}/user/login" class="login">로그인</a>
            </sec:authorize>

        </div>
    </nav>
</body>
</html>
