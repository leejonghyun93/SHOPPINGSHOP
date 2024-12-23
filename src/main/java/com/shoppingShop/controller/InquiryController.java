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
@RequestMapping("/product/inquiry")
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    // 문의 리스트 가져오기
    @ResponseBody
    @GetMapping("/list")
    public Map<String, Object> getInquiries(
            @RequestParam("proId") int proId,
            @RequestParam("page") int page,
            @RequestParam("size") int size) {

        Map<String, Object> result = new HashMap<>();
        List<InquiryDto> inquiries = inquiryService.getInquiries(proId, page, size);
        int totalInquiries = inquiryService.getInquiryCount(proId);

        result.put("inquiries", inquiries);
        result.put("totalInquiries", totalInquiries);
        return result;
    }


    // 문의 등록하기
    @ResponseBody
    @PostMapping("/add")
    public ResponseEntity<String> addInquiry(@RequestBody InquiryDto inquiryDto) {
        inquiryService.addInquiry(inquiryDto);
        return ResponseEntity.ok("문의가 등록되었습니다.");
    }
}
