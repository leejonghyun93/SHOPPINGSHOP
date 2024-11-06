package com.shoppingShop.domain;

public class CartDto {
    private Long cartId;
    private String userId;
    private Integer proId;
    private Integer cartCount;
    private String imageUrl;
    private String productInfo;
    private Integer quantity;
    private Double shippingFee;
    private Double totalPrice;
    private Double unitPrice;

    public CartDto(Long cartId, String userId, Integer proId, Integer cartCount, String imageUrl, String productInfo, Integer quantity, Double shippingFee, Double totalPrice, Double unitPrice) {
        this.cartId = cartId;
        this.userId = userId;
        this.proId = proId;
        this.cartCount = cartCount;
        this.imageUrl = imageUrl;
        this.productInfo = productInfo;
        this.quantity = quantity;
        this.shippingFee = shippingFee;
        this.totalPrice = totalPrice;
        this.unitPrice = unitPrice;
    }

    public CartDto(){
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

    public Double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(Double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return "CartDto{" +
                "cartId=" + cartId +
                ", userId='" + userId + '\'' +
                ", proId=" + proId +
                ", cartCount=" + cartCount +
                ", imageUrl='" + imageUrl + '\'' +
                ", productInfo='" + productInfo + '\'' +
                ", quantity=" + quantity +
                ", shippingFee=" + shippingFee +
                ", totalPrice=" + totalPrice +
                ", unitPrice=" + unitPrice +
                '}';
    }
}
