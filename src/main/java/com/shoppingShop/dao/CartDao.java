package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;

import java.util.List;

public interface CartDao {
    // 사용자 ID로 장바구니 조회
    List<CartDto> findByUserId(String userId);

    // 장바구니에 항목 추가
    void insertCart(CartDto cartDto);

    // 특정 장바구니 항목 삭제
    void deleteCartById(Long cartId);
}