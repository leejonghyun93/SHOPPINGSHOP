package com.shoppingShop.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;

public class InquiryDto {
    private int inquiryId;
    private int proId;
    private String content;

    private String title;


    private String author;
    private LocalDateTime createdAt;
    private String userName;
    private String userId;

    // Getters and Setters
    public InquiryDto() {
    }


    @JsonCreator
    public InquiryDto(
            @JsonProperty("inquiryId") int inquiryId,
            @JsonProperty("proId") int proId,
            @JsonProperty("content") String content,
            @JsonProperty("title") String title,
            @JsonProperty("author") String author,
            @JsonProperty("createdAt") LocalDateTime createdAt,
            @JsonProperty("userName") String userName,
            @JsonProperty("userId") String userId
    ) {
        this.inquiryId = inquiryId;
        this.proId = proId;
        this.content = content;
        this.title = title;
        this.author = author;
        this.createdAt = createdAt;
        this.userName = userName;
        this.userId = userId;
    }

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

}