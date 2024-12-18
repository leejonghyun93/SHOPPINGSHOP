package com.shoppingShop.dao;

import com.shoppingShop.domain.ProductDto;

import java.util.List;

public interface ProductDao {
    List<ProductDto> selectProductAll(int subCategoryId) throws Exception;

    ProductDto selectProductDetail(int proId) throws Exception;

    List<ProductDto> selectAllProducts() throws Exception;

    ProductDto findCurrentProduct(int proId);
}
