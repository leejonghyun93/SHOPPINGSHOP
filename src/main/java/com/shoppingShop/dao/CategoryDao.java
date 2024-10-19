package com.shoppingShop.dao;

import com.shoppingShop.domain.CategoryDto;

import java.util.List;

public interface CategoryDao {
    List<CategoryDto> selectMainCategories();
}