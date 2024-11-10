package com.shoppingShop.domain;


import java.time.LocalDate;
import java.time.LocalDateTime;

public class BoardDto {
    private int noticeId;
    private String userId;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private LocalDate updatedAt;
    private LocalDateTime updateAt;

    public BoardDto(int noticeId, String userId, String title, String content, LocalDateTime createdAt, LocalDate updatedAt, LocalDateTime updateAt) {
        this.noticeId = noticeId;
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.updateAt = updateAt;
    }

    public BoardDto(){

    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDate getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDate updatedAt) {
        this.updatedAt = updatedAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "BoardDto{" +
                "noticeId=" + noticeId +
                ", userId='" + userId + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", updateAt=" + updateAt +
                '}';
    }
}
