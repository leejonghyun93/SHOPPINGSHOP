package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {

    @GetMapping("/detail/{productId}")
    public String productDetail(@PathVariable ProductDto productId){


    }
}
