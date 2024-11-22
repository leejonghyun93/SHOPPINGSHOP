package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;

import java.util.List;

public interface CartDao {
    void addCart(CartDto cart);
    List<CartDto> getCartByUserId(String userId);
    void deleteCart(Long cartId);
}