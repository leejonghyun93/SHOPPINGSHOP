package com.shoppingShop.dao;

import com.shoppingShop.domain.CategoryDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDaoImpl implements CategoryDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.shoppingShop.mapper.CategoryMapper";

    @Override
    public List<CategoryDto> selectMainCategories() {
        return sqlSession.selectList(NAMESPACE + ".selectMainCategories");
    }
}