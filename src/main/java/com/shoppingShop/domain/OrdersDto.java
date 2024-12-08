package com.shoppingShop.domain;

import java.time.LocalDateTime;

public class OrdersDto {
    private int orderId;
    private String userId;
    private String odStatus;
    private int odTotalPrice;
    private LocalDateTime createdAt;
    private Long cartId;
    private Long proId;
    private int quantity;
    private int shippingFee;
    private int unitPrice;

    public OrdersDto() {}

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOdStatus() {
        return odStatus;
    }

    public void setOdStatus(String odStatus) {
        this.odStatus = odStatus;
    }

    public int getOdTotalPrice() {
        return odTotalPrice;
    }

    public void setOdTotalPrice(int odTotalPrice) {
        this.odTotalPrice = odTotalPrice;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getProId() {
        return proId;
    }

    public void setProId(Long proId) {
        this.proId = proId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(int shippingFee) {
        this.shippingFee = shippingFee;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public OrdersDto(int orderId, String userId, String odStatus, int odTotalPrice, LocalDateTime createdAt, Long cartId, Long proId, int quantity, int shippingFee, int unitPrice) {
        this.orderId = orderId;
        this.userId = userId;
        this.odStatus = odStatus;
        this.odTotalPrice = odTotalPrice;
        this.createdAt = createdAt;
        this.cartId = cartId;
        this.proId = proId;
        this.quantity = quantity;
        this.shippingFee = shippingFee;
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return "OrdersDto{" +
                "orderId=" + orderId +
                ", userId='" + userId + '\'' +
                ", odStatus='" + odStatus + '\'' +
                ", odTotalPrice=" + odTotalPrice +
                ", createdAt=" + createdAt +
                ", cartId=" + cartId +
                ", proId=" + proId +
                ", quantity=" + quantity +
                ", shippingFee=" + shippingFee +
                ", unitPrice=" + unitPrice +
                '}';
    }
}