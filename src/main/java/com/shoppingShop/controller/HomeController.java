package com.shoppingShop.controller;

import com.shoppingShop.domain.CategoryDto;
import com.shoppingShop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private CategoryService categoryService;

    @ModelAttribute("mainCategories")
    public List<CategoryDto> populateCategories() {
        return categoryService.getMainCategories();
    }

    @RequestMapping("/")
    public String home(Model model){
//        List<CategoryDto> mainCategories = categoryService.getMainCategories();
//        model.addAttribute("mainCategories", mainCategories);
        return "index";
    }
}
