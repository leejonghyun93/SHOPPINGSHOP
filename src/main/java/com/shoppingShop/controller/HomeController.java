package com.shoppingShop.controller;

import com.shoppingShop.domain.CategoryDto;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.service.CategoryService;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;

    @ModelAttribute("mainCategories")
    public List<CategoryDto> populateCategories() {
        return categoryService.getMainCategories();
    }

    @RequestMapping("/")
    public String home(Model model)throws Exception{
        List<ProductDto> productList = productService.getAllProducts();
        model.addAttribute("productList", productList);
        return "index";
    }
}
