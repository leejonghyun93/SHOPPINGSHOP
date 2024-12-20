package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductReviewDto;
import com.shoppingShop.service.ProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
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
    public ResponseEntity<String> addReview(@RequestBody ProductReviewDto reviewDto) {
        System.out.println("Received Review: " + reviewDto);

        if (reviewDto.getProId() == null || reviewDto.getRating() == null) {
            System.out.println("Validation failed: Missing proId or rating");
            return ResponseEntity.badRequest().body("Product ID or Rating is missing");
        }

        // 유효성 검사
        List<String> validRatings = Arrays.asList("terrible", "poor", "average", "good", "excellent");
        if (!validRatings.contains(reviewDto.getRating())) {
            System.out.println("Validation failed: Invalid rating value");
            return ResponseEntity.badRequest().body("Invalid rating value");
        }

        try {
            productReviewService.addReview(reviewDto); // 서비스 호출
            return ResponseEntity.ok("Review added successfully");
        } catch (Exception e) {
            System.err.println("Error occurred: " + e.getMessage());
            return ResponseEntity.status(500).body("Failed to add review: " + e.getMessage());
        }
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
