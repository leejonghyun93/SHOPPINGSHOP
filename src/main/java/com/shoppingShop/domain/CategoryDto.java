package com.shoppingShop.domain;

import java.util.List;

public class CategoryDto {
    private int categoryId;
    private String categoryName;
    private List<SubCategoryDto> subCategories; // 서브카테고리 리스트

    // Getter와 Setter 메소드
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<SubCategoryDto> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<SubCategoryDto> subCategories) {
        this.subCategories = subCategories;
    }
}