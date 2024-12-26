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
@RequestMapping("/api/inquiries")
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    // 문의 리스트 API
    @GetMapping
    @ResponseBody
    public Map<String, Object> getInquiryList(@RequestParam(value = "page", defaultValue = "1") int page) {
        int pageSize = 10; // 한 페이지당 문의 개수
        Map<String, Object> response = new HashMap<>();
        response.put("content", inquiryService.getInquiriesByPage(page, pageSize));
        response.put("totalPages", inquiryService.getTotalPages(pageSize));
        return response;
    }

    // 문의 등록 API
    @PostMapping
    @ResponseBody
    public ResponseEntity<String> addInquiry(@RequestBody InquiryDto inquiryDto) {
        inquiryService.addInquiry(inquiryDto);
        return ResponseEntity.ok("문의가 등록되었습니다.");
    }
}
