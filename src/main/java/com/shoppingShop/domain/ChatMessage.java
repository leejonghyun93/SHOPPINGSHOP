package com.shoppingShop.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ChatMessage {
    @JsonProperty("sender")
    private String sender;

    @JsonProperty("content")
    private String content;

    public ChatMessage() {
    }

    public ChatMessage(String sender, String content) {
        this.sender = sender;
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}