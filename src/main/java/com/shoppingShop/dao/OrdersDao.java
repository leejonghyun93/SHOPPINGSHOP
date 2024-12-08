package com.shoppingShop.dao;

import com.shoppingShop.domain.OrdersDto;

import java.util.List;

public interface OrdersDao {

    void createOrder(OrdersDto order);
    List<OrdersDto> getOrderHistoryByUserId(String userId);
}
