package com.shoppingShop.dao;

import com.shoppingShop.domain.CartDto;
import com.shoppingShop.domain.OrdersDto;

import java.util.List;

public interface CartDao {
    // 사용자 ID로 장바구니 조회
    List<CartDto> selectCartByUserId(String userId);

    // 장바구니에 상품 추가
    int insertCart(CartDto cartDto);

    int checkProductInCart(CartDto cartDto);

    // 개별 장바구니 항목 삭제
    int deleteCart(Long cartId);

    boolean existsByUserIdAndProductId(String userId, int proId);

    // 장바구니 ID 목록으로 상품 조회
    List<OrdersDto> getCartItemsByIds(List<Long> cartIds);


    // 여러 장바구니 항목 삭제
    int deleteCartItems(List<Long> cartIds);

    // 장바구니 항목에 해당하는 주문 삭제
    int deleteOrdersByCartIds(List<Long> cartIds);
}
