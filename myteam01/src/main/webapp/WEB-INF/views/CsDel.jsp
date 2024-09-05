<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 삭제 확인</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}

.container {
    max-width: 600px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    margin-bottom: 20px;
}

button {
    padding: 10px 20px;
    margin: 5px;
    border: none;
    border-radius: 4px;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
}

.btn-confirm {
    background-color: #dc3545;
}

.btn-confirm:hover {
    opacity: 0.9;
}

.btn-cancel {
    background-color: #007bff;
}

.btn-cancel:hover {
    opacity: 0.9;
}
</style>
</head>
<body>
    <div class="container">
        <h1>FAQ 삭제 확인</h1>
        <p>아래 버튼을 클릭하여 FAQ를 삭제할 수 있습니다.</p>

        <form action="${contextPath}/cs/deleteProc" method="post">
            <input type="hidden" name="faqno" value="${faqno}" />
            <button type="submit" class="btn-confirm">삭제</button>
            <button type="button" class="btn-cancel" onclick="location.href='${contextPath}/cs/Center'">취소</button>
        </form>
    </div>
</body>
</html>
