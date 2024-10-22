package com.shoppingShop.dao;

import com.shoppingShop.domain.ProductDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDaoImpl implements ProductDao{

    @Autowired
    private SqlSession session;
    private static String namespace = "com.shoppingShop.dao.ProductDao.";

    @Override
    public List<ProductDto> selectProductAll(int subCategoryId) throws Exception {
        return session.selectList(namespace + "selectProductAll", subCategoryId); // 파라미터 이름 수정
    }

}
