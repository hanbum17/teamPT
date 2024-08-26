<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Display</title>
    <link rel="stylesheet" href="/css/vroomEvent.css">
</head>
<body>
    <div id="container">
        <div id="left">
            <!-- Left section for events -->
        </div>
        <div id="right">
            <!-- Right section for events -->
        </div>
    </div>

    <div id="detail-view" class="hidden">
        <button id="back-button">Back</button>
        <div id="left-detail" class="detail-box">
            <!-- Left detail box -->
        </div>
        <div id="right-detail" class="detail-box">
            <!-- Right detail box -->
        </div>
    </div>

    <script src="/js/vroomEvent.js"></script>
</body>
</html>
