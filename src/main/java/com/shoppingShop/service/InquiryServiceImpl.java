package com.shoppingShop.service;

import com.shoppingShop.dao.InquiryDao;
import com.shoppingShop.domain.InquiryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InquiryServiceImpl implements InquiryService {

    @Autowired
    private InquiryDao inquiryDao;

    @Override
    public List<InquiryDto> getInquiriesByPage(int page) {
        int offset = (page - 1) * 10; // 페이지 당 10개 기준
        return inquiryDao.selectInquiries(offset, 10);
    }

    @Override
    public int getInquiryCount(int proId) {
        return inquiryDao.getInquiryCount(proId);
    }

    @Override
    public void addInquiry(InquiryDto inquiryDto) {
        inquiryDao.addInquiry(inquiryDto);
    }
}