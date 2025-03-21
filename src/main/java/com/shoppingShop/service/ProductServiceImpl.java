package com.shoppingShop.service;

import com.shoppingShop.dao.ProductDao;
import com.shoppingShop.domain.ProductDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public List<ProductDto> getAllProducts() throws Exception {
        return productDao.selectAllProducts();
    }

    @Override
    public List<ProductDto> getList(int subCategoryId) throws Exception {
        return productDao.selectProductAll(subCategoryId);
    }

    @Override
    public ProductDto getProductDetail(int proId) throws Exception {
        return productDao.selectProductDetail(proId);
    }

    @Override
    public ProductDto getCurrentProduct(int proId) {
        // Fetch the current product from the database or any source
        ProductDto product = productDao.findCurrentProduct(proId);
        if (product == null) {
            throw new RuntimeException("Product ID를 가져오는 데 실패했습니다.");
        }
        return product;
    }
}
