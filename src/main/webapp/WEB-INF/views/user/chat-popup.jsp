<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Popup</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <style>
        /* CSS styling as per your requirement */
        #chat-messages {
            border: 1px solid #ccc;
            padding: 10px;
            height: 300px;
            overflow-y: auto;
        }

        #message-input {
            width: calc(100% - 120px);
        }

        #send-button {
            width: 100px;
        }
    </style>
</head>
<body>
<div id="chat-messages"></div>
<input type="text" id="message-input">
<button id="send-button">Send</button>

<script>
    let socket;

    // 웹소켓 서버 연결
    function connectWebSocket() {
        socket = new WebSocket('ws://localhost:8087/chat'); // 서버 URL에 맞게 수정
        socket.onopen = function() {
            console.log('웹소켓 연결 성공');
        };
        socket.onmessage = function(event) {
            const message = JSON.parse(event.data);
            console.log('메시지 수신:', message);
            // 메시지 처리, 예를 들어 메시지 출력
            document.getElementById('chat-messages').innerHTML += `<p><strong>${message.sender}:</strong> ${message.content}</p>`;
        };
        socket.onerror = function(error) {
            console.error('웹소켓 오류:', error);
        };
    }

    // 페이지 로드 시 웹소켓 연결
    window.onload = function() {
        connectWebSocket();
    };

    // 메시지 전송
    document.getElementById('send-button').addEventListener('click', function() {
        const messageInput = document.getElementById('message-input');
        if (messageInput.value.trim() !== '') {
            socket.send(JSON.stringify({ sender: 'user', content: messageInput.value }));
            messageInput.value = ''; // 입력 창 비우기
        }
    });
</script>
</body>
</html>
