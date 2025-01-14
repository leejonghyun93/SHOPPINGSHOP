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
    public String viewInquiries(@RequestParam("proId") int proId, // 특정 상품 번호를 받음
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "5") int size,
                                Model model) {
        // 특정 상품의 문의 가져오기
        model.addAttribute("inquiries", inquiryService.getInquiriesByProductId(proId, page, size));
        model.addAttribute("totalPages", inquiryService.getTotalPagesByProductId(proId, size));
        model.addAttribute("currentPage", page);
        model.addAttribute("proId", proId); // 현재 상품 ID를 뷰로 전달
        return "product/productDetail";
    }
}
