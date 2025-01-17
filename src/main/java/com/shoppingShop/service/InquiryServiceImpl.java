package com.shoppingShop.service;

import com.shoppingShop.dao.InquiryDao;
import com.shoppingShop.domain.InquiryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InquiryServiceImpl implements InquiryService {

    @Autowired
    private InquiryDao inquiryDao;

    @Override
    public List<InquiryDto> getInquiriesByProductId(int proId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("proId", proId);
        params.put("limit", pageSize);
        params.put("offset", offset);
        return inquiryDao.selectInquiriesByProductId(params);
    }

    @Override
    public int getTotalPagesByProductId(int proId, int pageSize) {
        int totalCount = inquiryDao.getInquiryCountByProductId(proId);
        return (int) Math.ceil((double) totalCount / pageSize);
    }

    @Override
    public void addInquiry(InquiryDto inquiryDto) {
        System.out.println("Saving Inquiry: " + inquiryDto);
        inquiryDao.addInquiry(inquiryDto);
    }
}
