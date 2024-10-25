package com.shoppingShop.service;

import com.shoppingShop.dao.ProductDao;
import com.shoppingShop.domain.ProductDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{

    @Autowired
    private ProductDao productDao;

    @Override
    public List<ProductDto> getList(int subCategoryId) throws Exception{
        return productDao.selectProductAll(subCategoryId);
    }

    @Override
    public String getProductDetail(int productId) throws Exception{
        return productDao.selectProductDetail(productId);
    }
}
