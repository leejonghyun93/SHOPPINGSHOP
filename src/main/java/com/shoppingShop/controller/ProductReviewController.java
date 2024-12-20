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
    public ResponseEntity<ProductReviewDto> addReview(@RequestBody ProductReviewDto reviewDto) {
        try {
            if (reviewDto.getProId() == null || reviewDto.getRating() == null || reviewDto.getRating() < 1 || reviewDto.getRating() > 5) {
                return ResponseEntity.badRequest().body(null); // Invalid input data
            }
            ProductReviewDto savedReview = productReviewService.addReview(reviewDto);
            return ResponseEntity.ok(savedReview); // 정상적인 응답 처리
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null); // 리뷰 추가 실패
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
