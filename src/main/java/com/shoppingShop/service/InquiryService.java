package com.shoppingShop.service;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;

public interface InquiryService {
    List<InquiryDto> getInquiries(int proId, int page, int size);
    int getInquiryCount(int proId);
    void addInquiry(InquiryDto inquiryDto);
}