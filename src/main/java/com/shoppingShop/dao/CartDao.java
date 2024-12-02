package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;

import java.util.List;

public interface CartDao {
    // 사용자 ID로 장바구니 조회
    List<CartDto> selectCartByUserId(String userId); // 사용자별 장바구니 조회

    int insertCart(CartDto cartDto);                // 장바구니에 상품 추가

    int deleteCart(Long cartId);
}
