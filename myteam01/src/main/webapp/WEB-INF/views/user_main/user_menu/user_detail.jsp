<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../userSide.jsp"%>

<!-- 메인 콘텐츠 박스 -->
	<main class="content-box">
		<div class="content">
			<div class="content-header">
				<h2>상세정보</h2>
			</div>
			<div class="user-details">
				<p>사용자 ID: ${user.username}</p>
				<p>이메일: ${user.email}</p>
				<p>전화번호: ${user.phone}</p>
				<p>가입일: ${user.registrationDate}</p>
			</div>
	
			<div class="account-settings">
				<h3>계정 설정</h3>
				<a href="/user/updatePassword">비밀번호 변경</a> <a
					href="/user/updateEmail">이메일 변경</a>
			</div>
	
			<div class="notification-settings">
				<h3>알림 설정</h3>
				<form action="/user/updateNotifications" method="post">
					<label> <input type="checkbox" name="emailNotifications"
						checked> 이메일 알림
					</label> <label> <input type="checkbox" name="smsNotifications">
						SMS 알림
					</label>
					<button type="submit">저장</button>
				</form>
			</div>
		</div>
		
	</main>
</div>
</body>
</html>