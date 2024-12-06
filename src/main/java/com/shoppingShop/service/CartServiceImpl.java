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

        // 상품 가격을 가져오기 위해 productDto에서 값을 설정 (예: productId로 DB에서 정보 조회)
        ProductDto productDto = cartDto.getProductDto();  // CartDto에 ProductDto가 포함되어 있다고 가정

        if (productDto != null) {
            // 상품 가격 계산
            int totalPrice = cartDto.getCartCount() * productDto.getProPrice();
            cartDto.setTotalPrice(totalPrice);
        }

        // DB에 삽입하는 로직
        cartDao.insertCart(cartDto);
    }

    @Override
    public void removeCart(Long cartId) {
        cartDao.deleteCart(cartId);
    }
}
