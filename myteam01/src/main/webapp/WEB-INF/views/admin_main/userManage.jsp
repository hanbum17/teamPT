<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../menu/nav.jsp"%>
<%@ include file="../menu/footer.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f5f5;
    width: 100%;
    color: #333;
    background: linear-gradient(120deg, #84fab0, #8fd3f4);
}

.container {
    display: flex;
    justify-content: space-between;
}


 .user-detail-container {
    width: 45%;
    height: 70vh; /* 화면 높이의 70% 차지 */
    min-height: 300px; /* 최소 높이 설정 */
    min-width: 200px; /* 최소 너비 설정 */
    overflow-y: auto; /* 세로 스크롤 추가 */
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px; /* 모서리 둥글게 */
    background-color: #ffffff; /* 흰색 배경 */
}
.user-list-container {
    width: 45%;
    height: 70vh; /* 화면 높이의 70% 차지 */
    min-height: 300px; /* 최소 높이 설정 */
    min-width: 200px; /* 최소 너비 설정 */
    overflow-y: auto; /* 세로 스크롤 추가 */
    /* border: 1px solid #ccc; /* 테두리 추가 */ 
    border-radius: 5px; /* 모서리 둥글게 */
    background-color: #ffffff; /* 흰색 배경 */
    padding: 0; /* 내부 여백 제거 */
    margin: 0; /* 여백 제거 */
}

/* 스크롤 바 스타일 */
.user-list-container::-webkit-scrollbar {
    width: 4px; /* 스크롤 바의 너비 */
    height: 4px;
}

.user-list-container::-webkit-scrollbar-track {
    background: #f1f1f1; /* 스크롤 바 트랙 배경색 */
    border-radius: 10px; /* 모서리 둥글게 */
}

.user-list-container::-webkit-scrollbar-thumb {
    background: #888; /* 스크롤 바의 색상 */
    border-radius: 10px; /* 모서리 둥글게 */
}

.user-list-container::-webkit-scrollbar-thumb:hover {
    background: #555; /* 스크롤 바에 마우스를 올렸을 때의 색상 */
}


.user-table {
    width: 100%;
    border-collapse: collapse; /* 셀 간의 여백 제거 */
}

.user-table th, .user-table td {
    padding: 10px; /* 셀 내부 여백 */
    border: 1px solid #ccc; /* 셀 테두리 */
    text-align: center;
}

.board {
    width: 100%;
    margin-top: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    background-color: #f9f9f9;
}

.board h2 {
    border-bottom: 2px solid #ddd;
    padding-bottom: 10px;
}

.board table {
    width: 100%;
    border-collapse: collapse;
}

.board th, .board td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: left;
}

.board th {
    background-color: #e9e9e9;
}

.content-box {
    background-color: #ffffff;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 20px;
    margin: 100px auto;
    width: 80%;
}
.user-detail-card {
    background-color: #ffffff; /* 카드 배경색 */
    /* border: 1px solid #ccc; /* 카드 테두리 */
    border-radius: 10px; /* 모서리 둥글게 */
    padding: 20px; /* 내부 여백 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    margin-bottom: 20px; /* 카드 간 여백 */
    
}

.user-detail-card h2 {
    margin-top: 0; /* 제목 상단 여백 제거 */
}

.user-detail-card .user-detail p {
    overflow-wrap: break-word; /* 긴 단어가 줄 바꿈되도록 설정 */
}

.buttons {
    display: flex; /* 버튼을 가로로 나열 */
    justify-content: flex-end; /* 오른쪽 정렬 */
}

.buttons button {
    background-color: #4CAF50; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    border: none; /* 테두리 제거 */
    padding: 10px 15px; /* 버튼 내부 여백 */
    border-radius: 5px; /* 버튼 모서리 둥글게 */
    cursor: pointer; /* 커서 포인터로 변경 */
    transition: background-color 0.3s; /* 호버 시 배경색 변화 애니메이션 */
}

.buttons button:hover {
    background-color: #45a049; /* 호버 시 배경색 */
}

.buttons #confirm-delete-btn, .buttons #delete-btn {
	background-color: red
}

</style>
</head>
<body>

	<div class="content-box">
	    <div class="container">
	        <div class="user-list-container">
	            <!-- 사용자 목록이 표시될 위치 -->
	        </div>
	        <div class="user-detail-container">
	            <!-- 사용자 상세 정보가 표시될 위치 -->
	        </div>
	    </div>
	</div>

</body>
<script src="/js/adminPage.js"></script>
</html>
