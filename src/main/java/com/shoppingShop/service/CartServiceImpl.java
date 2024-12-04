package com.shoppingShop.service;

import com.shoppingShop.dao.CartDao;
import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.ProductDto;
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
    public void addCart(CartDto cartDto, ProductDto productDto) {
//        // 상품명 누락 검사를 먼저 수행
//        if (cartDto.getProName() == null || cartDto.getProName().isEmpty()) {
//            throw new IllegalArgumentException("상품명이 누락되었습니다.");
//        }

        // cartCount가 null이면 기본값 1로 설정
        if (cartDto.getCartCount() == null) {
            cartDto.setCartCount(1);  // 기본값 설정
        }

        // productDto에서 가격을 가져옵니다.
        int totalPrice = cartDto.getCartCount() * productDto.getProPrice();  // 상품 가격 * 개수
        cartDto.setTotalPrice(totalPrice);

        // DB에 삽입하는 로직
        cartDao.insertCart(cartDto);
    }

    @Override
    public void removeCart(Long cartId) {
        cartDao.deleteCart(cartId);
    }
}
