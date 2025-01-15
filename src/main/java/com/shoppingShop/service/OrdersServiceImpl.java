package com.shoppingShop.service;

import com.shoppingShop.dao.CartDao;
import com.shoppingShop.dao.OrdersDao;
import com.shoppingShop.domain.OrdersDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrdersServiceImpl implements OrdersService {

    @Autowired
    private OrdersDao ordersDao;

    @Autowired
    private CartDao cartDao; // CartDao를 사용하여 장바구니 정보 조회

    @Override
    @Transactional
    public void placeOrder(String userId, List<Long> cartIds) {  // cartId -> cartIds
        List<OrdersDto> cartItems = cartDao.getCartItemsByIds(cartIds);  // cartId -> cartIds
        List<OrdersDto> orders = new ArrayList<>();

        for (OrdersDto cartItem : cartItems) {
            OrdersDto order = new OrdersDto();
            order.setUserId(userId);
            order.setOdStatus("결제완료");
            order.setQuantity(cartItem.getQuantity());
            order.setUnitPrice(cartItem.getUnitPrice());
            order.setShippingFee(cartItem.getShippingFee());
            order.setOdTotalPrice(order.getQuantity() * order.getUnitPrice() + order.getShippingFee());
            order.setCartId(cartItem.getCartId());
            order.setProId(cartItem.getProId());
            order.setCreatedAt(LocalDateTime.now());

            // 주문 DB에 저장
            try {
                ordersDao.createOrder(order);
                System.out.println("주문 저장 후 orderId: " + order.getOrderId()); // 확인용 로그
            } catch (Exception e) {
                e.printStackTrace(); // 예외 발생 시 출력
                throw e; // 예외를 던져서 트랜잭션 롤백
            }
        }

        // 장바구니 항목 삭제
        cartDao.deleteCartItems(cartIds);  // cartId -> cartIds
    }

    @Override
    public List<OrdersDto> getOrderHistory(String userId) {
        return ordersDao.getOrderHistoryByUserId(userId);
    }

    @Override
    public List<OrdersDto> getSelectOrderList(String userId) {
        return ordersDao.getSelectOrderList(userId);
    }
}

