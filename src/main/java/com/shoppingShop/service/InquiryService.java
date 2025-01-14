package com.shoppingShop.service;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;

public interface InquiryService {

    List<InquiryDto> getInquiriesByProductId(int proId, int page, int size);
    int getTotalPagesByProductId(int proId, int size);

    void addInquiry(InquiryDto inquiryDto);
}
