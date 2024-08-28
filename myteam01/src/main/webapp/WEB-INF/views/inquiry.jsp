<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피드백 페이지</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    overflow-x: hidden;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
}

.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-control {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.fileUploadResult ul {
    list-style: none;
    padding: 0;
}

.fileUploadResult li {
    margin: 5px 0;
}

.btnRegister, .btnCancel {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
}

.btnRegister {
    background-color: #28a745;
}

.btnCancel {
    background-color: #dc3545;
}

.btnRegister:hover, .btnCancel:hover {
    opacity: 0.9;
}

.btnCancel {
    margin-left: 10px;
}

#map {
    margin-top: 20px;
    width: 100%;
    height: 350px;
}

</style>
</head>
<body>
<%@ include file="/jsp/admin_main/header.jsp" %>

    <h1>문의사항</h1>
    <p>문의사항 내용을 여기에 작성합니다.</p>
    <button onclick="location.href='/csCenter'">고객센터로 돌아가기</button>
		
</body>	



</html>