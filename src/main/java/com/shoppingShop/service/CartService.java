package com.shoppingShop.service;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.ProductDto;

import java.util.List;

public interface CartService {
    // 사용자 ID로 장바구니 조회
    List<CartDto> getCartByUserId(String userId); // 사용자별 장바구니 조회

    void addCart(CartDto cartDto, ProductDto productDto);               // 장바구니에 상품 추가

    void removeCart(Long cartId);
}
