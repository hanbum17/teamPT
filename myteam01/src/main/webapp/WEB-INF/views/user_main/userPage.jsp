<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    
    <%@ include file="nav.jsp" %>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPage.css">
<body>
    <div class="wrapper">
        <!-- 사이드바 박스 -->
        <aside class="sidebar-box">
            <div class="sidebar">
                <h2 class="sidebar-title">마이페이지</h2>
                <ul class="sidebar-menu">
                    <li class="menu-item">
                        <a href="#">개설교과목 조회</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">수업 계획서 조회</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">수강 신청 내역 조회</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">개인 시간표 조회</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">강의 시간표 조회</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">중간강의 평가서 입력</a>
                    </li>
                    <li class="menu-item">
                        <a href="#">최종강의 평가서 입력</a>
                    </li>
                </ul>
            </div>
        </aside>

        <!-- 메인 콘텐츠 박스 -->
        <main class="content-box">
            <div class="content">
                <div class="content-header">
                    <h2>개설교과목 조회</h2>
                </div>
                <div class="content-body">
                    <!-- 예시 내용 -->
                    <p>이 영역에 선택한 메뉴에 대한 정보가 표시됩니다.</p>
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
