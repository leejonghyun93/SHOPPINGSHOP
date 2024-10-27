package com.shoppingShop.service;

import com.shoppingShop.domain.ProductDto;

import java.util.List;

public interface ProductService {
    List<ProductDto> getList(int subCategoryId) throws Exception;

    ProductDto getProductDetail(int proId) throws Exception;
}
