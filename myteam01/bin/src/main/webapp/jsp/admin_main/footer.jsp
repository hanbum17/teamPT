<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer Links</title>
    <style>
        /* 기본 스타일 설정 */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color:  #444;
        }
        
        main {
            flex: 1;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        footer a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 14px;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <main>
        <!-- 메인 콘텐츠가 들어갈 부분 -->
    </main>
    <footer>
        <a href="#">이용약관</a>
        <a href="#">개인정보 취급방침 및 쿠키정책</a>
        <a href="#">쿠키동의</a>
        <a href="#">문의하기</a>
    </footer>
</body>
</html>
