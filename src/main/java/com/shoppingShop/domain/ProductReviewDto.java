package com.shoppingShop.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;
import java.util.Date;

public class ProductReviewDto {
    private int reviewId;
    private Integer proId;
    private Integer  rating;
    private String comment;
    private int excellent;
    private int good;
    private int average;
    private int poor;
    private int terrible;

    private Date createdAt;

    public ProductReviewDto(){

    }

    public ProductReviewDto(int reviewId, Integer  proId, Integer  rating, String comment, int excellent, int good, int average, int poor, int terrible, Date createdAt) {
        this.reviewId = reviewId;
        this.proId = proId;
        this.rating = rating;
        this.comment = comment;
        this.excellent = excellent;
        this.good = good;
        this.average = average;
        this.poor = poor;
        this.terrible = terrible;
        this.createdAt = createdAt;
    }

    // Getter와 Setter
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public Integer getProId() { return proId; }
    public void setProId(Integer  proId) { this.proId = proId; }

    public Integer  getRating() { return rating; }
    public void setRating(Integer  rating) { this.rating = rating; }

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

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "ProductReviewDto{" +
                "reviewId=" + reviewId +
                ", proId=" + proId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", excellent=" + excellent +
                ", good=" + good +
                ", average=" + average +
                ", poor=" + poor +
                ", terrible=" + terrible +
                ", createdAt=" + createdAt +
                '}';
    }
}
