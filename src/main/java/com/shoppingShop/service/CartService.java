package com.shoppingShop.service;

import com.shoppingShop.domain.CartDto;

import java.util.List;

public interface CartService {

    List<CartDto> getCartByUserId(String userId);

    void addCart(CartDto cartDto);

    void deleteCart(Long cartId);
}
