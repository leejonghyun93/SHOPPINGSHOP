package com.shoppingShop.controller;

import com.shoppingShop.dao.ProductDao;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.domain.SubCategoryDto;
import com.shoppingShop.service.CategoryService;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
public class CategoryController {

    @Autowired
    private ProductService productService;

    @GetMapping("/subCategoryId/{subCategoryId}")
    public String subCategoryList(@PathVariable int subCategoryId, Model m) throws Exception{

        List<ProductDto> list = productService.getList(subCategoryId);
        m.addAttribute("productList", list); //

        return "product/productList";
    }
}