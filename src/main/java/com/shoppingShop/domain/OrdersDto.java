package com.shoppingShop.domain;

import java.time.LocalDateTime;

public class OrdersDto {

    private Long orderId;
    private Long cartId;
    private String userId;
    private String proName;
    private String proColor;

    private int proId;
    private String proSize;
    private Integer quantity;
    private int unitPrice;
    private int shippingFee;
    private int odTotalPrice;
    private String odStatus;

    private LocalDateTime createdAt;

    public OrdersDto() {}

    public OrdersDto(Long orderId, Long cartId, String userId, String proName, String proColor, int proId, String proSize, Integer quantity, int unitPrice, int shippingFee, int odTotalPrice, String odStatus, LocalDateTime createdAt) {
        this.orderId = orderId;
        this.cartId = cartId;
        this.userId = userId;
        this.proName = proName;
        this.proColor = proColor;
        this.proId = proId;
        this.proSize = proSize;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.shippingFee = shippingFee;
        this.odTotalPrice = odTotalPrice;
        this.odStatus = odStatus;
        this.createdAt = createdAt;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
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

    public int getProId() {
        return proId;
    }

    public void setProId(int proId) {
        this.proId = proId;
    }

    public String getProSize() {
        return proSize;
    }

    public void setProSize(String proSize) {
        this.proSize = proSize;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "OrdersDto{" +
                "orderId=" + orderId +
                ", cartId=" + cartId +
                ", userId='" + userId + '\'' +
                ", proName='" + proName + '\'' +
                ", proColor='" + proColor + '\'' +
                ", proId=" + proId +
                ", proSize='" + proSize + '\'' +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", shippingFee=" + shippingFee +
                ", odTotalPrice=" + odTotalPrice +
                ", odStatus='" + odStatus + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}