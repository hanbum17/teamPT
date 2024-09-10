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



function connect() {
    //username = document.querySelector('#name').value.trim();
	username = principal ;
    if (username) {
        /*usernamePage.classList.add('hidden');
        chatPage.classList.remove('hidden');*/

        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
		stompClient.debug = null;
        stompClient.connect({}, onConnected, onError);
    }
    //event.preventDefault();
}

/*연결 끊겼을 때 함수*/
function disconnect() {
    if (stompClient) {
        stompClient.send("/pub/chat/leave",
            {},
            JSON.stringify({ username: username, sendDate: new Date(), roomId: roomId})
        );
		
		/*stompClient.send("/pub/chat/leave",
		            {},
		            JSON.stringify({ username: username, content: 'LEAVE', sendDate: new Date(), roomId: roomId})
		        );*/
		
        stompClient.disconnect();
    }
}

/*연결 성공 함수*/
function onConnected() {
    stompClient.subscribe('/sub/chat/room/'+ roomId , onMessageReceived);
	stompClient.subscribe('/sub/chat/userCnt', onUserCntReceived);
	stompClient.subscribe('/sub/chat/chatHistory'+roomId , chatHistory);
	
	stompClient.send("/pub/chat/enter",
	        {},
	        JSON.stringify({ username: username, sendDate: new Date(), roomId: roomId })
	    );
    
	/*stompClient.send("/pub/chat/enter",
        {},
        JSON.stringify({ username: username, content: 'JOIN', sendDate: new Date(), roomId: roomId })
    );*/
	
    /*connectingElement.classList.add('hidden');*/
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
			sendDate: new Date(),
			roomId: roomId
        };
        stompClient.send("/pub/chat/message", {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
    event.preventDefault();
}
//////////////////////////////////////////////////////////////////////////////
function formatDate(sendDate) {
    // ISO 형식의 날짜 문자열을 Date 객체로 변환
    var date = new Date(sendDate);

    // 연도, 월, 일, 시간, 분, 초를 각각 가져옴
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
    var day = ('0' + date.getDate()).slice(-2);
    var hours = ('0' + date.getHours()).slice(-2);
    var minutes = ('0' + date.getMinutes()).slice(-2);
    var seconds = ('0' + date.getSeconds()).slice(-2);

    // 형식에 맞게 조합하여 반환
    //var formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
	var formattedDate = ' ' + hours + ':' + minutes + ':' + seconds + ' '; //시 분 초
    return formattedDate;
}
/*유저 입장 시 인원수증가*/
function onUserCntReceived(payload) {
    userCnt = JSON.parse(payload.body);
    $("#chat-title").text(chatRoomTitle + " 채팅방");
}

/*이전 채팅기록 불러오기*/
function chatHistory(payload) {
    // JSON으로 변환
    var messages = JSON.parse(payload.body);
    
    // 메시지 영역 초기화
    messageArea.innerHTML = '';

    // 메시지 배열을 반복하며 처리
    for (var i in messages) {
        var message = messages[i];

        if (!message.content) {
            continue; // 내용이 없는 메시지는 건너뜁니다
        }

        var messageElement = document.createElement('li');
        
        // 메시지 스타일을 설정
        if (message.username && message.username !== principal) {
            // 상대방의 메시지
            messageElement.classList.add('chat-message');

            // 메시지 내용과 타임스탬프를 포함할 div 생성
            var chatWrapper = document.createElement('div');
            chatWrapper.classList.add('chat1');

            // 사용자 이름
            var usernameElement = document.createElement('span');
            usernameElement.classList.add('username');
            var usernameText = document.createTextNode(message.username);
            usernameElement.appendChild(usernameText);
            chatWrapper.appendChild(usernameElement);

            // 메시지 내용
            var textElement = document.createElement('p');
            var messageText = document.createTextNode(message.content);
            textElement.appendChild(messageText);
            chatWrapper.appendChild(textElement);

            // 타임스탬프
            var timeElement = document.createElement('div');
            timeElement.classList.add('timestamp');
            var formattedDate = formatDate(message.sendDate);
            var timeTextNode = document.createTextNode(formattedDate);
            timeElement.appendChild(timeTextNode);

            // 메시지 요소에 내용을 추가
            messageElement.appendChild(chatWrapper);
            messageElement.appendChild(timeElement);

        } else {
            // 자신의 메시지
            messageElement.classList.add('my-chat-message');

            // 타임스탬프
            var timeElement = document.createElement('div');
            timeElement.classList.add('timestamp');
            var formattedDate = formatDate(message.sendDate);
            var timeTextNode = document.createTextNode(formattedDate);
            timeElement.appendChild(timeTextNode);

            // 메시지 내용과 사용자 이름을 포함할 div 생성
            var chatWrapper = document.createElement('div');
            chatWrapper.classList.add('chat1');

            // 사용자 이름
            var usernameElement = document.createElement('span');
            usernameElement.classList.add('username');
            var usernameText = document.createTextNode(message.username);
            usernameElement.appendChild(usernameText);
            chatWrapper.appendChild(usernameElement);

            // 메시지 내용
            var textElement = document.createElement('p');
            var messageText = document.createTextNode(message.content);
            textElement.appendChild(messageText);
            chatWrapper.appendChild(textElement);

            // 메시지 요소에 타임스탬프와 내용을 추가
            messageElement.appendChild(timeElement);
            messageElement.appendChild(chatWrapper);
        }

        // 메시지 영역에 추가
        messageArea.appendChild(messageElement);
    }

    // 스크롤을 맨 아래로 이동
    messageArea.scrollTop = messageArea.scrollHeight;
}





function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);

    if (!message.content) {
        return;
    }

    var messageElement = document.createElement('li');

    if (message.content === 'JOIN') {
        messageElement.classList.add('event-message');
        messageElement.textContent = message.username + ' 님이 입장하셨습니다.';
    } else if (message.content === 'LEAVE') {
        messageElement.classList.add('event-message');
        messageElement.textContent = message.username + ' 님이 퇴장하셨습니다.';
    } else {
        var chatWrapper = document.createElement('div');
        chatWrapper.classList.add('chat1');

        var usernameElement = document.createElement('span');
        var usernameText = document.createTextNode(message.username);
        usernameElement.appendChild(usernameText);

        var textElement = document.createElement('p');
        var messageText = document.createTextNode(message.content);
        textElement.appendChild(messageText);

        if (message.username && message.username !== principal) {
            // 상대방 채팅
            messageElement.classList.add('chat-message');

            chatWrapper.appendChild(usernameElement);
            chatWrapper.appendChild(textElement);

            var timeElement = document.createElement('div');
            timeElement.classList.add('timestamp');
            var formattedDate = formatDate(message.sendDate);
            var timeTextNode = document.createTextNode(formattedDate);
            timeElement.appendChild(timeTextNode);

            messageElement.appendChild(chatWrapper);
            messageElement.appendChild(timeElement);

        } else {
            // 자신의 채팅
            messageElement.classList.add('my-chat-message');

            var timeElement = document.createElement('div');
            timeElement.classList.add('timestamp');
            var formattedDate = formatDate(message.sendDate);
            var timeTextNode = document.createTextNode(formattedDate);
            timeElement.appendChild(timeTextNode);

            chatWrapper.appendChild(usernameElement);
            chatWrapper.appendChild(textElement);

            messageElement.appendChild(timeElement);
            messageElement.appendChild(chatWrapper);
        }
    }

    var messageArea = document.getElementById('messageArea');
    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
}



/* 프로필배경 색깔 랜덤뽑기 */
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

/*usernameForm.addEventListener('submit', connect, true);*/
messageForm.addEventListener('submit', sendMessage, true);
