package com.shoppingShop.controller;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.service.CartService;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CartService cartService;

    @GetMapping("/detail/{proId}")
    public String productDetail(@PathVariable int proId, Model model) throws Exception {
        ProductDto detail = productService.getProductDetail(proId);
        model.addAttribute("productDetail", detail);
        return "product/productDetail";
    }


}
