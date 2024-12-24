package com.shoppingShop.service;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;

public interface InquiryService {
    List<InquiryDto> getInquiriesByPage(int page);
    int getInquiryCount(int proId);
    void addInquiry(InquiryDto inquiryDto);
}