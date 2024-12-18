package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.domain.ProductReviewDto;
import com.shoppingShop.service.CartService;
import com.shoppingShop.service.ProductReviewService;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CartService cartService;
    @Autowired
    private ProductReviewService productReviewService;
    @GetMapping("/detail/{proId}")
    public String productDetail(@PathVariable int proId, Model model) throws Exception {
        ProductDto detail = productService.getProductDetail(proId);
        model.addAttribute("productDetail", detail);
        return "product/productDetail";
    }

    @GetMapping("/current")
    public ResponseEntity<ProductDto> getCurrentProduct(@RequestParam("proId") int proId) {
        ProductDto product = productService.getCurrentProduct(proId);
        if (product == null) {
            return ResponseEntity.notFound().build();  // 404 응답으로 변경
        }
        return ResponseEntity.ok(product);  // 정상적으로 상품 정보를 반환
    }
}
