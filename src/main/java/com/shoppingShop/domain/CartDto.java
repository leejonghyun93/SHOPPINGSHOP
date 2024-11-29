package com.shoppingShop.domain;

import java.math.BigDecimal;

public class CartDto {
    private Long cartId;
    private String userId;
    private Integer proId;
    private Integer cartCount;
    private String imageUrl;
    private String productInfo;
    private Integer quantity;
    private String proName;
    private String proDescription;
    private String proColor;
    private String proSize;

    public CartDto(Long cartId, String userId, Integer proId, Integer cartCount, String imageUrl, String productInfo, Integer quantity, String proName, String proDescription, String proColor, String proSize, BigDecimal shippingFee, BigDecimal totalPrice, BigDecimal unitPrice, String totalPriceFormatted) {
        this.cartId = cartId;
        this.userId = userId;
        this.proId = proId;
        this.cartCount = cartCount;
        this.imageUrl = imageUrl;
        this.productInfo = productInfo;
        this.quantity = quantity;
        this.proName = proName;
        this.proDescription = proDescription;
        this.proColor = proColor;
        this.proSize = proSize;
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

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public Integer getCartCount() {
        return cartCount;
    }

    public void setCartCount(Integer cartCount) {
        this.cartCount = cartCount;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(String productInfo) {
        this.productInfo = productInfo;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProDescription() {
        return proDescription;
    }

    public void setProDescription(String proDescription) {
        this.proDescription = proDescription;
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

//    public BigDecimal getShippingFee() {
//        return shippingFee;
//    }

//    public void setShippingFee(BigDecimal shippingFee) {
//        this.shippingFee = shippingFee;
//    }
//
//    public BigDecimal getTotalPrice() {
//        return totalPrice;
//    }
//
//    public void setTotalPrice(BigDecimal totalPrice) {
//        this.totalPrice = totalPrice;
//    }
//
//    public BigDecimal getUnitPrice() {
//        return unitPrice;
//    }
//
//    public void setUnitPrice(BigDecimal unitPrice) {
//        this.unitPrice = unitPrice;
//    }
//
//    public String getTotalPriceFormatted() {
//        return totalPriceFormatted;
//    }
//
//    public void setTotalPriceFormatted(String totalPriceFormatted) {
//        this.totalPriceFormatted = totalPriceFormatted;
//    }
}
