package com.shoppingShop.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.math.BigDecimal;

public class CartDto {
    private Long cartId;
    private String userId;

    private Long proId;
    private Integer cartCount;
    private String imageUrl;
    private String productInfo;
    private Integer quantity;
    private String proName;

    private String proDescription;
    private String proColor;
    private String proSize;
    private Integer totalPrice;
    private ProductDto productDto;
    public CartDto() {}
    @JsonCreator
    public CartDto(
            @JsonProperty("proId") Long proId,
            @JsonProperty("proColor") String proColor,
            @JsonProperty("proSize") String proSize,
            @JsonProperty("quantity") int quantity,
            @JsonProperty("proName") String proName
    ) {
        this.proId = proId;
        this.proColor = proColor;
        this.proSize = proSize;
        this.quantity = quantity;
        this.proName = proName;
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

    public Long getProId() {
        return proId;
    }

    public void setProId(Long proId) {
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

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

    public ProductDto getProductDto() {
        return productDto;
    }

    public void setProductDto(ProductDto productDto) {
        this.productDto = productDto;
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
                ", proName='" + proName + '\'' +
                ", proDescription='" + proDescription + '\'' +
                ", proColor='" + proColor + '\'' +
                ", proSize='" + proSize + '\'' +
                ", totalPrice=" + totalPrice +
                ", productDto=" + productDto +
                '}';
    }
}
