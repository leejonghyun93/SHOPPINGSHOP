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
    public void addCart(CartDto cartDto) {
        // cartCount가 null이면 기본값 1로 설정
        if (cartDto.getCartCount() == null) {
            cartDto.setCartCount(1);  // 기본값 설정
        }

        // 상품이 이미 장바구니에 존재하는지 확인
        if (cartDao.checkProductInCart(cartDto) > 0) {
            throw new IllegalArgumentException("이미 장바구니에 존재하는 상품입니다.");
        }

        // 상품 가격 계산
        ProductDto productDto = cartDto.getProductDto();
        if (productDto != null) {
            int totalPrice = cartDto.getCartCount() * productDto.getProPrice();
            cartDto.setTotalPrice(totalPrice);
        }

        // DB에 삽입
        cartDao.insertCart(cartDto);
    }
    @Override
    public boolean isItemInCart(CartDto cartDto) {
        // CartDao에서 상품이 이미 장바구니에 존재하는지 확인하는 로직 추가
        return cartDao.existsByUserIdAndProductId(cartDto.getUserId(), cartDto.getProId());
    }

    @Override
    public void removeCart(Long cartId) {
        cartDao.deleteCart(cartId);
    }

    @Override
    public void clearCartByUserId(String userId) {
        cartDao.clearCartByUserId(userId);
    }
}
