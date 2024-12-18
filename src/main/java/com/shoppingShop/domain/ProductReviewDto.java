package com.shoppingShop.domain;

import java.time.LocalDateTime;

public class ProductReviewDto {
    private int reviewId;
    private int proId;
    private int rating;
    private String comment;
    private int excellent;
    private int good;
    private int average;
    private int poor;
    private int terrible;
    private LocalDateTime createdAt;

    // Getter와 Setter
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getProId() { return proId; }
    public void setProId(int proId) { this.proId = proId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public int getExcellent() { return excellent; }
    public void setExcellent(int excellent) { this.excellent = excellent; }

    public int getGood() { return good; }
    public void setGood(int good) { this.good = good; }

    public int getAverage() { return average; }
    public void setAverage(int average) { this.average = average; }

    public int getPoor() { return poor; }
    public void setPoor(int poor) { this.poor = poor; }

    public int getTerrible() { return terrible; }
    public void setTerrible(int terrible) { this.terrible = terrible; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
