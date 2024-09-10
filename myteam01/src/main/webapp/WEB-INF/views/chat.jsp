<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <title>Spring Boot WebSocket Chat Application</title>
    <link rel="stylesheet" href="/css/chat.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
</head>
<body>
<div id="chat-page" class="hidden">
    <div class="chat-container">
        <div class="chat-header">
            <h2 id="chat-title">☆★☆902강의장 ${roomId }번 채팅방☆★☆ 참여인원: 0</h2>
        </div>
        <!-- <div class="connecting">
            연결중...
        </div> -->
        <ul id="messageArea">
        
        </ul>
        <form id="messageForm" name="messageForm">
            <div class="form-group">
                <div class="input-group clearfix">
                    <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                    <button type="submit" class="primary">보내기</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/js/chat.js"></script>
<script>
var roomId = ${roomId};
var chatRoomTitle = '${chatRoomTitle}';
var principal = '${username}' ; 

$(document).ready(function(){
	console.log("connect 즉시실행, 닉네임: " + principal);
	connect();
	
});
	
</script>
</body>
</html>