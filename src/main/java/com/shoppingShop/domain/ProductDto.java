package com.shoppingShop.domain;

public class ProductDto {
    private int proId;
    private int categoryId;
    private String proName;
    private String proDescription;
    private String proColor;
    private String proSize;
    private int proPrice;
    private int proStock;
    private String createdAt;
    private String updatedAt;
    private boolean featured;
    private Integer subCategoryId;
    private String imagePath;
    private Integer cartCount;
    private String imageUrl;
    private int shippingFee;
    private int totalPrice;

    private int quantity;

    public ProductDto(){

    }
    public ProductDto(int proId, int categoryId, String proName, String proDescription, String proColor, String proSize, int proPrice, int proStock, String createdAt, String updatedAt, boolean featured, Integer subCategoryId, String imagePath, Integer cartCount, String imageUrl, int shippingFee, int totalPrice, int quantity) {
        this.proId = proId;
        this.categoryId = categoryId;
        this.proName = proName;
        this.proDescription = proDescription;
        this.proColor = proColor;
        this.proSize = proSize;
        this.proPrice = proPrice;
        this.proStock = proStock;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.featured = featured;
        this.subCategoryId = subCategoryId;
        this.imagePath = imagePath;
        this.cartCount = cartCount;
        this.imageUrl = imageUrl;
        this.shippingFee = shippingFee;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
    }

    public int getProId() {
        return proId;
    }

    public void setProId(int proId) {
        this.proId = proId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public int getProPrice() {
        return proPrice;
    }

    public void setProPrice(int proPrice) {
        this.proPrice = proPrice;
    }

    public int getProStock() {
        return proStock;
    }

    public void setProStock(int proStock) {
        this.proStock = proStock;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    public Integer getSubCategoryId() {
        return subCategoryId;
    }

    public void setSubCategoryId(Integer subCategoryId) {
        this.subCategoryId = subCategoryId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
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

    public int getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(int shippingFee) {
        this.shippingFee = shippingFee;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "ProductDto{" +
                "proId=" + proId +
                ", categoryId=" + categoryId +
                ", proName='" + proName + '\'' +
                ", proDescription='" + proDescription + '\'' +
                ", proColor='" + proColor + '\'' +
                ", proSize='" + proSize + '\'' +
                ", proPrice=" + proPrice +
                ", proStock=" + proStock +
                ", createdAt='" + createdAt + '\'' +
                ", updatedAt='" + updatedAt + '\'' +
                ", featured=" + featured +
                ", subCategoryId=" + subCategoryId +
                ", imagePath='" + imagePath + '\'' +
                ", cartCount=" + cartCount +
                ", imageUrl='" + imageUrl + '\'' +
                ", shippingFee=" + shippingFee +
                ", totalPrice=" + totalPrice +
                ", quantity=" + quantity +
                '}';
    }
}
