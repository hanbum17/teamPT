<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>User Registration</h2>
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

        <!-- Hidden input for userType, defaulting to 0 -->
        <input type="hidden" id="userType" name="userType" value="0">

        <button type="submit">Register</button>
    </form>

    <c:if test="${success}">
        <script>
            $(document).ready(function() {
                alert('User registered successfully!');
            });
        </script>
    </c:if>
</body>
</html>
