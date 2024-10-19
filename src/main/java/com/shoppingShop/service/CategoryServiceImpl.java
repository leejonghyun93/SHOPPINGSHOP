package com.shoppingShop.service;

import com.shoppingShop.dao.CategoryDao;
import com.shoppingShop.domain.CategoryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    @Override
    public List<CategoryDto> getMainCategories() {
        return categoryDao.selectMainCategories();
    }
}