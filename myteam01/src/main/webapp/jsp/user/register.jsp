<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
</head>
<body>
    <h2>User Registration</h2>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div style="color: red;">${error}</div>
    </c:if>

    <form action="/user/register" method="post">
	    <label for="userId">User ID:</label>
	    <input type="text" id="userId" name="userId" required><br>
	
	    <label for="userPw">Password:</label>
	    <input type="password" id="userPw" name="userPw" required><br>
	
	    <label for="userName">Name:</label>
	    <input type="text" id="userName" name="userName" required><br>
	
	    <label for="userGender">Gender:</label>
	    <input type="radio" id="male" name="userGender" value="M" required>
	    <label for="male">Male</label>
	    <input type="radio" id="female" name="userGender" value="F" required>
	    <label for="female">Female</label><br>
	
	    <label for="userCall">Call:</label>
	    <input type="text" id="userCall" name="userCall" required><br>
	
	    <label for="userAddress">Address:</label>
	    <input type="text" id="userAddress" name="userAddress" required><br>
	
	    <label for="userEmail">Email:</label>
	    <input type="email" id="userEmail" name="userEmail" required><br>
	
	    <button type="submit">Register</button>
	</form>
    <form action="/user/login" method="get">
    	<div>
	        <button type="submit">돌아가기</button>
	    </div>
    </form>

</body>
</html>
