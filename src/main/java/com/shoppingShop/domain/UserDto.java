package com.shoppingShop.domain;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Date;

public class UserDto {

    private String userId;
    private String userPwd;
    private String userName;
    private String userAddress;
    private String detailAddress;
    private Integer userPhone;
    private String userEmail;
    private Date createdAt;
    private Date updatedAt;


    public UserDto(){

    }

    public UserDto(String userId, String userPwd, String userName, String userAddress, String detailAddress, Integer userPhone, String userEmail, Date createdAt, Date updatedAt) {
        this.userId = userId;
        this.userPwd = userPwd;
        this.userName = userName;
        this.userAddress = userAddress;
        this.detailAddress = detailAddress;
        this.userPhone = userPhone;
        this.userEmail = userEmail;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public Integer getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(Integer userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "userId='" + userId + '\'' +
                ", userPwd='" + userPwd + '\'' +
                ", userName='" + userName + '\'' +
                ", userAddress='" + userAddress + '\'' +
                ", detailAddress='" + detailAddress + '\'' +
                ", userPhone=" + userPhone +
                ", userEmail='" + userEmail + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
