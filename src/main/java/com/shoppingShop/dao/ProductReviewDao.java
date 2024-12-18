package com.shoppingShop.dao;

import com.shoppingShop.domain.ProductReviewDto;

import java.util.List;

public interface ProductReviewDao {
    List<ProductReviewDto> getReviewsByProductId(int proId);

    void insertReview(ProductReviewDto productReview);
}