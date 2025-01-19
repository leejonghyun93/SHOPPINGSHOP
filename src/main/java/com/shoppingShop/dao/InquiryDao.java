package com.shoppingShop.dao;

import com.shoppingShop.domain.InquiryDto;

import java.util.List;
import java.util.Map;

public interface InquiryDao {

    List<InquiryDto> selectInquiriesByProductId(Map<String, Object> params);

    int getInquiryCountByProductId(int proId);

    void addInquiry(InquiryDto inquiryDto);

    InquiryDto selectInquiryById(int inquiryId);
}