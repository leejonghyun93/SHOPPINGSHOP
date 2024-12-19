package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductReviewDto;
import com.shoppingShop.service.ProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/product/review")
public class ProductReviewController {
    private final ProductReviewService productReviewService;

    @Autowired
    public ProductReviewController(ProductReviewService productReviewService) {
        this.productReviewService = productReviewService;
    }

    @PostMapping("/add")
    public ProductReviewDto addReview(@RequestBody ProductReviewDto reviewDto) {
        return productReviewService.addReview(reviewDto);
    }

    @GetMapping("/getByProductId/{proId}")
    public List<ProductReviewDto> getReviewsByProductId(@PathVariable("proId") int proId) {
        System.out.println("Received proId: " + proId);
        List<ProductReviewDto> reviews = productReviewService.getReviewsByProductId(proId);
        System.out.println("Fetched reviews: " + reviews);
        if (reviews == null || reviews.isEmpty()) {
            System.out.println("No reviews found for proId: " + proId);
            return new ArrayList<>(); // 빈 리스트 반환
        }
        return reviews;
    }
}
