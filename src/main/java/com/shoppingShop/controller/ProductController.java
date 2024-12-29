package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.InquiryDto;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.domain.ProductReviewDto;
import com.shoppingShop.service.CartService;
import com.shoppingShop.service.InquiryService;
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

    @Autowired
    private InquiryService inquiryService;

    @GetMapping("/detail/{proId}")
    public String productDetail(@PathVariable int proId, Model model,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "5") int size) throws Exception {
        ProductDto detail = productService.getProductDetail(proId);

        model.addAttribute("inquiries", inquiryService.getInquiriesByPage(page, size));
        model.addAttribute("totalPages", inquiryService.getTotalPages(size));
        model.addAttribute("currentPage", page);

        model.addAttribute("productDetail", detail);
        return "product/productDetail";
    }
    @GetMapping("/inquiries")
    public ResponseEntity<Map<String, Object>> getInquiriesByPage(
            @RequestParam("page") int page,
            @RequestParam("size") int size) {

        Map<String, Object> response = new HashMap<>();
        List<InquiryDto> inquiries = inquiryService.getInquiriesByPage(page, size);
        int totalPages = inquiryService.getTotalPages(size);

        response.put("content", inquiries);
        response.put("totalPages", totalPages);
        response.put("currentPage", page);

        return ResponseEntity.ok(response);
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
