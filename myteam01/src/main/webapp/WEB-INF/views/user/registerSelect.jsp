<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 선택</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/registerSelect.css">
</head>
<body>
    <div class="container">
        <h2>회원 유형을 선택하세요</h2>
        <div class="selection-boxes">
            <div class="box" onclick="navigateToRegister('ADMIN')">
                <h3>관리자</h3>
            </div>
            <div class="box" onclick="navigateToRegister('BUSINESS')">
                <h3>사업자</h3>
            </div>
            <div class="box" onclick="navigateToRegister('USER')">
                <h3>일반 사용자</h3>
            </div>
        </div>
    </div>

    <script>
        function navigateToRegister(role) {
            window.location.href = `${pageContext.request.contextPath}/user/register?role=${role}`;
        }
    </script>
</body>
</html>
