package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductReviewDto;
import com.shoppingShop.service.ProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
        return productReviewService.getReviewsByProductId(proId);
    }
}