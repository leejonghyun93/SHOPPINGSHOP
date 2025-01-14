package com.shoppingShop.dao;

import com.shoppingShop.domain.InquiryDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class InquiryDaoImpl implements InquiryDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.dao.InquiryDao";

    @Override
    public List<InquiryDto> selectInquiriesByProductId(Map<String, Object> params) {
        return sqlSession.selectList(NAMESPACE + ".selectInquiriesByProductId", params);
    }

    @Override
    public int getInquiryCountByProductId(int proId) {
        return sqlSession.selectOne(NAMESPACE + ".getInquiryCountByProductId", proId);
    }

    @Override
    public void addInquiry(InquiryDto inquiryDto) {
        sqlSession.insert(NAMESPACE + ".addInquiry", inquiryDto);
    }
}