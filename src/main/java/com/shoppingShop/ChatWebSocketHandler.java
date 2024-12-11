package com.shoppingShop;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatWebSocketHandler extends TextWebSocketHandler {

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 클라이언트로부터 메시지 수신
        System.out.println("Received message: " + message.getPayload());

        // 메시지를 클라이언트에 다시 전송
        session.sendMessage(new TextMessage("Echo: " + message.getPayload()));
    }
}