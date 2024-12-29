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
    public List<InquiryDto> getInquiriesByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        Map<String, Integer> params = new HashMap<>();
        params.put("limit", pageSize);
        params.put("offset", offset);
        return inquiryDao.selectInquiries(params);
    }

    @Override
    public int getTotalPages(int pageSize) {
        int totalCount = inquiryDao.getInquiryCount();
        return (int) Math.ceil((double) totalCount / pageSize);
    }

    @Override
    public void addInquiry(InquiryDto inquiryDto) {
        inquiryDao.addInquiry(inquiryDto);
    }
}
