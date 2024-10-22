package com.shoppingShop.dao;

import com.shoppingShop.domain.ProductDto;

import java.util.List;

public interface ProductDao {
    List<ProductDto> selectProductAll(int subCategoryId) throws Exception;
}
