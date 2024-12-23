package com.shoppingShop.dao;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;

public interface InquiryDao {
    List<InquiryDto> getInquiries(int proId, int offset, int size);
    int getInquiryCount(int proId);
    void addInquiry(InquiryDto inquiryDto);
}