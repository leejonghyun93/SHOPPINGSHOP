package com.shoppingShop.domain;

import java.time.LocalDateTime;

public class InquiryDto {
    private int inquiryId;
    private int proId;
    private String content;

    private String userName;
    private String author;
    private LocalDateTime createdAt;

    private String userId;

    // Getters and Setters

    public int getInquiryId() {
        return inquiryId;
    }

    public void setInquiryId(int inquiryId) {
        this.inquiryId = inquiryId;
    }

    public int getProId() {
        return proId;
    }

    public void setProId(int proId) {
        this.proId = proId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }



    @Override
    public String toString() {
        return "InquiryDto{" +
                "inquiryId=" + inquiryId +
                ", proId=" + proId +
                ", content='" + content + '\'' +
                ", userName='" + userName + '\'' +
                ", author='" + author + '\'' +
                ", createdAt=" + createdAt +
                ", userId='" + userId + '\'' +
                '}';
    }
}