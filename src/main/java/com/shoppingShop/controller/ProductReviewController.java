package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductReviewDto;
import com.shoppingShop.service.ProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController // RESTful 웹 서비스를 위한 컨트롤러임을 선언합니다.
@RequestMapping("/product/review") // 이 컨트롤러의 기본 요청 경로를 설정합니다.
public class ProductReviewController {
    private final ProductReviewService productReviewService;

    @Autowired // ProductReviewService를 의존성 주입합니다.
    public ProductReviewController(ProductReviewService productReviewService) {
        this.productReviewService = productReviewService;
    }

    @PostMapping("/add") // HTTP POST 요청을 처리하며, '/add' 경로와 매핑됩니다.
    public ResponseEntity<String> addReview(@RequestBody ProductReviewDto reviewDto) {
        System.out.println("Received Review: " + reviewDto); // 전달된 리뷰 정보를 출력합니다.

        // proId와 rating이 null인지 확인하여 유효성을 검사합니다.
        if (reviewDto.getProId() == null || reviewDto.getRating() == null) {
            System.out.println("Validation failed: Missing proId or rating");
            return ResponseEntity.badRequest().body("Product ID or Rating is missing");
        }

        // rating 값이 유효한지 확인합니다.
        List<String> validRatings = Arrays.asList("1", "2", "3", "4", "5");
        if (!validRatings.contains(reviewDto.getRating())) {
            System.out.println("Validation failed: Invalid rating value");
            return ResponseEntity.badRequest().body("Invalid rating value");
        }

        try {
            productReviewService.addReview(reviewDto); // 리뷰를 추가하기 위해 서비스 메서드를 호출합니다.
            return ResponseEntity.ok("Review added successfully");
        } catch (Exception e) {
            System.err.println("Error occurred: " + e.getMessage());
            return ResponseEntity.status(500).body("Failed to add review: " + e.getMessage());
        }
    }

    @GetMapping("/getByProductId/{proId}") // HTTP GET 요청을 처리하며, '/getByProductId/{proId}' 경로와 매핑됩니다.
    public ResponseEntity<List<ProductReviewDto>> getReviewsByProductId(@PathVariable("proId") int proId) {
        System.out.println("Received proId: " + proId); // 전달된 상품 ID를 출력합니다.

        try {
            List<ProductReviewDto> reviews = productReviewService.getReviewsByProductId(proId);
            System.out.println("Fetched reviews: " + reviews);

            // 해당 상품에 대한 리뷰가 없을 경우 빈 리스트를 반환합니다.
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
