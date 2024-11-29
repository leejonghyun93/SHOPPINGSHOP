package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDaoImpl implements CartDao {

    private static final String NAMESPACE = "com.shoppingShop.mapper.CartMapper.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<CartDto> selectCartByUserId(String userId) {
        return sqlSession.selectList(NAMESPACE + "selectCartByUserId", userId);
    }

    @Override
    public int insertCart(CartDto cartDto) {
        return sqlSession.insert(NAMESPACE + "insertCart", cartDto);
    }

    @Override
    public int deleteCart(Long cartId) {
        return sqlSession.delete(NAMESPACE + "deleteCart", cartId);
    }
}