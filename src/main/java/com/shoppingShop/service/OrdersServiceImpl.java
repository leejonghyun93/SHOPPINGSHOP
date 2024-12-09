package com.shoppingShop.service;

import com.shoppingShop.dao.CartDao;
import com.shoppingShop.dao.OrdersDao;
import com.shoppingShop.domain.OrdersDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrdersServiceImpl implements OrdersService {

    @Autowired
    private OrdersDao ordersDao;

    @Autowired
    private CartDao cartDao; // CartDao를 사용하여 장바구니 정보 조회

    @Override
    public void placeOrder(String userId, List<Long> cartIds) {
        // cartIds를 기반으로 장바구니 항목을 조회 (OrdersDto를 사용)
        List<OrdersDto> cartItems = cartDao.getCartItemsByIds(cartIds);

        List<OrdersDto> orders = new ArrayList<>();

        for (OrdersDto cartItem : cartItems) {
            OrdersDto order = new OrdersDto();
            order.setUserId(userId);
            order.setCartId(cartItem.getCartId());
            order.setOdStatus("결제완료");
            order.setQuantity(cartItem.getQuantity()); // 장바구니에서 가져온 수량
            order.setUnitPrice(cartItem.getUnitPrice()); // 장바구니에서 가져온 단가
            order.setShippingFee(cartItem.getShippingFee()); // 장바구니에서 가져온 배송비
            order.setOdTotalPrice(order.getQuantity() * order.getUnitPrice() + order.getShippingFee());
            orders.add(order);
        }

        // DAO를 통해 주문 저장
        for (OrdersDto order : orders) {
            ordersDao.createOrder(order);
        }
        cartDao.deleteCartItems(cartIds);
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

