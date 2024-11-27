package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/detail/{proId}")
    public String productDetail(@PathVariable int proId, Model model) throws Exception {
        ProductDto detail = productService.getProductDetail(proId);
        model.addAttribute("productDetail", detail);
        return "product/productDetail";
    }


}
