package com.shoppingShop.service;

import com.shoppingShop.domain.OrdersDto;

import java.util.List;

public interface OrdersService {

    void placeOrder(List<OrdersDto> orders);
    List<OrdersDto> getOrderHistory(String userId);
}
