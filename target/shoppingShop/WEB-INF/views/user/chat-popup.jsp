<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
<h1>Chat</h1>
<div id="chat-messages"></div>
<input type="text" id="message-input">
<button id="send-button">Send</button>

<script>
    var socket = new SockJS('/chat');  // 서버의 /chat 엔드포인트에 연결
    var stompClient = Stomp.over(socket);

    // WebSocket 연결
    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);

        // 메시지 구독
        stompClient.subscribe('/topic/messages', function (message) {
            console.log("Received message: ", message.body);  // 메시지 내용 확인
            var chatMessage = JSON.parse(message.body);  // JSON 파싱
            console.log("Parsed message: ", chatMessage);    // 파싱된 데이터 확인

            // UI에 메시지 출력
            var chatMessagesDiv = document.getElementById('chat-messages');
            chatMessagesDiv.innerHTML += `<p><strong>${chatMessage.sender}</strong>: ${chatMessage.content}</p>`;
        });
    }, function (error) {
        console.error('WebSocket connection error: ', error);
    });

    // Send 버튼 클릭 이벤트
    document.getElementById('send-button').addEventListener('click', function () {
        var messageContent = document.getElementById('message-input').value.trim();
        if (messageContent === "") {
            alert("메시지를 입력하세요.");
            return;
        }

        var message = {
            content: messageContent,
            sender: "User"  // 예시: 사용자 이름
        };

        // 전송 데이터 확인
        console.log("Sending message: ", message);

        // WebSocket으로 메시지 전송
        stompClient.send("/app/chat", {}, JSON.stringify(message));

        // 입력 필드 초기화
        document.getElementById('message-input').value = '';
    });
</script>
</body>
</html>
