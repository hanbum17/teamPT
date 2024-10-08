var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;
var username = null;

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

function connect(event) {
    username = document.querySelector('#name').value.trim();

    if (username) {
        usernamePage.classList.add('hidden');
        chatPage.classList.remove('hidden');

        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, onConnected, onError);
    }
    event.preventDefault();
}

function disconnect() {
    if (stompClient) {
        stompClient.send("/pub/chat/leave",
            {},
            JSON.stringify({ username: username, content: 'LEAVE', date: new Date()})
        );
        stompClient.disconnect();
    }
}

function onConnected() {
    stompClient.subscribe('/sub/chat/room/1', onMessageReceived);
	stompClient.subscribe('/sub/chat/userCnt', onUserCntReceived);
    stompClient.send("/pub/chat/enter",
        {},
        JSON.stringify({ username: username, content: 'JOIN', date: new Date() })
    );
	
    connectingElement.classList.add('hidden');
}

function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}

function sendMessage(event) {
    var messageContent = messageInput.value.trim();
    if (messageContent && stompClient) {
        var chatMessage = {
            username: username,
            content: messageInput.value,
			date: new Date()
        };
        stompClient.send("/pub/chat/message", {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
    event.preventDefault();
}

function formatDate(){
	var today = new Date();
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2); 

	var timeString = hours + ':' + minutes  + ':' + seconds;
	
	return timeString ; 
}
function onUserCntReceived(payload) {
    userCnt = JSON.parse(payload.body);
    $("#chat-title").text("☆★☆902강의장 임시 채팅방☆★☆ 참여인원: " + userCnt);
}

function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);
    //console.log("message", message);
    var messageElement = document.createElement('li');

    if (message.content === 'JOIN') {
        messageElement.classList.add('event-message');
        messageElement.textContent = message.username + ' 님이 입장하셨습니다.';
    } else if (message.content === 'LEAVE') {
        messageElement.classList.add('event-message');
        messageElement.textContent = message.username + ' 님이 퇴장하셨습니다.';
    } else {
        messageElement.classList.add('chat-message');

        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(message.username[0]);
        avatarElement.appendChild(avatarText);
        avatarElement.style['background-color'] = getAvatarColor(message.username);

        messageElement.appendChild(avatarElement);

        var usernameElement = document.createElement('span');
        var usernameText = document.createTextNode(message.username);
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
    }

    var textElement = document.createElement('p');
	var timeElement = document.createElement('p');
	var formattedDate = formatDate(); // formatDate()가 반환하는 문자열
	// 문자열을 텍스트 노드로 변환하여 추가
	var textNode = document.createTextNode(formattedDate);
	timeElement.appendChild(textNode);

	var messageText = document.createTextNode(message.content);
	
	if(messageElement.classList.value === "chat-message"){
	    textElement.appendChild(messageText);
	}
	    messageElement.appendChild(textElement);
		messageElement.appendChild(timeElement);
	
	    messageArea.appendChild(messageElement);
	    messageArea.scrollTop = messageArea.scrollHeight;
}


function getAvatarColor(messageusername) {
    var hash = 0;
    for (var i = 0; i < messageusername.length; i++) {
        hash = 31 * hash + messageusername.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}

// Listen for the window unload event to handle browser close or refresh
window.addEventListener('beforeunload', function (event) {
    disconnect(); // Send a LEAVE message before closing
    // Optionally, you can provide a custom message in the event to warn the user.
    // event.preventDefault(); // Some browsers may require this to show a confirmation dialog
});

usernameForm.addEventListener('submit', connect, true);
messageForm.addEventListener('submit', sendMessage, true);
