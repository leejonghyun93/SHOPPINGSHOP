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
        List<String> validRatings = Arrays.asList("1", "2", "3", "4", "5");
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
    public ResponseEntity<List<ProductReviewDto>> getReviewsByProductId(@PathVariable("proId") int proId) {
        System.out.println("Received proId: " + proId);

        try {
            List<ProductReviewDto> reviews = productReviewService.getReviewsByProductId(proId);
            System.out.println("Fetched reviews: " + reviews);

            // 리뷰가 없을 경우 빈 리스트 반환
            if (reviews == null || reviews.isEmpty()) {
                System.out.println("No reviews found for proId: " + proId);
                return ResponseEntity.ok(new ArrayList<>());
            }
            return ResponseEntity.ok(reviews);
        } catch (Exception e) {
            System.err.println("Error occurred while fetching reviews: " + e.getMessage());
            return ResponseEntity.status(500).body(new ArrayList<>());
        }
    }
}
