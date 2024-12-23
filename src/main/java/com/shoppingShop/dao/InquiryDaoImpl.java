package com.shoppingShop.dao;

import com.shoppingShop.domain.InquiryDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class InquiryDaoImpl implements InquiryDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.dao.InquiryDao";

    @Override
    public List<InquiryDto> getInquiries(int proId, int offset, int size) {
        Map<String, Object> params = new HashMap<>();
        params.put("proId", proId);
        params.put("offset", offset);
        params.put("size", size);
        return sqlSession.selectList(NAMESPACE + ".getInquiries", params);
    }

    @Override
    public int getInquiryCount(int proId) {
        return sqlSession.selectOne(NAMESPACE + ".getInquiryCount", proId);
    }

    @Override
    public void addInquiry(InquiryDto inquiryDto) {
        sqlSession.insert(NAMESPACE + ".addInquiry", inquiryDto);
    }
}