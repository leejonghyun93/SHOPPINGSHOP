package com.shoppingShop.service;

import com.shoppingShop.dao.CartDao;
import com.shoppingShop.domain.CartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDao cartDao;

    @Override
    public List<CartDto> getCartByUserId(String userId) {
        List<CartDto> cartItems = cartDao.findByUserId(userId);

        // 숫자 포맷 적용
        // 숫자 포맷팅 준비
        NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.getDefault());

        for (CartDto cart : cartItems) {
            // null 체크 후 포맷팅
            if (cart.getTotalPrice() != null) {
                cart.setTotalPriceFormatted(numberFormat.format(cart.getTotalPrice()));
            } else {
                cart.setTotalPriceFormatted("0");
            }
        }
        return cartItems;
    }

    @Override
    public void addCart(CartDto cartDto) {
        cartDao.insertCart(cartDto);
    }

    @Override
    public void deleteCart(Long cartId) {
        cartDao.deleteCartById(cartId);
    }
}