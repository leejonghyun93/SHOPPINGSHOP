package com.shoppingShop.controller;

import com.shoppingShop.service.InquiryService;
import com.shoppingShop.domain.InquiryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller

public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping
    public String viewInquiries(Model model,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "5") int size) {
        model.addAttribute("inquiries", inquiryService.getInquiriesByPage(page, size));
        model.addAttribute("totalPages", inquiryService.getTotalPages(size));
        model.addAttribute("currentPage", page);
        return "product/productDetail";
    }
}
