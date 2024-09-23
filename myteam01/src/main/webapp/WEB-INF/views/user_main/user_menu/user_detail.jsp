<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../userSide.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_menu/detail.css">
<!-- 메인 콘텐츠 박스 -->
<main class="content-box">
    <div class="content">
        <div class="content-header">
            <h2>상세정보</h2>
        </div>
        <div class="user-details">
            <p>사용자 ID: ${user.userId}</p>
            <p>이메일: ${user.userEmail}</p>
            <p>전화번호: ${user.userCall}</p>
            <p>가입일: ${user.joinDate}</p>
        </div>

        <div class="account-settings">
            <h3>계정 설정</h3>
            <a href="#" id="openModalBtn">비밀번호 변경</a> 
            
           	<!-- 에러 메시지가 있을 경우 표시 -->
			<c:if test="${not empty error}">
			    <div class="alert alert-danger">
			        ${error}
			    </div>
			</c:if>

			<!-- 성공 메시지가 있을 경우 표시 -->
			<c:if test="${not empty message}">
			    <div class="alert alert-success">
			        ${message}
			    </div>
			</c:if>
        </div>

        <div class="notification-settings">
            <h3>알림 설정</h3>
            <form action="/user/updateNotifications" method="post">
                <label><input type="checkbox" name="emailNotifications" checked> 이메일 알림</label> 
                <label><input type="checkbox" name="smsNotifications"> SMS 알림</label>
                <button type="submit">저장</button>
            </form>
        </div>
    </div>
    
    <!-- 비밀번호 변경 모달 -->
	<div id="changePasswordModal" class="modal">
	    <div class="modal-content">
	        <h2>비밀번호 변경</h2>
	        <form id="changePasswordForm" action="/user/changePassword" method="post">
	            <div>
	                <label for="oldPassword">현재 비밀번호</label>
	                <input type="password" id="oldPassword" name="oldPassword" required>
	            </div>
	            <div>
	                <label for="newPassword">새 비밀번호</label>
	                <input type="password" id="newPassword" name="newPassword" required>
	            </div>
	            <div>
	                <label for="confirmPassword">새 비밀번호 확인</label>
	                <input type="password" id="confirmPassword" name="confirmPassword" required>
	            </div>
	            <button type="submit" id="modal-button">비밀번호 변경</button>
	        </form>
	    </div>
	</div>

	
</main>
</div>
</body>
</html>

<script>
// 모달을 열고 닫는 스크립트
var modal = document.getElementById("changePasswordModal");
var btn = document.getElementById("openModalBtn");
var span = document.getElementsByClassName("close")[0];

// 모달 열기
btn.onclick = function() {
    modal.style.display = "block";
}


// 모달 닫기 (외부 클릭 시)
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

</script>