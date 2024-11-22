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
    public boolean addCart(CartDto cart) {
        try {
            cartDao.addCart(cart);
            return true; // 성공하면 true 반환
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 예외가 발생하면 false 반환
        }
    }

    @Override
    public List<CartDto> getCartByUserId(String userId) {
        return cartDao.getCartByUserId(userId);
    }

    @Override
    public void deleteCart(Long cartId) {
        cartDao.deleteCart(cartId);
    }
}