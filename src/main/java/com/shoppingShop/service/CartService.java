package com.shoppingShop.service;

import com.shoppingShop.domain.CartDto;

import java.util.List;

public interface CartService {
    // 사용자 ID로 장바구니 조회
    List<CartDto> selectCartByUserId(String userId);

    // 장바구니 항목 추가
    void addCart(CartDto cartDto);

    // 장바구니 항목 삭제
    void deleteCart(Long cartId);
}
