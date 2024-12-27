package com.shoppingShop.service;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;

public interface InquiryService {

    List<InquiryDto> getInquiriesByPage(int page, int pageSize);

    int getTotalPages(int pageSize);

    void addInquiry(InquiryDto inquiryDto);
}
