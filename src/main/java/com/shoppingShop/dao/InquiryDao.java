package com.shoppingShop.dao;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;
import java.util.Map;

public interface InquiryDao {

    List<InquiryDto> selectInquiries(Map<String, Integer> params);

    int getInquiryCount();

    void addInquiry(InquiryDto inquiryDto);
}