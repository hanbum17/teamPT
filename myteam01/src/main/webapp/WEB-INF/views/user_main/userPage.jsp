<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    
    <%@ include file="nav.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPage.css">
</head>
<body>
    <div class="wrapper">
        <!-- 사이드바 박스 -->
        <aside class="sidebar-box">
            <div class="sidebar">
                <h2 class="sidebar-title">마이페이지</h2>
                <ul class="sidebar-menu">
                    <li class="menu-item">
                        <a href="#">상세 정보</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">즐겨찾기 목록</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">여행계획 세우기</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">등록한 행사 및 음식점</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">등록한 리뷰 내역</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">예약 내역</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">결제 내역</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">문의 내역</a>
                    </li>
                    <li class="menu-item">
					    <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_BUSINESS')">
					        <a href="#">비지니스 - 등록된 사업 정보</a>
					    </sec:authorize>
					</li>
                    <!-- 회원탈퇴 메뉴 -->
                    <li class="menu-item delete-account">
                        <a href="#">회원탈퇴</a>
                    </li>
                </ul>
            </div>
        </aside>

        <!-- 메인 콘텐츠 박스 -->
        <main class="content-box">
            <div class="content">
                <div class="content-header">
                    <h2>상세정보</h2>
                </div>
                <div class="content-body">
                    <!-- 예시 내용 -->
                    <p>이 영역에 선택한 메뉴에 대한 정보가 표시됩니다.</p>
                    <p>환영합니다, <sec:authentication property="name" /> 님!</p>
                </div>
            </div>
        </main>
    </div>
</body>


<script>
	$(".myChat").on("click", function(){
		alert("하기싫다.");
	});
</script>


</html>
