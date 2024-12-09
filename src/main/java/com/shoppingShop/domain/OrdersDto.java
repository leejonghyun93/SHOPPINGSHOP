package com.shoppingShop.domain;

import java.time.LocalDateTime;

public class OrdersDto {
    private Long cartId;
    private String userId;
    private String proName;
    private String proColor;
    private String proSize;
    private int quantity;
    private int unitPrice;
    private int shippingFee;
    private int odTotalPrice;
    private String odStatus;

    private String createdAt;

    public OrdersDto() {}

    public OrdersDto(Long cartId, String userId, String proName, String proColor, String proSize, int quantity, int unitPrice, int shippingFee, int odTotalPrice, String odStatus, String createdAt) {
        this.cartId = cartId;
        this.userId = userId;
        this.proName = proName;
        this.proColor = proColor;
        this.proSize = proSize;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.shippingFee = shippingFee;
        this.odTotalPrice = odTotalPrice;
        this.odStatus = odStatus;
        this.createdAt = createdAt;
    }

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProColor() {
        return proColor;
    }

    public void setProColor(String proColor) {
        this.proColor = proColor;
    }

    public String getProSize() {
        return proSize;
    }

    public void setProSize(String proSize) {
        this.proSize = proSize;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(int shippingFee) {
        this.shippingFee = shippingFee;
    }

    public int getOdTotalPrice() {
        return odTotalPrice;
    }

    public void setOdTotalPrice(int odTotalPrice) {
        this.odTotalPrice = odTotalPrice;
    }

    public String getOdStatus() {
        return odStatus;
    }

    public void setOdStatus(String odStatus) {
        this.odStatus = odStatus;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "OrdersDto{" +
                "cartId=" + cartId +
                ", userId='" + userId + '\'' +
                ", proName='" + proName + '\'' +
                ", proColor='" + proColor + '\'' +
                ", proSize='" + proSize + '\'' +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", shippingFee=" + shippingFee +
                ", odTotalPrice=" + odTotalPrice +
                ", odStatus='" + odStatus + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}