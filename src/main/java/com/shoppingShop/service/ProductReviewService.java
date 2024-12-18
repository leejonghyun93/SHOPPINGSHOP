package com.shoppingShop.service;

import com.shoppingShop.domain.ProductReviewDto;

import java.util.List;
import java.util.Map;

public interface ProductReviewService {
    List<ProductReviewDto> getReviewsByProductId(int proId);
    ProductReviewDto addReview(ProductReviewDto productReview);
}
