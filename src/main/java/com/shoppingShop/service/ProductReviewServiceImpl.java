package com.shoppingShop.service;

import com.shoppingShop.dao.ProductReviewDao;
import com.shoppingShop.domain.ProductReviewDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {
    private final ProductReviewDao productReviewDao;

    @Autowired
    public ProductReviewServiceImpl(ProductReviewDao productReviewDao) {
        this.productReviewDao = productReviewDao;
    }

    @Override
    public ProductReviewDto addReview(ProductReviewDto productReview) {
        productReviewDao.insertReview(productReview);  // DAO 메서드 호출
        return productReview;  // 추가된 리뷰 반환
    }
    @Override
    public List<ProductReviewDto> getReviewsByProductId(int proId) {
        return productReviewDao.getReviewsByProductId(proId);
    }
}