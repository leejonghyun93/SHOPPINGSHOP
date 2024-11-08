package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDaoImpl implements CartDao {

    @Autowired
    private SqlSession sqlSession;
    private static final String NAMESPACE = "com.shoppingShop.dao.CartMapper.";

    @Override
    public void addCart(CartDto cart) {
        sqlSession.insert(NAMESPACE + "addCart", cart);
    }

    @Override
    public List<CartDto> getCartByUserId(String userId) {
        return sqlSession.selectList(NAMESPACE + "getCartByUserId", userId);
    }

    @Override
    public void deleteCart(Long cartId) {
        sqlSession.delete(NAMESPACE + "deleteCart", cartId);
    }
}
