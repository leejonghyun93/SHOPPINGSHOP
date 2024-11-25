package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDaoImpl implements CartDao {

    private static final String NAMESPACE = "com.shoppingShop.dao.CartDao.";

    @Autowired
    private SqlSession sqlSession;

    // 사용자 ID로 장바구니 조회
    @Override
    public List<CartDto> findByUserId(String userId) {
        return sqlSession.selectList(NAMESPACE + "findByUserId", userId);
    }

    // 장바구니에 항목 추가
    @Override
    public void insertCart(CartDto cartDto) {
        sqlSession.insert(NAMESPACE + "insertCart", cartDto);
    }

    // 특정 장바구니 항목 삭제
    @Override
    public void deleteCartById(Long cartId) {
        sqlSession.delete(NAMESPACE + "deleteCartById", cartId);
    }
}