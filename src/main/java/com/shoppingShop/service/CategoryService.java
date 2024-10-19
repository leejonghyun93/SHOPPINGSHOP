package com.shoppingShop.service;

import com.shoppingShop.domain.CategoryDto;

import java.util.List;

public interface CategoryService {
    List<CategoryDto> getMainCategories();
}