package com.shoppingShop.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shoppingShop.domain.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {

    @MessageMapping("/chat")
    @SendTo("/topic/messages")
    public ChatMessage sendMessage(ChatMessage message, SimpMessageHeaderAccessor headerAccessor) {
        try {
            // Log the incoming message
            String messageJson = new ObjectMapper().writeValueAsString(message);
            System.out.println("Received Message: " + messageJson);  // Debugging log

            return new ChatMessage(message.getSender(), message.getContent());
        } catch (Exception e) {
            e.printStackTrace();
            return new ChatMessage("Error", "Message serialization failed");
        }
    }

    @GetMapping("/chat-popup")
    public String chatPopup() {
        return "user/chat-popup"; // JSP 경로와 매핑
    }
}
