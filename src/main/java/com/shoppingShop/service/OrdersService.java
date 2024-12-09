package com.shoppingShop.service;

import com.shoppingShop.domain.OrdersDto;

import java.util.List;

public interface OrdersService {

    void placeOrder(String userId, List<Long> cartIds);

    List<OrdersDto> getOrderHistory(String userId);

    List<OrdersDto> getSelectOrderList(String userId);
}
