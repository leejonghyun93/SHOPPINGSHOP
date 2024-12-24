package com.shoppingShop.dao;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;

public interface InquiryDao {
    List<InquiryDto> selectInquiries(int offset, int limit);
    int getInquiryCount(int proId);
    void addInquiry(InquiryDto inquiryDto);
}