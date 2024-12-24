package com.shoppingShop.controller;

import com.shoppingShop.domain.InquiryDto;
import com.shoppingShop.service.InquiryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping("/list")
    @ResponseBody
    public List<InquiryDto> getInquiryList(@RequestParam(value = "page", defaultValue = "1") int page) {
        return inquiryService.getInquiriesByPage(page);
    }



    // 문의 등록하기
    @ResponseBody
    @PostMapping("/add")
    public ResponseEntity<String> addInquiry(@RequestBody InquiryDto inquiryDto) {
        inquiryService.addInquiry(inquiryDto);
        return ResponseEntity.ok("문의가 등록되었습니다.");
    }
}
