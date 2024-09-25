<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
    prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>

    <%@ include file="../menu/nav.jsp" %>
    <%@ include file="../menu/footer.jsp"%>
    <style>

        
        /* 지도 스타일 추가 */
        .footer { 
        	bottom: -152px;
        }
    </style>
    
    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/userSide.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">  
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="wrapper">
        <!-- 사이드바 박스 -->
        <aside class="sidebar-box">
            <div class="sidebar">
                <h2 class="sidebar-title">마이페이지</h2>
                <ul class="sidebar-menu">
                    <li class="menu-item">
                        <form action="/user/user_detail" method="get">
                            <button type="submit"><i class="fa-solid fa-circle-info"></i> 상세 정보</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_fav" method="get">
                            <button type="submit"><i class="fa-solid fa-bookmark"></i> 즐겨찾기 목록</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_recommend" method="get">
                            <button type="submit"><i class="fa-solid fa-bookmark"></i> 추천 목록</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_trip" method="get">
                            <button type="submit"><i class="fa-regular fa-calendar-days"></i> 여행계획 짜기</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_register" method="get">
                            <button type="submit"><i class="fa-solid fa-house"></i> 행사 및 음식점</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_review" method="get">
                            <button type="submit"><i class="fa-regular fa-newspaper"></i> 등록한 리뷰</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_reservation" method="get">
                            <button type="submit"><i class="fa-solid fa-cart-shopping"></i> 예약 내역</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_pay" method="get">
                            <button type="submit"><i class="fa-solid fa-coins"></i> 결제 내역</button>
                        </form>
                    </li>
                    <li class="menu-item">
                        <form action="/user/user_inquiry" method="get">
                            <button type="submit"><i class="fa-solid fa-comment"></i> 문의 내역</button>
                        </form>
                    </li>
                    <li class="menu-item"><sec:authorize
                            access="hasAnyRole('ROLE_ADMIN', 'ROLE_BUSINESS')">
                            <form action="/user/user_business" method="get">
                                <button type="submit"><i class="fa-regular fa-building"></i> 비지니스 - 등록된 사업 정보</button>
                            </form>
                        </sec:authorize></li>
                    <!-- 회원탈퇴 메뉴 -->
                    <li class="menu-item delete-account">
                        <form id="deleteAccountForm" action="/user/deleteAccount" method="post">
                            <button type="button" id="deleteAccountBtn">회원탈퇴</button>
                        </form>
                    </li>
                </ul>
            </div>
        </aside>


    <script>
        document.getElementById('deleteAccountBtn').addEventListener('click', function () {
            Swal.fire({
                title: '정말로 회원탈퇴를 하시겠습니까?',
                text: "이 작업은 되돌릴 수 없습니다!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, 탈퇴합니다!',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('deleteAccountForm').submit(); // 실제 폼 제출
                }
            });
        });
    </script>