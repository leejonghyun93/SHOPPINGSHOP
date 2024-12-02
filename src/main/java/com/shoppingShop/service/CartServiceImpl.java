package com.shoppingShop.service;

import com.shoppingShop.dao.CartDao;
import com.shoppingShop.domain.CartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDao cartDao;

    @Override
    public List<CartDto> getCartByUserId(String userId) {
        return cartDao.selectCartByUserId(userId);
    }

    @Override
    public void addCart(CartDto cartDto) {
        cartDao.insertCart(cartDto);
    }

    @Override
    public void removeCart(Long cartId) {
        cartDao.deleteCart(cartId);
    }
}
