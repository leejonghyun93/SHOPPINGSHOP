package com.shoppingShop.service;

import com.shoppingShop.domain.CartDto;

import java.util.List;

public interface CartService {

    boolean addCart(CartDto cart);
    List<CartDto> getCartByUserId(String userId);
    void deleteCart(Long cartId);
}
