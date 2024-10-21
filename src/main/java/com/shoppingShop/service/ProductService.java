package com.shoppingShop.service;

import com.shoppingShop.domain.ProductDto;

import java.util.List;

public interface ProductService {
    List<ProductDto> getList() throws Exception;
}
